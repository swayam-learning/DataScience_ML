USE sqllearning;
SELECT * FROM `movies (1)`;

-- Q1. Find the movie with highest profit (vs Order by)

SELECT * FROM `movies (1)`
 WHERE (gross - budget)=(SELECT MAX(gross-budget) FROM `movies (1)`);

-- find all the movies that have rating greater than avg rating

SELECT * FROM `movies (1)` WHERE score > (SELECT AVG(score) FROM `movies (1)`); 

SELECT * FROM `movies (1)` WHERE year = 2000  AND (score) = (SELECT Max(score) FROM `movies (1)` WHERE year=2000);


-- find all the users woh never ordered
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM food;
SELECT * FROM customers;

SELECT * FROM users;

SELECT * FROM users WHERE user_id NOT IN (SELECT DISTINCT(u1.user_id) FROM users u1 JOIN orders o1 ON u1.user_id = o1.user_id 
JOIN order_details o2 ON o2.order_id = o1.order_id); 

SELECT * FROM users WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders);

-- Q2. Find all the movies made by top3 directors (in terms of total gross income)

SELECT director,SUM(gross) FROM `movies (1)` GROUP BY director ORDER BY SUM(gross) DESC LIMIT 3;

