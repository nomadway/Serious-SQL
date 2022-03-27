--VERY BASIC INTRO-
SELECT
  *
FROM
  balanced_tree.product_details;

  --SORTING-
  SELECT country
FROM
  dvd_rentals.country
ORDER BY country --by default prints countries in alphabetical order
LIMIT 5;

--SORT WITH MUPTIPLE COLUMNS-prints categories with lowest sales-
SELECT
  category,
  total_sales
FROM
  dvd_rentals.sales_by_film_category
ORDER BY
  total_sales
LIMIT
  5;

  --SORT by DESC to print the latest payment--
  SELECT
  payment_date
FROM
  dvd_rentals.payment
ORDER BY
  payment_date DESC
LIMIT
  1;

--SORTING by multiple columns and create CTE-
DROP TABLE IF EXISTS sample_table;
CREATE TEMP TABLE sample_table AS WITH raw_data (id, column_a, column_b) AS (
  VALUES
    (1, 0, 'A'),
    (2, 0, 'B'),
    (3, 1, 'C'),
    (4, 1, 'D'),
    (5, 2, 'D'),
    (6, 3, 'D')
)
SELECT
  *
FROM
  raw_data;

SELECT
  *
FROM
  sample_table;

--SORT by 2 columns ASCENDING
SELECT
  *
FROM
  sample_table
ORDER BY
  column_a,
  column_b 
  
  --SORT ASCENDING & DESCENDING
SELECT
  *
FROM
  sample_table
ORDER BY
  column_a DESC,
  column_b
  
    --SORT both DESCENDING
SELECT
  *
FROM
  sample_table
ORDER BY
  column_a DESC,
  column_b DESC;
  
  
--CHANGED COLUMN ORDER

SELECT
  *
FROM
  sample_table
ORDER BY
  column_b DESC,
  column_a;
  

--CHANGED COLUMN ORDER AGAIN 

SELECT
  *
FROM
  sample_table
ORDER BY
  column_b,
  column_a DESC;

--RECOURD COUNT AND DISTINCT VALUES--

--How many Records in film_list table?--
SELECT COUNT(*) AS row_count 
FROM dvd_rentals.film_list;

--Unique column values--(find unique values for the 'rating' column in 'film_list' table)
SELECT DISTINCT rating
FROM dvd_rentals.film_list;

--Count of unique values (find unique 'category' values in film_list table)
SELECT
  COUNT(DISTINCT category) AS unique_category_count
FROM dvd_rentals.film_list;


--GROUP BY COUNT
--what is the frequency of values in the 'rating' clolumn in the 'film_list' table?
--COUNT(*) will not check for NULLS
--important to note: GROUP BY returns only 1 row for each group

SELECT
  rating,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list
GROUP BY rating; 

--Adding a percentage % to counting frequency of 'rating'
SELECT
  rating,
  COUNT(*) AS frequency,
  COUNT(*) :: NUMERIC / SUM(COUNT(*)) OVER () AS percentage
FROM dvd_rentals.film_list
GROUP BY rating
ORDER BY frequency DESC; --ORDER BY always comes after GROUP BY

--Multiple Column GROUP BY--
--(find 5 most frequent 'rating' and 'category'
--combinations in the film_list table)
SELECT
  rating,
  category,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list
GROUP BY rating, category
ORDER BY frequency DESC
LIMIT 5; 

--GROUP BY Ordinal Syntax--
SELECT
  rating,
  category,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list
GROUP BY 1, 2  --1 refers to 'rating' and 2 to 'category'

--GROUP BY Ordinal Syntax example
SELECT
  rating, 
  category,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list  
GROUP BY 1, 2
ORDER BY rating, category, frequency DESC
LIMIT 5; 

--GROUP BY Ordinal Syntax example
SELECT
  rating, 
  category,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list  
GROUP BY 1, 2
ORDER BY 3 DESC --here 3 refers to 'frequency'
LIMIT 5;

--GROUP BY Ordinal RECOMMENDED Syntax
SELECT
  rating, 
  category,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list  
GROUP BY 1, 2
ORDER BY frequency DESC 
LIMIT 5;

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
























































