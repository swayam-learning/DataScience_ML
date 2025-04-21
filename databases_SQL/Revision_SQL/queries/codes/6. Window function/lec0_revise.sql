-- Active: 1740077526153@@127.0.0.1@3306@zomato
use campusx_revise;
show tables;

-- Group by return by the no of groups
-- Window Functions return result row by row


CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51)

-- Window Functions
SELECT *,AVG(marks)  OVER(PARTITION BY branch) FROM marks;

-- Group By
SELECT branch,AVG(marks) FROM marks GROUP BY branch;


-- Aggregate Functions in Window Functions
SELECT * ,AVG(marks) OVER(),
MIN(marks) OVER() ,
MAX(marks) OVER(),
MIN(marks) OVER(PARTITION BY branch)
FROM marks
ORDER BY student_id;

-- Q1. Find all the students who have marks higher than the avg marks of their respective branch
SELECT * FROM (SELECT *,AVG(marks)
               OVER(PARTITION BY branch) AS "branch_avg" 
               FROM marks) t 
WHERE t.marks > branch_avg;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Rank Function/Dense Rank/ Row_number

SELECT  *, RANK() 
OVER(ORDER BY marks DESC)
FROM marks; 

SELECT  *, RANK() 
OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks; 


SELECT  *, RANK() OVER(PARTITION BY branch ORDER BY marks DESC) , 
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks; 

SELECT * ,
ROW_NUMBER() OVER(PARTITION BY branch)
FROM marks;

SELECT * ,
CONCAT(branch,'-',ROW_NUMBER() OVER(PARTITION BY branch))
FROM marks;


-- Zomato
use zomato;
show tables;
-- Q1. Find top 2 most paying customers of each month

SELECT user_id,amount ,RANK() OVER(ORDER BY amount DESC) 
FROM orders WHERE user_id in (SELECT t1.user_id FROM orders t1)
LIMIT 2;


SELECT * FROM(SELECT MONTHNAME(date) as month,user_id,SUM(amount) as total,
            RANK() OVER(PARTITION BY MONTHNAME(`date`) ORDER BY SUM(amount) DESC) as month_rank
            FROM orders
            GROUP BY MONTHNAME(date),user_id
            ORDER BY MONTHNAME(date)) t 
WHERE t.`month_rank`<3
ORDER BY month DESC , month_rank ASC;

SELECT MONTHNAME(date) as month,user_id,SUM(amount) as total,
            RANK() OVER(PARTITION BY MONTHNAME(`date`) ORDER BY SUM(amount) DESC) as month_rank
            FROM orders
            GROUP BY MONTHNAME(date),user_id
            ORDER BY MONTHNAME(date);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

