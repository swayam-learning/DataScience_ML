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
-- SELECT f1.f_name AS `food name`,COUNT(f_name) AS `most sold food`
-- FROM menu m1
-- INNER JOIN restaurants r1
-- ON m1.r_id=r1.r_id
-- INNER JOIN food f1
-- ON m1.f_id=f1.f_id
-- GROUP BY f1.f_name
-- ORDER BY `most sold food` DESC
-- LIMIT 5;


-- better way
SELECT f_name,COUNT(*) AS `most sold` FROM menu m1
JOIn food f1 ON m1.f_id = f1.f_id
GROUP BY f_name
ORDER BY `most sold` DESC
LIMIT 5;


-- Q10. find restaurant with max revenue in a given month

SELECT r1.r_name,SUM(o1.amount) AS `revenue` FROM orders o1
INNER JOIN restaurants r1
ON o1.r_id = r1.r_id
WHERE MONTHNAME(DATE(o1.date)) = 'may'
GROUP BY r1.r_id
ORDER BY `revenue` DESC LIMIT 1;

-- Q11. Month by Month revenue geenerated by a restaurant

-- 1st approach
SELECT r1.r_name,MONTHNAME(DATE(o1.date)) AS `month name`,SUM(o1.amount) AS `revenue` 
FROM orders o1
INNER JOIN restaurants r1
ON o1.r_id = r1.r_id
WHERE r1.r_name= 'kfc'
GROUP BY MONTHNAME(DATE(o1.`date`))
ORDER BY MONTHNAME(DATE(o1.`date`));

-- 2nd approach
-- Pivot table
SELECT 
    r1.r_name,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'January' THEN o1.amount ELSE 0 END) AS `January`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'February' THEN o1.amount ELSE 0 END) AS `February`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'March' THEN o1.amount ELSE 0 END) AS `March`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'April' THEN o1.amount ELSE 0 END) AS `April`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'May' THEN o1.amount ELSE 0 END) AS `May`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'June' THEN o1.amount ELSE 0 END) AS `June`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'July' THEN o1.amount ELSE 0 END) AS `July`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'August' THEN o1.amount ELSE 0 END) AS `August`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'September' THEN o1.amount ELSE 0 END) AS `September`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'October' THEN o1.amount ELSE 0 END) AS `October`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'November' THEN o1.amount ELSE 0 END) AS `November`,
    SUM(CASE WHEN MONTHNAME(o1.date) = 'December' THEN o1.amount ELSE 0 END) AS `December`
FROM orders o1
INNER JOIN restaurants r1 ON o1.r_id = r1.r_id
WHERE r1.r_name = 'kfc'
GROUP BY r1.r_name;

-- 3rd approach
SELECT 
    r1.r_name,
    MONTHNAME(o1.date) AS `month name`,
    SUM(o1.amount) AS `revenue`
FROM orders o1
INNER JOIN restaurants r1 ON o1.r_id = r1.r_id
WHERE r1.r_name = 'kfc'
GROUP BY MONTHNAME(o1.date), MONTH(o1.date)
ORDER BY MONTH(o1.date);

-- Q12. find restaurants with sales > x

SELECT r1.r_id,r1.r_name,SUM(t1.amount) as `sales` from orders t1
INNER JOIN restaurants r1
ON r1.r_id = t1.r_id
GROUP BY r_id
HAVING `sales` > 2500;

-- Q13. Find customers who have never ordered
SELECT u1.user_id,name FROM users u1
EXCEPT
SELECT o1.user_id,name 
FROM orders o1
INNER JOIN users u2 ON o1.user_id=u2.user_id;

-- Approach 2
SELECT u1.user_id, u1.name
FROM users u1
LEFT JOIN orders o1 ON u1.user_id = o1.user_id
WHERE o1.user_id IS NULL;


-- Q14. Show details of a particular customer in a given date range

SELECT o1.user_id,o1.order_id,f_name,`date` FROM orders o1
JOIN order_details o2
ON o1.order_id=o2.order_id
JOIN food f1
ON o2.f_id = f1.f_id
WHERE user_id = 1 
AND `date` BETWEEN '2022-05-15' AND '2022-06-15'; 


-- ALTER TABLE order_details CHANGE r_id f_id INT; this was used to change column r_id to f_id

-- Q15. Customers Favourite Food
SELECT 
    u.user_id,
    u.name,
    f.f_name AS favorite_food,
    COUNT(*) AS order_count
FROM 
    users u
JOIN 
    orders o ON u.user_id = o.user_id
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    food f ON od.f_id = f.f_id
GROUP BY 
    u.user_id, f.f_name
HAVING 
    COUNT(*) = (
        SELECT 
            MAX(order_count)
        FROM (
            SELECT 
                COUNT(*) AS order_count
            FROM 
                orders o2
            JOIN 
                order_details od2 ON o2.order_id = od2.order_id
            WHERE 
                o2.user_id = u.user_id
            GROUP BY 
                od2.f_id
        ) AS subquery
    );

SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM delivery_partner;
SELECT * FROM food;
SELECT * FROM menu;
SELECT * FROM restaurants;
SELECT * FROM users;



WITH RankedOrders AS (
    SELECT 
        u.user_id,
        u.name,
        f.f_name AS favorite_food,
        COUNT(*) AS order_count,
        ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY COUNT(*) DESC) AS `rank`
    FROM 
        users u
    JOIN 
        orders o ON u.user_id = o.user_id
    JOIN 
        order_details od ON o.order_id = od.order_id
    JOIN 
        food f ON od.f_id = f.f_id
    GROUP BY 
        u.user_id, f.f_name
)
SELECT 
    user_id,
    name,
    favorite_food,
    order_count
FROM 
    RankedOrders
WHERE 
    `rank` = 1;
