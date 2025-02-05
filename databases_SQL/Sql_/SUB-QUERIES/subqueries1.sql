-- Active: 1728126369033@@127.0.0.1@3306@sqllearning
use sqllearning;
SELECT * from `movies (1)`;
--------------------------------------------------------------------------------------------------------------------------------------
-- Name of highest rated movies 

SELECT * FROM `movies (1)` where score = (select max(score) from `movies (1)`);

--------------------------------------------------------------------------------------------------------------------------------------------
-- Count the no of movies which are above average

SELECT COUNT(*) FROM `movies (1)` WHERE score > (SELECT AVG(score) FROM `movies (1)`);

-------------------------------------------------------------------------------------------------------------------------------------------------
-- find the highest rated movies of year 2000

SELECT * FROM `movies (1)` WHERE year = 2000 AND score = (SELECT MAX(score) FROM `movies (1)` WHERE year = 2000);

---------------------------------------------------------------------------------------------------------------------------------------------------
-- find the highest rated movies among all movies whose number of votes are > the dataset avg votes

SELECT * FROM `movies (1)` WHERE votes = (SELECT MAX(votes) FROM `movies (1)` WHERE votes > (SELECT AVG(votes) FROM `movies (1)`)) ;

-----------------------------------------------------------------------------------------------------------------------------------------------

use zomato;
show tables;

SELECT * FROM delivery_partner;y