-- Databricks notebook source
-- DBTITLE 1,Cell 1
-- MODULE 3
-- AMAZON SILVER LAYER
CREATE OR REPLACE TABLE amazon_silver AS

SELECT

product_id,

product_name,

category,

CAST(
REPLACE(
REPLACE(discounted_price,'₹',''),
',',''
)
AS DOUBLE
) AS discounted_price,

CAST(
REPLACE(
REPLACE(actual_price,'₹',''),
',',''
)
AS DOUBLE
) AS actual_price,

CAST(
REPLACE(discount_percentage,'%','')
AS INT
) AS discount_percentage,

rating,

CAST(
REPLACE(rating_count,',','')
AS BIGINT
) AS rating_count,

about_product,

user_id,

user_name,

review_id,

review_title,

review_content,

img_link,

product_link

FROM workspace.amazon_product_analytics.amazon_bronze;


--Verification
SELECT *
FROM amazon_silver
LIMIT 10;
--Checking Data Types
DESCRIBE amazon_silver;

--Highest Price
SELECT
MAX(actual_price)
FROM amazon_silver;
--Lowest Price
SELECT
MIN(actual_price)
FROM amazon_silver;
--Average Price
SELECT
ROUND(AVG(actual_price),2)
FROM amazon_silver;

--Check Rating
SELECT

MIN(TRY_CAST(rating AS DOUBLE)),

MAX(TRY_CAST(rating AS DOUBLE)),

AVG(TRY_CAST(rating AS DOUBLE))

FROM amazon_silver;

--Check Discount
SELECT

MIN(discount_percentage),

MAX(discount_percentage),

AVG(discount_percentage)

FROM amazon_silver;
--Check duplicates
SELECT
product_id,
COUNT(*)
FROM amazon_silver
GROUP BY product_id
HAVING COUNT(*)>1;
--Null Analysis
SELECT
COUNT(*)
FROM amazon_silver
WHERE product_name IS NULL;

SELECT
COUNT(*)
FROM amazon_silver
WHERE category IS NULL;

SELECT
COUNT(*)
FROM amazon_silver
WHERE discounted_price IS NULL;


SELECT
COUNT(*)
FROM amazon_silver
WHERE actual_price IS NULL;

SELECT
COUNT(*)
FROM amazon_silver
WHERE rating IS NULL;

SELECT
COUNT(*)
FROM amazon_silver
WHERE rating_count IS NULL;

--Data Quality Report
SELECT
COUNT(*) AS Total_Records,
COUNT(product_name) AS Product_Name,
COUNT(category) AS Category,
COUNT(actual_price) AS Price,
COUNT(rating) AS Rating
FROM amazon_silver;

--table format
DESCRIBE DETAIL amazon_silver;

-- COMMAND ----------

