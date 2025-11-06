-- Active: 1740077526153@@127.0.0.1@3306@sqllearning
use sqllearning;

SELECT * FROM movies;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1. Find the movie with highest rating
SELECT * FROM movies WHERE score = (SELECT MAX(score) FROM movies);

-- Types of Subqueries

-- Based on the result it returns
--  1. Scalar Subquery -- return only one value
--  2. Row Subquery -- returns multiple rows , but single column
--  3. Table Subquery -- return multiple rows and multiple columns

-- Based on Working
--  1.Indepedent Subquery -- the inner query is indepedent of outer query
--  2.Correlated Subquery -- the inner and outer query are related

----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Subqueries can be used with
-- INSERT
-- DELETE
-- SELECT --- with --> 1.WHERE 
--                     2.SELECT 
--                     3.FROM 
--                     4.HAVING
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- iNDEPEDENT sUBQUERY
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1.Find movie with highest profit

SELECT * FROM movies 
WHERE gross-budget = (SELECT MAX(gross-budget) 
                            FROM movies);


-- 2nd approach(a little better because order by uses indexing)
SELECT * FROM movies ORDER BY (gross-budget) DESC LIMIT 1;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2.Find how many movies have a rating > the avg rating of all the movie ratings (find the count of above average movies)
SELECT COUNT(*) FROM movies WHERE score > (SELECT AVG(score) FROM movies);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q3. find the highest rated movie of 2000

SELECT * FROM movies 
WHERE year = 2000 
AND score=(SELECT MAX(score) 
           FROM movies 
           WHERE year = 2000);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q4. Find the highest rated movie among all the movies whose number of votes are > the dataset avg votes

SELECT * FROM movies
WHERE votes > (SELECT AVG(votes) FROM movies )
ORDER BY score DESC limit 1;


SELECT * FROM movies
WHERE score = (SELECT max(score) FROM movies WHERE votes > (SELECT AVG(votes) FROM movies) );

-- to get explaination on which query is better even though it gets the same answer

-- EXPLAIN
-- SELECT * FROM movies
-- WHERE votes > (SELECT AVG(votes) FROM movies)
-- ORDER BY score DESC LIMIT 1;

-- EXPLAIN
-- SELECT * FROM movies
-- WHERE score = (SELECT MAX(score) FROM movies WHERE votes > (SELECT AVG(votes) FROM movies))
-- LIMIT 1;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Indepedent subquery (row subquery)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

use zomato;
SELECT * FROM order_details;

-- Q1/ find all the users who never ordered
SELECT * FROM users WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders);

-- Q2/ find all the movies made by top 3 directors ( in terms of total gross income)
use sqllearning;

WITH top_directors AS (SELECT director FROM movies
                                            GROUP BY director
                                            ORDER BY sum(gross) DESC LIMIT 3)
SELECT * FROM movies
WHERE director IN (SELECT * FROM top_directors);

-- Q3/ Find all movies of all those actors whose filmography's avg rating > 8.5 (take 25000 votes as cutoff)

SELECT * FROM movies 
WHERE star 
IN (SELECT star FROM movies WHERE votes>25000 
    GROUP BY star
    HAVING AVG(score)>8.5); 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Indepedent Subquery - Table Subquery (Multi col Multi Row)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q1/ Find the most profitable movie of each year

SELECT * FROM movies WHERE gross-budget in(
SELECT max(gross-budget)
FROM movies
GROUP BY year);

-- Q2/ Find the highest rated movie of each genre votes cutoff of 25000

SELECT * FROM movies WHERE (genre,score)IN (SELECT genre,max(score)
                                        FROM movies
                                        WHERE votes > 25000
                                        GROUP BY genre)
AND votes > 25000;

-- Q3/ Find the highest grossing movies of top 5 actor/director combo in terms of total gross income


SELECT * FROM movies WHERE (star,director,gross) IN (SELECT star,director,MAX(gross) 
                                                        FROM movies
                                                        GROUP BY star,director
                                                        ORDER BY MAX(gross))
ORDER BY gross DESC LIMIT 5;


-- better and faster approach
WITH top_duos AS (SELECT star,director,MAX(gross) 
                FROM movies
                GROUP BY star,director
                ORDER BY MAX(gross) DESC LIMIT 5)
SELECT * FROM movies WHERE (star,director,gross) in (SELECT * FROM top_duos) ORDER BY gross DESC;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Correlated Subquery
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1/ Find all the movies that have a rating higher than the average rating of movies in the same genre

SELECT * FROM movies m1
WHERE score > (SELECT AVG(score) 
                FROM movies m2 
                WHERE m2.genre = m1.genre);
-- the inner query gets the avg score for each genre and tries to correlate it with
-- the genre of the movie we are looping through in the outer query 

-- Q2/ Find favourite food of each customer
use zomato;

-- SELECT * FROM orders;
-- SELECT * FROM order_details;
-- SELECT * FROM food;


WITH fav_food AS (SELECT o1.user_id,name,f_name,COUNT(*) as 'frequency' 
                FROM users u1
                JOIN orders o1 ON u1.user_id = o1.user_id
                JOIN order_details od1 ON od1.order_id = o1.order_id
                JOIN food f1 ON f1.f_id = od1.f_id
                GROUP BY o1.user_id,od1.f_id)
SELECT * FROM fav_food f1 
WHERE frequency = (SELECT max(frequency) 
                    FROM fav_food f2
                    WHERE f2.user_id = f1.user_id); 


