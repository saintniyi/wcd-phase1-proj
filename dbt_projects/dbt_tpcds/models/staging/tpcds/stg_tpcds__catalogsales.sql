-- Source model for catalogsales in "staging schema". 
-- Contains daily sales data via the catalog channel

with stg_tpcds__catalogsales as (
  Select * from {{ source('tpcds', 'catalogsales') }}
)
SELECT 
  cs_warehouse_sk, 
  cs_ship_date_sk, 
  cs_ext_list_price, 
  cs_quantity, 
  cs_net_paid_inc_tax, 
  cs_sold_time_sk, 
  cs_promo_sk, 
  cs_list_price, 
  cs_ext_ship_cost, 
  cs_net_paid, 
  cs_sold_date_sk, 
  cs_ext_discount_amt, 
  cs_ship_addr_sk, 
  cs_ext_tax, 
  cs_catalog_page_sk, 
  cs_net_profit, 
  cs_item_sk, 
  cs_bill_cdemo_sk, 
  cs_bill_hdemo_sk, 
  cs_net_paid_inc_ship, 
  cs_coupon_amt, 
  cs_net_paid_inc_ship_tax, 
  cs_order_number, 
  cs_ext_wholesale_cost, 
  cs_ship_mode_sk, 
  cs_ext_sales_price, 
  cs_ship_customer_sk, 
  cs_bill_addr_sk, 
  cs_ship_cdemo_sk, 
  cs_ship_hdemo_sk, 
  cs_wholesale_cost, 
  cs_sales_price, 
  cs_call_center_sk, 
  cs_bill_customer_sk, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__catalogsales
