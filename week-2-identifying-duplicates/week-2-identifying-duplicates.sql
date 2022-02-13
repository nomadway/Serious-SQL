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


