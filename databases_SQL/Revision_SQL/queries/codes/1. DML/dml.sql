-- Active: 1740077526153@@127.0.0.1@3306@sqllearning

use sqllearning;
SELECT * FROM smartphones_cleaned_v6 WHERE 1;

--------------------------------------------------------select ---------------------------------------------------------------------------------------------------------------

SELECT model,price FROM smartphones_cleaned_v6;
SELECT model,battery_capacity,os FROM smartphones_cleaned_v6;

--------------------------------------------------------------Alias-->As-------------------------------------------------------------------------------------------------------------
SELECT os AS Operating_System , battery_capacity AS MaH FROM smartphones_cleaned_v6;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Q1. Calculate PPI
SELECT model,ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height)/screen_size,2) as PPI5 FROM smartphones_cleaned_v6;

-- Q2. Tell the type of device
SELECT model,"Smartphone" AS "Type" FROM smartphones_cleaned_v6;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------Distinct----------------------------------------------------------------------------------------------------
-- Q3. Distinct Brands
SELECT DISTINCT(brand_name) as "All Brands" FROM smartphones_cleaned_v6;

-- Q4. Processor Brands
SELECT DISTINCT(processor_brand) as "All Processor Brands" FROM smartphones_cleaned_v6;

-- Q5. Distinct Combinations 
SELECT DISTINCT brand_name,processor_brand FROM smartphones_cleaned_v6;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q6. Find all the phones with price > 50000
SELECT model, price FROM smartphones_cleaned_v6 WHERE price>50000 ORDER BY price DESC;

-- Q7. Find all phones in the price range of 10000 and 20000
SELECT model,price FROM smartphones_cleaned_v6 WHERE price BETWEEN 10000 AND 20000;

-- Q8. Find Phones with rating greater than 80 and price <25000
SELECT model,price,rating FROM smartphones_cleaned_v6 WHERE rating>80 AND price<25000;

-- Q9. find all phones whose brand is samsung and ram capacity greater than 8
SELECT model,brand_name,ram_capacity FROM smartphones_cleaned_v6 WHERE brand_name="samsung" AND ram_capacity>8;

-- Q10. Find all phones with snapdragon processor
SELECT model FROM smartphones_cleaned_v6 WHERE processor_brand="snapdragon" AND brand_name="samsung";

-- Q11. Find brands who sell phones with price > 50000
SELECT DISTINCT(brand_name) FROM smartphones_cleaned_v6 WHERE price > 50000;

-- Q12. IN and NOT IN 
SELECT DISTINCT(brand_name) FROM smartphones_cleaned_v6 WHERE processor_brand IN ("exynos","snapdragon","bionic");


----------------------------------------------------------------UPDATE-----------------------------------------------------------------------------------------------------
-- Q13. Update processor_name to mediatek wherever it is dimensity
UPDATE smartphones_cleaned_v6 SET processor_brand ="Mediatek" WHERE processor_brand ="dimensity";

----------------------------------------------------------------DELETE-----------------------------------------------------------------------------------------------------
DELETE FROM smartphones_cleaned_v6 WHERE price > 200000;

DELETE FROM smartphones_cleaned_v6 WHERE primary_camera_rear > 100;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------Functions---------------------------------------------------------------------------------------------------

-- SQL Functions

-- 1. Built-In Functions
-- 2. User-Defined Functions

-- Q15. Max Function
SELECT max(price) FROM smartphones_cleaned_v6 ;

-- Q16. Min Function
SELECT min(price) FROM smartphones_cleaned_v6;

-- Q17. Select Samsung model with maximum price
SELECT model, price FROM smartphones_cleaned_v6 WHERE brand_name = "Samsung" ORDER BY price DESC LIMIT 1;

-- Q18. Find the no of oneplus phones
SELECT count(*) FROM smartphones_cleaned_v6 WHERE brand_name = "apple";

-- Q19. Find no of brands
SELECT COUNT(DISTINCT(processor_brand)) FROM smartphones_cleaned_v6;

-- Q20. Variance of Screen Size 
SELECT VARIANCE(screen_size) FROM smartphones_cleaned_v6;

-- Q21.
SELECT ROUND(AVG(battery_capacity)),ROUND(AVG(primary_camera_rear)) FROM smartphones_cleaned_v6 WHERE price >= 100000;