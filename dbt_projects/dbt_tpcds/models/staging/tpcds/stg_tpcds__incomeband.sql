-- Source model for incomeband in "staging schema", a customer model related data

with stg_tpcds__income_band as (
  Select * from {{ source('tpcds', 'incomeband') }}
)
SELECT 
  ib_lower_bound, 
  ib_income_band_sk, 
  ib_upper_bound, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__income_band

