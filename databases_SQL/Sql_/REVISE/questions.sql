-- Active: 1728126369033@@127.0.0.1@3306@sqllearning
USE sqllearning;
SELECT * FROM ipl_ball_by_ball_2008_2022;
-- Q1. top 5 batsman in ipl
SELECT batter, sum(batsman_run) as total_runs_scored FROM ipl_ball_by_ball_2008_2022 GROUP BY batter ORDER BY total_runs_scored DESC LIMIT 5;
-- Q2. Find the second highest 6 hitter in ipl
SELECT  batter,COUNT(batsman_run) as num_sixes FROM ipl_ball_by_ball_2008_2022 WHERE batsman_run=6 GROUP BY batter ORDER BY num_sixes DESC LIMIT 1,1;
-- Q3. Find Virat Kohli perfomance against all ipl teams
SELECT batter,SUM(batsman_run) FROM ipl_ball_by_ball_2008_2022 WHERE batter="V Kohli";

