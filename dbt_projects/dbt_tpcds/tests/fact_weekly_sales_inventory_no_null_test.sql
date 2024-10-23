/* Test to confirm each of the columns 'warehouse_sk', 'item_sk', & 'sold_wk_sk'
of fact_weekly_sales_inventory model is not null */

{{ no_nulls_in_columns(ref("fact_weekly_sales_inventory"), 
['warehouse_sk', 'item_sk', 'sold_wk_sk']) }}