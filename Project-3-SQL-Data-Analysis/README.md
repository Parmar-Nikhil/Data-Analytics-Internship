# 📊 Project 3 – SQL Data Analysis

## 🛒 E-Commerce Sales Analysis

This project uses SQL to extract business insights from an E-Commerce Sales dataset.

### Objective
- Write SELECT queries
- Filter data with WHERE
- Sort results with ORDER BY
- Group data with GROUP BY
- Filter groups with HAVING
- Use COUNT, SUM, AVG, MIN and MAX
- Analyze dates and monthly trends
- Use CASE expressions
- Use subqueries and CTEs
- Use window functions such as RANK, LAG and running totals
- Generate business insights

## Dataset
- Rows: 1,200
- Columns: 14
- Unique customers: 1,189
- Date range: 2023-01-01 to 2025-06-30

## Tools
- MySQL 8+
- MySQL Workbench
- Excel/CSV

## Folder Structure

```text
Project_3_SQL_Data_Analysis/
│
├── data/
│   └── ecommerce_sales.csv
│
├── sql/
│   ├── 01_create_database_table.sql
│   ├── 02_import_data.sql
│   └── 03_analysis_queries.sql
│
├── results/
│   └── key_results.md
│
└── README.md
```

## Step-by-Step Execution

### Step 1 — Create database and table

Open MySQL Workbench and run:

```sql
SOURCE path/to/01_create_database_table.sql;
```

Or open `01_create_database_table.sql` and click the lightning/run button.

### Step 2 — Import the CSV

Use **MySQL Workbench → Navigator → Schemas → ecommerce_analytics → Tables → right-click → Table Data Import Wizard**.

Select:

```text
data/ecommerce_sales.csv
```

Import into:

```text
ecommerce_sales
```

### Step 3 — Verify the data

```sql
USE ecommerce_analytics;

SELECT COUNT(*) AS total_rows
FROM ecommerce_sales;

SELECT *
FROM ecommerce_sales
LIMIT 10;
```

Expected row count:

```text
1200
```

### Step 4 — Run SQL analysis

Open:

```text
sql/03_analysis_queries.sql
```

Run the queries section by section.

The project contains **30 SQL analysis queries**, starting from basic SELECT/WHERE/ORDER BY and progressing to GROUP BY, HAVING, CASE, subqueries, CTEs and window functions.

## Key Findings

- Total recorded sales: **₹1,264,761.96**
- Total orders: **1,200**
- Unique customers: **1,189**
- Average order value: **₹1,053.97**
- Top product by sales: **Chair**
- Top payment method by sales: **Credit Card**
- Top referral source by sales: **Instagram**

## SQL Skills Demonstrated

| Level | Skills |
|---|---|
| Basic | SELECT, LIMIT, DISTINCT |
| Filtering | WHERE, AND, OR, IN, BETWEEN |
| Sorting | ORDER BY |
| Aggregation | COUNT, SUM, AVG, MIN, MAX |
| Grouping | GROUP BY, HAVING |
| Logic | CASE |
| Dates | YEAR, DATE_FORMAT |
| Intermediate | Subqueries |
| Advanced | CTEs |
| Advanced | RANK(), ROW_NUMBER(), LAG() |
| Advanced | Window functions and running totals |

## Important Business Note

The dataset contains Cancelled and Returned orders. This project reports `total_price` as **recorded order value**. A true net-revenue metric should follow an explicit business rule for how cancelled and returned orders are treated.

## Author

**Parmar Nikhil**  
Aspiring Data Analyst

Skills: Excel • SQL • Python • Power BI • Data Cleaning • EDA

## Project Status

**COMPLETED ✅**
