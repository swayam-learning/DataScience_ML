use sqllearning;
-- usage with select
-- Q1/  Get the percentage of votes for each movie compared to the total number of votes
SELECT name,(votes/ (SELECT SUM(votes) FROM movies) )*100 AS percentage_vote 
FROM movies;

-- Q2/ Display all movie names, genre , score and avg(score) of genre
SELECT name,genre,score ,(SELECT ROUND(AVG(score),2) FROM movies m2 WHERE m2.genre = m1.genre) AS avg_score 
FROM movies m1;
