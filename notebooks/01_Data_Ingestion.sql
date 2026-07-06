# Databricks notebook source
# DBTITLE 1,Cell 1

 CREATE SCHEMA IF NOT EXISTS amazon_product_analytics;
 USE amazon_product_analytics;
 SHOW TABLES;

 SELECT *
 FROM workspace.default.amazon
 LIMIT 10;
 DESCRIBE DETAIL workspace.default.amazon;
 -- CREATING BRONZE TABLE
 CREATE OR REPLACE TABLE amazon_bronze
 AS
 SELECT *
 FROM workspace.default.amazon;

 --Verify the Bronze Table
 SELECT *
 FROM amazon_bronze
 LIMIT 20;
 --Count the Records
 SELECT COUNT(*) AS Total_Records
 FROM amazon_bronze;
 --Check the Schema
 DESCRIBE amazon_bronze;

 --Initial Data Profiling
 --Total Products
 SELECT COUNT(*) AS Total_Products
 FROM amazon_bronze;
 --Unique Categories
 SELECT COUNT(DISTINCT category) AS Total_Categories
 FROM amazon_bronze;
 --Average Rating
 SELECT ROUND(AVG(TRY_CAST(rating AS DOUBLE)),2) AS Average_Rating
 FROM amazon_bronze;
 --Highest Rating
 SELECT MAX(rating) AS Highest_Rating
 FROM amazon_bronze;
 --Lowest Rating
 SELECT MIN(rating) AS Lowest_Rating
 FROM amazon_bronze;

 --Identifying Data Issues
 --Null Values checking
 SELECT *
 FROM amazon_bronze
 WHERE product_name IS NULL;
 --Duplicate Product IDs
 SELECT
     product_id,
     COUNT(*) AS duplicate_count
 FROM amazon_bronze
 GROUP BY product_id
 HAVING COUNT(*) > 1;
 --Products with Missing Ratings
 SELECT *
 FROM amazon_bronze
 WHERE rating IS NULL;
 --Products with Missing Prices
 SELECT *
 FROM amazon_bronze
 WHERE discounted_price IS NULL;