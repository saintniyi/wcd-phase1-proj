/* Test to confirm column 'item_sk' values of
 'model fact_weekly_sales_inventory' is either a subset or complete values
 found in column 'i_item_sk' of model 'item_dim' */
 
{{ column_contains_values(ref("fact_weekly_sales_inventory"), 'item_sk', ref("item_dim"), 'i_item_sk') }}