-- This "marts schema" model is the fact table containing sales and inventory data 
-- aggregated to weekly level so that weekly level analysis can be done.
-- Model is made available for the business user in the "marts schema" for analysis

{{config(
  materialized='incremental',
  target_schema='marts',
  unique_key=['warehouse_sk', 'item_sk', 'sold_wk_sk']
)}}

with aggregating_daily_sales_to_week as (
SELECT 
    warehouse_sk, 
    item_sk, 
    min(sold_date_sk) as sold_wk_sk, 
    sold_wk_num, 
    sold_yr_num, 
    sum(daily_qty) as sum_qty_wk, 
    sum(daily_sales_amt) as sum_amt_wk, 
    sum(daily_net_profit) as sum_profit_wk
FROM
    {{ ref("int_tpcds__dailyaggregatedsales") }}
GROUP BY
    1,2,4,5
),

-- We need to have the same sold_wk_sk for all the items. Currently, 
-- any items that didn't have any sales on Sunday (first day of the week) would not have 
-- Sunday date as sold_wk_sk so this CTE will correct that.
finding_first_date_of_the_week as (
SELECT 
    warehouse_sk, 
    item_sk, 
    date.d_date_sk as sold_wk_sk, 
    sold_wk_num, 
    sold_yr_num, 
    sum_qty_wk, 
    sum_amt_wk, 
    sum_profit_wk
FROM
    aggregating_daily_sales_to_week daily_sales
    INNER JOIN {{ ref("stg_tpcds__datedim") }} as date
    on daily_sales.SOLD_WK_NUM = date.wk_num
    and daily_sales.sold_yr_num = date.yr_num
    and date.day_of_wk_num = 0
),

-- This will help sales and inventory tables to join together using wk_num and yr_num
date_columns_in_inventory_table as (
    SELECT 
        inventory.*,
        date.wk_num as inv_wk_num,
        date.yr_num as inv_yr_num
    FROM
        {{ ref("stg_tpcds__inventory") }} inventory
        INNER JOIN {{ ref("stg_tpcds__datedim") }} as date
        on inventory.inv_date_sk = date.d_date_sk
        INNER JOIN TPCDS.RAW.WAREHOUSE wh 
    ON inventory.inv_warehouse_sk = wh.w_warehouse_sk
)

select 
       warehouse_sk, 
       item_sk, 
       sold_wk_sk as sold_wk_sk,
       sold_wk_num as sold_wk_num,
       sold_yr_num as sold_yr_num,
       sum(sum_qty_wk) as sum_qty_wk,
       sum(sum_amt_wk) as sum_amt_wk,
       sum(sum_profit_wk) as sum_profit_wk,
       sum(sum_qty_wk)/7 as avg_qty_dy,
       sum(coalesce(inv.inv_quantity_on_hand, 0)) as inv_qty_wk, 
       sum(coalesce(inv.inv_quantity_on_hand, 0)) / sum(sum_qty_wk) as wks_sply,
       iff(avg_qty_dy>0 and avg_qty_dy>inv_qty_wk, true , false) as low_stock_flg_wk
from finding_first_date_of_the_week
left join date_columns_in_inventory_table inv 
    on inv_wk_num = sold_wk_num and inv_yr_num = sold_yr_num and 
    item_sk = inv_item_sk and inv_warehouse_sk = warehouse_sk
group by 1, 2, 3, 4, 5
-- to ensure we only consider data with qty > 0 in the model
having sum(sum_qty_wk) > 0 
{% if is_incremental() %}
  and sold_wk_sk >= coalesce((select max(sold_wk_sk) from {{ this }}), 0)
{% endif %}