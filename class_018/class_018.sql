USE sakila;

# 1. Create a user data_analyst
#
# 2. Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
#
# 3. Login with this user and try to create a table. Show the result of that operation.
#
# 4. Try to update a title of a film. Write the update script.
#
# 5. With root or any admin user revoke the UPDATE permission. Write the command
#
# 6. Login again with data_analyst and try again the update done in step 4. Show the result.

# 1.
CREATE USER data_analyst@localhost IDENTIFIED BY 'pepe1234'
;

# 2.
# Old:
GRANT SELECT, DELETE, UPDATE ON sakila.*
TO data_analyst IDENTIFIED BY 'pepe1234'
;

ALTER USER data_analyst@localhost
IDENTIFIED BY 'pepe1234'
;

# 3.
CREATE TABLE IF NOT EXISTS actor_2(
	actor_id INT NOT NULL,
	first_name CHAR(15),
	last_name CHAR(15)
)
;
# resultado:
# 

# 4.
UPDATE film
SET title = 'CAMBIA3'
WHERE film_id IN (
	SELECT film_id FROM film
	ORDER BY RAND()
	LIMIT 1
)
;

# 5.
REVOKE UPDATE ON sakila.*
FROM data_analyst@localhost
;

# 6.
UPDATE film
SET title = 'CAMBIA3'
WHERE film_id IN (
	SELECT film_id FROM film
	ORDER BY RAND()
	LIMIT 1
)
;
# resultado:
# 