DROP DATABASE IF EXISTS imdb;

CREATE DATABASE IF NOT EXISTS imdb;

USE imdb;

CREATE TABLE IF NOT EXISTS film(
	film_id INT NOT NULL,
	title CHAR(15),
	description CHAR(40),
	release_year YEAR
);

ALTER TABLE film ADD CONSTRAINT film_pk PRIMARY KEY (film_id);
ALTER TABLE film MODIFY film_id INT NOT NULL AUTO_INCREMENT;

CREATE TABLE IF NOT EXISTS actor(
	actor_id INT NOT NULL,
	first_name CHAR(15),
	last_name CHAR(15)
);

ALTER TABLE actor ADD CONSTRAINT actor_pk PRIMARY KEY (actor_id);
ALTER TABLE actor MODIFY actor_id INT NOT NULL AUTO_INCREMENT;

CREATE TABLE IF NOT EXISTS film_actor(
	actor_id INT NOT NULL,
	film_id INT NOT NULL
);

ALTER TABLE film ADD COLUMN last_update DATETIME DEFAULT NOW();
ALTER TABLE actor ADD COLUMN last_update DATETIME DEFAULT NOW();

ALTER TABLE film_actor ADD CONSTRAINT film_fk FOREIGN KEY (film_id) REFERENCES film (film_id);
ALTER TABLE film_actor ADD CONSTRAINT actor_fk FOREIGN KEY (actor_id) REFERENCES actor (actor_id);

INSERT INTO film (title, description, release_year) VALUES ('Matrix', 'Description 1', 2001);
INSERT INTO film (title, description, release_year) VALUES ('Pulp Fiction', 'Description 2', 1988);

INSERT INTO actor (first_name, last_name) VALUES ('Johny', 'Sins');
INSERT INTO actor (first_name, last_name) VALUES ('Barack', 'Obama');

INSERT INTO film_actor (actor_id, film_id) VALUES (1, 1);
INSERT INTO film_actor (actor_id, film_id) VALUES (2, 2);

SELECT * FROM film;
SELECT '';
SELECT * FROM actor;
SELECT '';
SELECT a.first_name, a.last_name, f.title FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id 
	JOIN actor a ON fa.actor_id = a.actor_id;