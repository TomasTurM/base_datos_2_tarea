# Needs the employee table (defined in the triggers section) 
# created and populated.

# 1. Insert a new employee to , but with an null email. 
#    Explain what happens.

# 2. Run the first the query
#
#       UPDATE employees SET employeeNumber = employeeNumber - 20
#
#    What did happen? Explain. Then run this other
#
#       UPDATE employees SET employeeNumber = employeeNumber + 20
#
#    Explain this case also.

# 3. Add an age column to the table employee where and it 
#    can only accept values from 16 up to 70 years old.

# 4. Describe the referential integrity between tables film, 
#    actor and film_actor in sakila db.

# 5. Create a new column called lastUpdate to table employee 
#    and use trigger(s) to keep the date-time updated on 
#    inserts and updates operations. 
#    Bonus: add a column lastUpdateUser and the respective 
#    trigger(s) to specify who was the last MySQL user that 
#    changed the row (assume multiple users, other than root, 
#    can connect to MySQL and change this table).

# 6. Find all the triggers in sakila db related to loading 
#    film_text table. What do they do? Explain each of them 
#    using its source code for the explanation.


# 1.
INSERT INTO employees
(employeeNumber, lastName, firstName, extension, email, 
officeCode, jobTitle)
VALUES 
(1005, 'Monier', 'Tomas', 'x5157', NULL, 1, 'Programmer')
;

# Explanation
#   Error 1048 was returned because, in the table sentence,
#   it is declared that email cannot be null

# 2.
# First query
UPDATE employees SET employeeNumber = employeeNumber - 20;
# Explanation
#   This query updated the employeeNumber of all registries of
#   the table employees, by substracting 20 to their values
# Second query
UPDATE employees SET employeeNumber = employeeNumber + 20;
# Explanation
#   This query tries to add 20 to the employeeNumber of all
#   regitries of the table employees, but MySQL returns 
#   Error 1062: Duplicate entry for key 'PRIMARY' because,
#   despite being changed in the previous query, employeeNumber
#   was created as a Primary Key and each value inserted in
#   that field cannot be repeated

# 3. (No funciona, preguntar profe)
ALTER TABLE employees
ADD age int(2) NOT NULL
;

ALTER TABLE employees
ADD CONSTRAINT ageCheckConstraint CHECK(age > 16 AND age < 70)
;

# ALTER TABLE employees
# ADD CONSTRAINT ageCheckConstraint70 CHECK(age <= 70)
# ;

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`,`age`) values 
(1003,'Murphi','Diano','x5801','mmurphy@classicmodelcars.com','1',NULL,'Presidente',15);

# 4.
# No entiendo la pregunta

# 5.
ALTER TABLE employees
ADD lastUpdate DATETIME
;

ALTER TABLE employees
ADD lastUpdateUser VARCHAR(45)
;

DELIMITER $$
CREATE TRIGGER before_employees_insert
    BEFORE INSERT ON employees
    FOR EACH ROW
BEGIN    
    SET NEW.lastUpdate = NOW(),
    NEW.lastUpdateUser = USER();
END$$

DELIMITER $$
CREATE TRIGGER before_employees_update
    BEFORE UPDATE ON employees
    FOR EACH ROW
BEGIN    
    SET NEW.lastUpdate = NOW(),
    NEW.lastUpdateUser = USER();
END$$

# 6.
# No aparece nada