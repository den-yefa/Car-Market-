-- Data cleaning 
/* CREATE A DUPLICATE TABLE */

INSERT Car_sales
SELECT* FROM `car sales.xlsx - car_data`;
SELECT*
FROM `car sales.xlsx - car_data`;
CREATE TABLE 
Car_sales
LIKE `car sales.xlsx - car_data`;

INSERT Car_sales
SELECT* FROM `car sales.xlsx - car_data`;

-- checking /removing duplicates--
SELECT Car_id,COUNT(*) AS duplicate_count
FROM Car_sales 
GROUP BY Car_id
HAVING COUNT(*)>1;

SELECT `Customer Name`,COUNT(*) AS duplicate_count
FROM Car_sales 
GROUP BY `Customer Name`
HAVING COUNT(*)>1;

CREATE TABLE `car_sale` (
  `Car_id` text,
  `Date` text,
  `Customer Name` text,
  `Gender` text,
  `Annual Income` int DEFAULT NULL,
  `Dealer_Name` text,
  `Company` text,
  `Model` text,
  `Engine` text,
  `Transmission` text,
  `Color` text,
  `Price ($)` int DEFAULT NULL,
  `Dealer_No` text,
  `Body Style` text,
  `Phone` int DEFAULT NULL,
  `Dealer_Region` text,
  `Row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select * 
from car_sale;

INSERT INTO car_sale
SELECT*,
ROW_NUMBER() OVER
(PARTITION BY Car_id,`Date`,`Customer Name`,Gender,`Annual Income`,Dealer_Name,Company,Model,`Engine`,Transmission,Color,
`Price ($)`,Dealer_No,`Body Style`,Phone,Dealer_Region) AS Row_num
FROM car_sales;

SELECT*
FROM  car_sale
where Row_num > 1;

SELECT*
FROM car_sale;

-- standardizing the data--
SELECT DISTINCT Gender
FROM car_sale
ORDER BY 1;
SELECT DISTINCT Dealer_Name
FROM car_sale
ORDER BY 1;
SELECT DISTINCT Company
FROM car_sale
ORDER BY 1;
SELECT DISTINCT Model
FROM car_sale
ORDER BY 1;
SELECT DISTINCT Transmission
FROM car_sale
ORDER BY 1;
SELECT DISTINCT Color
FROM car_sale
ORDER BY 1;
SELECT DISTINCT `Body Style`
FROM car_sale
ORDER BY 1;

-- changing data type( changing text to date)
SELECT `Date`,
STR_TO_DATE(`Date`, '%m/%d/%Y')
FROM car_sale;

UPDATE car_sale
SET `Date`= STR_TO_DATE(`Date`, '%m/%d/%Y');

ALTER TABLE car_sale
MODIFY COLUMN `Date` date;

-- checking for null values --
SELECT*
FROM car_sale
WHERE `Price ($)` IS NULL
AND `Customer Name`IS NULL;

SELECT*
FROM car_sale
WHERE Car_id ='';

-- Row count check--
SELECT COUNT(*) AS num_of_rows
FROM car_sale;
-- Column count check--
SELECT COUNT(*) AS column_count
FROM Information_schema.columns 
WHERE TABLE_NAME = 'car_sale';

-- Remove columns that are irrelevant for analysis--
ALTER TABLE car_sale
DROP COLUMN Phone,
DROP COLUMN Dealer_No,
DROP COLUMN Row_num;

ALTER TABLE car_sale
DROP COLUMN Car_id;

select*
from car_sale;

-- EXPLORATORY DATA ANALYSIS -- 
SELECT MAX(`Price ($)`)
FROM car_sale;
 SELECT AVG(`Price ($)`)
 FROM car_sale;
 
 SELECT AVG(`Annual Income`)
 FROM car_sale;
 
 SELECT COUNT(*)
 FROM car_sale
 WHERE Color= 'Black';
  SELECT COUNT(*)
 FROM car_sale
 WHERE Color= 'Red';
 
  SELECT COUNT(*)
 FROM car_sale
 WHERE Color= 'Pale White';
 
 SELECT Company, SUM(`Price ($)`)
 FROM car_sale
 GROUP BY Company
 ORDER BY 2  DESC;
 
SELECT 
Gender,
SUM(`Price ($)`)
FROM car_sale
GROUP BY Gender
ORDER BY 2 DESC;
 
 SELECT 
 Dealer_Region, SUM(`Price ($)`)
 FROM car_sale
 GROUP BY Dealer_Region;
 
  SELECT 
Dealer_Name, SUM(`Price ($)`)
 FROM car_sale
 GROUP BY Dealer_Name;
 
 -- create view-- 
 CREATE VIEW Car_data AS
 SELECT 
`Date`,
`Customer Name`,
Gender,
`Annual Income`,
Dealer_Name,
Company,
Model,
`Engine`,
Transmission,
Color,
`Price ($)`,
`Body Style`, 
Dealer_Region
FROM car_sale;

