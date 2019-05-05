# 1. Get the amount of cities per country in the database. 
# 		Sort them by country, country_id.
# 2. Get the amount of cities per country in the database. 
# 		Show only the countries with more than 10 cities, 
# 		order from the highest amount of cities to the lowest   
# 3. Generate a report with customer (first, last) name, 
# 		address, total films rented and the total money 
# 		spent renting films. 
#	- Show the ones who spent more money first.
# 4. Which film categories have the larger film 
# 		duration (comparing average)?
#	- Order by average in descending order
# 5. Show sales per film rating

USE sakila;

# 1.
SELECT c.country, COUNT(*) AS city_counter FROM country c, city ci
WHERE c.country_id = ci.country_id
GROUP BY c.country_id
ORDER BY c.country, c.country_id
;

# 2.
SELECT c.country, COUNT(*) AS city_counter FROM country c, city ci
WHERE c.country_id = ci.country_id
GROUP BY c.country_id
HAVING city_counter > 10
ORDER BY city_counter DESC
;

# 3.
SELECT c.first_name, c.last_name, a.address, 
	(SELECT COUNT(*) FROM rental r
		WHERE r.customer_id = c.customer_id) AS total_rented,
	(SELECT SUM(p.amount) FROM payment p
		WHERE p.customer_id = c.customer_id) AS sum_payment
	FROM customer c, address a
	WHERE c.address_id = a.address_id
	ORDER BY sum_payment DESC
;

# 4
SELECT c.name, 
	(SELECT AVG(f.length) FROM film f
		WHERE f.film_id IN (
			SELECT fc.film_id FROM film_category fc
				WHERE fc.category_id = c.category_id
		)
	) AS avg
	FROM category c
	GROUP BY c.category_id
	HAVING avg > (SELECT AVG(length) FROM film)
	ORDER BY avg DESC
;

# 5
SELECT f.rating, SUM(p.amount) AS sales
FROM payment p
INNER JOIN rental USING (rental_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film f USING (film_id)
GROUP BY f.rating
ORDER BY sales DESC
;