# Retail Sales Analytics: End-to-End Data Pipeline

This project demonstrates a complete data engineering and analytics workflow. I moved from managing raw transaction data in a database to automating data quality checks and finally delivering business insights through an interactive dashboard.

## 🚀 Project Overview
The goal was to transform messy, raw retail data into a clean, reliable source of truth for business decision-making.

### 1. Data Extraction & Management (SQL)
* **Tool:** PostgreSQL
* **Action:** Created and managed relational tables to store retail transactions.
* **Skills:** Schema design, data types, and structural integrity.

### 2. Data Automation & Quality (Python)
* **Tool:** Python (Pandas)
* **Script:** `data_cleaning.py`
* **Action:** Developed an automated pipeline that:
    * Loads raw `.xlsx` or `.csv` files.
    * Programmatically identifies missing values (Null/NaN).
    * Removes incomplete records to ensure 100% data accuracy.
    * Exports a "Cleaned" dataset ready for visualization 

### 3. Data Visualization (Power BI)
* **Tool:** Power BI Desktop
* **Action:** Engineered a high-level executive dashboard connected directly to the cleaned Python output.
* **Key Visuals:**
    * **Total Revenue KPI:** Tracks the exact financial performance.
    * **Revenue by Product Category:** Identifies top-performing products (e.g., Product 103).
    * **Sales Volume Distribution:** Analyzes the physical movement of stock.

## 🛠️ Tech Stack
* **Database:** PostgreSQL
* **Languages:** SQL, Python
* **Libraries:** Pandas, Openpyxl
* **Visualization:** Power BI
* **Version Control:** Git & GitHub

## 📂 Project Structure
* `sql_scripts/`: SQL commands for database setup.
* `python_scripts/`: Python automation and cleaning logic.
* `data/`: Contains both `raw_data` and the Python-generated `cleaned_sales_data`.
* `Retail_Sales_Dashboard.pbix`: The source Power BI file.

## 📈 Final Result
The final dashboard provides a real-time view of sales performance with 0% data error rate, thanks to the automated Python cleaning layer.
