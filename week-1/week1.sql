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
