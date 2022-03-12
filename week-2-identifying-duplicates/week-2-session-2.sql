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

--CTE vs SUBQUERY--(Biggets difference is CTE is read 'sequentially, top-down', we can have multiple CTEs in a query. SUBQUERY is read from inside-out.)
--CTE
WITH deduped_logs AS (
  SELECT DISTINCT *
  FROM health.user_logs
  )
  
SELECT COUNT(*)
FROM deduped_logs;

--SUBQUERY
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

