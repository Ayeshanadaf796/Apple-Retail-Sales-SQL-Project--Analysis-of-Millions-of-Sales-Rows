# Apple Retail Sales SQL Project - Analyzing Millions of Sales Rows

<p align="center">
  <img src="images/apple store image.jpg" alt="apple Logo" width="1000"/>
</p>

## 📌 Project Overview

- Analyze Apple retail sales to uncover trends in store performance and product popularity.

- Calculate key metrics such as revenue, units sold, and regional performance.

- Examine warranty claims to identify patterns and potential issues.

- Determine sales peaks, best-selling products, and customer behavior insights.

- Use advanced SQL techniques to answer complex business questions.

- Track year-over-year growth, correlations between price and warranty claims, and other actionable insights.

---
## 🗄️Dataset

- **Size**: 1 million+ rows of sales data.
- **Period Covered**: The data spans multiple years, allowing for long-term trend analysis.
- **Geographical Coverage**: Sales data from Apple stores across various countries.

---
## 🧩Entity Relationship Diagram(ERD)

<p align="center">
  <img src="images/ERD - Apple retail analysis.png" alt="ERD" width="1000"/>
</p>

---
## 📊Database Schema

The project uses five main tables:

1. **stores**: Contains information about Apple retail stores.
   - `store_id`: Unique identifier for each store.
   - `store_name`: Name of the store.
   - `city`: City where the store is located.
   - `country`: Country of the store.

2. **category**: Holds product category information.
   - `category_id`: Unique identifier for each product category.
   - `category_name`: Name of the category.

3. **products**: Details about Apple products.
   - `product_id`: Unique identifier for each product.
   - `product_name`: Name of the product.
   - `category_id`: References the category table.
   - `launch_date`: Date when the product was launched.
   - `price`: Price of the product.

4. **sales**: Stores sales transactions.
   - `sale_id`: Unique identifier for each sale.
   - `sale_date`: Date of the sale.
   - `store_id`: References the store table.
   - `product_id`: References the product table.
   - `quantity`: Number of units sold.

5. **warranty**: Contains information about warranty claims.
   - `claim_id`: Unique identifier for each warranty claim.
   - `claim_date`: Date the claim was made.
   - `sale_id`: References the sales table.
   - `repair_status`: Status of the warranty claim (e.g., Paid Repaired, Warranty Void).

---
## 🔎Project Focus

This project primarily focuses on developing and showcasing the following SQL skills:

- **Complex Joins and Aggregations**: Demonstrating the ability to perform complex SQL joins and aggregate data meaningfully.
- **Window Functions**: Using advanced window functions for running totals, growth analysis, and time-based queries.
- **Data Segmentation**: Analyzing data across different time frames to gain insights into product performance.
- **Correlation Analysis**: Applying SQL functions to determine relationships between variables, such as product price and warranty claims.
- **Real-World Problem Solving**: Answering business-related questions that reflect real-world scenarios faced by data analysts.

---
## 🎯 Project Objectives

This project is designed to test SQL skills through Apple retail sales analysis, structured into three tiers of questions from basic to complex:

### 🟢 Easy to Medium (10 Questions)
-  Find the number of stores in each country
-  Calculate the total number of units sold by each store
-  Identify how many sales occurred in December 2023
-  Determine how many stores have never had a warranty claim filed
-  Calculate the percentage of warranty claims marked as "Rejected"
-  Identify which store had the highest total units sold in the last year
-  Count the number of unique products sold in the last year
-  Find the average price of products in each category
- How many warranty claims were filed in 2024
- For each store, identify the best-selling day based on highest quantity sold

### 🟡 Medium to Hard (5 Questions)
-  Identify the least selling product in each country for each year based on total units sold
-  Calculate how many warranty claims were filed within 180 days of a product sale
-  Determine how many warranty claims were filed for products launched in the last two years
-  List the months in the last three years where sales exceeded 5,000 units in the Australia
-  Identify the product category with the most warranty claims filed in the last two years

### 🔴 Complex (6 Questions)
-  Determine the percentage chance of receiving warranty claims after each purchase for each country
-  Analyze the year-by-year growth ratio for each store
-  Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range
-  Identify the store with the highest percentage of repair status "Completed" claims relative to total claims filed
-  Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends
-  Analyze product sales trends over time, segmented into key periods: from launch to 6 months, 6–12 months, 12–18 months, and beyond 18 months

---
## 🧠 Key Insights
-  **Strong Early Demand**: Most products experience their highest sales within the first 6 months after launch, reflecting strong initial market excitement and effective launch   campaigns.
-  **Stabilization Phase (6–12 Months)**: Sales begin to stabilize or slightly decline as the initial hype fades and competition increases.
-  **Decline Phase (12–18 Months)**: A clear downward trend is observed in many products as customer interest shifts toward newer models.
-  **Sustained Long-Term Sales (>18 Months)**: Certain products maintain steady performance even beyond 18 months, showing brand loyalty, strong reputation, or continued market demand.

 ---
 ## 📈 Conclusions
- The first 6–12 months contribute the majority of total sales, underscoring the importance of a well-planned product launch and early marketing push.
- Sales decay patterns help in understanding the product life cycle and can guide production and inventory decisions.
- Products that sustain sales after 18 months are long-term value drivers and may benefit from price optimizations, refreshed marketing, or rebranding strategies.
- Analyzing sales by post-launch periods helps forecast demand trends, allocate budgets efficiently, and plan product replacement cycles more effectively.

---
## 💡 Business Implication

This analysis helps stakeholders identify:

1. When to invest in marketing for new products.
2. Which products have lasting market value.
3. How to time promotions or discounts to extend the profitable life cycle of each product.











