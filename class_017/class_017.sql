USE sakila;

# 1. Create two or three queries using address table in sakila db:
# - include postal_code in where (try with in/not it operator) 
# - eventually join the table with city/country tables.
# - measure execution time.
# - Then create an index for postal_code on address table.
# - measure execution time again and compare with the previous ones.
# - Explain the results

# 2. Run queries using actor table, searching for first and last name columns 
#    independently. Explain the differences and why is that happening?

# 3. Compare results finding text in the description on table film with LIKE 
#    and in the film_text using MATCH ... AGAINST. Explain the results.

# Sintaxis sin cache
# SELECT SQL_NO_CACHE ...

# 1.
# Without indexes
DROP INDEX index_postal_code ON address;

SELECT SQL_NO_CACHE * FROM address
WHERE postal_code IN (
	96115, 943, 53694, 3,
	4545, 8657, 2212, 669);
# Duration: 0.00467375

SELECT SQL_NO_CACHE * FROM address
WHERE postal_code NOT IN (1944, 27107);
# Duration: 0.00941750

SELECT SQL_NO_CACHE * FROM address a
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id)
WHERE a.postal_code NOT IN (1944, 27107);
# Duration: 0.02373350

# With indexes
CREATE INDEX index_postal_code
ON address(postal_code);

SELECT SQL_NO_CACHE * FROM address
WHERE postal_code IN (
	96115, 943, 53694, 3,
	4545, 8657, 2212, 669);
# Duration: 0.01879200

SELECT SQL_NO_CACHE * FROM address
WHERE postal_code NOT IN (1944, 27107);
# Duration: 0.00567975

SELECT SQL_NO_CACHE * FROM address a
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id)
WHERE a.postal_code NOT IN (1944, 27107);
# Duration: 0.00815425

# 2.
SELECT first_name FROM actor
WHERE first_name LIKE 'A%';
# Duration: 0.00128325

SELECT last_name FROM actor
WHERE last_name LIKE 'T%';
# Duration: 0.00121025

# La columna last_name tiene un index

# 3.
# LIKE en la tabla film
SELECT description FROM film
WHERE description LIKE '%Discover%'
# 48 results
# Duration: 0.00889175

SELECT description FROM film
WHERE description LIKE '%Discover%'
AND description LIKE '%Amazing%';
# 7 results
# Duration: 0.01146000

# MATCH en la tabla film_text
SELECT description FROM film_text
WHERE MATCH(title, description) AGAINST('Discover');
# 48 results
# Duration: 0.00304600

SELECT description FROM film_text
WHERE MATCH(title, description) AGAINST('Discover,Amazing');
# 89 results
# Duration: 0.00449925