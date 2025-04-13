-- WHERE Clause

SELECT *
FROM parks_and_recreation.employee_salary
;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie'
;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000
;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary <= 50000
;


SELECT *
FROM parks_and_recreation.employee_demographics
WHERE gender = 'Female'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE gender != 'Female'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE 
	birth_date > '1985-01-01'
	AND gender = 'male'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE 
	(first_name = 'Leslie' AND age = 44)
	OR
    age > 55
;

-- LIKE Statement
-- % = it could be anything
-- _ = it needs to be an specific character, but one character mandatorily

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'Jer%'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%er%'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a%'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a__'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a___%'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '1989%'
;
