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
SELECT model,ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height)/screen_size,2) as PPI FROM smartphones_cleaned_v6;

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

-- Q11. 