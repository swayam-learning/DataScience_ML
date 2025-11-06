-- Active: 1740077526153@@127.0.0.1@3306@sqllearning


-- ===========================
--         RANKING
-- ===========================
show tables;

SELECT * FROM ipl_ball_by_ball_2008_2022;

SELECT * FROM (SELECT batter,`BattingTeam`,SUM(batsman_run) AS 'total_runs',
                DENSE_RANK() OVER(PARTITION BY `BattingTeam` ORDER BY SUM(batsman_run) DESC) AS 'rank_within_team'
                FROM ipl_ball_by_ball_2008_2022
                GROUP BY `BattingTeam`,batter) t
WHERE t.rank_within_team<6;


-- ===========================
--      CUMMULATIVE SUM
-- ===========================

use zomato;
SELECT * FROM orders;

SELECT *,
IFNULL(amount + LAG((amount)) OVER(ORDER BY amount ASC),0)
FROM orders;


SELECT * FROM(SELECT CONCAT('Match-',ROW_NUMBER() OVER(ORDER BY ID)) AS 'match_no' ,
            SUM(batsman_run) as 'runs_scored',
            SUM(SUM(batsman_run)) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'career_Runs'
            FROM ipl_ball_by_ball_2008_2022
            WHERE batter = 'V Kohli'
            GROUP BY ID) t
WHERE match_no = "Match-50" OR match_no = "Match-100" OR match_no = "Match-200"  ;


-- ===========================
--    CUMMULATIVE AVERAGE
-- ===========================

SELECT * FROM(SELECT CONCAT('Match-',ROW_NUMBER() OVER(ORDER BY ID)) AS 'match_no' ,
            SUM(batsman_run) as 'runs_scored',
            SUM(SUM(batsman_run)) OVER w AS 'career_Runs',
            AVG(SUM(batsman_run)) OVER w AS 'career_AVG_Runs'
            FROM ipl_ball_by_ball_2008_2022
            WHERE batter = 'V Kohli'
            GROUP BY ID
            WINDOW w AS (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) t;


-- ===========================
--      RUNNING AVERAGE
-- ===========================

-- calculates average over a window

SELECT * FROM(SELECT CONCAT('Match-',ROW_NUMBER() OVER(ORDER BY ID)) AS 'match_no' ,
            SUM(batsman_run) as 'runs_scored',
            SUM(SUM(batsman_run)) OVER w AS 'career_Runs',
            AVG(SUM(batsman_run)) OVER w AS 'career_AVG_Runs',
            AVG(SUM(batsman_run)) OVER(ORDER BY ID ROWS BETWEEN 9 PRECEDING and CURRENT ROW) AS 'Rolling_avg_runs'
            FROM ipl_ball_by_ball_2008_2022
            WHERE batter = 'V Kohli'
            GROUP BY ID
            WINDOW w AS (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) t;


-- ===========================
--    PERCENT OF TOTAL
-- ===========================

USE zomato;

SELECT * FROM orders;
SELECT * FROM order_details;

SELECT t.f_id,t3.f_name,(total_value/SUM(total_value) OVER()*100) FROM(SELECT f_id,SUM(amount) AS 'total_value' FROM orders t1
            JOIN order_details t2 
            ON t1.order_id = t2.order_id
            WHERE r_id=1
            GROUP BY f_id) t
JOIN food t3
ON t3.f_id = t.f_id ;


-- ===========================
--      PERCENT CHANGE
-- ===========================
SELECT 
  view_year,
  view_month_name,
  views,
  previous_month_views,
  ROUND((views - previous_month_views) / previous_month_views * 100, 2) AS mom_growth_percent
FROM (  SELECT 
        YEAR(`date`) AS view_year,
        MONTH(`date`) AS view_month,
        MONTHNAME(`date`) AS view_month_name,
        SUM(views) AS views,
        LAG(SUM(views),1) OVER (ORDER BY YEAR(`date`), MONTH(`date`)) AS previous_month_views
        FROM youtube_views
        GROUP BY YEAR(`date`), MONTH(`date`), MONTHNAME(`date`)) AS monthly_summary
ORDER BY view_year, view_month;

