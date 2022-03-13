--IDENTIFYING DUPLICATES / HEALTH DATA ANALYTICS 
--WEEK-2-Session-2 

--DATA INSPECTION

SELECT *
FROM health.user_logs
LIMIT 10;
----------------
SELECT COUNT(*)
FROM health.user_logs;
-----------------------

--Look at value where the measure_value = 0
SELECT *
FROM health.user_logs
WHERE measure_value = 0;

----------------------
SELECT measure, COUNT(*)
FROM health.user_logs
WHERE measure_value=0
GROUP BY measure;
-----------------------

SELECT *
FROM health.user_logs
WHERE measure = 'blood_pressure';
-------------------------

SELECT *
FROM health.user_logs
WHERE measure = 'blood_pressure' AND measure_value = 0;
---------------------------

SELECT *
FROM health.user_logs
WHERE systolic is NULL;
----------------------------

SELECT measure, COUNT(*)
FROM health.user_logs
WHERE systolic is NULL OR systolic = 0
GROUP BY measure; 
-----------------------------

--DEALING WITH DUPLICATES--

--How to identify duplicates?
SELECT COUNT(*)
FROM health.user_logs;
----------------------

--Using CTE and SUBQUERY to do COUNT DISTINCT--
--Both are run on memory and nothing get written to the Disk--
--This is faster when using not large datasets, and where indexing or partitioning is not rrequired.
--Using CTE--query will run in sequential order
--Stick with CTEs, as they are easier to use and understand. 
--CTE
WITH deduped_logs AS (
  SELECT DISTINCT *
  FROM health.user_logs
  )
  
SELECT COUNT(*)
FROM deduped_logs;

--SUBQUERY
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

--CTEs, SUBQUERIES & TEMP TABLES--

--CTE: sequential (in-memory)
--SUBQUERIES: inside out(in-memory)
--TEMP TABLES: sequential ((write/read to disk). 
--(when using TEMP TABLES, one has more control how query is written. Important concepts are indexes, partitions)
--one thing to note, data on MEMEMORY is read faster than on DISK 

--This query will not work to find DISTINCT/UNIQUE records. Better to use CTE
SELECT COUNT(DISTINCT *)
FROM health.user_logs;
---------------------------

WITH deduped_logs AS (
    SELECT DISTINCT *
    FROM health.user_logs)

SELECT COUNT(*)
FROM deduped_logs;---in CTE it is best practice to refer to CTE,i.e. deduped_logs
---------------------------

WITH deduped_logs AS (
    SELECT DISTINCT *
    FROM health.user_logs)

SELECT COUNT(*)
FROM health.user_logs;
----------------------------
--using MULTIPLE CTEs

WITH deduped_logs AS (
    SELECT DISTINCT *
    FROM health.user_logs),  --First CTE is deduped_logs

actual_row_count AS (
    SELECT COUNT(*)
    FROM health.user_logs),--Second CTE is actual_row_count

final_output AS (
    SELECT * 
    FROM actual_row_count) --it is best practice to use final_output

SELECT *
FROM final_output;
--------------------------------------------

--INVESTIGATING DUPLICATES--
SELECT 
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic;
  --------------------------------
  WITH groupby_counts AS (
  SELECT 
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS frequency
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic
),
final_output AS (
SELECT
  id,
  COUNT(*) AS total_record_count,--this Counts only the number of rows and not the number of frequency
  SUM(frequency) AS actual_record_count --The CORRECT thing to do is to use SUM query thatx gives the number of duplicates
FROM groupby_counts
WHERE frequency > 1
GROUP BY id
)
SELECT * 
FROM final_output
ORDER BY total_record_count DESC; 

--------------------------------------------
--THERE IS AN EASIER WAY TO IDENTIFY AND REMOVE DUPLICATES WITHOUT USING CTE
WITH groupby_counts AS (
  SELECT 
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS frequency
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic
)
SELECT *
FROM groupby_counts
WHERE frequency > 1;
--------------------------------------
--without using CTE. Query below gives data that are all duplicates.
SELECT 
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS frequency
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic
HAVING COUNT(*) > 1; --here cannot refer to alias 'frequency', but can refer to expression 'COUNT(*)'
----------------------------------------




  





























