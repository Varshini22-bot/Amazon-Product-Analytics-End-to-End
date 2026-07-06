-- Databricks notebook source
--Log Table
CREATE TABLE IF NOT EXISTS etl_log
(
pipeline_name STRING,
execution_date DATE,
execution_timestamp TIMESTAMP,
status STRING,
source_table STRING,
target_table STRING,
rows_processed BIGINT
);

--Insert Log Record
INSERT INTO etl_log
SELECT
'Amazon_Product_ETL',
CURRENT_DATE(),
CURRENT_TIMESTAMP(),
'SUCCESS',
'amazon_bronze',
'amazon_silver',
COUNT(*)
FROM amazon_silver;

--View Logs
SELECT *
FROM etl_log
ORDER BY execution_timestamp DESC;