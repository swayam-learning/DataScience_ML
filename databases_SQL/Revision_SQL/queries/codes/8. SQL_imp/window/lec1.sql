-- Active: 1740077526153@@127.0.0.1@3306@campusx_revise
-- window functions
-- it returns row by row result 
-- while group by returns the no of rows same as the no of groups
SELECT * FROM marks;

-- 1st example
SELECT * , AVG(marks) OVER(PARTITION BY branch) AS branch_avg
FROM marks;

-- 2nd example

SELECT *,
AVG(marks) OVER(),
MAX(marks) OVER (),
MIN(marks) OVER ()
FROM marks
ORDER BY student_id;

-- Aggregate Function with OVER()
-- Find all the students who have marks higher than the avg marks of their respective branch

-- subquery way
WITH branch_avg_marks AS (SELECT branch, AVG(marks) as branch_marks 
                          FROM marks
                          GROUP BY branch
                        )
SELECT m.student_id,m.name,m.marks,b.branch_marks FROM marks m
JOIN branch_avg_marks b
ON m.branch = b.branch
WHERE m.marks > b.branch_marks;


-- window function way

SELECT *
FROM (SELECT *,AVG(marks) OVER (PARTITION BY branch) AS "branch_avg" FROM marks) t
WHERE t.marks>t.branch_avg;

-- Rank/Dense_Rank/Row_Number
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks),
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks)
FROM marks;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch)
FROM marks;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE zomato;
SHOW TABLES;
-- Find top 2 most paying customers of each month

-- Top N categories

SELECT * FROM orders;

SELECT * FROM(SELECT 
                MONTHNAME(date) AS month,
                user_id,
                SUM(amount) AS total_amount,
                RANK() OVER(PARTITION BY MONTHNAME(date) order BY SUM(amount) DESC) AS 'month_rank'
            FROM orders
            GROUP BY MONTH(date), MONTHNAME(date), user_id
            ORDER BY MONTH(date))t
WHERE t.month_rank<3
ORDER BY month DESC, month_rank ASC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- First_value/Last_value/Nth_value

SELECT *,
FIRST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;

-- FRAMES
-- frame in window function is a subset of rows within the partition that
-- determines the scope ot the Window function calculation. The frame is defined
-- using a combination of two Clauses in the Window function: ROWS and BETWEEN.
-- The ROWS clause specifies how many rows should be included in the frame
-- relative to the current row. For example, ROWS 3 PRECEDING means that the
-- frame includes the current row and the three rows that precede it in the partition.
-- The BETWEEN clause specifies the boundaries of the frame.
-- Examples
-- • ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW - means that the
-- frame includes all rows from the beginning of the partition up to and including the
-- current row.
-- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING: the frame includes the
-- current row and the row immediately before and after it.
-- • ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING: the
-- frame includes all rows in the partition.
-- • ROWS BETWEEN 3 PRECEDING AND 2 FOLLOWING: the frame includes the
-- current row and the three rows before it and the two rows after it.

-- SELECT *,
-- LAST_VALUE(marks) OVER(ORDER BY marks DESC)
-- FROM marks; because we did not define the frames the output is wrong

SELECT *,
LAST_VALUE(marks) OVER(ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING)
FROM marks;
-- By default it is in Unobunded preceeding and current row
SELECT *,
NTH_VALUE(marks,2) OVER(ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING)
FROM marks;
-- it gives the nth highest value

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Find the branch toppers

SELECT * FROM(SELECT *,RANK() OVER(PARTITION BY branch ORDER BY marks DESC) as 'branch_rank'
FROM marks) t
WHERE t.branch_rank=1;


with branch_highest AS (SELECT branch,MAX(marks) as 'max_marks' 
                        FROM marks
                        GROUP BY branch)
SELECT m.student_id,m.name,m.branch,m.marks FROM marks m
JOIN branch_highest b
on m.marks= b.max_marks
ORDER BY m.branch;

SELECT t.name,t.branch,t.marks FROM(SELECT *,
              FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_name',
              FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_marks'
              FROM marks) t
WHERE t.name = t.topper_name AND t.marks = t.topper_marks;

-- Find the last guy from each branhc

SELECT * FROM(SELECT *,RANK() OVER(PARTITION BY branch ORDER BY marks ASC) as 'branch_rank'
FROM marks) t
WHERE t.branch_rank=1;

SELECT t.name,t.branch,t.marks FROM(SELECT *,
              LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC  ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) AS 'LOSER_name',
              LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC  ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) AS 'LOSER_marks'
              FROM marks) t
WHERE t.name = t.LOSER_name AND t.marks = t.LOSER_marks;



SELECT t.name,t.branch,t.marks FROM(SELECT *,
              LAST_VALUE(name) OVER w AS 'LOSER_name',
              LAST_VALUE(marks) OVER w AS 'LOSER_marks'
              FROM marks
              WINDOW w as (PARTITION BY branch ORDER BY marks DESC  ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING)) t
WHERE t.name = t.LOSER_name AND t.marks = t.LOSER_marks;


-- LEAD AND LAG
SELECT *,
LAG(marks) OVER (ORDER BY student_id),
LEAD(marks) OVER (ORDER BY student_id)
FROM marks;


------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q1 show MoM revenue for zomato

use zomato;
SHOW tables;
SELECT * FROM orders;

SELECT MONTHNAME(date),SUM(amount),
COALESCE(CONCAT(ROUND((SUM(amount)-LAG(SUM(amount)) OVER(ORDER BY MONTH(DATE)))/(LAG(SUM(amount)) OVER(ORDER BY MONTH(DATE)))*100,2),'%'),'0%')
FROM orders
GROUP BY MONTHNAME(date),MONTH(date)
ORDER BY MONTH(date);
