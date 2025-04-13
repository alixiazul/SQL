-- String Functions

SELECT LENGTH('skyfall')
;

SELECT *
FROM employee_demographics
;

-- How long is each person's name
SELECT 
	first_name, 
    LENGTH(first_name)
FROM employee_demographics
ORDER BY LENGTH(first_name)
;

SELECT upper('sky')
;

SELECT lower('SKY')
;

SELECT 
	first_name, 
    UPPER(first_name)
FROM employee_demographics
ORDER BY UPPER(first_name)
;

-- Show sky with all its whitespaces
SELECT ('             sky  ');

-- Show sky without whitespaces, not to the left, not the right
SELECT TRIM('             sky  ');

-- Show sky without the left spaces
SELECT LTRIM('             sky  ');

-- Show sky without the right spaces
SELECT RTRIM('             sky  ');

-- Show only the first 4 letters of the name of the employees
SELECT 
	first_name, 
    LEFT(first_name, 4)
FROM employee_demographics
;

-- Show also the last 4 letters of the name of the employees
SELECT 
	first_name, 
    LEFT(first_name, 4),
    RIGHT(first_name, 4)
FROM employee_demographics
;

-- Show also the month they were born
SELECT 
	first_name, 
    LEFT(first_name, 4),
    RIGHT(first_name, 4),
    SUBSTRING(first_name, 3, 2),
    birth_date,
    SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics
;

SELECT 
	first_name,
    REPLACE(first_name, 'a', 'c')
FROM employee_demographics
;

SELECT 
	LOCATE('c', 'Alicia')
;

SELECT 
	first_name,
    LOCATE('An', first_name)
FROM employee_demographics
;

SELECT 
	first_name,
    last_name,
    CONCAT(first_name, ' ' , last_name) AS full_name
FROM employee_demographics
;