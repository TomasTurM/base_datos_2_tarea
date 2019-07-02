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

# 3. Add a age column to the table employee where and it 
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

# Second query
UPDATE employees SET employeeNumber = employeeNumber + 20
# Explanation
