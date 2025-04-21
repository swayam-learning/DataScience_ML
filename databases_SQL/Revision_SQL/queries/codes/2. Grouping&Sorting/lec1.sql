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

-- Q7. group by smartphone by whether they have an nfc and get the average price and rating

SELECT has_nfc,ROUND(AVG(price),2) as avg_price, ROUND(AVG(rating),2) as avg_rating 
FROM smartphones_cleaned_v6 
GROUP BY has_nfc;

--  Q8. group smartphones by the brand and processor brand and get the count of models and the avergae primary camera resolution (rear)
SELECT brand_name,processor_brand,count(model) as num_phones,avg(primary_camera_rear) as avg_rear_camera 
FROM smartphones_cleaned_v6 
GROUP BY brand_name , processor_brand 
ORDER BY num_phones desc;

-- Q9. Top 5 costliest phone brands

SELECT brand_name, ROUND(AVG(price),2) as avg_price FROM smartphones_cleaned_v6 GROUP BY brand_name 
ORDER BY avg_price DESC LIMIT 5;

-- Q10. Group by smartphones by the brand and find the brand with the highest number of models that have both nfc and an ir blaster
SELECT brand_name,count(*) as num_of_phones FROM smartphones_cleaned_v6 
WHERE has_ir_blaster="True" and has_nfc="True" 
GROUP BY brand_name
ORDER BY num_of_phones DESC;

-- Q11.Find all samsung 5g enabled smartphones and find out the average price for nfc and non-nfc phones
SELECT AVG(price) as avg_price ,has_nfc FROM smartphones_cleaned_v6 WHERE brand_name="samsung" AND has_5g="True" GROUP BY has_nfc;

--------------------------------------------------------------HAVING------------------------------------------------------------------------------------------------------------

-- Q12. find the avg rating of smartphones which have more than 20 phones
SELECT brand_name,count(*) as num ,AVG(rating) as "avg rating" FROM smartphones_cleaned_v6 GROUP BY brand_name HAVING num>20 ORDER BY "avg rating"; 

-- Q13. Find top 3 brands with the highes avg ram that have a refresh rate if at least 90 hz 
-- and fast charging available and dont consider brands which have less than 10 phones
SELECT brand_name, ROUND(AVG(ram_capacity),2) as avg_ram FROM smartphones_cleaned_v6 
WHERE refresh_rate >=90 AND fast_charging_available=1 
GROUP BY brand_name having count(*) > 10 ORDER BY avg_ram DESC limit 3;

-- Q14.Find the phone brands with average rating > 70 and num_phones more than 1O among 5g enabled phones
SELECT brand_name, AVG(price) FROM smartphones_cleaned_v6 
WHERE has_5g="True"
GROUP BY brand_name
HAVING count(*) > 10 AND AVG(rating) > 70;