-- The final customer model in the "marts schema" that consolidates all the   
-- columns from the customer_snapshot model, together with columns from other 
-- customer related models

with customer_dim as (
  Select * from  {{ ref('customer_snapshot')}}
)
SELECT
    c_salutation,
    COALESCE(NULLIF(TRIM(c_preferred_cust_flag), ''), 'Unknown') as c_preferred_cust_flag,
    c_first_sales_date_sk,
    c_customer_sk,
    c_login,
    c_current_cdemo_sk,
    c_first_name,
    c_current_hdemo_sk,
    c_current_addr_sk,
    c_last_name,
    c_customer_id,
    c_last_review_date_sk,
    c_birth_month,
    c_birth_country,
    c_birth_year,
    c_birth_day,
    c_email_address,
    c_first_shipto_date_sk,
    ca_street_name,
    ca_suite_number,
    ca_state,
    COALESCE(NULLIF(TRIM(ca_location_type), ''), 'Unknown') ca_location_type,
    ca_country,
    ca_address_id,
    ca_county,
    ca_street_number,
    ca_zip,
    ca_city,
    ca_gmt_offset,
    cd_dep_employed_count,
    cd_dep_count,
    cd_credit_rating,
    cd_education_status,
    cd_purchase_estimate,
    cd_marital_status,
    cd_dep_college_count,
    cd_gender,
    hd_buy_potential,
    hd_dep_count,
    hd_vehicle_count,
    hd_income_band_sk,
    ib_lower_bound,
    ib_upper_bound
    -- dbt_valid_from as start_date,
    -- dbt_valid_to as end_date
FROM
    customer_dim c
    LEFT JOIN {{ ref('stg_tpcds__customeraddress') }} ON c_current_addr_sk = ca_address_sk
    LEFT join {{ ref('stg_tpcds__customerdemographics') }} ON c_current_cdemo_sk = cd_demo_sk
    LEFT join {{ ref('stg_tpcds__householddemographics') }} ON c_current_hdemo_sk = hd_demo_sk
    LEFT join {{ ref('stg_tpcds__incomeband') }} ON hd_income_band_sk = ib_income_band_sk
where c.dbt_valid_TO is null


