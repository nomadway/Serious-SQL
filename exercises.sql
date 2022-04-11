
---------------SELECT & SORT DATA-------------------

--EXERCISES--

--1-
--What is the 'name' of the category with the highest 
--category_id in the dvd_rentals.category table?

SELECT
  name,
  category_id
FROM dvd_rentals.category
ORDER BY category_id DESC;

--2--
--For the films with the longest 'length', what is the title 
--of the “R” rated film with the lowest 'replacement_cost' 
--in 'dvd_rentals.film' table?

SELECT
  title,
  replacement_cost,
  length,
  rating
FROM dvd_rentals.film
ORDER BY length DESC, replacement_cost
LIMIT 10;

--Answer: 'HOME PITY'


--3-
--Who was the manager of the store with the highest 
--'total_sales' in the 'dvd_rentals.sales_by_store' table?

SELECT
  manager,
  store,
  total_sales
FROM dvd_rentals.sales_by_store
ORDER BY total_sales DESC;


--4-
--What is the 'postal_code' of the city 
--with the 5th highest 'city_id' in the dvd_rentals.address table?

SELECT 
  postal_code,
  city_id
FROM dvd_rentals.address
ORDER BY city_id DESC
LIMIT 5; 

--5--
--Which category had the lowest 'total_sales' value 
--according to the sales_by_film_category table? 
--What was the total_sales value?

SELECT 
  category,
  total_sales
FROM dvd_rentals.sales_by_film_category
ORDER BY total_sales ASC;

--6-
--What was the latest 'payment_date' of all dvd rentals 
--in the 'payment' table?

SELECT 
  payment_date
FROM dvd_rentals.payment
ORDER BY payment_date DESC
LIMIT 1; 

--7-
--Which category had the Highest sales?
SELECT
   category,
   total_sales
FROM dvd_rentals.sales_by_film_category
ORDER BY total_sales DESC
LIMIT 5;


--8--
--Which customer_id had the latest rental_date for inventory_id = 1 and 2?
--Translation: show the dvd_rentals.rental table and order by inventory_id and rental_date descending.

SELECT 
  customer_id,
  inventory_id,
  rental_id

FROM dvd_rentals.rental
WHERE inventory_id IN (1,2)
ORDER BY inventory_id, rental_date DESC; 


--GROUP BY COUNTS--

SELECT
  fid,
  title,
  category,
  rating,
  price
FROM dvd_rentals.film_list
LIMIT 10; 

--GROUP BY--using CTE

WITH example_table AS (
  SELECT
    fid,
    title,
    category,
    rating,
    price
    FROM dvd_rentals.film_list
    LIMIT 10

) 
SELECT
  rating,
  COUNT(*) AS record_count
  FROM example_table
  GROUP BY rating
  ORDER BY record_count DESC;


  --What is the frequency of values in the 'rating' column 
--in the film_list table?
  
SELECT 
  rating,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list
GROUP BY rating
ORDER BY frequency DESC;

--Calculating PERCENTAGE of values in 'rating' column in the 'film_list' table

SELECT
  rating,
  COUNT(*) AS frequency, 
  COUNT(*) :: NUMERIC / SUM(COUNT(*)) OVER () AS percentage
FROM dvd_rentals.film_list
GROUP BY rating
ORDER BY FREQUENCY DESC;

--Calculating percentage-METHOD-2
SELECT
  rating,
  COUNT(*) AS frequency, 
  ROUND(100 * COUNT(*) :: NUMERIC / SUM(COUNT(*)) OVER (), 2
  ) AS percentage
FROM dvd_rentals.film_list
GROUP BY rating
ORDER BY FREQUENCY DESC;

--What are the 5 most frequent 'rating' and 'category' 
--combinations in the film_list table?

SELECT
  rating,
  category,
  COUNT(*) AS frequency
  FROM dvd_rentals.film_list
  GROUP BY rating, category
  ORDER BY frequency DESC
  LIMIT 5; 



---------RECORD COUNTS & DISTINCT VALUES----------------

  --EXERCISES--

--1--
--Which 'actor_id' has the most number of unique 'film_id' 
--records in the 'dvd_rentals.film_actor' table?

SELECT
  actor_id,
  COUNT(DISTINCT film_id)  
FROM dvd_rentals.film_actor
GROUP BY actor_id
ORDER BY count DESC; 


--2--
--How many distinct 'fid' values are there for the 3rd most common 
--'price' value in the dvd_rentals.nicer_but_slower_film_list table?

SELECT 
  COUNT(DISTINCT fid) AS fid,
  price
FROM dvd_rentals.nicer_but_slower_film_list
GROUP BY price
ORDER BY fid DESC
LIMIT 3; 

--3--
--How many unique country_id values exist in the dvd_rentals.city table?--

SELECT
  COUNT(DISTINCT country_id) AS unique_countries
FROM
  dvd_rentals.city;

--4--
--What percentage of overall 'total_sales' does the 'Sports' category 
--make up in the dvd_rentals.sales_by_film_category table?

SELECT
  category,
  ROUND(
      100 * total_sales::NUMERIC / SUM(total_sales) OVER (), 2 ) AS percentage
FROM dvd_rentals.sales_by_film_category;

--5--
--What percentage of unique 'fid' values are in the 'Children'
-- category in the dvd_rentals.film_list table?
SELECT
  category,
  ROUND (100 * COUNT(DISTINCT fid)::NUMERIC / SUM(COUNT(DISTINCT fid)) OVER (), 2) AS percentage
FROM dvd_rentals.film_list
GROUP BY category
ORDER BY category;


--How many rows are there in the film_list table?
SELECT 
  COUNT(*) AS row_count
FROM 
  dvd_rentals.film_list  

--What are the unique values for the rating column in the film table?
SELECT
  DISTINCT rating
FROM 
  dvd_rentals.film

  --How many unique category values are there in the film_list table?
SELECT
  COUNT(DISTINCT category) AS unique_category_count
FROM
  dvd_rentals.film_list

--What is the frequency of values in the rating column in the film_list table?
SELECT
  rating,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list
GROUP BY rating
ORDER BY frequency DESC; 
-------------------
SELECT
  fid,
  title,
  category,
  price,
  rating

FROM
  dvd_rentals.film_list
LIMIT 10;
-----------------------

WITH frequency_table AS (
  SELECT
    fid,
    title,
    category,
    rating,
    price
  FROM dvd_rentals.film_list
  LIMIT 10
)
SELECT
  rating,
  COUNT(*) AS record_count
FROM frequency_table
GROUP BY rating
ORDER BY record_count DESC;

--Adding a Percentage Column/Calculate percentage of rating and rating frequency
SELECT
  rating,
  COUNT(*) frequency_count,
  ROUND(100 * COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM 
  dvd_rentals.film_list 
GROUP BY rating
ORDER BY frequency_count DESC; 

--What are the 5 most frequent rating and category combinations in the film_list table?
SELECT
  rating,
  category,
  COUNT(*) frequency_count
FROM dvd_rentals.film_list
GROUP BY rating, category
ORDER BY frequency_count DESC
LIMIT 5; 

--Using Positional Numbers Instead of Column Names
SELECT
  rating,
  category,
  COUNT(*) frequency_count
FROM dvd_rentals.film_list
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5; 


















------------IDENTIFYING DUPLICATE RECORDS--------------------
------------EXERCISES----------------------

--1--
--Which id value has the most number of duplicate records in the health.user_logs table?--
WITH count_duplicates AS (
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
SELECT
  id,
  SUM(frequency) AS total_num_duplicates
  FROM count_duplicates
  WHERE frequency > 1
  GROUP BY id
  ORDER BY total_num_duplicates DESC
LIMIT 10;

--2--


























































