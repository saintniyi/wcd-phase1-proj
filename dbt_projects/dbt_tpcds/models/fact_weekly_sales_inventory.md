{% docs fact_weekly_sales_inventory %}

Fact tables containing sales data and inventory data that has been
aggregated for weekly analysis, curated from catalog sales and web sales
channels.

It is an incremental model that will add new weekly aggregated data incrementally.

Each record in the model is unique by the combination of three columns: `warehouse_sk`, `item_sk`, `sold_wk_sk` and represent weekly based aggregation that can be analysed based on date, item and warehous dimensions to provide further insight to help decision making.

The model contains tests such as: 
- not-null for each of the three columns: `warehouse_sk`, `item_sk`, `sold_wk_sk` 
- uniquess of the combined three columns: `warehouse_sk`, `item_sk`, `sold_wk_sk`   
- confirmation of relationship and the same distinct values in columns `warehouse_sk` and `w_warehouse_sk`'of the  `fact_weekly_sales_inventory` and `warehouse_dim` models
- confirmation that each of the three columns values of `warehouse_sk`, `item_sk`, `sold_wk_sk` of the `fact_weekly_sales_inventory` is wholly contained or subset of their respective columns `w_warehouse_sk`, `i_item_sk`, `d_date_sk` of the `warehouse_dim`, `item_dim`, `date_dim` models.

{% enddocs %}