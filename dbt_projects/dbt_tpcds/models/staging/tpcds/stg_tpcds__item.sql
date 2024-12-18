-- Source model for item in "staging schema"

with stg_tpcds__item as (
  Select * from {{ source('tpcds', 'item') }}
)
SELECT 
  i_item_desc, 
  i_container, 
  i_manufact_id, 
  i_wholesale_cost, 
  i_brand_id, 
  i_formulation, 
  i_current_price, 
  i_size, 
  i_manufact, 
  i_rec_start_date, 
  i_item_sk, 
  i_manager_id, 
  i_class, 
  i_item_id, 
  i_class_id, 
  i_category, 
  i_category_id, 
  i_brand, 
  i_units, 
  i_color, 
  i_product_name, 
  i_rec_end_date, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__item

