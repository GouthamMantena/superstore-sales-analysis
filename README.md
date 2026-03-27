# SUPERSTORE SALES AND PROFIT ANALYSIS

**Project Overview:**
This project performs an end-to-end sales and profitability analysis using the Superstore dataset. The objective is to evaluate business performance, identify profit leakage, and understand the impact of discount strategies on overall profitability.

Data was analyzed using SQL for querying and transformation, and visualized using Power BI through an interactive dashboard designed for business decision-making

**Objectives:**
- Analyze overall sales, profit, and key business KPIs
- Identify high-performing and loss-making product categories
- Perform sub-category level profitability analysis
- Understand the relationship between discount and profit
- Build an interactive dashboard to present business insights

**Dataset:**
The dataset contains transactional retail data including order details, product categories, sales, profit, and discount information.

- Total records: 9,994
- Time period: 2014 – 2017
- Total sales: $2.3M+

**Tools & Technologies:**
- SQL (MySQL) → Data extraction & analysis
- Power BI → Data visualization & dashboard development
- DAX → KPI calculations and dynamic measures

**Data Analysis Process:**
1. Data Exploration (SQL)
   - Analyzed sales and profit trends
   - Evaluated category and sub-category performance
   - Investigated discount distribution and its impact
2. KPI Development (Power BI - DAX)
   Created Key business metrics:
   - Total Revenue
   - Total Profit
   - Profit Margin
   - Total Orders
   - Average Order Value

**Dashboard Preview**

![Dashboard](images/dashboard_preview.png)

**Dashboard Features:**

- KPI Cards: Revenue, Profit, Margin, Orders, AOV
- Trend Analysis: Sales & Profit over time
- Sub-Category Analysis: Identification of loss-making segments
- Category Analysis: Profitability by category
- Category Analysis: Profitability by category
---

**Key Insights:**
- Generated **$2.3M+** revenue with an overall **~12.5% profit margin**
- Sales increased consistently from **2014 to 2017**, but profit growth was not proportional
- **Furniture category underperforms, contributing to margin inefficiencies**
- **Tables and Bookcases are consistently loss-making sub-categories**
- Higher discount levels show a strong correlation with negative profitability

---

**Business Insights:**
- Optimize discount strategies to prevent margin erosion
- Re-evaluate pricing for loss-making sub-categories (Tables, Bookcases)
- Focus on high-margin categories like Technology
- Implement controlled discounting to improve profitability
---

**Project Structure** 
```
│
├── data
│ ├── raw
│ │ └── superstore_raw.csv
│ │
│ └── cleaned
│ └── superstore_cleaned.csv
│
├── sql
│ └── sales_analysis_queries.sql
│
├── dashboard
│ └── superstore_dashboard.twb
│
├── images
│ └── dashboard_preview.png
│
└── README.md
```
