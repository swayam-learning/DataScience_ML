USE sqllearning;

SELECT * FROM users;
SELECT * FROM users1;
SELECT * FROM membership;
SELECT * FROM `groups`;
-- --------------------- CROSS JOINS -----------------------------------------------
SELECT * FROM users t1 CROSS JOIN `groups` t2; 
-- --------------------INNER JOINS--------------------------------------------------
SELECT * FROM membership t1 INNER JOIN `groups` t2 ON t1.group_id = t2.group_id;
-- --------------------LEFT JOINS---------------------------------------------------
SELECT * FROM users t1 LEFT JOIN membership t2 ON t1.user_id = t2.user_id;
-- -------------------RIGHT JOINS---------------------------------------------------
SELECT * FROM users t1 RIGHT JOIN membership t2 on t1.user_id=t2.user_id;
-- -------------------FULL OUTER JOINS----------------------------------------------
SELECT * FROM users FULL JOIN membership ;
-- ------------------ SETS----------------------------------------------------------
-- ------------------UNION----------------------------------------------------------
SELECT * FROM person1
UNION
SELECT * FROM person2;
-- -------------------UNION ALL ----------------------------------------------------
SELECT * FROM person1 
UNION ALL
SELECT * FROM person2;
-- -------------------INTERSECT------------------------------------------------------
SELECT * FROM person1
INTERSECT
SELECT * FROM person2;
-- ------------------ EXCEPT or MINUS------------------------------------------------
SELECT * FROM person1
EXCEPT
SELECT * FROM person2;
-- -----------------------------------------------------------------------------------
-- ------------------FULL OUTER JOIN--------------------------------------------------
SELECT * FROM users t1 LEFT JOIN membership t2 ON t1.user_id=t2.user_id
UNION
SELECT * FROM users t3 RIGHT JOIN membership t4 ON t3.user_id=t4.user_id;
-- -----------------------------------------------------------------------------------
-- ------------------ SELF JOINS -----------------------------------------------------
SELECT u1.user_id,u1.name,u2.emergency_contact AS emergency_contact_id ,u2.name AS emergency_contact_name FROM users1 u1 JOIN users1 u2 ON u1.user_id=u2.emergency_contact;
-- --------------------joining on two different column-------------------------------
SELECT * FROM students s1 RIGHT JOIN class c1 ON s1.enrollment_year = c1.class_year;

-- FROM -- JOIN -- WHERE -- GROUP BY --HAVING --SELECT --DISTINCT --ORDER BY

-- -------------- 3 TABLE JOINING ------------------------------------------------------
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM orders1;
SELECT * FROM orders2;
SELECT * FROM category;
SELECT * FROM users;

SELECT t1.order_id,t1.amount,t1.profit,t2.user_id,t4.name,t4.state,t4.city 
FROM order_details t1 
JOIN orders t2 
ON t1.order_id = t2.order_id 
JOIN
users t4 ON t4.user_id = t2.user_id;
-- --------------------------------------------------------------------------------------------------------------
-- Q1.Find order id, name, city by joining users and orders
SELECT u1.name,u1.city,o1.order_id FROM users u1 JOIN orders o1 ON u1.user_id = o1.user_id;
-- Q2 . Find order_id ,product category by joining order_details and category
SELECT o1.order_id, c1.vertical FROM order_details o1 JOIN category c1 ON o1.category_id=c1.category_id;
--Q3. Find all the orders placed in Pune
SELECT o1.order_id,o1.user_id,u1.name,u1.state,u1.city FROM orders o1 JOIN users u1 ON o1.user_id = u1.user_id WHERE u1.city="Pune";
-- Q4. find all the details for order where category is phones
SELECT * FROM order_details o1 JOIN category c1 ON o1.category_id = c1.category_id WHERE c1.vertical="Phones";
-- Q5. Find all the profitable orders
SELECT o1.order_id,SUM(o1.profit) AS total_profit 
FROM order_details o1 
JOIN orders o2 
ON o1.order_id = o2.order_id 
GROUP BY o1.order_id 
HAVING total_profit>0 
ORDER BY total_profit 
DESC LIMIT 100;
