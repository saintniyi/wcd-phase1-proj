-- This model in "intermediate schema" aggregated daily sales data and 
-- add new daily data using incremental load strategy. 
-- Model is not available for analytic layer since it is not a requirement
-- However, model is an intermediary steps towards generating / calculating 
-- the fact table (fact_weekly_sales_inventory) requirement

{{config(
  materialized='incremental',
  target_schema='intermediate',
  unique_key=['warehouse_sk', 'item_sk', 'sold_date_sk']
)}}


with incremental_sales as (
    
    SELECT 
            cs_warehouse_sk as warehouse_sk,
            cs_item_sk as item_sk,
            cs_sold_date_sk as sold_date_sk,
            cs_quantity as quantity,
            cs_sales_price * cs_quantity as sales_amt,
            cs_net_profit as net_profit
    FROM {{ ref("stg_tpcds__catalogsales") }}
    WHERE quantity IS NOT NULL
        AND sales_amt IS NOT NULL
        AND cs_warehouse_sk IS NOT NULL
        AND quantity > 0
        AND sales_amt > 0
        AND cs_warehouse_sk > 0
        
    union all

    SELECT 
        ws_warehouse_sk as warehouse_sk,
        ws_item_sk as item_sk,
        ws_sold_date_sk as sold_date_sk,
        ws_quantity as quantity,
        ws_sales_price * ws_quantity as sales_amt,
        ws_net_profit as net_profit
    FROM {{ ref("stg_tpcds__websales") }}
    WHERE quantity IS NOT NULL
        AND sales_amt IS NOT NULL
        AND ws_warehouse_sk IS NOT NULL
        AND quantity > 0
        AND sales_amt > 0
        AND ws_warehouse_sk > 0

),

aggregating_records_to_daily_sales as
(
    SELECT 
        warehouse_sk,
        item_sk,
        sold_date_sk, 
        sum(quantity) as daily_qty,
        sum(sales_amt) as daily_sales_amt,
        sum(net_profit) as daily_net_profit 
    FROM incremental_sales
    GROUP BY 1, 2, 3

),

adding_week_number_and_yr_number as
(
    SELECT 
        *,
        date.wk_num as sold_wk_num,
        date.yr_num as sold_yr_num
    FROM aggregating_records_to_daily_sales 
    LEFT JOIN {{ ref("stg_tpcds__datedim") }} as date 
    ON sold_date_sk = d_date_sk

)

SELECT 
    warehouse_sk,
    item_sk,
    sold_date_sk,
    max(sold_wk_num) as sold_wk_num,
    max(sold_yr_num) as sold_yr_num,
    sum(daily_qty) as daily_qty,
    sum(daily_sales_amt) as daily_sales_amt,
    sum(daily_net_profit) as daily_net_profit 
FROM adding_week_number_and_yr_number
{% if is_incremental() %}
    where sold_date_sk >= coalesce((select max(sold_date_sk) from {{this}}), 0)
{% endif %}
GROUP BY 1,2,3
ORDER BY 1,2,3
