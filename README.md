# 🏗️ SQL Data Warehouse Project


A full end-to-end Data Warehouse built on SQL Server, integrating data from two operational source systems (CRM and ERP) through a **Medallion Architecture** (Bronze → Silver → Gold). The project covers raw ingestion, data cleansing and standardization, and a business-ready dimensional model ready for reporting and BI tooling.

> 📌 *Built as a portfolio project to demonstrate end-to-end data engineering skills — from raw ingestion to dimensional modeling.*

---

## 📋 Table of Contents

- [Architecture Overview](#architecture-overview)
- [Data Sources](#data-sources)
- [Layer Descriptions](#layer-descriptions)
- [Data Model](#data-model)
- [Project Structure](#project-structure)
- [How to Run](#how-to-run)
- [Skills Demonstrated](#skills-demonstrated)
- [About This Project & Author](#about-this-project--author)

---

## 🏛️ Architecture Overview

The pipeline follows the **Medallion Architecture** pattern — a layered approach that progressively refines raw data into analytics-ready output.

```
┌─────────────────────────────────────────────────────────────┐
│                     Source Systems                          │
│           CRM (customers, products, sales)                  │
│           ERP (attributes, categories, locations)           │
└───────────────────────┬─────────────────────────────────────┘
                        │  BULK INSERT
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                     BRONZE LAYER                            │
│              Raw ingestion — no transformations             │
│   crm_cust_info │ crm_prd_info │ crm_sales_details          │
│   erp_cust_az12 │ erp_loc_a101 │ erp_px_cat_g1v2           │
└───────────────────────┬─────────────────────────────────────┘
                        │  Cleanse & Standardize
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                     SILVER LAYER                            │
│      Deduplicated, standardized, null-handled records       │
│   crm_cust_info │ crm_prd_info │ crm_sales_details          │
│   erp_cust_az12 │ erp_loc_a101 │ erp_px_cat_g1v2           │
└───────────────────────┬─────────────────────────────────────┘
                        │  Dimensional Modeling
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                      GOLD LAYER                             │
│           Business-ready star schema for analytics          │
│     gold.dim_customers │ gold.dim_products │ gold.fact_sales │
└─────────────────────────────────────────────────────────────┘
```

---

## 📂 Data Sources

| System | Contents |
|--------|----------|
| **CRM** | Customer information, product catalog, sales transactions |
| **ERP** | Customer attributes, product categories, location data |

Data is loaded from flat files using `BULK INSERT` into the Bronze layer.

---

## 🔍 Layer Descriptions

### 🥉 Bronze — Raw Ingestion

The Bronze layer stores source data exactly as received, without any transformation. It acts as an audit trail and reprocessing baseline.

- Raw BULK INSERT from flat files
- No business logic applied
- Preserves source system fidelity

### 🥈 Silver — Cleansed & Standardized

The Silver layer applies data quality rules to produce consistent, reliable records.

Transformations include:
- Gender field standardization (e.g., `M/F` → `Male/Female`)
- Product category normalization
- Duplicate record removal
- NULL handling and data type corrections
- Data enrichment from cross-system joins

### 🥇 Gold — Business-Ready Analytics

The Gold layer implements a **star schema** optimized for reporting and BI tools.

| Object | Type | Description |
|--------|------|-------------|
| `gold.dim_customers` | Dimension | Consolidated customer master with attributes |
| `gold.dim_products` | Dimension | Product catalog with category hierarchy |
| `gold.fact_sales` | Fact | Transactional sales data with foreign keys to dimensions |

---

## 📐 Data Model

```
                    ┌──────────────────────┐
                    │   gold.dim_customers  │
                    │  customer_key (PK)    │
                    │  customer_id          │
                    │  name, country, ...   │
                    └──────────┬───────────┘
                               │
┌──────────────────────┐       │       ┌──────────────────────┐
│   gold.dim_products   │       │       │    gold.fact_sales    │
│  product_key (PK)    │◄──────┼──────►│  order_number (PK)   │
│  product_name        │       │       │  customer_key (FK)   │
│  category, cost, ... │       └───────┤  product_key (FK)    │
└──────────────────────┘               │  order_date          │
                                       │  sales_amount        │
                                       │  quantity, price, ...│
                                       └──────────────────────┘
```

---

## 📁 Project Structure

```
sql-data-warehouse-project/
│
├── Bronze/
│   ├── init_warehouse.sql       # Database and schema initialization
│   ├── ddl_bronze.sql           # Bronze table definitions
│   └── proc_load_bronze.sql     # Stored procedure: raw data ingestion
│
├── Silver/
│   ├── ddl_silver.sql           # Silver table definitions
│   └── proc_load_silver.sql     # Stored procedure: cleansing & transforms
│
├── Gold/
│   └── DDL_gold.sql             # Gold views/tables: dimensional model
│
├── Source/
│   ├── source_crm/              # CRM flat files
│   └── source_erp/              # ERP flat files
│
└── README.md
```

---

## ▶️ How to Run

> **Prerequisites:** SQL Server (2019 or later recommended), SSMS or Azure Data Studio.

**Step 1 — Initialize the warehouse**
```sql
-- Creates the DataWarehouse database and schemas (bronze, silver, gold)
EXEC Bronze/init_warehouse.sql
```

**Step 2 — Run scripts in order**

| Order | Script | Purpose |
|-------|--------|---------|
| 1 | `Bronze/init_warehouse.sql` | Initialize DB and schemas |
| 2 | `Bronze/ddl_bronze.sql` | Create Bronze tables |
| 3 | `Bronze/proc_load_bronze.sql` | Load raw source data |
| 4 | `Silver/ddl_silver.sql` | Create Silver tables |
| 5 | `Silver/proc_load_silver.sql` | Cleanse and transform data |
| 6 | `Gold/DDL_gold.sql` | Build dimensional model |

**Step 3 — Update file paths**

Before executing `proc_load_bronze.sql`, update the `BULK INSERT` file paths to match your local source file locations.

**Step 4 — Execute stored procedures**
```sql
EXEC bronze.load_bronze;
EXEC silver.load_silver;
```

---

## 💡 Skills Demonstrated

This project covers the full lifecycle of a data warehouse build:

- 🏗️ **Data Architecture** — Designed a multi-layer Medallion Architecture from scratch
- ⚙️ **ETL Development** — Built reusable stored procedures for ingestion and transformation
- 📐 **Data Modeling** — Implemented a star schema (fact + dimension tables) in the Gold layer
- ✅ **Data Quality** — Applied systematic cleansing: deduplication, standardization, NULL handling
- 🛠️ **T-SQL** — Used CTEs, window functions, stored procedures, and DDL across all layers
- 📊 **BI Readiness** — Delivered a reporting-ready schema consumable by Power BI or similar tools

---

## 👤 About This Project & Author

**Mersad** — Civil Engineer transitioning into Data Analytics.
Built as part of a self-directed portfolio to demonstrate end-to-end data warehousing skills.

This project was designed and built independently to demonstrate practical skills in data warehouse architecture, ETL pipeline development, and dimensional data modeling using SQL Server. The dataset simulates a real-world business scenario with two integrated source systems — a CRM and an ERP — producing a unified analytical layer ready for business intelligence consumption.

🔗 [GitHub Portfolio](https://github.com/Mersad-MAZ)
