--WEEK-2-'HEALTH ANALYTICS DATA'

--Show a few rows and all columns
SELECT
  *
FROM
  health.user_logs 
LIMIT
  10;

--Show number of records in the table
SELECT
  COUNT(*)
FROM
  health.user_logs;

--COUNT on a few columns
SELECT
  measure,
  COUNT(*) AS frequency
FROM
  health.user_logs
GROUP BY
  measure;

--Show number of unique IDs
SELECT COUNT(DISTINCT id)
FROM health.user_logs;

--Print top 20 customers by record count (those with most records/rows in the table)
SELECT id, COUNT(*) AS row_count
FROM health.user_logs
GROUP BY id
ORDER BY row_count DESC
LIMIT 15; 

--DATA INSPECTION/INVESTIGATION

--Inspecting the data where measure_value = 0
SELECT *
FROM health.user_logs
WHERE measure_value = 0;

--COUNT all measures where measure_value = 0
SELECT measure, COUNT(*) AS record_count
FROM health.user_logs
WHERE measure_value = 0
GROUP BY measure;

--Check for NULL values--(There are no Null values)
SELECT COUNT(*)
FROM health.user_logs
WHERE measure_value = 0 OR measure_value IS NULL;

--Check for NULL values in 'systolic' measure
SELECT COUNT(*)
FROM health.user_logs
WHERE systolic = 0 --this returns over 15,000 '0' values.
OR systolic IS NULL;--when NULL is added, 41,000 values.


--Using CTE and SUBQUERY to do COUNT DISTINCT--
--Both are run on memory and nothing get written to the Disk--
--This is faster when using not large datasets, and where indexing or partitioning is not rrequired.
--Using CTE--query will run in sequential order
WITH deduped_logs AS (
  SELECT DISTINCT *
  FROM health.user_logs
  )
  
SELECT COUNT(*)
FROM deduped_logs;
  
--Using SUBQUERY--
--This query runs from inside out, in non squential order.
SELECT COUNT(*)
FROM(
  SELECT DISTINCT *
  FROM health.user_logs)
  AS subquery;

--TEMPORARY TABLE--
--here query is written on the Disk and user has a control how to write the query--
--useful to do query on Large datasets, and when there's need for Indexing and Partitioning
--similar to CTE, it is sequential
--write and read to disk--
DROP TABLE IF EXISTS deduplicated_user_logs;

CREATE TEMP TABLE deduplicated_user_logs AS
SELECT DISTINCT *
FROM health.user_logs;

SELECT COUNT(*)
FROM deduplicated_user_logs; 

--This query does exactly the same thing as DISTINCT 
SELECT
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS record_count
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic
ORDER BY record_count DESC;

--Use CTE to run the above query-

WITH duplicate_data AS (

SELECT
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS record_count
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic

)

SELECT
  id,
  SUM(record_count) AS total_count
FROM duplicate_data
WHERE record_count > 1
GROUP BY id
ORDER BY total_count DESC;

--EXERCISE QUESTIONS--
--Which ID values has the most duplicate records in health.user_logs?

WITH duplicate_data AS (

SELECT
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS record_count
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic

)

SELECT
  id,
  SUM(record_count) AS total_count
FROM duplicate_data
WHERE record_count > 1
GROUP BY id
ORDER BY total_count DESC;

--Which log_date value had the most duplicate records after removing the max
--duplicate ID value from the previous questions?

WITH duplicate_data AS (

SELECT
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS record_count
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic

)

SELECT
  log_date,
  SUM(record_count) AS total_count
FROM duplicate_data
WHERE record_count > 1 AND id != '054250c692e07a9fa9e62e345231df4b54ff435d'
GROUP BY log_date
ORDER BY total_count DESC;

--QUESTION-1
--how may unique users in user_log table?

SELECT COUNT(DISTINCT id)
FROM health.user_logs;

--QUESTION-2
--How many total measurements do we have 
--per user on average rounded to the nearest integer?

DROP TABLE IF EXISTS user_measure_count;

CREATE TEMP TABLE user_measure_count AS
SELECT
  id, 
  COUNT(*) AS measure_count,
  COUNT(DISTINCT measure) as unique_measures
FROM health.user_logs
GROUP BY 1; 
--how many total measurements do we have per user on average?
SELECT
  ROUND(AVG(measure_count)) AS average_value
FROM user_measure_count; 

--QUESTION-3
--What is the Median number of measurement per user?
DROP TABLE IF EXISTS user_measure_count;

CREATE TEMP TABLE user_measure_count AS
SELECT
  id, 
  COUNT(*) AS measure_count,
  COUNT(DISTINCT measure) as unique_measures
FROM health.user_logs
GROUP BY 1; 

SELECT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY measure_count) AS median_value
FROM user_measure_count; 

--QUESTION-4
--How many users have 3 or more measurements?

DROP TABLE IF EXISTS user_measure_count;

CREATE TEMP TABLE user_measure_count AS
SELECT
  id, 
  COUNT(*) AS measure_count,
  COUNT(DISTINCT measure) as unique_measures
FROM health.user_logs
GROUP BY 1; 

SELECT
  COUNT(*)
FROM user_measure_count
WHERE measure_count >=3;


--QUESTION-5
--How many users have 1,000 or more measurements?
DROP TABLE IF EXISTS user_measure_count;

CREATE TEMP TABLE user_measure_count AS
SELECT
  id, 
  COUNT(*) AS measure_count,
  COUNT(DISTINCT measure) as unique_measures
FROM health.user_logs
GROUP BY 1; 

SELECT
  COUNT(*)
FROM user_measure_count
WHERE measure_count >=1000;



















































