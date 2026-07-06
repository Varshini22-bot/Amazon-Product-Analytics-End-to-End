-- Databricks notebook source
--Check Total Records
SELECT COUNT(*) AS total_records
FROM amazon_silver;

--Check for NULL Product Names
SELECT COUNT(*) AS null_product_names
FROM amazon_silver
WHERE product_name IS NULL;

--Check NULL Categories
SELECT COUNT(*) AS null_categories
FROM amazon_silver
WHERE category IS NULL;

--Duplicate Product IDs
SELECT
product_id,
COUNT(*) occurrences
FROM amazon_silver
GROUP BY product_id
HAVING COUNT(*)>1;

--Ratings Outside Valid Range
SELECT *
FROM amazon_silver
WHERE CAST(rating AS DOUBLE)<0
OR CAST(rating AS DOUBLE)>5;

--Negative Prices
SELECT *
FROM amazon_silver
WHERE actual_price<0
OR discounted_price<0;

--Discount Greater Than 100%
SELECT *
FROM amazon_silver
WHERE discount_percentage>100;

--Discount Less Than 0%
SELECT *
FROM amazon_silver
WHERE discount_percentage<0;

--Invalid Review Counts
SELECT *
FROM amazon_silver
WHERE rating_count<0;

--Products Without Reviews
SELECT *
FROM amazon_silver
WHERE rating_count=0;

--Missing Product Links
SELECT *
FROM amazon_silver
WHERE product_link IS NULL;

--Missing Image Links
SELECT *
FROM amazon_silver
WHERE img_link IS NULL;

--Empty Product Names
SELECT *
FROM amazon_silver
WHERE TRIM(product_name)='';

--Empty Categories
SELECT *
FROM amazon_silver
WHERE TRIM(category)='';

--Final Validation
SELECT
COUNT(*) total_products,
COUNT(DISTINCT category) categories,
ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) average_rating,
MAX(actual_price) highest_price,
MIN(actual_price) lowest_price
FROM amazon_silver;