-- "Staging schema" source model for calendar and date related information  
-- such as day of week, week number, month number, year etc.

with stg_tpcds__datedim as (
  Select * from {{ source('tpcds', 'datedim') }}
)
SELECT 
  d_date_id, 
  cal_dt, 
  day_of_wk_desc, 
  wk_num, 
  mnth_num, 
  yr_mnth_num,  
  d_date_sk, 
  yr_num, 
  day_of_wk_num, 
  yr_wk_num, 
  _airbyte_normalized_at 
FROM 
  stg_tpcds__datedim
