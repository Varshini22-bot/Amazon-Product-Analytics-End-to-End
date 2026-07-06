-- Databricks notebook source
-- DBTITLE 1,Cell 1
--SECTION 1 — Product Performance
--Top 10 Highest Rated Products
SELECT
product_name,
category,
rating
FROM amazon_silver
ORDER BY rating DESC
LIMIT 10;

--Products with Highest Review Count
SELECT
product_name,
rating_count
FROM amazon_silver
ORDER BY rating_count DESC
LIMIT 10;

--Best Products (High Rating + High Reviews)
SELECT
product_name,
rating,
rating_count
FROM amazon_silver
WHERE TRY_CAST(rating AS DOUBLE) >=4.5
AND rating_count>=50000
ORDER BY rating DESC;

--SECTION 2 — Pricing Strategy
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
WHERE actual_price<500
ORDER BY actual_price;

--Products Above Average Price
SELECT
product_name,
actual_price
FROM amazon_silver
WHERE actual_price>
(
SELECT AVG(actual_price)
FROM amazon_silver
);

--Products Below Average Price
SELECT
product_name,
actual_price
FROM amazon_silver
WHERE actual_price<
(
SELECT AVG(actual_price)
FROM amazon_silver
);

--SECTION 3 — Discount Strategy
--Products with More than 70% Discount
SELECT
product_name,
discount_percentage
FROM amazon_silver
WHERE discount_percentage>70
ORDER BY discount_percentage DESC;

--Categories Giving Highest Discount
SELECT
category,
ROUND(AVG(discount_percentage),2) avg_discount
FROM amazon_silver
GROUP BY category
ORDER BY avg_discount DESC;

--Low Discount Products
SELECT
product_name,
discount_percentage
FROM amazon_silver
WHERE discount_percentage<20;

--SECTION 4 — Customer Satisfaction
--Categories with Highest Rating
SELECT
category,
ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) avg_rating
FROM amazon_silver
GROUP BY category
ORDER BY avg_rating DESC;

--Categories with Lowest Rating
SELECT
category,
ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) avg_rating
FROM amazon_silver
GROUP BY category
ORDER BY avg_rating;
jjjjhhy
--Products Needing Attention
SELECT
product_name,
rating
FROM amazon_silver
WHERE TRY_CAST(rating AS DOUBLE)<3.5;

--SECTION 5 — Revenue Opportunity
--Highest Actual Price
SELECT
product_name,
actual_price
FROM amazon_silver
ORDER BY actual_price DESC
LIMIT 20;

--Highest Discounted Price
SELECT
product_name,
discounted_price
FROM amazon_silver
ORDER BY discounted_price DESC
LIMIT 20;

--Biggest Price Difference
SELECT
product_name,
(actual_price-discounted_price) AS savings
FROM amazon_silver
ORDER BY savings DESC;


--SECTION 6 — Category Analysis
--Number of Products
SELECT
category,
COUNT(*) total_products
FROM amazon_silver
GROUP BY category
ORDER BY total_products DESC;

--Category Average Price
SELECT
category,
ROUND(AVG(actual_price),2) avg_price
FROM amazon_silver
GROUP BY category
ORDER BY avg_price DESC;

--Category Average Reviews
SELECT
category,
ROUND(AVG(rating_count)) avg_reviews
FROM amazon_silver
GROUP BY category
ORDER BY avg_reviews DESC;

--SECTION 7 — Product Quality
--Highly Rated Premium Products
SELECT
product_name,
actual_price,
rating
FROM amazon_silver
WHERE TRY_CAST(rating AS DOUBLE)>=4.5
AND actual_price>5000;

--Highly Rated Budget Products
SELECT
product_name,
actual_price,
rating
FROM amazon_silver
WHERE TRY_CAST(rating AS DOUBLE)>=4.5
AND actual_price<1000;

--High Discount + High Rating
SELECT
product_name,
discount_percentage,
rating
FROM amazon_silver
WHERE TRY_CAST(rating AS DOUBLE)>=4.5
AND discount_percentage>=60;

--High Discount + Low Rating
SELECT
product_name,
discount_percentage,
rating
FROM amazon_silver
WHERE TRY_CAST(rating AS DOUBLE)<4
AND discount_percentage>60;

--SECTION 8 — Business KPIs
--Overall KPIs
SELECT
COUNT(*) Total_Products,
COUNT(DISTINCT category) Categories,
ROUND(AVG(actual_price),2) Avg_Price,
ROUND(AVG(discount_percentage),2) Avg_Discount,
ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) Avg_Rating,
MAX(actual_price) Highest_Price,
MIN(actual_price) Lowest_Price
FROM amazon_silver;

--Price Range
SELECT
CASE
WHEN actual_price<500 THEN 'Budget'
WHEN actual_price<2000 THEN 'Mid Range'
WHEN actual_price<10000 THEN 'Premium'
ELSE 'Luxury'
END Price_Category,
COUNT(*) Products
FROM amazon_silver
GROUP BY Price_Category;

--Rating Classification
SELECT
CASE
WHEN TRY_CAST(rating AS DOUBLE)>=4.5 THEN 'Excellent'
WHEN TRY_CAST(rating AS DOUBLE)>=4 THEN 'Good'
WHEN TRY_CAST(rating AS DOUBLE)>=3 THEN 'Average'
ELSE 'Poor'
END Rating_Category,
COUNT(*) Products
FROM amazon_silver
GROUP BY Rating_Category;