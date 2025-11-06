USE sqllearning;
SELECT * FROM smartphones_cleaned_v6;

SELECT model,battery_capacity,os FROM smartphones_cleaned_v6;

-- ----------------------------------------- Alias ------------------------------------------------------------------------------------------
SELECT os AS "Operating System" ,model,battery_capacity AS mAH FROM smartphones_cleaned_v6;
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------- Mathematical Function ---------------------------------------------------------------------------------
SELECT model , SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size as "ppi" FROM smartphones_cleaned_v6;
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------Constants ----------------------------------------------------------------------------------------------

SELECT model,"smartphone" AS "type" FROM smartphones_cleaned_v6;
-- ---------------------------------- Distinct -----------------------------------------------------------------------------------------------
SELECT DISTINCT (brand_name) AS "all_brands" FROM  smartphones_cleaned_v6;

SELECT DISTINCT (processor_brand) AS "processor_name" FROM smartphones_cleaned_v6;
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------Distinct combinations + Where -----------------------------------------------------------------------------
SELECT DISTINCT brand_name,processor_brand from smartphones_cleaned_v6 WHERE brand_name="samsung";
-- --------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM smartphones_cleaned_v6 WHERE brand_name="samsung";

SELECT * FROM smartphones_cleaned_v6 WHERE price > 60000 AND brand_name="samsung" ;
-- ---------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------Between-------------------------------------------------------------------------------------------------
SELECT model FROM smartphones_cleaned_v6 WHERE price BETWEEN 10000 AND 20000;
SELECT model ,rating FROM smartphones_cleaned_v6 WHERE rating BETWEEN 81 AND 24999;
SELECT model , ram_capacity FROM smartphones_cleaned_v6 WHERE ram_capacity > 8;
SELECT model ,price, processor_brand FROM smartphones_cleaned_v6 WHERE price BETWEEN 80 AND 25000 AND processor_brand ="snapdragon";

-- ------------------------------Query Execution Order -----------------------------------------------------------------------------------------

-- FROM --> JOIN --> WHERE --> GROUP BY --> HAVING --> SELECT --> DISTINCT --> ORDER BY

-- ---------------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT(brand_name) FROM smartphones_cleaned_v6 WHERE price >50000;

-- --------------------------------IN and NOT IN -----------------------------------------------------------------------------------------------
SELECT * FROM smartphones_cleaned_v6 WHERE processor_brand IN ('snapdragon','exynos','bionic');
SELECT * FROM smartphones_cleaned_v6 WHERE processor_brand NOT IN ('snapdragon','exynos','bionic');
-- ----------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------UPDATE----------------------------------------------------------------------------------------------------------------
UPDATE smartphones_cleaned_v6 SET processor_brand="dimensity" WHERE processor_brand="mediatek";
-- -------------------------- DELETE ------------------------------------------------------------------------------------------------------------
DELETE FROM smartphones_cleaned_v6 WHERE primary_camera_rear > 150;
-- ----------------------------------------------------------------------------------------------------------------------------------------------
/* UPDATE AND DELETE ARE PERMANENT OPERATIONS*/
-- ----------------------------------------BUILT IN-FUNCTIONS -----------------------------------------------------------------------------------
-- SCALAR FUNCTIONS
-- AGGREGATE FUNCTIONS
-- ----------------------------------------AGGREGATE FUNCTIONS-----------------------------------------------------------------------------------
SELECT MAX(price) FROM smartphones_cleaned_v6 WHERE brand_name = 'samsung';
SELECT * FROM smartphones_cleaned_v6 WHERE price = 110999;
SELECT AVG(rating) FROM smartphones_cleaned_v6 WHERE brand_name='samsung';
SELECT COUNT(*) FROM smartphones_cleaned_v6 WHERE brand_name="samsung";
SELECT COUNT(DISTINCT(brand_name)) FROM smartphones_cleaned_v6;
SELECT STD(screen_size) FROM smartphones_cleaned_v6;
SELECT VARIANCE(screen_size) FROM smartphones_cleaned_v6;
-- -------------------------------------SCALAR FUNCTIONS-----------------------------------------------------------------------------------------
SELECT ABS(price - 100000) FROM smartphones_cleaned_v6;
SELECT ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size) as round_ppi FROM smartphones_cleaned_v6;
SELECT CEIL(rating) AS ceil_rating FROM smartphones_cleaned_v6;
SELECT FLOOR(rating) AS floor_rating FROM smartphones_cleaned_v6;
-- ---------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM smartphones_cleaned_v6;