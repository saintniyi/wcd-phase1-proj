/* Test to confirm column 'sold_wk_sk' values of
 'model fact_weekly_sales_inventory' is either a subset or complete values
 found in column 'd_date_sk' of model 'd_date_sk' */
 
{{ column_contains_values(ref("fact_weekly_sales_inventory"), 'sold_wk_sk', ref("date_dim"), 'd_date_sk') }}