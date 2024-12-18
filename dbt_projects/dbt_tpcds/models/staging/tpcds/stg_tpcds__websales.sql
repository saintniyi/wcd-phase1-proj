-- Source model for websales in "staging schema". Contains daily sales data 
-- via the web channel

with stg_tpcds__websales as (
  Select * from {{ source('tpcds', 'websales') }}
)
SELECT 
  WS_ORDER_NUMBER, 
  WS_SHIP_MODE_SK, 
  WS_SOLD_TIME_SK, 
  WS_SHIP_ADDR_SK, 
  WS_NET_PAID_INC_TAX, 
  WS_PROMO_SK, 
  WS_NET_PAID_INC_SHIP, 
  WS_QUANTITY, 
  WS_EXT_SALES_PRICE, 
  WS_WEB_SITE_SK, 
  WS_SHIP_DATE_SK, 
  WS_BILL_CDEMO_SK, 
  WS_NET_PROFIT, 
  WS_NET_PAID, 
  WS_EXT_SHIP_COST, 
  WS_BILL_CUSTOMER_SK, 
  WS_COUPON_AMT, 
  WS_WHOLESALE_COST, 
  WS_SHIP_CUSTOMER_SK, 
  WS_BILL_HDEMO_SK, 
  WS_SOLD_DATE_SK, 
  ws_ship_cdemo_sk, 
  ws_warehouse_sk, 
  ws_ext_tax, 
  ws_item_sk, 
  ws_ship_hdemo_sk, 
  ws_ext_wholesale_cost, 
  ws_net_paid_inc_ship_tax, 
  ws_ext_discount_amt, 
  ws_sales_price, 
  ws_web_page_sk, 
  ws_ext_list_price, 
  ws_list_price, 
  ws_bill_addr_sk, 
  _airbyte_ab_id, 
  _airbyte_emitted_at, 
  _airbyte_normalized_at, 
  _airbyte_web_sales_hashid 
FROM 
  stg_tpcds__websales
