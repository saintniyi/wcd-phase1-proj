-- Source model for customeraddress in "staging schema", a customer model 
-- related data

with stg_tpcds__customeraddress as (
  Select * from {{ source('tpcds', 'customeraddress') }}
)
SELECT 
  ca_street_name, 
  ca_suite_number, 
  ca_state, 
  ca_location_type, 
  ca_address_sk, 
  ca_country, 
  ca_address_id, 
  ca_county, 
  ca_street_number, 
  ca_zip, 
  ca_city, 
  ca_street_type, 
  ca_gmt_offset, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__customeraddress
