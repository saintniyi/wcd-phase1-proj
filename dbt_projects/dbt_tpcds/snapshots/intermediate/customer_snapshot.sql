-- This model is a snapshot of the customer table
-- It perform slowly changing dimension (scd) using all columns of the customer table 
{% snapshot customer_snapshot %}

    {{
        config(
          target_schema='intermediate',
          strategy='check',
          unique_key='c_customer_sk',
          check_cols=['c_salutation', 'c_preferred_cust_flag', 'c_first_sales_date_sk', 
          'c_customer_sk', 'c_login', 'c_current_cdemo_sk', 'c_first_name', 'c_current_hdemo_sk', 
          'c_current_addr_sk', 'c_last_name', 'c_customer_id', 'c_last_review_date_sk', 
          'c_birth_month', 'c_birth_country', 'c_birth_year', 'c_birth_day', 'c_email_address', 
          'c_first_shipto_date_sk'],
          invalidate_hard_deletes=True
        )
    }}

    SELECT 
      c_salutation, 
      c_preferred_cust_flag, 
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
      _airbyte_normalized_at 
    FROM 
      {{ source('tpcds', 'customer') }}

{% endsnapshot %}