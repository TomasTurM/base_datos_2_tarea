# 1. Create a view named list_of_customers, it should 
#    contain the following columns:
# 	 - customer id
#    - customer full name, 
#    - address
#    - zip code
#    - phone 
#    - city
#    - country
#    - status (when active column is 1 show it as 
#      'active', otherwise is 'inactive') 
#    - store id

# 2. Create a view named film_details, it should contain 
#    the following columns:
#    - film id
#    - title
#    - description
#    - category
#    - price
#    - length
#    - rating
#    - actors  - as a string of all the actors separated 
#      by comma
#    Hint use GROUP_CONCAT

# 3. Create view sales_by_film_category, it should 
#    return 'category' and 'total_rental' columns.

# 4. Create a view called actor_information where it 
#    should return, actor id, first name, last name and 
#    the amount of films he/she acted on.

# 5. Analyze view actor_info, explain the entire query 
#    and specially how the sub query works. Be very 
#    specific, take some time and decompose each part and 
#    give an explanation for each. 

# 6. Materialized views, write a description, why they are 
#    used, alternatives, DBMS were they exist, etc.

# 1.
CREATE VIEW list_of_customers AS
SELECT c.customer_id, 
CONCAT_WS(' ', c.first_name, c.last_name)
AS full_name, ad.address, ad.postal_code, ad.phone, 
ci.city, co.country, 
CASE
WHEN c.active = 1 THEN "ACTIVE"
WHEN c.active = 0 THEN "INACTIVE"
END, s.store_id
FROM customer c
INNER JOIN store s USING(store_id)
INNER JOIN address ad ON ad.address_id = s.address_id
INNER JOIN city ci USING(city_id)
INNER JOIN country co USING(country_id)
;

# 2. (Preguntar si esta bien, da mil resultados)
CREATE VIEW film_details AS
SELECT f.film_id, f.title, f.description, c.name, 
f.replacement_cost, f.length, f.rating, (
SELECT GROUP_CONCAT(	
CONCAT_WS(' ', a.first_name, a.last_name)
)
FROM actor a
INNER JOIN film_actor fa
GROUP BY fa.film_id
HAVING fa.film_id = f.film_id
) AS actors
FROM film f
INNER JOIN film_category fa ON f.film_id = fa.film_id
INNER JOIN category c ON fa.category_id = c.category_id
;

# 3.
CREATE OR REPLACE VIEW sales_by_film_category AS
	SELECT c.name AS category, SUM(p.amount) AS total_rental
	FROM film f
	INNER JOIN film_category fa ON f.film_id = fa.film_id
	INNER JOIN category c ON fa.category_id = c.category_id
	INNER JOIN inventory i ON f.film_id = i.film_id
	INNER JOIN rental r ON i.inventory_id = r.inventory_id
	INNER JOIN payment p ON r.rental_id = p.rental_id
	GROUP BY c.name
;

# 4.
CREATE OR REPLACE VIEW actor_information AS
	SELECT a.actor_id, a.first_name, a.last_name,
	COUNT(fa.film_id) AS featured_movies
	FROM actor a
	INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id
;