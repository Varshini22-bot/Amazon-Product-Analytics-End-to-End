# Databricks notebook source




 
 --COMMON TABLE EXPRESSIONS (CTE)
 --Without CTE
 SELECT *
 FROM
 (
 SELECT
category,
 AVG(actual_price) avg_price
FROM amazon_silver
 GROUP BY category
)t
 WHERE avg_price > 1000;

--With CTE
 WITH category_price AS
 (
SELECT
 category,
 AVG(actual_price) AS avg_price
 FROM amazon_silver
 GROUP BY category
 )
 SELECT *
 FROM category_price
 WHERE avg_price > 1000;
 --Premium Categories
 WITH category_avg AS
 (
 SELECT
 category,
 AVG(actual_price) avg_price
 FROM amazon_silver
 GROUP BY category
 )

 SELECT *
 FROM category_avg
 WHERE avg_price > 5000;

 --Multiple CTEs
 WITH
 price_cte AS
 (
 SELECT
 category,
 AVG(actual_price) avg_price
 FROM amazon_silver
 GROUP BY category
 ),
 rating_cte AS
 (
 SELECT
 category,
 AVG(TRY_CAST(rating AS DOUBLE)) avg_rating
 FROM amazon_silver
 GROUP BY category
 )
 SELECT
 p.category,
 p.avg_price,
 r.avg_rating
 FROM price_cte p
 JOIN rating_cte r
 ON p.category=r.category;

 --Recursive CTE
 WITH RECURSIVE numbers AS
 (
 SELECT 1 AS n
 UNION ALL
 SELECT n+1
 FROM numbers
 WHERE n<10
 )
 SELECT *
 FROM numbers;

 --Views
 CREATE OR REPLACE VIEW premium_products AS
 SELECT
 product_name,
 category,
 actual_price,
 TRY_CAST(rating AS DOUBLE) as rating
 FROM amazon_silver
 WHERE actual_price>5000;

 SELECT *
 FROM premium_products;

 --Temporary Views
 CREATE OR REPLACE TEMP VIEW high_discount_products AS
 SELECT *
 FROM amazon_silver
 WHERE discount_percentage>70;

 SELECT *
 FROM high_discount_products;

 --Correlated Subqueries
 SELECT
 product_name,
 category,
 actual_price
 FROM amazon_silver a
 WHERE actual_price>
 (
 SELECT AVG(actual_price)
 FROM amazon_silver b
 WHERE a.category=b.category
 );

 --EXISTS
 SELECT
 product_name,
 category
 FROM amazon_silver a
 WHERE EXISTS
 (
 SELECT 1
 FROM amazon_silver b
 WHERE a.category=b.category
 AND TRY_CAST(b.rating AS DOUBLE)>=4.8
 );


 --UNION
 --High Rated Products
 SELECT
 product_name,
 category,
 TRY_CAST(rating AS DOUBLE) as rating
 FROM amazon_silver
 WHERE TRY_CAST(rating AS DOUBLE)>=4.5;

 SELECT
 product_name,
 category,
 TRY_CAST(rating AS DOUBLE) as rating
 FROM amazon_silver
 WHERE discount_percentage>=60;

 SELECT
 product_name
 FROM amazon_silver
 WHERE TRY_CAST(rating AS DOUBLE)>=4.5

 UNION

 SELECT
 product_name
 FROM amazon_silver
 WHERE discount_percentage>=60;

 --Marketing wants products that are:
 --Highly rated
 --Highly discounted
 SELECT
 product_name
 FROM amazon_silver
 WHERE TRY_CAST(rating AS DOUBLE)>=4.5

 INTERSECT

 SELECT
 product_name
 FROM amazon_silver
 WHERE discount_percentage>=60;

 --STRING FUNCTIONS
 --LENGTH()
 SELECT
 product_name,
 LENGTH(product_name) AS name_length
 FROM amazon_silver;

--UPPER()
 SELECT
 UPPER(product_name)
 FROM amazon_silver;

 --LOWER()
 SELECT
 LOWER(product_name)
 FROM amazon_silver;

--INITCAP()
 SELECT
 INITCAP(product_name)
 FROM amazon_silver;

 --TRIM()
 SELECT
 TRIM(product_name)
 FROM amazon_silver;

 --REPLACE()
 SELECT
 REPLACE(product_name,'boAt','Boat')
 FROM amazon_silver;

 --REGEXP_REPLACE()
 SELECT
 REGEXP_REPLACE(actual_price,'[^0-9.]','')
 FROM amazon_silver;

 --SUBSTRING()
 SELECT
 SUBSTRING(product_name,1,20)
 FROM amazon_silver;

 --SPLIT()
 SELECT
 SPLIT(category,'\\|')
 FROM amazon_silver;

 --CONCAT()
 SELECT
 CONCAT(product_name,' - ',category)
 FROM amazon_silver;

 --DATE FUNCTIONS
 --Current Date
 SELECT CURRENT_DATE();

 --Year
 SELECT YEAR(CURRENT_DATE());

 --Subtract Days
 SELECT DATE_SUB(CURRENT_DATE(),30);

 --NULL Handling
 SELECT *
 FROM amazon_silver
 WHERE rating IS NULL;

 --Replace NULL
 SELECT
 product_name,
 COALESCE(TRY_CAST(rating AS DOUBLE),0.0)
 AS rating
 FROM amazon_silver;

 --IFNULL()
 SELECT
 IFNULL(TRY_CAST(rating AS DOUBLE),0.0)
 FROM amazon_silver;

 --Advanced CASE
 SELECT
 product_name,
 CASE
 WHEN TRY_CAST(rating AS DOUBLE)>=4.5 THEN 'Excellent'
 WHEN TRY_CAST(rating AS DOUBLE)>=4 THEN 'Good'
 WHEN TRY_CAST(rating AS DOUBLE)>=3 THEN 'Average'
 ELSE 'Poor'
 END
 AS product_quality
 FROM amazon_silver;

 --Conditional Aggregation
 SELECT
 COUNT(*) Total_Products,
 SUM(
 CASE
 WHEN TRY_CAST(rating AS DOUBLE)>=4.5
 THEN 1
 ELSE 0
 END
 )
 AS Excellent_Products
 FROM amazon_silver;

 --Data Validation
 --DUPLICATE PRODUCTS
 SELECT
 product_name,
 COUNT(*)
 FROM amazon_silver
 GROUP BY product_name
 HAVING COUNT(*)>1;
