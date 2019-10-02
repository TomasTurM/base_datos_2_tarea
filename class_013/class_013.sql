# Write the statements with all the needed subqueries, 
# do not use hard-coded ids unless is specified.
# Check which fields are mandatory and which ones 
# can be ommited (use default value).

# 1. Add a new customer
# -	To store 1
# -	For address use an existing address. The one that 
# 	has the biggest address_id in 'United States'

# 2. Add a rental
# -	Make easy to select any film title. 
# 	I.e. I should be able to put 'film tile' in the 
# 	where, and not the id.
# -	Do not check if the film is already rented, just 
# 	use any from the inventory, e.g. the one with highest id.
# -	Select any staff_id from Store 2. 

# 3. Update film year based on the rating
# -	For example if rating is 'G' release date will be '2001'
# -	You can choose the mapping between rating and year.
# -	Write as many statements are needed.

# 4. Return a film
# -	Write the necessary statements and queries for 
# 	the following steps.
# -	Find a film that was not yet returned. And use 
# 	that rental id. Pick the latest that was rented 
# 	for example.
# -	Use the id to return the film.

# 5. Try to delete a film
# -	Check what happens, describe what to do.
# -	Write all the necessary delete statements to entirely 
# 	remove the film from the DB.

# 6. Rent a film
# -	Find an inventory id that is available for rent 
# 	(available in store) pick any movie. Save this id 
# 	somewhere.
# -	Add a rental entry
# -	Add a payment entry
# -	Use sub-queries for everything, except for the 
# 	inventory id that can be used directly in the queries.

USE sakila;

# 1.
INSERT INTO customer
(store_id, first_name, last_name, address_id, active,
create_date, last_update)
VALUES
(1, "Tomas", "Monier", (
	SELECT MAX(a.address_id) FROM address a
	INNER JOIN city ci ON a.city_id = ci.city_id
	INNER JOIN country co ON co.country_id = ci.country_id
	WHERE co.country = "United States"
), 1, CURDATE(), CURDATE()
)
;

# 2.
INSERT INTO rental
(inventory_id, customer_id, return_date,
staff_id)
VALUES
((
SELECT i.inventory_id FROM inventory i
INNER JOIN film f ON i.film_id = f.film_id
WHERE f.title = "ADAPTATION HOLES"
LIMIT 1
), (
SELECT c.customer_id FROM customer c
ORDER BY RAND()
LIMIT 1
), '2018-06-12 12:12:12',
(
SELECT staff_id FROM staff
WHERE store_id = 2
ORDER BY RAND()
LIMIT 1
)
)
;

# 3.
UPDATE film
SET release_year = 2001
WHERE rating = 'G'
;

# 4.
SELECT f1.* FROM film f1
WHERE film_id = (
	SELECT f2.film_id FROM film f2
	INNER JOIN inventory i 
	ON f2.film_id = i.film_id
	INNER JOIN rental r 
	ON i.inventory_id = r.inventory_id
	WHERE r.return_date IS NULL
	ORDER BY r.rental_date DESC
	LIMIT 1
)
;

# 5.
DELETE FROM film WHERE title = 'SHINING ROSES';
# Explanation
# 	The query couldnt delete the film because it has a 
# 	foreign key constraint with the table film_actor

# Delete a film entirely (Falta)
DELETE FROM film_actor
WHERE film_id = (
	SELECT f.film_id FROM film f
	WHERE title = 'SHINING ROSES'
)
;
DELETE FROM film_category
WHERE film_id = (
	SELECT f.film_id FROM film f
	WHERE title = 'SHINING ROSES'
)
;
DELETE FROM payment
WHERE film_id = (
	SELECT f.film_id FROM film f
	WHERE title = 'SHINING ROSES'
)
;
DELETE FROM inventory
WHERE film_id = (
	SELECT f.film_id FROM film f
	WHERE title = 'SHINING ROSES'
)
;

# 6. (Preguntar como hacerlo)