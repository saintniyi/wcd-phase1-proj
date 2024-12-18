-- Source model for warehouse in "staging schema"

with stg_tpcds__warehouse as (
  Select * from {{ source('tpcds', 'warehouse') }}
)
SELECT 
  w_zip, 
  w_warehouse_name, 
  w_street_name, 
  w_state, 
  w_city, 
  w_county, 
  w_street_type, 
  w_warehouse_sq_ft, 
  w_suite_number, 
  w_street_number, 
  w_country, 
  w_warehouse_sk, 
  w_gmt_offset, 
  w_warehouse_id, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__warehouse
