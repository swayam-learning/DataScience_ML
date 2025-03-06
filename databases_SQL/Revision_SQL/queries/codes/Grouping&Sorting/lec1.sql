-- Active: 1740077526153@@127.0.0.1@3306@sqllearning

USE sqllearning;

-----------------------------------------------------------------------order by----------------------------------------------------------------------

-- Q1.  top 5 samsung phone by screen size 
SELECT model,screen_size FROM smartphones_cleaned_v6 WHERE brand_name="Samsung"
ORDER BY screen_size DESC LIMIT 5 ;

-- Q2. sort on basis of ppi

SELECT model,ROUND(sqrt(resolution_width*resolution_width + resolution_height*resolution_width)) as ppi FROM smartphones_cleaned_v6 ORDER BY ppi DESC;

-- Q3. Find the phone with 2nd largst battery

SELECT model FROM smartphones_cleaned_v6 ORDER BY battery_capacity DESC limit 1,1;

-- Q4. Find the name and rating of the worst rated apple phone
SELECT model,rating FROM smartphones_cleaned_v6 WHERE brand_name = "apple" order by rating desc limit 1;

-- Q5. Sort Phones alphabetically and then on the basis of rating in desc order
SELECT * FROM smartphones_cleaned_v6 ORDER BY brand_name ASC , rating DESC;

----------------------------------------------------------------------Grouping------------------------------------------------------------------------------------------------------


-- Q6. Grouping smartphone on basis brand name and no of phones
SELECT brand_name,COUNT(*) as num_phones,ROUND(AVG(price),2) as avg_price , 
MAX(rating) as max_rating, ROUND(AVG(screen_size),2) as avg_screen_size,
ROUND(AVG(battery_capacity),2) as avg_battery_capacity
FROM smartphones_cleaned_v6 GROUP BY brand_name ORDER BY num_phones DESC LIMIT 10;

-- Q7. 