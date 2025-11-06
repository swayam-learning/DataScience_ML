-- Active: 1740077526153@@127.0.0.1@3306@sqllearning
SELECT * FROM movies;

-- find the movie with highest rating


SELECT name
FROM movies 
where score = (SELECT MAX(score)
                FROM movies);

---------------------------------------------------------------------------------------------------------------------------------------
-- types of sub queries

-- based on output
--      1. Scalar
--      2. Row
--      3. Table

-- based on execution
--      1. Indepedent
--      2. Correlated
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Independent subquery-Scalar
-- 1. Find movie with highest profit
SELECT *
FROM movies
WHERE gross-budget = (SELECT MAX(gross-budget) 
                        FROM movies);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Find how many movies have a rating > the avg of all the movie ratings(find the count of above avg movies)

SELECT COUNT(name) 
FROM movies
WHERE score > (SELECT AVG(score) FROM movies);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Find the highest rated of all the movies having rating greater than the avg rating of the whole dataset
SELECT *
FROM movies
WHERE score = (SELECT MAX(score)
                FROM movies
                WHERE votes>(SELECT AVG(votes) 
                            FROM movies));

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Row Subquery
use zomato;

SELECT * FROM zomato.delivery_partner;

-- Find the users who never ordered
SHOW tables;
SELECT * FROM delivery_partner;
SELECT * FROM orders;

SELECT name,user_id FROM users
WHERE user_id NOT IN (SELECT u1.user_id 
FROM users u1
INNER JOIN orders o1
ON u1.user_id = o1.user_id);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM movies;
-- find all the movies made by top 3 directors (in terms of total gross income)


WITH top_director as (  SELECT director
                        FROM movies
                        GROUP BY director
                        ORDER BY SUM(gross) DESC LIMIT 3)
SELECT * FROM movies
WHERE director in(SELECT * FROM top_director);

-- Find all the movies of all those actors whose filmography avg rating > 8.5 (take 250000 votes as cutoof)

SELECT * FROM movies
WHERE star IN(SELECT star 
                FROM movies
                WHERE votes > 25000
                GROUP BY star
                HAVING AVG(score)>8.5);


-- Table subquery
-- Find the most profitable movie of each year
SELECT * FROM movies;

SELECT name ,year
FROM movies 
where gross-budget IN(SELECT MAX(gross-budget)
FROM movies
GROUP BY year);

-- find the highest rated movie of each genre votes cutoff of 25000

SELECT * FROM movies
WHERE (genre,score) IN(SELECT genre,max(score)
                        FROM movies
                        WHERE votes > 25000
                        GROUP BY genre);

-- find the highest grossing movies of top 5 actor/director combo in terms of total gross income

SELECT * FROM movies
where (star,director,gross) IN (SELECT star,director,max(gross)
                                FROM movies
                                GROUP BY star,director
                                ORDER BY MAX(gross))
ORDER BY gross DESC LIMIT 5;