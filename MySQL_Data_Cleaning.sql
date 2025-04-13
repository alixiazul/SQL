-- Data Cleaning

SELECT *
FROM layoffs;

-- 1. Remove duplicates
-- 2. Standardise the data: issues with data like spellings
-- 3. Null values or blank values. We'll try to populate that if we can.
-- 4. Remove any irrelevant columns or rows: blank columns

-- DON'T REMOVE DATA FROM THE ORIGINAL SOURCE
-- SOLUTION: Create a Staging

-- 1) Copy all the RAW data into the STAGING table
-- 1.1 Create the staging as an exact copy of the raw table (in the beginning is empty)
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

-- 1.2 Insert the data from the raw data
INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

-- 2) Identify duplicates and remove them
-- 2.1 The table doesn't have an ID to identiy duplicates. So, let's create one.
-- And partition all the information by company, industry, total_laid_off, percentage_laid_off and date
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`
) AS row_num
FROM layoffs_staging;

-- 2.2 Check if there is a row number > 1
-- For that, I'll create a CTE with the previous query so I can reference it later

WITH duplicates_cte AS 
(
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`
	) AS row_num
	FROM layoffs_staging
)
SELECT *
FROM duplicates_cte
WHERE row_num > 1;

-- Let's confirm these are duplicates
SELECT *
FROM layoffs_staging
WHERE company = "Oda"
;

-- We confirm these are NOT DUPLICATES, so, we need to do the partition over ALL the columns
WITH duplicates_cte_2 AS
(
	SELECT *,
    ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicates_cte_2
WHERE row_num > 1;

-- Confirm duplicates again --> 5 DUPLICATES
SELECT *
FROM layoffs_staging
WHERE company = "Casper"
;

-- Confirmation ok, THOSE are DUPLICATES
-- We don't want to remove both of them, just one, the duplicate
-- In MySQL we cannot REMOVE raws from a CTE, so, we need to CREATE another table, staging 2, without the duplicates.
-- It's creating a new table with the row num (row number) and only add those rows with row number = 1 from staging

CREATE TABLE `layoffs_staging_3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging_3;

-- Now we insert the data from layoffs_staging
INSERT layoffs_staging_3
	SELECT *,
    ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
    FROM layoffs_staging
;

-- Check the ones with row_num > 1
SELECT *
FROM layoffs_staging_3
WHERE row_num > 1;

-- Delete them 
DELETE
FROM layoffs_staging_3
WHERE row_num > 1;

SELECT *
FROM layoffs_staging_3
WHERE row_num > 1;

SELECT *
FROM layoffs_staging_3
;

-- SELECT 

-- Standardising data: finding issues in your data and fixing them
-- Findings:
-- 1) Spaces before company names, example: " Included Health"

SELECT company, TRIM(company)
FROM layoffs_staging_3
WHERE company LIKE ' %';

-- We have 2 companies with spaces in their names
UPDATE layoffs_staging_3
SET company = TRIM(company)
;

SELECT company, TRIM(company)
FROM layoffs_staging_3;

SELECT DISTINCT industry
FROM layoffs_staging_3
ORDER BY industry;

-- We have blank industry names
-- We have different names that are quite similar: Crypto, Crypto Currency, CryptoCurrency
-- We want all grouped together, not be different things

SELECT *
FROM layoffs_staging_3
WHERE industry LIKE 'Crypto%' 
ORDER BY company;

-- We are going to update "Crypto Currency" and "CryptoCurrency" to "Crypto" as this last value is in more than 90% of the dataset
SELECT *
FROM layoffs_staging_3
WHERE industry LIKE 'Crypto_%' 
ORDER BY company;

UPDATE layoffs_staging_3
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto_%' 
ORDER BY company;

SELECT DISTINCT industry
FROM layoffs_staging_3
ORDER BY industry;

-- Let's check location
SELECT DISTINCT(location)
FROM layoffs_staging_3
ORDER BY location;

-- I see Dusseldorf, Florianapolis, Malmo as bad written locations
-- Let's update those.
SELECT DISTINCT(location)
FROM layoffs_staging_3
WHERE location LIKE 'D__sseldorf';

UPDATE layoffs_staging_3
SET location = 'Dusseldorf'
WHERE location LIKE 'D__sseldorf';

SELECT DISTINCT(location)
FROM layoffs_staging_3
WHERE location LIKE 'Floria%';

UPDATE layoffs_staging_3
SET location = 'Florianapolis'
WHERE location LIKE 'Floria%';

SELECT DISTINCT(location)
FROM layoffs_staging_3
WHERE location LIKE 'Malm__';

UPDATE layoffs_staging_3
SET location = 'Malmo'
WHERE location LIKE 'Malm__';

SELECT DISTINCT(location)
FROM layoffs_staging_3
ORDER BY location;

-- Let's check country
SELECT DISTINCT(country)
FROM layoffs_staging_3
ORDER BY country;

-- I see "United States."
-- Let's update it
SELECT DISTINCT(country)
FROM layoffs_staging_3
WHERE country ='United States.';

SELECT DISTINCT(country), TRIM(TRAILING '.' FROM country)
FROM layoffs_staging_3
ORDER BY country
;


UPDATE layoffs_staging_3
SET country = 'United States'
WHERE country ='United States.';

SELECT DISTINCT(country)
FROM layoffs_staging_3
ORDER BY country;

-- Now, let's reformat the date column. It is text, and needs to be converted to date format
SELECT 
	`date`,
	STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging_3
;

UPDATE layoffs_staging_3
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
;

SELECT *
FROM layoffs_staging_3;

-- The date column has now the right format BUT it is STILL a TEXT format
-- Let's convert the column from TEXT to DATETIME
ALTER TABLE layoffs_staging_3
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging_3;

-- Dealing with NULLs
-- Let's check the NULLs in the column 'total_laid_off'
SELECT *
FROM layoffs_staging_3
WHERE 
	total_laid_off IS NULL
    AND percentage_laid_off IS NULL
;

-- Let's check the NULLs in the column 'industry'
SELECT *
FROM layoffs_staging_3
WHERE 
	industry IS NULL
    OR industry = ''
;

SELECT *
FROM layoffs_staging_3
WHERE company = 'Airbnb'
;

-- There are companies where we can populate their industry because some raws or records are empty or blank and some are not
SELECT t1.company, t1.industry, t2.industry
FROM layoffs_staging_3 AS t1
JOIN layoffs_staging_3 AS t2
	ON t1.company = t2.company
WHERE
	(t1.industry IS NULL OR t1.industry = '') AND
    t2.industry IS NOT NULL
;

SELECT industry
FROM layoffs_staging_3
WHERE industry = '';

UPDATE layoffs_staging_3
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging_3 AS t1
JOIN layoffs_staging_3 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE
	(t1.industry IS NULL OR t1.industry = '') AND
    t2.industry IS NOT NULL
;

SELECT *
FROM layoffs_staging_3
WHERE industry IS NULL;

SELECT *
FROM layoffs_staging_3
WHERE company LIKE 'Bally%';

-- Let's check the NULLS in total_laid_off and percentage_laid_off
SELECT *
FROM layoffs_staging_3
WHERE 
	total_laid_off IS NULL AND
    percentage_laid_off IS NULL
;

-- We assume that, if a company has NULL values in total_laid_off AND percentage_laid_off
-- then they're not worth to be in the table in terms of analysis in a later report
-- So, we'll delete them. We can't trust that data.

DELETE
FROM layoffs_staging_3
WHERE 
	total_laid_off IS NULL AND
    percentage_laid_off IS NULL
;

SELECT *
FROM layoffs_staging_3;

-- Remove now the row num column we created in the beginning
ALTER TABLE layoffs_staging_3
DROP COLUMN row_num;