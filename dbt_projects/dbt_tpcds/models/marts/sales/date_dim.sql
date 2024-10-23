-- This "marts schema" model contains data on date, day, week, month and year 
-- and can be used in analysis relating to date

with date_dim as (
  SELECT * FROM {{ ref('stg_tpcds__datedim') }}
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
  yr_wk_num 
FROM 
  date_dim