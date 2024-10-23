# WCD Phase 1 Project

## Overview

The **WCD Phase 1 Project** is an Analytical Data Engineering initiative that involves ingesting data from multiple sources into a Snowflake data warehouse. After a series of transformations using dbt, the data is prepared for analytics and business intelligence reporting, which is conducted using Metabase.

<br>

<i>Project Architecture diagram below:</i>

<br>

![Project Architecture diagram](screenshots/projectarchitecture.jpg)

## Table of Contents

- [Features](#features)
- [Technologies](#technologies)
- [Data Ingestion](#data-ingestion)
- [Data Transformation](#data-transformation)
- [Testing](#testing)
- [Business Intelligence](#business-intelligence)

## Features

- Ingestion of data and integration with Snowflake for data warehousing
- Data transformation with dbt
- Business intelligence reporting, dashboards, and visualizations with Metabase

## Technologies

- **Data Storage and Warehousing:** Snowflake
- **Data Ingestion:** Airbyte, AWS Lambda
- **Data Transformation:** dbt, Python, SQL
- **Business Intelligence:** Metabase
- **Cloud Services:** AWS (CloudShell, CloudWatch, EC2, EventBridge, IAM, Lambda, S3)

## Data Ingestion

Data is ingested from two sources:

### Data Ingestion and Integration with Snowflake using Airbyte

Data is ingested from the TPC-DS database in AWS RDS PostgreSQL into the RAW schema of the Snowflake database using **Airbyte**. The data consists of the retail sales dataset from the relational TPC-DS database.

<br>

<i>See screenshot of Airbyte connection from PostgreSQL to Snowflake below:</i>

<br>

![Airbyte connection screenshot](screenshots/airbyteconnection.jpg)

<br>

<i>Airbyte ingestion job screenshot below:</i> 

<br>

![Airbyte ingestion job screenshot](screenshots/airbyteingestionjob.jpg)

<br>

### Data Ingestion and Integration with Snowflake Using AWS Lambda

Inventory data is ingested from an API source and saved to an AWS S3 bucket, from which it will be loaded into the RAW schema of the TPC-DS database in Snowflake using an **AWS Lambda function**. For detailed implementation of the ingestion process into Snowflake with Lambda, refer to the [Lambda function](/LambdaCode/lambda_function.py).

<br>

<i>Lambda ingestion screenshot below:</i>

<br>

<table style="width: 100%; border-collapse: collapse;">
  <tr>
    <td style="width: 40%; padding: 10px; vertical-align: top; border-right: 1px solid #ddd;">
      <img src="/screenshots/lambdaingestion.jpg" alt="Lambda ingestion" width="100%">
    </td>
    <td style="width: 40%; padding: 10px; vertical-align: top;">
      <img src="/screenshots/cloudwatch.jpg" alt="CloudWatch" width="100%">
    </td>
  </tr>
</table>

<br>

<div align="right">

  [Back to Table of Contents](#table-of-contents) &nbsp; [Back to Top](#overview)

</div>

<br>


## Data Transformation

The ingested data undergoes three stages of transformations within Snowflake using **dbt**.

1. In the **first stage**, the data undergoes transformations in the RAW schema and stores the output in the **staging** schema of the TPC-DS Snowflake database. Refer to files in the folder [Staging](./dbt_projects/dbt_tpcds/models/staging/tpcds/) for Staging schema transformations.

2. The **second stage** further transforms the data in the staging schema and stores the final result in the **intermediate** schema of the TPC-DS Snowflake database. Refer to files in the folder [Intermediate](./dbt_projects/dbt_tpcds/models/intermediate/sales/) for Intermediate schema transformations.

3. The **final stage** performs additional transformations on the data in the intermediate schema and stores the output in the **Marts** schema of the same Snowflake database. Refer to files in the folder [Marts](./dbt_projects/dbt_tpcds/models/marts/sales/) for Marts schema transformations.

<br>

<i>Marts Schema screenshot below:</i>

<br>

![Marts Schema](/screenshots/martschema.jpg)

<br>

<i>See below the data lineage of the data flow in the project:</i>

<br>

<img src="/screenshots/dbt-dag.jpg" alt="Data Lineage" width="800" height="400">


<br>

<div align="right">

  [Back to Table of Contents](#table-of-contents) &nbsp; [Back to Top](#overview)

</div>

<br>


## Testing

To ensure data quality, various tests were performed to validate the integrity and accuracy of the data throughout the pipeline. These tests included:

1. **Schema Tests**
2. **Uniqueness Tests**
3. **Not Null Tests**
4. **Referential Integrity Tests**
5. **Accepted Values Tests**
6. **Subset Validation Tests**

Refer to the folder [Tests](./dbt_projects/dbt_tpcds/tests/), [Macros](./dbt_projects/dbt_tpcds/macros/), and the [Schema file](./dbt_projects/dbt_tpcds/models/schema.yml) for tests implemented.

<br>

<i>See screenshots of tests below:</i>

<br>

<table style="width: 100%; border-collapse: collapse;">
  <tr>
    <td style="width: 40%; padding: 10px; vertical-align: top; border-right: 1px solid #ddd;">
      <img src="/screenshots/dbtTest1.jpg" alt="dbt tests" width="100%">
    </td>
    <td style="width: 40%; padding: 10px; vertical-align: top;">
      <img src="/screenshots/dbtTest2.jpg" alt="dbt tests" width="100%">
    </td>
  </tr>
</table>

<br>

<div align="right">

  [Back to Table of Contents](#table-of-contents) &nbsp; [Back to Top](#overview)

</div>

<br>

## Business Intelligence

**Metabase** is now connected to the transformed data in the Marts schema of the TPC-DS database in Snowflake and is used to create dashboards and reports. Refer to the folder [Report Files](./Reports/) for PDF files containing screenshots of the reports.

<br>


## Acknowledgements

Thanks to the WeCloudData team for their support and collaboration throughout this project.

<br>

<div align="right">

  [Back to Table of Contents](#table-of-contents) &nbsp; [Back to Top](#overview)

</div>