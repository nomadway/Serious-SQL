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


