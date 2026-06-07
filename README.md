
# SQL Data Warehouse Project

## Overview

This project demonstrates the design and implementation of a modern Data Warehouse using SQL Server and the Medallion Architecture approach (Bronze, Silver, and Gold layers).

The solution integrates data from multiple source systems (CRM and ERP), performs data cleansing and transformation, and delivers a business-ready analytical layer through dimensional modeling.

## Objectives

* Consolidate data from multiple operational systems.
* Build a scalable data warehouse architecture.
* Implement ETL processes using SQL Server.
* Clean and standardize source data.
* Create analytical datasets for reporting and business intelligence.

---

## Architecture

The project follows the Medallion Architecture pattern:

```text
Source Systems (CRM + ERP)
            │
            ▼
        Bronze Layer
     (Raw Ingestion)
            │
            ▼
        Silver Layer
   (Data Cleansing &
    Standardization)
            │
            ▼
         Gold Layer
    (Business-Ready
     Analytical Data)
```

---

## Data Sources

### CRM System

* Customer Information
* Product Information
* Sales Transactions

### ERP System

* Customer Attributes
* Product Categories
* Location Information

---

## Project Structure

```text
sql-data-warehouse-project/
│
├── Bronze/
│   ├── init_warehouse.sql
│   ├── ddl_bronze.sql
│   └── proc_load_bronze.sql
│
├── Silver/
│   ├── ddl_silver.sql
│   └── proc_load_silver.sql
│
├── Gold/
│   └── DDL_gold.sql
│
├── Source/
│   ├── source_crm/
│   └── source_erp/
│
└── README.md
```

---

## Layer Description

### Bronze Layer

The Bronze layer stores raw data extracted from source systems without business transformations.

Key Features:

* Raw data ingestion using BULK INSERT
* Source system preservation
* Historical data retention
* Staging area for downstream processing

### Silver Layer

The Silver layer applies data quality and transformation rules.

Key Features:

* Data cleansing
* Deduplication
* Standardization
* Null handling
* Data enrichment

Examples include:

* Customer gender standardization
* Product category normalization
* Duplicate record removal
* Data type corrections

### Gold Layer

The Gold layer provides business-ready datasets optimized for analytics.

Key Features:

* Dimensional modeling
* Customer dimension
* Product dimension
* Sales fact table
* Reporting-ready structure

Objects Created:

* gold.dim_customers
* gold.dim_products
* gold.fact_sales

---

## Technologies Used

* SQL Server
* T-SQL
* ETL Development
* Data Warehousing
* Dimensional Modeling
* Medallion Architecture

---

## Skills Demonstrated

* Data Warehouse Design
* ETL Pipeline Development
* SQL Programming
* Data Transformation
* Data Quality Management
* Dimensional Modeling
* Business Intelligence Preparation

---

## How to Run

1. Create the DataWarehouse database.
2. Execute scripts in the following order:

```text
1. Bronze/init_warehouse.sql
2. Bronze/ddl_bronze.sql
3. Bronze/proc_load_bronze.sql
4. Silver/ddl_silver.sql
5. Silver/proc_load_silver.sql
6. Gold/DDL_gold.sql
```

3. Update source file paths if necessary.
4. Execute stored procedures to load and transform the data.

---

## Future Improvements

* Incremental loading strategy
* Data quality monitoring
* Automated scheduling
* Performance optimization
* Dashboard integration with Power BI

---

## Author

Created as a personal portfolio project to demonstrate SQL Server Data Warehousing, ETL development, and dimensional modeling skills.
