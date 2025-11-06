-- Active: 1740077526153@@127.0.0.1@3306@sqllearning
USE sqllearning;
select * from `movies (1)`;

-- ------------------------- Sub-Queries------------------------------------------------------------------------------
SELECT * FROM `movies (1)` 
-- outer query
WHERE score = (SELECT MAX(score) FROM `movies (1)`);
-- inner query result is acted upon the outer query

-- --------------------------------------------------------------------------------------------------------------------
-- Q1. Find the movie with highest profit (vs Order by)
SELECT * FROM `movies (1)`
 WHERE (gross - budget)=(SELECT MAX(gross-budget) FROM `movies (1)`);
 -- O(n) + O(n) = O(2n)

SELECT * FROM `movies (1)` ORDER BY (gross-budget) DESC LIMIT 1; 
-- this will be faster in larger dataset

 -- Q2. Find how many movies have a rating > the avg of all the movies ratings(Find the 
 -- count of above average movies)
SELECT * FROM `movies (1)` WHERE score > (SELECT AVG(score) FROM `movies (1)`);

-- Q3. Find the highest rated movie in 2000
SELECT * FROM `movies (1)` WHERE year=2000  AND score =(SELECT MAX(score) FROM `movies (1)` WHERE year=2000)

-- Q4. Find the highest rated movie among all movies whose number of votes are > the dataset avg votes
SELECT * FROM `movies (1)` WHERE score = (SELECT MAX(score) FROM `movies (1)` WHERE votes > (SELECT AVG(votes) FROM `movies (1)`)); 

--  ----------------------------- Row Sub Query---------------------------------------------------------------------------------------------------------
USE zomato;
SELECT * FROM users;
SELECT * FROM orders;

-- Q1. Find all the users who never ordered
SELECT * FROM users WHERE user_id NOT IN(SELECT DISTINCT(user_id) FROM orders);
-- Q2. Find all the movies made by top3 directors (in terms of total gross income)
use sqllearning;
WITH top_directors AS (SELECT director  FROM `movies (1)` GROUP BY director ORDER BY SUM(gross) DESC LIMIT 3)
SELECT * FROM `movies (1)` WHERE director IN (SELECT * FROM top_directors);
-- limit was not supported in this verison of mysql so we had to move to cte

-- Q3. Find all movies of all those actors whose filmography avg rating > 8.5(take 25000 votes as cutoff)
SELECT name,star,rating,score,votes FROM `movies (1)` 
WHERE votes>25000 
AND star IN(SELECT star FROM `movies (1)` WHERE votes > 25000 GROUP BY star HAVING AVG(score)>8.5);


-- ------------------------ Table Subquery-------------------------------------------------------------------------------

-- Q4.  Find the most profitable movies of each year
SELECT * FROM `movies (1)` WHERE (year, gross-budget) 
IN (SELECT year,MAX(gross-budget) 
    FROM `movies (1)` 
    GROUP BY year); 

-- Q5. Find the highest rated movie of each genre votes cutoff 25000
SELECT * FROM `movies (1)` 
WHERE (genre,score) 
IN (SELECT genre,MAX(score) 
    FROM `movies (1)` 
    WHERE votes > 25000
    GROUP BY genre)
AND votes > 25000;

-- Q6. Find the highest grossing movie of top 5 actor / director combo in terms of total gross income

SELECT * FROM `movies (1)`;
WITH top_actor_director_duo 
AS (SELECT star,director,MAX(gross) 
    FROM `movies (1)` 
    GROUP BY star,director
    ORDER BY SUM(gross) DESC LIMIT 5)
SELECT * FROM `movies (1)` WHERE (star,director,gross) IN (SELECT * FROM top_actor_director_duo);

-- -------------------------- Correlated subquery ------------------------------------------------------------------------------------------------------
-- the inner query is related to the outer query
-- Q7.find all the movies that have a rating higher than average rating of movies in the same genre.
SELECT * FROM `movies (1)` m1 WHERE score > (SELECT AVG(score) FROM `movies (1)` m2 WHERE m2.genre = m1.genre );

-- Q8. Find the favouriet food of each customer
USE sqllearning;
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM food;
SELECT * FROM users;


WITH fav_food AS (SELECT t2.user_id,name, f_name, COUNT(*) AS "frequency"
                    FROM users t1
                    JOIN orders t2 ON t1.user_id = t2.user_id
                    JOIN order_details t3 ON t2.order_id = t3.order_id
                    JOIN food t4 ON t3.f_id = t4.f_id
                    GROUP BY t1.name, t4.f_name, t2.user_id, t3.f_id)
SELECT * FROM fav_food f1 WHERE frequency = (SELECT max(frequency) FROM fav_food f2
                                            WHERE f1.user_id = f2.user_id);

-- ------------------------- SELECT in subquery -------------------------------------------------------------------------------
