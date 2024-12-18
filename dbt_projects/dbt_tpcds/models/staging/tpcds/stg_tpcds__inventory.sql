-- Source model for inventory in "staging schema"

with stg_tpcds__inventory as (
  Select * from {{ source('tpcds', 'inventory') }}
)
SELECT 
  inv_date_sk, 
  inv_item_sk, 
  inv_quantity_on_hand, 
  inv_warehouse_sk 
FROM 
  stg_tpcds__inventory
