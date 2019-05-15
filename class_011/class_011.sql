# 1) Find all the film titles that are not in the inventory.
# 2) Find all the films that are in the inventory but 
# 	 were never rented. 
# 	 -	Show title and inventory_id.
# 	 -	This exercise is complicated.
# 	 -	hint: use sub-queries in FROM and in WHERE 
#  		or use left join and ask if one of the fields is null
# 3) Generate a report with:
#    -	customer (first, last) name, store id, film title, 
#	 - 	when the film was rented and returned for each of 
#		these customers
#	 - 	order by store_id, customer last_name
# 4) Show sales per store (money of rented films)
#	 -	show store's city, country, manager info and 
#	    total sales (money)
#	 -	(optional) Use concat to show city and country 
#	 	and manager first and last name
# 5) Which actor has appeared in the most films?

USE sakila;

# 1)
SELECT f.title FROM film f 
LEFT OUTER JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL
GROUP BY f.title
;

# 2)
SELECT f.title, i.inventory_id
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
LEFT OUTER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.inventory_id IS NULL
;

# 3)
SELECT c.first_name, c.last_name, s.store_id, f.title,
r.rental_date, r.return_date
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN store s ON s.store_id = i.store_id
INNER JOIN film f ON f.film_id = i.film_id
WHERE rental_date IS NOT NULL
AND return_date IS NOT NULL
ORDER BY s.store_id, c.last_name
;

# 4)
SELECT CONCAT_WS(' ', ci.city, co.country, "-", 
st.first_name, st.last_name) AS 'concat', 
SUM(p.amount) AS 'sales' 
FROM store s
INNER JOIN staff st ON st.staff_id = s.manager_staff_id
INNER JOIN inventory i ON i.store_id = s.store_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN payment p ON p.rental_id = r.rental_id
INNER JOIN address ad ON ad.address_id = s.address_id
INNER JOIN city ci ON ci.city_id = ad.city_id
INNER JOIN country co ON co.country_id = ci.country_id
GROUP BY s.store_id
;

# 5)
SELECT a.* FROM actor a
INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
WHERE a.actor_id IN (
	SELECT actor_id FROM film_actor

)

SELECT MAX(COUNT(actor_id)) FROM film_actor fa