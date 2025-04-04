/*
1. This query creates an 'employees' table with various constraints.
It includes:
- emp_id as PRIMARY KEY
- emp_name NOT NULL
- age with a CHECK constraint
- email as UNIQUE
- salary with a DEFAULT value
*/
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000.00
);

/*
Q2. Explain the purpose of constraints and how they help maintain data integrity 
in a database. Provide examples of common types of constraints.
*/

-- Constraints are rules applied to table columns to maintain data integrity.
-- They prevent invalid, duplicate, or inconsistent data entries.

-- Common types of constraints:

-- 1. PRIMARY KEY: Uniquely identifies each record.
--    Example: emp_id INT PRIMARY KEY

-- 2. NOT NULL: Prevents NULL values in a column.
--    Example: emp_name VARCHAR(255) NOT NULL

-- 3. UNIQUE: Ensures all values in a column are different.
--    Example: email VARCHAR(255) UNIQUE

-- 4. CHECK: Validates data using a condition.
--    Example: age INT CHECK (age >= 18)

-- 5. DEFAULT: Assigns a default value when none is provided.
--    Example: salary DECIMAL(10,2) DEFAULT 30000.00

-- 6. FOREIGN KEY: Links records between tables and maintains referential integrity.
--    Example: dept_id INT REFERENCES departments(dept_id)

/*
Q3. Why would you apply the NOT NULL constraint to a column? 
Can a primary key contain NULL values? Justify your answer.
*/

-- The NOT NULL constraint ensures that a column cannot have NULL values.
-- It is used to enforce that all rows must have a value in that column.
-- A PRIMARY KEY cannot contain NULL values because:
-- 1. It must uniquely identify each row.
-- 2. NULL represents an unknown value, which breaks uniqueness.
-- Therefore, NULLs are not allowed in primary key columns.

/*
Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table.
Provide an example for both adding and removing a constraint.
*/

-- To ADD a constraint:
-- Use ALTER TABLE with ADD CONSTRAINT.

ALTER TABLE employees
ADD CONSTRAINT chk_age CHECK (age >= 18);

-- To REMOVE a constraint:
-- Use ALTER TABLE with DROP CONSTRAINT (if named), or DROP CHECK (in MySQL).

ALTER TABLE employees
DROP CHECK chk_age;

/*
Q5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
*/

-- Violating constraints causes errors and prevents invalid data from being inserted or updated.
-- This maintains data accuracy and integrity.

-- Example: Trying to insert NULL into a NOT NULL column

#INSERT INTO employees (emp_id, emp_name) VALUES (101, NULL);

-- Possible Error:
-- ERROR 1048 (23000): Column 'emp_name' cannot be null

/*
Q6. You created a products table without constraints. Now you realize that:
- product_id should be a PRIMARY KEY
- price should have a DEFAULT value of 50.00
*/
ALTER TABLE products
ADD PRIMARY KEY (product_id);

ALTER TABLE products
MODIFY price DECIMAL(10,2) DEFAULT 50.00;

/*
Q7. Write a query to fetch the student_name and class_name for each student 
using an INNER JOIN on Students and Classes tables.
*/

SELECT 
    Students.student_name,
    Classes.class_name
FROM 
    Students
INNER JOIN 
    Classes
ON 
    Students.class_id = Classes.class_id;

/*
Q8. Write a query that shows all order_id, customer_name, and product_name,
ensuring that all products are listed even if they are not associated with an order.
Hint: Use INNER JOIN and LEFT JOIN.
*/

SELECT 
    Products.order_id,
    Customers.customer_name,
    Products.product_name
FROM 
    Products
LEFT JOIN Orders 
    ON Products.order_id = Orders.order_id
LEFT JOIN Customers 
    ON Orders.customer_id = Customers.customer_id;

/*
Q9. Write a query to find the total sales amount for each product 
using an INNER JOIN and the SUM() function.
*/

SELECT 
    Products.product_name,
    SUM(Sales.amount) AS total_sales
FROM 
    Products
INNER JOIN Sales 
    ON Products.product_id = Sales.product_id
GROUP BY 
    Products.product_name;

#SQL COMMANDS
/*
Q1. Identify the primary keys and foreign keys in the Maven Movies database.
Also, discuss the difference between them.
*/

-- 🔑 PRIMARY KEYS in Maven Movies DB (some examples):
-- These uniquely identify each row in a table.

-- Example:
-- film(film_id) → PRIMARY KEY
-- actor(actor_id) → PRIMARY KEY
-- customer(customer_id) → PRIMARY KEY
-- rental(rental_id) → PRIMARY KEY

-- 🔗 FOREIGN KEYS in Maven Movies DB:
-- These create relationships between tables.

-- Example:
-- film_actor(film_id) → FOREIGN KEY referencing film(film_id)
-- film_actor(actor_id) → FOREIGN KEY referencing actor(actor_id)
-- payment(customer_id) → FOREIGN KEY referencing customer(customer_id)
-- rental(inventory_id) → FOREIGN KEY referencing inventory(inventory_id)

-- ✅ Difference:
-- PRIMARY KEY:
-- - Uniquely identifies each record.
-- - Cannot be NULL.
-- - One per table.

-- FOREIGN KEY:
-- - Links to the PRIMARY KEY of another table.
-- - Can have duplicates and NULLs (in some cases).
-- - Ensures referential integrity between tables.

/*
Q2. List all details of actors
*/

SELECT * 
FROM actor;

/*
Q3. List all customer information from DB
*/
SELECT * 
FROM customer;

/*
Q4. List different countries
*/
SELECT DISTINCT country 
FROM country;

/*
Q5. Display all active customers
*/
SELECT * 
FROM customer 
WHERE active = 1;

/*
Q6. List of all rental IDs for customer with ID 1
*/
SELECT rental_id 
FROM rental 
WHERE customer_id = 1;

/*
Q7. Display all the films whose rental duration is greater than 5
*/
SELECT * 
FROM film 
WHERE rental_duration > 5;
 
/*
Q8. List the total number of films whose replacement cost is greater than $15 and less than $20
*/
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

/*
Q9. Display the count of unique first names of actors
*/
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

/*
Q10. Display the first 10 records from the customer table
*/
SELECT * 
FROM customer
LIMIT 10;

/*
Q11. Display the first 3 records from the customer table whose first name starts with ‘b’
*/
SELECT * 
FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;

/*
Q12. Display the names of the first 5 movies which are rated as ‘G’
*/
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;

/*
Q13. Find all customers whose first name starts with "a"
*/
SELECT * 
FROM customer
WHERE first_name LIKE 'A%';

/*
Q14. Find all customers whose first name ends with "a"
*/
SELECT * 
FROM customer
WHERE first_name LIKE '%a';

/*
Q15. Display the list of first 4 cities which start and end with ‘a’
*/
SELECT city 
FROM city
WHERE city LIKE 'A%a'
LIMIT 4;

/*
Q16. Find all customers whose first name have "NI" in any position
*/
SELECT * 
FROM customer
WHERE first_name LIKE '%NI%';

/*
Q17. Find all customers whose first name has "r" in the second position
*/
SELECT * 
FROM customer
WHERE first_name LIKE '_r%';

/*
Q18. Find all customers whose first name starts with "a" and are at least 5 characters in length
*/
SELECT * 
FROM customer
WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

/*
Q19. Find all customers whose first name starts with "a" and ends with "o"
*/
SELECT * 
FROM customer
WHERE first_name LIKE 'A%o';

/*
Q20. Get the films with pg and pg-13 rating using IN operator
*/
SELECT * 
FROM film
WHERE rating IN ('PG', 'PG-13');

/*
Q21. Get the films with length between 50 to 100 using BETWEEN operator
*/
SELECT * 
FROM film
WHERE length BETWEEN 50 AND 100;

/*
Q22. Get the top 50 actors using LIMIT operator
*/
SELECT * 
FROM actor
LIMIT 50;

/*
Q23. Get the distinct film ids from inventory table
*/
SELECT DISTINCT film_id 
FROM inventory;

#Functions
/*
Q1. Retrieve the total number of rentals made in the Sakila database
*/
SELECT COUNT(*) AS total_rentals
FROM rental;

/*
Q2. Find the average rental duration (in days) of movies rented from the Sakila database
*/
SELECT AVG(rental_duration) AS average_rental_duration
FROM film;

/*
Q3. Display the first name and last name of customers in uppercase
*/
SELECT UPPER(first_name) AS upper_first_name, 
       UPPER(last_name) AS upper_last_name
FROM customer;

/*
Q4. Extract the month from the rental date and display it alongside the rental ID
*/
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

/*
Q5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals)
*/
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

/*
Q6. Find the total revenue generated by each store
*/
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

/*
Q7. Determine the total number of rentals for each category of movies
*/
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

/*
Q8. Find the average rental rate of movies in each language
*/
SELECT l.name AS language_name, 
       AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

/*
Q9. Display the title of the movie, customer's first name, and last name who rented it
*/
SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

/*
Q10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind"
*/
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

/*
Q11. Retrieve the customer names along with the total amount they've spent on rentals
*/
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

/*
Q12. List the titles of movies rented by each customer in a particular city (e.g., 'London')
*/
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.first_name, c.last_name, f.title;

#Advance
/*
Q13. Display the top 5 rented movies along with the number of times they've been rented
*/
SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY times_rented DESC
LIMIT 5;

/*
Q14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)
*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

#windows function
-- 1. Rank the customers based on the total amount they've spent on rentals
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 2. Calculate the cumulative revenue generated by each film over time
SELECT 
    f.film_id,
    f.title,
    r.rental_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;

-- 3. Determine the average rental duration for each film, considering films with similar lengths
SELECT 
    film_id,
    title,
    length,
    rental_duration,
    AVG(rental_duration) OVER (PARTITION BY length) AS avg_duration_for_length
FROM film;

-- 4. Identify the top 3 films in each category based on their rental counts
SELECT 
    c.name AS category,
    f.title,
    COUNT(r.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.title;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals,
    ROUND(COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER (), 2) AS rental_diff_from_avg
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 6. Find the monthly revenue trend for the entire rental store over time
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY month
ORDER BY month;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers
WITH ranked_customers AS (
    SELECT 
        customer_id,
        first_name,
        last_name,
        SUM(amount) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(amount) DESC) AS spending_tile
    FROM customer
    JOIN payment USING (customer_id)
    GROUP BY customer_id
)
SELECT * 
FROM ranked_customers
WHERE spending_tile = 1;

-- 8. Calculate the running total of rentals per category, ordered by rental count
SELECT 
    c.name AS category,
    f.title,
    COUNT(r.rental_id) AS rental_count,
    SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS running_total
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.title;

-- 9. Find the films that have been rented less than the average rental count for their respective categories
WITH film_rentals AS (
    SELECT 
        f.film_id,
        f.title,
        c.name AS category,
        COUNT(r.rental_id) AS rental_count,
        AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name) AS avg_in_category
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY f.film_id
)
SELECT *
FROM film_rentals
WHERE rental_count < avg_in_category;

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY revenue DESC
LIMIT 5;

# Normalizations and clt
/*1. First Normal Form (1NF):

 a. Identify a table in the Sakila database that violates 1NF. Explain how you

 would normalize it to achieve 1NF.*/
 CREATE TABLE customer_with_phones (
    customer_id INT,
    full_name VARCHAR(100),
    phone_numbers VARCHAR(255) -- multiple phone numbers in one field (not 1NF)
);

INSERT INTO customer_with_phones VALUES
(1, 'Alice Smith', '123456,7891011'),
(2, 'Bob Brown', '456789');

#normmalise it 
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100)
);

CREATE TABLE customer_phone (
    customer_id INT,
    phone_number VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

INSERT INTO customer VALUES
(1, 'Alice Smith'),
(2, 'Bob Brown');

INSERT INTO customer_phone VALUES
(1, '123456'),
(1, '7891011'),
(2, '456789');

/*2. Second Normal Form (2NF):

 a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 

 If it violates 2NF, explain the steps to normalize it.*/


CREATE TABLE rental_violates_2nf (
    rental_id INT,
    inventory_id INT,
    customer_id INT,
    rental_date DATE,
    customer_name VARCHAR(100) -- depends only on customer_id, not full PK
);

CREATE TABLE customer_2nf (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE rental (
    rental_id INT PRIMARY KEY,
    inventory_id INT,
    customer_id INT,
    rental_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer_2nf(customer_id)
);

/*3. Third Normal Form (3NF):

 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 

 present and outline the steps to normalize the table to 3NF.*/
 CREATE TABLE rental_violate_3nf (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100), -- Transitive dependency
    rental_date DATE
);
-- Step 1: Create a customer table (remove transitive dependency)
CREATE TABLE customer_3nf (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100)
);

-- Step 2: Create rental table with foreign key
CREATE TABLE rental_3nf (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    rental_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer_3nf(customer_id)
);

/*4. Normalization Process:

 a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 

 unnormalized form up to at least 2NF.*/
 -- Unnormalized table (UNF)
CREATE TABLE unrental (
    rental_id INT,
    customer_id INT,
    customer_name VARCHAR(100),
    films_rented VARCHAR(255)  -- e.g. '101,Laptop;102,Phone'
);
-- 1NF-compliant table
CREATE TABLE rental_1nf (
    rental_id INT,
    customer_id INT,
    customer_name VARCHAR(100),
    film_id INT,
    film_title VARCHAR(100)
);
-- Customer Table
CREATE TABLE customer_2nf (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Film Table
CREATE TABLE film_2nf (
    film_id INT PRIMARY KEY,
    film_title VARCHAR(100)
);

-- Rental Table (fact table)
CREATE TABLE rental_2nf (
    rental_id INT,
    customer_id INT,
    film_id INT,
    PRIMARY KEY (rental_id, film_id),
    FOREIGN KEY (customer_id) REFERENCES customer_2nf(customer_id),
    FOREIGN KEY (film_id) REFERENCES film_2nf(film_id)
);
INSERT INTO customer_2nf VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO film_2nf VALUES
(101, 'Laptop'),
(102, 'Phone');

INSERT INTO rental_2nf VALUES
(1, 1, 101),
(1, 1, 102),
(2, 2, 101);

/*5. CTE Basics:

 a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 

 have acted in from the actor and film_actor tables.*/
 -- Using CTE to get actor names and their film counts
WITH actor_film_count AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM 
        actor a
    JOIN 
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, a.first_name, a.last_name
)

-- Final SELECT from the CTE
SELECT * FROM actor_film_count;

/*6. CTE with Joins:

 a. Create a CTE that combines information from the film and language tables to display the film title, 

 language name, and rental rate.*/
 -- CTE to combine film and language details
WITH film_language_info AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)

-- Final output from CTE
SELECT * FROM film_language_info;

/*c\ CTE for Aggregation:

 a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 

 from the customer and payment tables.*/
 -- CTE to calculate total revenue for each customer
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM 
        customer c
    JOIN 
        payment p ON c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)

-- Final output from CTE
SELECT * FROM customer_revenue
ORDER BY total_revenue DESC;

/*8 CTE with Window Functions:

 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.*/
 
-- CTE to rank films by rental duration
WITH film_ranking AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM 
        film
)

-- Final output
SELECT * FROM film_ranking
ORDER BY duration_rank;

/*9 CTE and Filtering:

 a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 

 customer table to retrieve additional customer details.*/
-- CTE to get customers with more than two rentals
WITH frequent_customers AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM 
        rental
    GROUP BY 
        customer_id
    HAVING 
        COUNT(rental_id) > 2
)

-- Join CTE with customer table to get full customer details
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    fc.rental_count
FROM 
    frequent_customers fc
JOIN 
    customer c ON fc.customer_id = c.customer_id;
/*10CTE for Date Calculations:

 a. Write a query using a CTE to find the total number of rentals made each month, considering the 

 rental_date from the rental tabl*/
-- CTE to extract year and month and count rentals
WITH monthly_rentals AS (
    SELECT 
        YEAR(rental_date) AS rental_year,
        MONTH(rental_date) AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM 
        rental
    GROUP BY 
        YEAR(rental_date), MONTH(rental_date)
)

-- Display the result
SELECT 
    rental_year,
    rental_month,
    total_rentals
FROM 
    monthly_rentals
ORDER BY 
    rental_year, rental_month;
/*11 CTE and Self-Join:

 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 

 together, using the film_actor table.*/
-- CTE to simplify film_actor table reference
WITH actor_pairs AS (
    SELECT 
        fa1.actor_id AS actor_id_1,
        fa2.actor_id AS actor_id_2,
        fa1.film_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 
        ON fa1.film_id = fa2.film_id 
        AND fa1.actor_id < fa2.actor_id
)

-- Final query to show actor names along with film ID
SELECT 
    a1.first_name || ' ' || a1.last_name AS actor_1,
    a2.first_name || ' ' || a2.last_name AS actor_2,
    ap.film_id
FROM 
    actor_pairs ap
JOIN 
    actor a1 ON ap.actor_id_1 = a1.actor_id
JOIN 
    actor a2 ON ap.actor_id_2 = a2.actor_id
ORDER BY 
    ap.film_id, actor_1, actor_2;

/*12. CTE for Recursive Search:

 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 

 considering the reports_to column*/
-- Replace '1' with the manager_id you want to start with
WITH RECURSIVE staff_hierarchy AS (
    -- Anchor member: employees who directly report to the given manager
    SELECT 
        staff_id, 
        first_name, 
        last_name, 
        reports_to
    FROM 
        staff
    WHERE 
        reports_to = 1  -- 👈 Replace this with your desired manager ID

    UNION ALL

    -- Recursive member: employees who report to staff found above
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.reports_to
    FROM 
        staff s
    INNER JOIN 
        staff_hierarchy sh 
        ON s.reports_to = sh.staff_id
)

-- Final result: show staff who report up to the given manager
SELECT 
    staff_id, 
    first_name, 
    last_name, 
    reports_to
FROM 
    staff_hierarchy;
 
