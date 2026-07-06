# Databricks notebook source

 --Overall Average Price
 SELECT
 product_name,
 actual_price,
 ROUND(
 AVG(actual_price) OVER(),2
 ) AS overall_average_price
 FROM amazon_silver;

 --Average Price by Category
 SELECT
 product_name,
 category,
 actual_price,
 ROUND(
 AVG(actual_price)
 OVER(PARTITION BY category),2
 )
 AS category_average
 FROM amazon_silver;

 --Average Rating by Category
 SELECT
 product_name,
 category,
 rating,
 ROUND(
 AVG(TRY_CAST(rating AS DOUBLE))
 OVER(PARTITION BY category),2
 )
 AS category_rating
 FROM amazon_silver;

 --Product Price Difference from Category Average
 SELECT
 product_name,
 category,
 actual_price,
 ROUND(
 AVG(actual_price)
 OVER(PARTITION BY category),2
 )
 AS category_average,
 actual_price-
 AVG(actual_price)
 OVER(PARTITION BY category)
 AS price_difference
 FROM amazon_silver;

 --ROW_NUMBER()
 SELECT
 product_name,
 actual_price,
 ROW_NUMBER()
 OVER(
 ORDER BY actual_price DESC
 )
 AS row_num
 FROM amazon_silver;

 --RANK()
 SELECT
 product_name,
 actual_price,
 RANK()
 OVER(
 ORDER BY actual_price DESC
 )
 AS product_rank
 FROM amazon_silver;

 --DENSE_RANK()
 SELECT
 product_name,
 actual_price,
 DENSE_RANK()
 OVER(
 ORDER BY actual_price DESC
 )
 AS dense_rank
 FROM amazon_silver;

 --NTILE()
 --Divide Products into 4 Price Groups
 SELECT
 product_name,
 actual_price,
 NTILE(4)
 OVER(
 ORDER BY actual_price DESC
 ) AS price_quartile
 FROM amazon_silver;

 --Top 25% Products
 SELECT *
 FROM
 (
 SELECT
 product_name,
 actual_price,
 NTILE(4)
 OVER(ORDER BY actual_price DESC) AS quartile
 FROM amazon_silver
 ) t
 WHERE quartile=1;

 --LAG()
 --Previous Product Price
 SELECT
 product_name,
 actual_price,
 LAG(actual_price)
 OVER(
 ORDER BY actual_price
 )
 AS previous_price
 FROM amazon_silver;

 --Price Difference
 SELECT
 product_name,
 actual_price,
 LAG(actual_price)
 OVER(
 ORDER BY actual_price
 )
 AS previous_price,
 actual_price-
 LAG(actual_price)
 OVER(
 ORDER BY actual_price
 )
 AS difference
 FROM amazon_silver;

 --LEAD()
 --Next Product Price
 SELECT
 product_name,
 actual_price,
 LEAD(actual_price)
 OVER(
 ORDER BY actual_price
 )
 AS next_price
 FROM amazon_silver;

 --Difference with Next Product
 SELECT
 product_name,
 actual_price,
 LEAD(actual_price)
 OVER(
 ORDER BY actual_price
 )
 AS next_price,
 LEAD(actual_price)
 OVER(
 ORDER BY actual_price
 )-actual_price
 AS price_gap
 FROM amazon_silver;

 --Partition + ROW_NUMBER()
 --Top 3 most expensive products in every category.
 SELECT *
 FROM
 (
 SELECT
 product_name,
 category,
 actual_price,
 ROW_NUMBER()
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 )
 AS rn
 FROM amazon_silver
 ) t
 WHERE rn<=3;

 --Partition + RANK()
 SELECT
 product_name,
 category,
 actual_price,
 RANK()
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 )
 AS category_rank
 FROM amazon_silver;

 --Multiple Window Functions
 SELECT
 product_name,
 category,
 actual_price,
 ROW_NUMBER()
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 ) row_num,
 RANK()
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 ) product_rank,
 DENSE_RANK()
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 ) dense_rank
 FROM amazon_silver;

 --FIRST_VALUE()
 --cheapest product in every category
 SELECT
 product_name,
 category,
 actual_price,
 FIRST_VALUE(actual_price)
 OVER(
 PARTITION BY category
 ORDER BY actual_price
 )
 AS cheapest_price
 FROM amazon_silver;

 --LAST_VALUE()
 SELECT
 product_name,
 category,
 actual_price,
 LAST_VALUE(actual_price)
 OVER(
 PARTITION BY category
 ORDER BY actual_price
 ROWS BETWEEN UNBOUNDED PRECEDING
 AND UNBOUNDED FOLLOWING
 )
 AS highest_price
 FROM amazon_silver;

 --NTH_VALUE()
 --Second highest priced product.
 SELECT
 product_name,
 category,
 actual_price,
 NTH_VALUE(actual_price,2)
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 ROWS BETWEEN UNBOUNDED PRECEDING
 AND UNBOUNDED FOLLOWING
 )
 AS second_highest
 FROM amazon_silver;

 --Running Total
 --cumulative revenue growth
 SELECT
 product_name,
 actual_price,
 SUM(actual_price)
 OVER(
 ORDER BY actual_price
 ROWS BETWEEN UNBOUNDED PRECEDING
 AND CURRENT ROW
 )
 AS running_total
 FROM amazon_silver;

 --Cumulative Maximum
 SELECT
 product_name,
 actual_price,
 MAX(actual_price)
 OVER(
 ORDER BY actual_price
 ROWS BETWEEN UNBOUNDED PRECEDING
 AND CURRENT ROW
 )
 AS cumulative_max
 FROM amazon_silver;

 --Moving Average
 SELECT
 product_name,
 actual_price,
 ROUND(
 AVG(actual_price)
 OVER(
 ORDER BY actual_price
 ROWS BETWEEN 2 PRECEDING
 AND CURRENT ROW
 ),2
 )
 AS moving_average
 FROM amazon_silver;

 --Multiple Analytics
 SELECT
 product_name,
 category,
 actual_price,
 AVG(actual_price)
 OVER(PARTITION BY category)
 AS avg_price,
 MIN(actual_price)
 OVER(PARTITION BY category)
 AS min_price,
 MAX(actual_price)
 OVER(PARTITION BY category)
 AS max_price,
 ROW_NUMBER()
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 )
 AS row_num
 FROM amazon_silver;

 --Top 5 Most Expensive Products in Every Category
 SELECT *
 FROM
 (
 SELECT
 product_name,
 category,
 actual_price,
 ROW_NUMBER()
 OVER(
 PARTITION BY category
 ORDER BY actual_price DESC
 ) AS rn
 FROM amazon_silver
 ) t
 WHERE rn<=5;
