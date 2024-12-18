/* Test to confirm column 'warehouse_sk' values of
 'model fact_weekly_sales_inventory' is either a subset or complete values
 found in column 'w_warehouse_sk' of model 'warehouse_dim' */
 
{{ column_contains_values(ref("fact_weekly_sales_inventory"), 'warehouse_sk', 
ref("warehouse_dim"), 'w_warehouse_sk') }}