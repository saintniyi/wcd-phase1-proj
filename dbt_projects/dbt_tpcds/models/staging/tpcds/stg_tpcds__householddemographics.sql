-- Source model for householddemographics in "staging schema", 
-- a customer model related data

with stg_tpcds__householddemographics as (
  Select * from {{ source('tpcds', 'householddemographics') }}
)
SELECT 
  hd_buy_potential, 
  hd_income_band_sk, 
  hd_demo_sk, 
  hd_dep_count, 
  hd_vehicle_count, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__householddemographics
