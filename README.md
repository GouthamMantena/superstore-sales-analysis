#  End-to-End Sales & Profitability Analysis Pipeline

##  Project Overview

This project performs an end-to-end sales and profitability analysis using the Superstore dataset.
The goal is to track business performance, identify profit leakage, and evaluate the impact of discount strategies on overall profitability.

The workflow integrates SQL for data analysis and Power BI for building an interactive dashboard, simulating a real-world data analytics pipeline.

---

##  Objectives

* Analyze sales, profit, and key business KPIs
* Identify high-performing and loss-making categories
* Perform sub-category level profitability analysis
* Evaluate the impact of discounting on profit
* Build an interactive dashboard for business insights

---

##  Dataset

* Total records: **9,994**
* Time period: **2014 – 2017**
* Total sales: **$2.3M+**

The dataset includes order details, product categories, sales, profit, and discount information.

---

##  Tools & Technologies

* **SQL (MySQL)** – Data extraction and analysis
* **Power BI** – Dashboard and visualization
* **DAX** – KPI calculations

---

##  Data Analysis Workflow

### 1. Data Processing (SQL)

* Queried and analyzed transactional data
* Aggregated key metrics such as revenue and profit
* Evaluated category and sub-category performance

### 2. Data Modeling (Power BI)

* Connected SQL data to Power BI
* Created dynamic KPI measures using DAX

### 3. Dashboard Development

Built an interactive dashboard including:

* KPI Cards (Revenue, Profit, Margin, Orders, AOV)
* Sales & Profit Trend Analysis
* Category and Sub-Category Performance
* Discount vs Profit Analysis

---

##  Dashboard Preview

![Dashboard](images/dashboard_preview.png)

---

##  Key Insights

* Generated **$2.3M+ revenue** with ~**12.5% profit margin**
* Sales increased over time, but profit did not scale proportionally
* **Furniture category underperforms** compared to others
* **Tables and Bookcases are loss-making sub-categories**
* Higher discount levels lead to **negative profitability**

---

##  Business Recommendations

* Reduce excessive discounting to prevent margin loss
* Re-evaluate pricing for underperforming sub-categories
* Focus on high-margin categories like Technology

---

##  Project Outcome

Developed a professional analytics dashboard that transforms raw data into actionable insights, enabling better decision-making and highlighting key drivers of profit loss.

---

##  Project Structure

```
dashboard/
data/
images/
sql/
README.md
```
