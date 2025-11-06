-- Active: 1728126369033@@127.0.0.1@3306@sqllearning

-- ------------------------------- Sorting Data --ORDER BY ----------------------------------------------------------------------------------------------------------------------
USE sqllearning;
SELECT * FROM smartphones_cleaned_v6;
SELECT model,screen_size FROM smartphones_cleaned_v6 WHERE brand_name="samsung" ORDER BY screen_size DESC LIMIT 5;
SELECT model,(num_rear_cameras+num_front_cameras) AS total_camera FROM smartphones_cleaned_v6 ORDER BY total_camera DESC LIMIT 5;
SELECT model,ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size) as "ppi" FROM smartphones_cleaned_v6 ORDER BY ppi DESC LIMIT 5; 
SELECT model,battery_capacity FROM smartphones_cleaned_v6 ORDER BY battery_capacity DESC LIMIT 2,10;
-- limit x,y the x is the offset which tells how many rows to skip and y tells how many rows to return after x skipped
SELECT model,rating FROM smartphones_cleaned_v6 WHERE brand_name="apple" ORDER BY rating ASC LIMIT 1;
SELECT model,price FROM smartphones_cleaned_v6 ORDER BY brand_name ASC , price asc;
SELECT model,price,rating FROM smartphones_cleaned_v6 ORDER BY brand_name ASC , rating DESC;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FROM --> JOIN --> WHERE --> GROUP BY --> HAVING --> SELECT --> DISTINCT --> ORDER BY
-- ------------------------------- GROUP BY ----------------------------------------------------------------------------------------------------------------------------------------
SELECT brand_name,COUNT(*) AS no_of_phones,ROUND(AVG(price)) AS avg_price,
MAX(rating) AS max_rating,
ROUND(AVG(screen_size),2) AS avg_screen_size,
ROUND(AVG(battery_capacity)) AS avg_bttry_capacity  FROM smartphones_cleaned_v6 GROUP BY brand_name ORDER BY no_of_phones DESC LIMIT 50;
UPDATE smartphones_cleaned_v6 SET has_nfc="yes" WHERE has_nfc="True" ;
UPDATE smartphones_cleaned_v6 SET has_nfc="no" WHERE has_nfc="False";
SELECT has_nfc,AVG(price) AS 'avg price' , AVG(rating) as 'avg rating' FROM smartphones_cleaned_v6 GROUP BY has_nfc;
SELECT fast_charging_available,AVG(price) AS 'avg price' , AVG(rating) as 'avg rating' FROM smartphones_cleaned_v6 GROUP BY fast_charging_available;
SELECT brand_name,processor_brand,COUNT(model) AS 'total models' ,AVG(primary_camera_front) AS 'primary_front_camera' FROM smartphones_cleaned_v6 GROUP BY brand_name,processor_brand;
SELECT brand_name,ROUND(AVG(price)) as avg_price FROM smartphones_cleaned_v6 GROUP BY brand_name,price ORDER BY avg_price DESC limit 5;
SELECT brand_name,AVG(screen_size) AS "screen_size_avg" FROM smartphones_cleaned_v6  GROUP BY brand_name HAVING COUNT(model)>5 ORDER BY screen_size_avg ASC LIMIT 1,1; 
SELECT has_5g,AVG(price) FROM smartphones_cleaned_v6 GROUP BY has_5g;
SELECT brand_name,COUNT(model) AS count FROM smartphones_cleaned_v6 WHERE has_ir_blaster="True" AND has_nfc="yes" GROUP BY brand_name ORDER BY count DESC LIMIT 1;
SELECT has_nfc,AVG(price) AS "avg price" FROM smartphones_cleaned_v6 WHERE brand_name="samsung" AND has_5g="True" GROUP BY has_nfc;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------- HAVING -----------------------------------------------------------------------------------------------------------------------------------------------
SELECT brand_name,AVG(rating) FROM smartphones_cleaned_v6 GROUP BY brand_name HAVING COUNT(model)>20;
SELECT brand_name,AVG(ram_capacity) as avg_ram_capacity FROM smartphones_cleaned_v6 
WHERE refresh_rate > 90 AND fast_charging_available=1 
GROUP BY brand_name  HAVING COUNT(*) > 10
ORDER BY avg_ram_capacity DESC LIMIT 3;

SELECT brand_name,AVG(price) as avg_price FROM smartphones_cleaned_v6 WHERE has_5g="True" GROUP BY brand_name HAVING AVG(rating)>70 AND count(*)>10;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 