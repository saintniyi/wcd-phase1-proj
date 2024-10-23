-- The "marts schema" model contains data items and allows analysis to be 
-- carried out on sales and inventory in the fact_weekly_sales_inventory model

with item_dim as (
  Select * from {{ ref('stg_tpcds__item') }}
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
  i_rec_end_date
FROM 
  item_dim 