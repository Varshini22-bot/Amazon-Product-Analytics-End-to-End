# Databricks notebook source
 %sql
 --Category Summary
 CREATE OR REPLACE TABLE gold_category_summary AS
 SELECT
 category,
 COUNT(*) AS total_products,
 ROUND(AVG(actual_price),2) AS avg_price,
 ROUND(AVG(discounted_price),2) AS avg_discounted_price,
 ROUND(AVG(discount_percentage),2) AS avg_discount,
 ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) AS avg_rating,
 SUM(rating_count) AS total_reviews,
 MAX(actual_price) AS highest_price,
 MIN(actual_price) AS lowest_price
 FROM amazon_silver
 GROUP BY category;

 SELECT *
 FROM gold_category_summary
 ORDER BY avg_rating DESC;

 --Product Ranking
 CREATE OR REPLACE TABLE gold_product_ranking AS
 SELECT
 product_name,
 category,
 actual_price,
 discount_percentage,
 rating,
 rating_count,
 ROW_NUMBER()
 OVER(
 PARTITION BY category
 ORDER BY TRY_CAST(rating AS DOUBLE) DESC,rating_count DESC
 )
 AS category_rank
 FROM amazon_silver;

 SELECT *
 FROM gold_product_ranking
 WHERE category_rank<=5;

 --Price Segmentation
 CREATE OR REPLACE TABLE gold_price_segment AS
 SELECT
 CASE
 WHEN actual_price<500 THEN 'Budget'
 WHEN actual_price<2000 THEN 'Economy'
 WHEN actual_price<5000 THEN 'Mid Range'
 WHEN actual_price<10000 THEN 'Premium'
 ELSE 'Luxury'
 END AS price_band,
 COUNT(*) AS total_products,
 ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) AS avg_rating,
 ROUND(AVG(discount_percentage),2) AS avg_discount
 FROM amazon_silver
 GROUP BY
 CASE
 WHEN actual_price<500 THEN 'Budget'
 WHEN actual_price<2000 THEN 'Economy'
 WHEN actual_price<5000 THEN 'Mid Range'
 WHEN actual_price<10000 THEN 'Premium'
 ELSE 'Luxury'
 END;

 SELECT COUNT(*)
 FROM gold_price_segment;

 --Discount Analysis
 CREATE OR REPLACE TABLE gold_discount_analysis AS
 SELECT
 category,
 ROUND(AVG(discount_percentage),2) avg_discount,
 MAX(discount_percentage) highest_discount,
 MIN(discount_percentage) lowest_discount,
 COUNT(*) products
 FROM amazon_silver
 GROUP BY category;

 SELECT COUNT(*)
 FROM gold_discount_analysis;

 --Rating Distribution
 CREATE OR REPLACE TABLE gold_rating_distribution AS
 SELECT
 CASE
 WHEN TRY_CAST(rating AS DOUBLE)>=4.5 THEN 'Excellent'
 WHEN TRY_CAST(rating AS DOUBLE)>=4 THEN 'Good'
 WHEN TRY_CAST(rating AS DOUBLE)>=3 THEN 'Average'
 ELSE 'Poor'
 END rating_group,
 COUNT(*) products
 FROM amazon_silver
 GROUP BY
 CASE
 WHEN TRY_CAST(rating AS DOUBLE)>=4.5 THEN 'Excellent'
 WHEN TRY_CAST(rating AS DOUBLE)>=4 THEN 'Good'
 WHEN TRY_CAST(rating AS DOUBLE)>=3 THEN 'Average'
 ELSE 'Poor'
 END;

 SELECT COUNT(*)
 FROM gold_rating_distribution;

 --Dashboard KPI
 CREATE OR REPLACE TABLE gold_dashboard_kpi AS
 SELECT
 COUNT(*) total_products,
 COUNT(DISTINCT category) total_categories,
 ROUND(AVG(actual_price),2) avg_price,
 ROUND(AVG(discount_percentage),2) avg_discount,
 ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) avg_rating,
 SUM(rating_count) total_reviews,
 MAX(actual_price) highest_price,
 MIN(actual_price) lowest_price
 FROM amazon_silver;

 SELECT COUNT(*)
 FROM gold_dashboard_kpi;

 --Premium Products
 CREATE OR REPLACE TABLE gold_premium_products AS
 SELECT *
 FROM amazon_silver
 WHERE
 actual_price>5000
 AND rating>=4.5;

 SELECT COUNT(*)
 FROM gold_premium_products;

 SHOW TABLES;

