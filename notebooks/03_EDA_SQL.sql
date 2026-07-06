# Databricks notebook source
# DBTITLE 1,Cell 1

 --SECTION 1 – Dataset Overview

 --Total Products
 SELECT COUNT(*) AS total_products
 FROM amazon_silver;

 --Unique Categories
 SELECT COUNT(DISTINCT category) AS unique_categories
 FROM amazon_silver;

 --List Categories
 SELECT DISTINCT category
 FROM amazon_silver
 ORDER BY category;

 --Products per Category
 SELECT
 category,
 COUNT(*) AS total_products
 FROM amazon_silver
 GROUP BY category
 ORDER BY total_products DESC;

 --SECTION 2 – Price Analysis
 --Most Expensive Product
 SELECT
 product_name,
 actual_price
 FROM amazon_silver
 ORDER BY actual_price DESC
 LIMIT 1;

 --Cheapest Product
 SELECT
 product_name,
 actual_price
 FROM amazon_silver
 ORDER BY actual_price
 LIMIT 1;

 --Average Product Price
 SELECT
 ROUND(AVG(actual_price),2) AS average_price
 FROM amazon_silver;

 --Price Statistics
 SELECT
 MIN(actual_price) AS minimum,
 MAX(actual_price) AS maximum,
 ROUND(AVG(actual_price),2) AS average
 FROM amazon_silver;

 --Products Above Average Price
 SELECT
 product_name,
 actual_price
 FROM amazon_silver
 WHERE actual_price >
 (
 SELECT AVG(actual_price)
 FROM amazon_silver
 );

 --Top 10 Expensive Products
 SELECT
 product_name,
 actual_price
 FROM amazon_silver
 ORDER BY actual_price DESC
 LIMIT 10;

 --SECTION 3 – Discount Analysis
 --Highest Discount
 SELECT
 product_name,
 discount_percentage
 FROM amazon_silver
 ORDER BY discount_percentage DESC
 LIMIT 10;

 --Average Discount
 SELECT
 ROUND(AVG(discount_percentage),2)
 AS average_discount
 FROM amazon_silver;

 --Products with More Than 70% Discount
 SELECT
 product_name,
 discount_percentage
 FROM amazon_silver
 WHERE discount_percentage>70
 ORDER BY discount_percentage DESC;

 --Discount Distribution
 SELECT
 discount_percentage,
 COUNT(*) AS products
 FROM amazon_silver
 GROUP BY discount_percentage
 ORDER BY discount_percentage DESC;

 --SECTION 4 – Rating Analysis
 --Highest Rated Products
 SELECT
 product_name,
 rating
 FROM amazon_silver
 ORDER BY rating DESC
 LIMIT 20;

 --Lowest Rated Products
 SELECT
 product_name,
 rating
 FROM amazon_silver
 ORDER BY rating
 LIMIT 20;

 --Average Rating
 SELECT
 ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2)
 AS average_rating
 FROM amazon_silver;

 --Rating Distribution
 SELECT
 rating,
 COUNT(*) AS products
 FROM amazon_silver
 GROUP BY rating
 ORDER BY rating DESC;

 --SECTION 5 – Review Analysis
 --Most Reviewed Products
 SELECT
 product_name,
 rating_count
 FROM amazon_silver
 ORDER BY rating_count DESC
 LIMIT 20;

 --Average Review Count
 SELECT
 ROUND(AVG(rating_count))
 FROM amazon_silver;

 --SECTION 6 – Combined Analysis
 --High Rating & High Discount
 SELECT
 product_name,
 rating,
 discount_percentage
 FROM amazon_silver
 WHERE rating>=4.5
 AND discount_percentage>=50;

 --Premium Products
 SELECT
 product_name,
 actual_price
 FROM amazon_silver
 WHERE actual_price>10000
 ORDER BY actual_price DESC;

 --Budget Products
 SELECT
 product_name,
 actual_price
 FROM amazon_silver
 WHERE actual_price<500;

 --Products with High Reviews and High Ratings
 SELECT
 product_name,
 rating,
 rating_count
 FROM amazon_silver
 WHERE rating>=4.5
 AND rating_count>50000;

 --SECTION 7 – Category Insights
 --Average Rating by Category
 SELECT
 category,
 ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2)
 AS average_rating
 FROM amazon_silver
 GROUP BY category
 ORDER BY average_rating DESC;

 --Average Price by Category
 SELECT
 category,
 ROUND(AVG(actual_price),2)
 AS average_price
 FROM amazon_silver
 GROUP BY category
 ORDER BY average_price DESC;

 --Average Discount by Category
 SELECT
 category,
 ROUND(AVG(discount_percentage),2)
 AS average_discount
 FROM amazon_silver
 GROUP BY category
 ORDER BY average_discount DESC;

 --Total Products per Category
 SELECT
 category,
 COUNT(*)
 AS total_products
 FROM amazon_silver
 GROUP BY category
 ORDER BY total_products DESC;