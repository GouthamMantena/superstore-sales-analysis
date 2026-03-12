CREATE DATABASE sales_analysis;
USE sales_analysis;

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
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2)
);


SELECT COUNT(*) FROM superstore;

SELECT order_date FROM superstore LIMIT 5;

UPDATE superstore
SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y');

SET SQL_SAFE_UPDATES=0;

UPDATE superstore
SET ship_date=STR_TO_DATE(ship_date, '%m/%d/%Y');

SET SQL_SAFE_UPDATES=1;

ALTER TABLE superstore MODIFY order_date DATE;
ALTER TABLE superstore MODIFY ship_date DATE;

SELECT order_date FROM superstore LIMIT 5;

SELECT ROUND(SUM(sales),2) AS total_revenue
FROM superstore;

SELECT ROUND(SUM(profit),2) AS total_profit
FROM superstore;

SELECT ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore;

SELECT ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS avg_order_value
FROM superstore;

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

SELECT
YEAR(order_date) AS order_year,
ROUND(SUM(sales),2) AS yearly_revenue,
ROUND(SUM(profit),2) AS yearly_profit
FROM superstore
GROUP BY YEAR(order_date)
ORDER BY order_year;


SELECT 
YEAR(order_date) AS order_year,
ROUND (SUM(sales),2) as yearly_revenue,
ROUND((SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY YEAR(order_date))) 
/ LAG(SUM(sales)) OVER (ORDER BY YEAR(order_date)) * 100, 2
) AS revenue_growth_percentage
FROM superstore
GROUP BY YEAR(order_date)
ORDER BY order_year;

SELECT 
DATE_FORMAT (order_date, '%Y-%m') AS month,
ROUND(SUM(sales),2) AS monthly_revenue
FROM superstore
GROUP BY month
ORDER BY month;


SELECT 
category,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


SELECT 
sub_category,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore
WHERE category='Furniture'
GROUP BY sub_category
ORDER BY total_profit ASC;

SELECT sub_category,
ROUND(AVG(discount),2) AS avg_discount,
ROUND(SUM(profit),2) AS total_profit
FROM superstore
WHERE category='Furniture'
GROUP BY sub_category
ORDER BY avg_discount DESC;



SELECT *
FROM superstore
WHERE sub_category='Tables';


SELECT discount,
ROUND(SUM(profit),2) AS total_profit,
COUNT(*) AS transactions
FROM superstore
WHERE category='Furniture'
GROUP BY discount
ORDER BY discount DESC;



SELECT region,
ROUND(SUM(sales),2)AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore
WHERE category='Furniture'
GROUP BY region
ORDER BY total_profit ASC;


SELECT region,
ROUND(AVG(discount),2) AS avg_discount,
ROUND(SUM(profit),2) AS total_profit
FROM superstore
WHERE category='Furniture'
GROUP BY region
ORDER BY avg_discount DESC;



SELECT region, sub_category,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore
WHERE category='Furniture'
GROUP BY region, sub_category
ORDER BY region, total_profit ASC;


SELECT *
FROM superstore
INTO OUTFILE 'C:/superstore_clean_export.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';




