{% docs customer_dim %}

This is the final merged cutomer model that is exposed to the end users which can be used for analysis.

The `customer_dim` model consolidates data from all other customer related model into this final model. Other customers related models merged with this model are: `customeraddress`, `customerdemographics`, `householddemographics`, and `incomeband`.

Each record in this final model is unique with the primary key as `c_customer_sk`. Using this model for analysis, end users can get insight into customer related data such as address, demographics, education, income and so on.

The `c_preferred_cust_flag` column in model has spaces in some of the rows. Those space are assigned the value of `unknown`. Available values for the column are: `Yes`, `No` and `Unknown`

Similarly, the `ca_location_type` column in the model has spaces in some of the rows. Those spaces are assigned the value of `unknown`. Available values for the column are: `single` `family`, `condo`, `apartment` and `unknown`

Tests performed on this model are: 
- uniqueness and not-null test on the `c_customer_sk` column
- accepted values test of `c_preferred_cust_flag` column
- accepted values test of `ca_location_type` column

{% enddocs %}