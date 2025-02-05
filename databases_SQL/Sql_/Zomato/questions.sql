USE zomato;
SELECT * FROM users;
SELECT * FROM restaurants;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM menu;
SELECT * FROM food;
SELECT * FROM delivery_partner;
-- --------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1 count number of rows
SELECT count(*) FROM order_details;

-- Q2.  Return n random records
SELECT * FROM users ORDER BY RAND() LIMIT 5;

-- Q3. find null values -- i replaced null by 0
SELECT * FROM orders WHERE restaurant_rating IS NULL;

-- Q4. to replace 0 values with NULL 
UPDATE orders  SET restaurant_rating = NULL WHERE restaurant_rating = 0;

-- Q5. Find number of orders placed bye each customer
SELECT u1.name,COUNT(o1.order_id) AS total_order  FROM orders o1 JOIN users u1 ON u1.user_id = o1.user_id GROUP BY o1.user_id;

-- Q6 find restaurant with most number of menu items
SELECT r1.r_name,COUNT(m1.menu_id) as total_no_of_items 
FROM menu m1 
JOIN restaurants r1 
ON m1.r_id = r1.r_id 
GROUP BY r1.r_name 
ORDER BY total_no_of_items DESC;

-- Q7.find number of votes and avg rating for all the restaurants
SELECT r1.r_name,count(o1.restaurant_rating) AS total_rating,ROUND(AVG(o1.restaurant_rating))
avg_rating FROM orders o1 
JOIN restaurants r1 ON o1.r_id = r1.r_id 
GROUP BY r1.r_name ORDER BY avg_rating DESC;

--Q8. Find the food that is being sold at most number of restaurants
SELECT t2.f_name , COUNT (*) FROM menu t1 JOIN food t2 ON t1.f_id=t2.f_id
GROUP BY t1.f_id ORDER BY COUNT(*) DESC LIMIT 1;

--Q9.Find restaurant with max revenue in a given month
-- SELECT  MONTH(DATE(date)) ,date FROM orders;
SELECT t2.r_name,SUM(t1.amount) AS amount FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTH(DATE(date)) = 5
GROUP BY t1.r_id
ORDER BY amount DESC;

-- Q10.how much does kfc earn in the month of june 
SELECT t2.r_name,SUM(t1.amount) AS amount FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTHNAME(DATE(date)) = "july" AND t2.r_name="kfc"
GROUP BY t1.r_id
ORDER BY amount DESC;

-- Q11.find restaurants with sales > 1000
SELECT r_name,SUM(amount) AS 'revenue' FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
GROUP BY t1.r_id
HAVING revenue>1500;

--Q12. Find customers who have never ordered

SELECT user_id,name FROM users
EXCEPT
SELECT t1.user_id,t1.name FROM users t1  JOIN orders t2 ON t1.user_id = t2.user_id;

SELECT t1.user_id, t1.name 
FROM users t1
LEFT JOIN orders t2 ON t1.user_id = t2.user_id
WHERE t2.order_id IS NULL;

-- Q13. Show order details for a user in a given date range
