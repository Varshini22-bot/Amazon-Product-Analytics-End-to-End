# 🛒 Amazon Product Analytics using Databricks SQL & Power BI

![Databricks](https://img.shields.io/badge/Databricks-Data%20Engineering-orange?logo=databricks)
![SQL](https://img.shields.io/badge/SQL-Analytics-blue?logo=mysql)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)
![GitHub](https://img.shields.io/badge/GitHub-Version%20Control-black?logo=github)
![License](https://img.shields.io/badge/License-MIT-green)

---

# 📌 Project Overview

This project demonstrates an **End-to-End Data Engineering Solution** using **Databricks SQL**, **Delta Tables**, and **Power BI**.

The project follows the **Medallion Architecture (Bronze → Silver → Gold)** to ingest, clean, transform, validate, and analyze Amazon product data. The processed Gold Layer is then connected to Power BI to create interactive dashboards for business intelligence.

---

# 🎯 Objectives

- Build a complete ETL Pipeline
- Implement Medallion Architecture
- Clean and Transform Raw Data
- Perform Business SQL Analysis
- Create Gold Layer Analytics Tables
- Validate Data Quality
- Implement ETL Logging
- Build Interactive Power BI Dashboards
- Maintain Project using GitHub

---

# 🛠 Technology Stack

| Technology | Purpose |
|------------|---------|
| Databricks SQL | Data Engineering |
| SQL | Data Transformation |
| Delta Tables | Data Storage |
| Power BI | Dashboard & Visualization |
| GitHub | Version Control |
| CSV | Source Dataset |

---

# 🏗 Project Architecture

![Architecture](architecture/architecture.png)

---

# 🥉🥈🥇 Medallion Architecture

![Medallion](architecture/medallion_architecture.png)

The project follows the Medallion Architecture:

### Bronze Layer
- Raw Amazon Dataset
- No Transformations
- Original Data Preserved

### Silver Layer
- Remove Null Values
- Remove Duplicate Records
- Data Type Conversion
- Standardization

### Gold Layer
- Dashboard KPI
- Product Ranking
- Category Summary
- Rating Distribution
- Discount Analysis
- Price Segmentation

---

# 🔄 ETL Pipeline

![Pipeline](architecture/etl_pipeline.png)

Pipeline Flow:

```
CSV Dataset
     │
     ▼
Bronze Layer
     │
     ▼
Silver Layer
     │
     ▼
Gold Layer
     │
     ▼
Data Validation
     │
     ▼
ETL Logging
     │
     ▼
Power BI Dashboard
```

---

# 📂 Repository Structure

```
Amazon-Product-Analytics-End-to-End/

├── architecture/
├── dataset/
├── documentation/
├── notebooks/
├── powerbi/
├── screenshots/
├── README.md
├── LICENSE
└── .gitignore
```

---

# 📊 Gold Layer Tables

The following business-ready tables were created:

| Table | Purpose |
|--------|----------|
| gold_dashboard_kpi | Dashboard KPIs |
| gold_category_summary | Category Analysis |
| gold_product_ranking | Product Ranking |
| gold_discount_analysis | Discount Insights |
| gold_rating_distribution | Rating Analysis |
| gold_price_segment | Price Segmentation |

---

# ✔ Data Validation

The following validation rules were implemented:

- Duplicate Check
- Null Check
- Rating Validation
- Price Validation
- Category Validation

---

# 📝 ETL Logging

Pipeline logs include:

- Pipeline Status
- Execution Time
- Execution Date
- Records Processed
- Source Table
- Target Table

---

# 📈 Business SQL Analysis

The project answers business questions such as:

- Highest Rated Products
- Highest Discount Products
- Product Ranking
- Category Performance
- Premium vs Budget Products
- Rating Distribution
- Average Price Analysis

---

# 📷 Project Screenshots

## Databricks Workspace

![Workspace](screenshots/01_Workspace.png)

---

## Bronze Layer

![Bronze](screenshots/02_Bronze_Table.png)

---

## Silver Layer

![Silver](screenshots/03_Silver_Table.png)

---

## Gold Layer

![Gold](screenshots/04_Gold_Table.png)

---

## ETL Pipeline

![Pipeline Run](screenshots/05_ETL_Pipeline.png)

---

# 📊 Power BI Dashboard

## Executive Dashboard

![Executive](screenshots/06_Executive_Dashboard.png)

---

## Product Dashboard

![Product](screenshots/07_Product_Dashboard.png)

---

## Category Dashboard

![Category](screenshots/08_Category_Dashboard.png)

---

# 💼 Skills Demonstrated

- Data Engineering
- ETL Pipeline Development
- SQL Programming
- Delta Lake
- Medallion Architecture
- Data Cleaning
- Data Validation
- ETL Logging
- Power BI Dashboard Development
- Business Intelligence
- GitHub Version Control
- Technical Documentation

---

# 🚀 Future Enhancements

- Automated ETL Scheduling
- Incremental Data Loading
- Real-time Streaming
- Machine Learning Integration
- Product Recommendation Engine
- Sales Forecasting
- CI/CD Deployment

---

# 📄 Documentation

Complete project documentation is available in:

```
documentation/
```

---

# 👩‍💻 Author

**Varshini V B**

Aspiring Data Engineer | SQL | Databricks | Power BI | Python
