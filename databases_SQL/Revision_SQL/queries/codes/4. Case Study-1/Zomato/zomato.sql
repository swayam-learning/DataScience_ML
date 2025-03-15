-- Active: 1740077526153@@127.0.0.1@3306@zomato
use zomato;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM delivery_partner;
SELECT * FROM food;
SELECT * FROM menu;
SELECT * FROM restaurants;
SELECT * FROM users;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q1. Count number of rows
SELECT count(*) FROM users;

-- Q2. return n random records
SELECT * FROM order_details ORDER BY RAND() LIMIT 5;

-- Q3. Find null values
SELECT * FROM orders WHERE restaurant_rating IS NULL;

-- Q4. to replace null values with 0
-- UPDATE orders SET restaurant_rating = 0 WHERE restaurant_rating = NULL;

-- Q5. Find orders placed by each customer
SELECT u1.name,o1.order_id FROM orders o1
INNER JOIN users u1 ON o1.user_id=u1.user_id
LEFT JOIN order_details o2 
ON o1.order_id=o2.order_id; 

-- Q6. Find number of orders placed by each customer
SELECT u1.name,COUNT(*) AS num_orders FROM orders o1
INNER JOIN users u1 ON o1.user_id = u1.user_id
GROUP BY u1.name;

-- Q7. find restaurants with most number of menu items
SELECT r1.r_name, COUNT(cuisine) AS `menu items` 
FROM restaurants r1
JOIN menu m1 ON r1.r_id = m1.r_id
GROUP BY r1.r_name;

-- Q8. Find number of votes and average rating for all the restaurants

SELECT r1.r_name,COUNT(*) AS    `num of votes`  ,ROUND(AVG(o1.restaurant_rating),2)  AS `avg restaurant rating`
FROM orders o1
INNER JOIN restaurants r1 ON o1.r_id = r1.r_id 
WHERE restaurant_rating IS NOT NULL
GROUP BY r_name
HAVING `avg restaurant rating` > 2;

-- '' makes a string literal and does not work so we use ` ` which makes it a column alias


-- Q9. Find food that is being sold most at restaurants



