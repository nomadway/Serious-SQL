--Show a few rows and all columns
SELECT
  *
FROM
  health.user_logs language
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


