-- Source model for callcenter "staging schema", a customer model related data

with stg_tpcds__customerdemographics as (
  Select * from {{ source('tpcds', 'customerdemographics') }}
)
SELECT 
  cd_dep_employed_count, 
  cd_demo_sk, 
  cd_dep_count, 
  cd_credit_rating, 
  cd_education_status, 
  cd_purchase_estimate, 
  cd_marital_status, 
  cd_dep_college_count, 
  cd_gender, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__customerdemographics

  
