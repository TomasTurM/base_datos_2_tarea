-- 1. Show title and special_features of films that are PG-13
-- 2. Get a list of all the different films duration.
-- 3. Show title, rental_rate and replacement_cost of films 
-- 	  that have replacement_cost from 20.00 up to 24.00
-- 4. Show title, category and rating of films that have 
--    'Behind the Scenes'   as special_features 
-- 5. Show first name and last name of actors that acted in 
--    'ZOOLANDER FICTION'
-- 6. Show the address, city and country of the store with id 1
-- 7. Show pair of film titles and rating of films that have the 
--    same rating.
-- 8. Get all the films that are available in store id 2 and the 
--    manager first/last name of this store (the manager will 
--    appear in all the rows).

USE sakila;
-- 1.
SELECT title, special_features FROM film
WHERE rating = 'PG-13';

-- 2.
SELECT DISTINCT length FROM film ORDER BY length ASC;

-- 3.
SELECT title, rental_rate, replacement_cost FROM film
WHERE replacement_cost BETWEEN 20.00 AND 24.00 
ORDER BY replacement_cost ASC;

-- 4.
SELECT title, name, rating FROM film f, film_category fc, category c
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id 
AND special_features LIKE '%Behind the Scenes%';

-- 5.
SELECT first_name, last_name FROM actor a, film_actor fa, film f
WHERE f.film_id = fa.film_id AND fa.actor_id = a.actor_id
AND f.title = 'ZOOLANDER FICTION';

-- 6.
SELECT address, city, country FROM address a, city ci, country co, store s
WHERE s.address_id = a.address_id AND a.city_id = ci.city_id AND ci.country_id = co.country_id
AND s.store_id = 1;

-- 7
SELECT f1.title, f2.title, f1.rating FROM film f1, film f2
WHERE f1.rating = f2.rating AND f1.film_id <> f2.film_id
AND f1.film_id < f2.film_id;

-- 8
SELECT f.title, sta.first_name, sta.last_name FROM film f, staff sta, inventory i, store sto
WHERE f.film_id = i.film_id AND i.store_id = sto.store_id 
AND sto.manager_staff_id = sta.staff_id
AND sto.store_id = 2;