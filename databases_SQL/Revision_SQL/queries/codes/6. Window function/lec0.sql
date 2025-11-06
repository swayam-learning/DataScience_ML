-- Active: 1740077526153@@127.0.0.1@3306@campusx_revise
SELECT * FROM marks;

select *, AVG(marks) OVER(PARTITION BY branch)
FROM marks;


-- minnimum and maximum marks
SELECT *,MIN(marks) OVER(PARTITION BY branch) AS min_marks,
MAX(marks) OVER(PARTITION BY branch) AS max_marks FROM marks;

-- Find all the students who have higher than the avg marks of their respective branch

SELECT * FROM (SELECT *,AVG(marks) OVER(PARTITION BY branch) as avg_marks
        FROM marks) t1
WHERE t1.marks > avg_marks;

-- SELECT * FROM marks WHERE marks > (SELECT AVG(marks) OVER(PARTITION BY branch) as avg_marks
--         FROM marks); this query is wrong because window functions cannot be directly used inside a where clause

-- Rank/Dense Rank/ Row Number

SELECT *,RANK() OVER(PARTITION BY branch ORDER BY marks)
FROM marks;


-- Dense Rank
SELECT *,DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC),
RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;

-- Row Number
SELECT *, ROW_NUMBER() OVER(PARTITION BY branch)
FROM marks; 

-- Frist value / last value / nth value

-- Find the branch topper
SELECT *,FIRST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;

-- Last value

SELECT *,LAST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;
-- the frame is not set properly it is at by default ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- we need to change th frame to get the result

SELECT *,LAST_VALUE(name) 
OVER(ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;


SELECT *,LAST_VALUE(name) 
OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;

-- nth value
SELECT *,NTH_VALUE(name,3) 
OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;


SELECT name,branch,marks FROM(SELECT *, 
        FIRST_VALUE(name)
        OVER(PARTITION BY branch ORDER BY marks DESC) AS "topper_name",
        FIRST_VALUE(marks)
        OVER(PARTITION BY branch ORDER BY marks DESC) AS "topper_marks"
        FROM marks) t1
WHERE t1.name = topper_name;

SELECT name,branch,marks FROM(SELECT *, 
        LAST_VALUE(name)
        OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) AS "laster_name",
        LAST_VALUE(marks)
        OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) AS "laster_marks"
        FROM marks) t1
WHERE t1.name = laster_name;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Alternate way to write window functions

SELECT name, branch, marks
FROM (
    SELECT *,
           LAST_VALUE(name) OVER w AS laster_name,
           LAST_VALUE(marks) OVER w AS laster_marks
    FROM marks
    WINDOW w AS (
        PARTITION BY branch ORDER BY marks DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )
) t1
WHERE t1.name = laster_name;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Lead & Lag
SELECT *, LAG(marks) OVER(PARTITION BY branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM marks;

-- Find the MoM revenue growth in zomato dataset

use zomato;
SELECT * FROM orders;

-- SELECT MONTHNAME(date),SUM(amount),
-- LAG(SUM(amount)) OVER(ORDER BY MONTH(date))
-- FROM orders 
-- GROUP BY MONTHNAME(DATE)
-- ORDER BY MONTH(date) ASC; not working on my sql engine

WITH monthly_sales AS (
    SELECT 
        MONTH(date) AS month_num,
        MONTHNAME(date) AS month_name,
        SUM(amount) AS total_amount
    FROM orders
    GROUP BY MONTH(date), MONTHNAME(date)
)
SELECT 
    month_name,
    total_amount,
    CONCAT(ROUND((total_amount - LAG(total_amount) OVER (ORDER BY month_num))/LAG(total_amount) OVER (ORDER BY month_num),2)*100,"%")
     AS prev_month_amount
FROM monthly_sales
ORDER BY month_num;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
