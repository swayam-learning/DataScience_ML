-- Active: 1740077526153@@127.0.0.1@3306@zomato
show tables;
SELECT * FROM ipl_ball_by_ball_2008_2022;

-- Ranking

-- Top 5 players on basis of scores in each team

SELECT * FROM(SELECT `BattingTeam`,batter,SUM(batsman_run) as total_run,
DENSE_RANK() OVER(PARTITION BY `BattingTeam` ORDER BY SUM(batsman_run) DESC)
AS Rank_within_team
FROM ipl_ball_by_ball_2008_2022
GROUP BY `BattingTeam` , batter) t1
WHERE t1.Rank_within_team <6
ORDER BY t1.BattingTeam,t1.rank_within_team;

-- Cummulative sum
-- Virat Kohli scored how much in 50th ,100th and 200th match

SELECT * FROM(SELECT ROW_NUMBER() OVER(ORDER BY `ID`) as `match_number`,
SUM(batsman_run) as "runs_scored",
SUM(SUM(batsman_run)) OVER(ORDER BY `ID`) as `CareerRuns(Cummulative sum)`
FROM ipl_ball_by_ball_2008_2022
WHERE batter = "V Kohli"
GROUP BY `ID`) t1
WHERE t1.`match_number` = 50 
or t1.`match_number`=100
or t1.`match_number`=200;


-- Cummulative average


SELECT * FROM(SELECT ROW_NUMBER() OVER w as `match_number`,
SUM(batsman_run) as `runs_scored`,
AVG(SUM(batsman_run)) OVER w as `cumulative average`
FROM ipl_ball_by_ball_2008_2022
WHERE batter = "V Kohli"
GROUP BY `ID`
WINDOW w as (ORDER BY `ID`)) t1
WHERE t1.`match_number` = 50 
or t1.`match_number`=100
or t1.`match_number`=200;

-- Running average

-- Running average (also known as moving average) is a statistical technique that calculates
-- the average value of a dataset over a moving window o consecutive data points.
-- The window size determines the number of data points used to calculate the average, and
-- the window moves forward in time, the average is recalculated using the new data points
-- and dropping the oldest one. This means that the running average is continuously updated
-- and reflects the most recent trends in the data.
-- For example. a running average of a batsman's runs scored over a window of 10 matches
-- will calculate the average runs scored in the last 10 matches, then move the window one
-- match forward and recalculate the average for the new set of IO matches, and so on.
-- Running averages are Often used in finance, economics, and engineering to smooth out
-- noisy or volatile data series, and to identify trends or patterns that may be obscured by
-- I random fluctuations in the data.

-- 10 rows
SELECT * FROM(SELECT ROW_NUMBER() OVER w as `match_number`,
SUM(batsman_run) as `runs_scored`,
AVG(SUM(batsman_run)) OVER w as `cumulative average`,
AVG(SUM(batsman_run)) OVER(ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) as `rolling average`
FROM ipl_ball_by_ball_2008_2022
WHERE batter = "V Kohli"
GROUP BY `ID`
WINDOW w as (ORDER BY `ID`)) t1;
-- WHERE t1.`match_number` = 50 
-- or t1.`match_number`=100
-- or t1.`match_number`=200;


-- percent of total
select f_name,(`total value`/SUM(`total value`) OVER())*100 as `percent of total`
FROM (SELECT f_id,SUM(amount) AS `total value` FROM orders t1
JOIN order_details t2
ON t1.order_id =  t2.order_id
WHERE r_id = 1
GROUP BY f_id) t
JOIN food t3
ON t.f_id = t3.f_id;