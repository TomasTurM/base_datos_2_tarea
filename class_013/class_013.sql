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
);

# 2.
INSERT INTO rental
(inventory_id, rental_date, customer_id, return_date,
satff_id, last_update)
VALUES
((
	SELECT i.inventory_id FROM inventory i
	INNER JOIN film f ON i.film_id = f.film_id
	WHERE f.title = ""
), '2018-05-25 12:12:12', (
	SELECT c.customer_id FROM customer c
	ORDER BY RAND()
	LIMIT 1
), 
);