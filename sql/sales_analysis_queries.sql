CREATE DATABASE IF NOT EXISTS sales_analysis;
USE sales_analysis;

DROP TABLE IF EXISTS superstore;
CREATE TABLE superstore(
    row_id INT,
    order_id VARCHAR(50),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales DECIMAL(12,4),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(12,4)
);

# LOAD RAW DATA
-- Requires local_infile enabled (MySQL Workbench: connection > Advanced > OPT_LOCAL_INFILE=1).
-- Run from the repository root, or replace the path with the full path to the CSV.

LOAD DATA LOCAL INFILE 'data/raw/superstore_raw.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT COUNT(*) FROM superstore;  -- expected: 9994

SELECT order_date FROM superstore LIMIT 5;

# 1. DATA CLEANING

-- Data quality checks
SELECT COUNT(*) - COUNT(DISTINCT row_id) AS duplicate_rows FROM superstore;

SELECT
SUM(order_id IS NULL) AS missing_order_id,
SUM(sales IS NULL) AS missing_sales,
SUM(profit IS NULL) AS missing_profit
FROM superstore;

-- Convert text dates (e.g. 11/8/2016) to real DATE values
SET SQL_SAFE_UPDATES=0;

UPDATE superstore
SET order_date = DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m-%d'),
    ship_date  = DATE_FORMAT(STR_TO_DATE(ship_date, '%m/%d/%Y'), '%Y-%m-%d');

SET SQL_SAFE_UPDATES=1;

ALTER TABLE superstore
MODIFY order_date DATE,
MODIFY ship_date DATE;

SELECT order_date FROM superstore LIMIT 5;

# 2. KPI LAYER

CREATE OR REPLACE VIEW kpi_summary AS
SELECT 
ROUND(SUM(sales),2) AS total_revenue,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage,
ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS avg_order_value,
COUNT(DISTINCT order_id) AS total_orders
FROM superstore;
SELECT * FROM kpi_summary;

# MONTHLY PERFORMANCE

CREATE OR REPLACE VIEW monthly_trends AS
SELECT
DATE_FORMAT(order_date, '%Y-%m') AS month,
ROUND(SUM(sales),2) AS revenue,
ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY month
ORDER BY month;
SELECT * FROM monthly_trends;


# YEARLY GROWTH

CREATE OR REPLACE VIEW yearly_growth AS
SELECT 
YEAR(order_date) AS year,
ROUND (SUM(sales),2) as revenue,
ROUND(
(SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY YEAR(order_date))) 
/ LAG(SUM(sales)) OVER (ORDER BY YEAR(order_date)) * 100, 2) AS growth_percentage
FROM superstore
GROUP BY YEAR;
SELECT * FROM yearly_growth;


# CATEGORY PROFITABILITY

CREATE OR REPLACE VIEW category_profitability AS
SELECT 
category,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore
GROUP BY category;
SELECT * FROM category_profitability;


# SUB-CATEGORY DEEP DIVE

CREATE OR REPLACE VIEW subcategory_profitability AS
SELECT 
sub_category,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore
GROUP BY sub_category
ORDER BY sub_category;
SELECT * FROM subcategory_profitability;


# DISCOUNT IMPACT

CREATE OR REPLACE VIEW discount_impact AS
SELECT 
discount,
COUNT(*) AS transactions,
ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY discount
ORDER BY discount DESC;
SELECT * FROM discount_impact;


# REGIONAL PERFORMANCE

CREATE OR REPLACE VIEW regional_performance AS
SELECT 
region,
ROUND(SUM(sales),2)AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore
GROUP BY region;
SELECT * FROM regional_performance;


# 3. BUSINESS ANALYSIS LAYER

-- Furniture profit loss from high discounts (discount >= 20%)

WITH furniture_discount AS (
    SELECT
        sub_category,
        discount,
        profit
    FROM superstore
    WHERE category = 'Furniture'
      AND discount >= 0.2
)
SELECT
    sub_category,
    COUNT(*) AS transactions,
    ROUND(SUM(profit), 2) AS total_profit
FROM furniture_discount
GROUP BY sub_category
ORDER BY total_profit;

-- Identify Loss-Making Products

SELECT *
FROM subcategory_profitability
WHERE total_profit < 0
ORDER BY total_profit;

-- High Discount

SELECT *
FROM discount_impact
WHERE discount >=0.2
ORDER BY total_profit;

-- WORST PERFORMING REGIONS

SELECT *
FROM regional_performance
ORDER BY total_profit ASC;


-- PROFIT LEAK

SELECT 
region,
category,
ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region, category
ORDER BY total_profit ASC;


# 4. Export Layer
-- Saved as data/cleaned/superstore_cleaned.csv (all 9,994 rows).
-- In MySQL Workbench, set the result limit to "Don't Limit" before exporting,
-- otherwise only the first 1,000 rows are saved.

SELECT
    order_date,
    region,
    category,
    sub_category,
    sales,
    profit,
    discount
FROM superstore
ORDER BY order_date;
