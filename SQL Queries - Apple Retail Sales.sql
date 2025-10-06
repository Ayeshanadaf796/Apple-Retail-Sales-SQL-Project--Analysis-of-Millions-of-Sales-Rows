-- Apple Retail Sales Project - 1M Rows Sales Data

SELECT * FROM `apple-474214.retail_sales_data.category`;

SELECT * FROM `apple-474214.retail_sales_data.sales`;

SELECT * FROM `apple-474214.retail_sales_data.products`;

SELECT * FROM `apple-474214.retail_sales_data.stores`;

SELECT * FROM `apple-474214.retail_sales_data.warranty`;


-- EDA 

SELECT DISTINCT product_name FROM `apple-474214.retail_sales_data.products`;

SELECT DISTINCT repair_status FROM `apple-474214.retail_sales_data.warranty`;

SELECT COUNT (*) FROM `apple-474214.retail_sales_data.sales`;

SELECT COUNT (*) FROM `apple-474214.retail_sales_data.warranty`;


-- Business Problems

-- Find the number of stores in each country

SELECT 
    country,
    COUNT(store_id) AS total_stores 
 FROM `apple-474214.retail_sales_data.stores`
GROUP BY country
ORDER BY total_stores DESC;


-- Calculate the total number of units sold by each store

SELECT 
    s.store_id,
    st.store_name,
    SUM(s.quantity) AS total_units_sold
FROM `apple-474214.retail_sales_data.sales` AS s
JOIN `apple-474214.retail_sales_data.stores` AS st
    ON s.store_id = st.store_id
GROUP BY s.store_id, st.store_name
ORDER BY total_units_sold DESC;


-- Identify how many sales occurred in December 2023

SELECT 
    COUNT(*) AS total_sales
FROM `apple-474214.retail_sales_data.sales`
WHERE sale_date BETWEEN '2023-12-01' AND '2023-12-31';


-- Determine how many stores have never had a warranty claim filed

SELECT 
  COUNT(*) AS stores_without_warranty
FROM 
  `apple-474214.retail_sales_data.stores` AS st
WHERE NOT EXISTS (
  SELECT 1
  FROM `apple-474214.retail_sales_data.sales` AS s
  JOIN `apple-474214.retail_sales_data.warranty` AS w
    ON s.sale_id = w.sale_id
  WHERE s.store_id = st.store_id
);


-- Calculate the percentage of warranty claims marked as "Rejected"

SELECT 
  ROUND
  ((COUNTIF(repair_status = 'Rejected') * 100.0) / COUNT(*),2) AS rejected_claims_percentage,
  FROM `apple-474214.retail_sales_data.warranty`;


-- Identify which store had the highest total units sold in the last year

 SELECT 
  st.store_id,
  st.store_name,
  SUM(s.quantity) AS total_units_sold
FROM `apple-474214.retail_sales_data.sales` AS s
JOIN `apple-474214.retail_sales_data.stores` AS st
  ON s.store_id = st.store_id
WHERE EXTRACT(YEAR FROM s.sale_date) = EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR))
GROUP BY st.store_id, st.store_name
ORDER BY total_units_sold DESC
LIMIT 1;


-- Count the number of unique products sold in the last year

SELECT 
  COUNT(DISTINCT product_id) AS unique_products_sold
FROM `apple-474214.retail_sales_data.sales` 
WHERE sale_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR);


-- Find the average price of products in each category

SELECT
  p.category_id,
  c.category_name,
  ROUND(AVG(p.price), 2) AS avg_price
FROM
  `apple-474214.retail_sales_data.products` AS p
JOIN
  `apple-474214.retail_sales_data.category` AS  c
ON
  p.category_id = c.category_id
GROUP BY
  p.category_id,
  c.category_name
ORDER BY
  avg_price DESC;


-- How many warranty claims were filed in 2024

SELECT
  COUNT(*) AS warranty_claims_2024
FROM
  `apple-474214.retail_sales_data.warranty`
WHERE
  EXTRACT(YEAR FROM claim_date) = 2024;


-- For each store, identify the best-selling day based on highest quantity sold

SELECT
  s.store_id,
  DATE(s.sale_date) AS best_selling_day,
  SUM(s.quantity) AS total_quantity_sold
FROM
  `apple-474214.retail_sales_data.sales` AS s
GROUP BY
  s.store_id,
  best_selling_day
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY s.store_id
  ORDER BY SUM(s.quantity) DESC
) = 1
ORDER BY
  s.store_id;


-- Identify the least selling product in each country for each year based on total units sold

SELECT
  st.country,
  EXTRACT(YEAR FROM s.sale_date) AS year,
  p.product_name,
  SUM(s.quantity) AS total_quantity
FROM
  `apple-474214.retail_sales_data.sales` AS s
JOIN
  `apple-474214.retail_sales_data.stores` AS st
ON
  s.store_id = st.store_id
JOIN
  `apple-474214.retail_sales_data.products` AS p
ON
  s.product_id = p.product_id
GROUP BY
  st.country,
  year,
  p.product_name
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY st.country, year
  ORDER BY SUM(s.quantity) ASC
) = 1
ORDER BY
  st.country,
  year;


--Calculate how many warranty claims were filed within 180 days of a product sale

SELECT
  COUNT(w.sale_id) AS claims_within_180_days
FROM
  `apple-474214.retail_sales_data.sales` AS s
JOIN
  `apple-474214.retail_sales_data.warranty` AS  w
ON
  s.sale_id = w.sale_id
WHERE
  DATE_DIFF(w.claim_date, s.sale_date, DAY) <= 180;


--Determine how many warranty claims were filed for products launched in the last two years

SELECT
  COUNT(w.sale_id) AS claims_last_2_years
FROM
  `apple-474214.retail_sales_data.sales`AS  s
JOIN
  `apple-474214.retail_sales_data.products`AS  p
ON
  s.product_id = p.product_id
JOIN
  `apple-474214.retail_sales_data.warranty` AS  w
ON
  s.sale_id = w.sale_id
WHERE
  p.launch_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR);


-- List the months in the last three years where sales exceeded 5,000 units in the Australia

SELECT
  EXTRACT(YEAR FROM s.sale_date) AS year,
  EXTRACT(MONTH FROM s.sale_date) AS month,
  SUM(s.quantity) AS total_units_sold
FROM
  `apple-474214.retail_sales_data.sales` AS s
JOIN
  `apple-474214.retail_sales_data.stores` AS st
ON
  s.store_id = st.store_id
WHERE
  st.country = 'Australia'
  AND s.sale_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 3 YEAR)
GROUP BY
  year,
  month
HAVING
  SUM(s.quantity) > 5000
ORDER BY
  year,
  month;


-- Identify the product category with the most warranty claims filed in the last two years

SELECT
  c.category_name,
  COUNT(w.sale_id) AS total_warranty_claims
FROM
  `apple-474214.retail_sales_data.sales` AS s
JOIN
  `apple-474214.retail_sales_data.products` AS p
ON
  s.product_id = p.product_id
JOIN
  `apple-474214.retail_sales_data.warranty`AS w
ON
  s.sale_id = w.sale_id
JOIN
  `apple-474214.retail_sales_data.category` AS c
ON
  p.category_id = c.category_id
WHERE
  w.claim_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR)
GROUP BY
  c.category_name
ORDER BY
  total_warranty_claims DESC
LIMIT 1;


-- Determine the percentage chance of receiving warranty claims after each purchase for each country

SELECT
  st.country,
  COUNT(w.sale_id) AS warranty_claims,
  COUNT(s.sale_id) AS total_sales,
  ROUND(SAFE_DIVIDE(COUNT(w.sale_id), COUNT(s.sale_id)) * 100, 2) AS warranty_claim_percentage
FROM
  `apple-474214.retail_sales_data.sales` AS s
JOIN
  `apple-474214.retail_sales_data.stores` AS st
ON
  s.store_id = st.store_id
LEFT JOIN
  `apple-474214.retail_sales_data.warranty` AS w
ON
  s.sale_id = w.sale_id
GROUP BY
  st.country
ORDER BY
  warranty_claim_percentage DESC;


--Analyze the year-by-year growth ratio for each store

WITH yearly_sales AS (
  SELECT
    s.store_id,
    EXTRACT(YEAR FROM s.sale_date) AS year,
    SUM(s.quantity) AS total_quantity
  FROM
    `apple-474214.retail_sales_data.sales` AS s
  GROUP BY
    s.store_id,
    year
)
SELECT
  store_id,
  year,
  total_quantity,
  LAG(total_quantity) OVER (
    PARTITION BY store_id
    ORDER BY year
  ) AS prev_year_quantity,
  ROUND(
    SAFE_DIVIDE(
      total_quantity - LAG(total_quantity) OVER (PARTITION BY store_id ORDER BY year),
      LAG(total_quantity) OVER (PARTITION BY store_id ORDER BY year)
    ),
    2
  ) AS growth_ratio
FROM
  yearly_sales
ORDER BY
  store_id,
  year;


-- Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range

WITH recent_sales AS (
  SELECT
    s.sale_id,
    p.product_id,
    p.price,
    IF(w.sale_id IS NOT NULL, 1, 0) AS warranty_claim
  FROM
    `apple-474214.retail_sales_data.sales` AS s
  JOIN
    `apple-474214.retail_sales_data.products`AS  p
  ON
    s.product_id = p.product_id
  LEFT JOIN
    `apple-474214.retail_sales_data.warranty` AS w
  ON
    s.sale_id = w.sale_id
  WHERE
    s.sale_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 5 YEAR)
),
segmented AS (
  SELECT
    *,
    CASE
      WHEN price < 100 THEN '<100'
      WHEN price BETWEEN 100 AND 499 THEN '100-499'
      WHEN price BETWEEN 500 AND 999 THEN '500-999'
      ELSE '1000+' 
    END AS price_range
  FROM
    recent_sales
)
SELECT
  price_range,
  CORR(price, warranty_claim) AS price_claim_correlation
FROM
  segmented
GROUP BY
  price_range
ORDER BY
  price_range;


-- Identify the store with the highest percentage of repair status "Completed" claims relative to total claims filed

WITH claims_summary AS (
  SELECT
    s.store_id,
    COUNT(*) AS total_claims,
    COUNTIF(w.repair_status = 'Completed') AS repair_completed_claims
  FROM
    `apple-474214.retail_sales_data.sales` AS s
  JOIN
    `apple-474214.retail_sales_data.warranty` AS w
  ON
    s.sale_id = w.sale_id
  GROUP BY
    s.store_id
)
SELECT
  store_id,
 repair_completed_claims,
  total_claims,
  ROUND(SAFE_DIVIDE(repair_completed_claims, total_claims) * 100, 2) AS repair_completed_claims_percentage
FROM
  claims_summary
ORDER BY
  repair_completed_claims_percentage DESC
LIMIT 1;


-- Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends

WITH monthly_sales AS (
  SELECT
    s.store_id,
    DATE_TRUNC(s.sale_date, MONTH) AS month_start,
    SUM(s.quantity) AS total_units_sold
  FROM
    `apple-474214.retail_sales_data.sales` AS s
  WHERE
    s.sale_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 4 YEAR)
  GROUP BY
    s.store_id,
    month_start
)
SELECT
  store_id,
  month_start,
  total_units_sold,
  SUM(total_units_sold) OVER (
    PARTITION BY store_id
    ORDER BY month_start
  ) AS running_total_units
FROM
  monthly_sales
ORDER BY
  store_id,
  month_start;


-- Analyze product sales trends over time, segmented into key periods: from launch to 6 months, 6–12 months, 12–18 months, and beyond 18 months

WITH sales_with_period AS (
  SELECT
    s.product_id,
    p.product_name,
    s.sale_date,
    s.quantity,
    DATE_DIFF(s.sale_date, p.launch_date, MONTH) AS months_since_launch,
    CASE
      WHEN DATE_DIFF(s.sale_date, p.launch_date, MONTH) <= 6 THEN '0-6 months'
      WHEN DATE_DIFF(s.sale_date, p.launch_date, MONTH) <= 12 THEN '6-12 months'
      WHEN DATE_DIFF(s.sale_date, p.launch_date, MONTH) <= 18 THEN '12-18 months'
      ELSE '>18 months'
    END AS launch_period
  FROM
    `apple-474214.retail_sales_data.sales` AS s
  JOIN
    `apple-474214.retail_sales_data.products` AS p
  ON
    s.product_id = p.product_id
)
SELECT
  product_id,
  product_name,
  launch_period,
  SUM(quantity) AS total_units_sold
FROM
  sales_with_period
GROUP BY
  product_id,
  product_name,
  launch_period
ORDER BY
  product_id,
  launch_period;








