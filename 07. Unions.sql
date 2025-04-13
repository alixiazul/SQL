-- Unions

-- Joins: where one column is next to the other
-- Unions: combine rows of data from separate tables (or even the same)
SELECT *
FROM employee_demographics
;

-- This is VERY BAD data, bcause the first name and last name are
-- added at the end, as rows instead of columns, and it can be confusing
-- You need to keep the data the same
SELECT
	age,
    gender
FROM employee_demographics
UNION
SELECT 
	first_name,
	last_name
FROM employee_salary
;


SELECT 
	first_name,
	last_name
FROM employee_demographics
;

SELECT 
	first_name,
	last_name
FROM employee_salary
;

SELECT 
	first_name,
	last_name
FROM employee_demographics
UNION
SELECT 
	first_name,
	last_name
FROM employee_salary
;

SELECT 
	first_name,
	last_name
FROM employee_demographics
UNION ALL
SELECT 
	first_name,
	last_name
FROM employee_salary
;

-- Identify people over 40 and those with high-paying salary
SELECT 
	first_name,
	last_name,
    'Old Man' AS Label
FROM employee_demographics
WHERE 
	age > 40 AND
    gender = 'male'
UNION
SELECT 
	first_name,
	last_name,
    'Old Lady' AS Label
FROM employee_demographics
WHERE 
	age > 40 AND
    gender = 'female'
UNION
SELECT 
	first_name,
	last_name,
    'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY
	first_name,
    last_name
;
