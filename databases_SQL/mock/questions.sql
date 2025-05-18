--Q1. Get top 3 most ordered dishes in each city in the last 30 days from CURRENT_DATE

SELECT * FROM cities;
SELECT * FROM orders;
SELECT * FROM dishes;


WITH dish__orders AS (SELECT o1.dish_id,o1.city_id,COUNT(*)
                        FROM orders o1
                        WHERE o1.order_date >= DATE_SUB(CURRENT_DATE , INTERVAL 30 DAY)
                        GROUP BY o1.dish_id,o1.city_id),
ranked_dishes AS(
    
)
                        
;

