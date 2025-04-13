-- Group By and Order By

SELECT *
FROM parks_and_recreation.employee_demographics
;

SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;

SELECT 
	gender, 
    AVG(age), 
    MAX(age),
    MIN(age),
    COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;

SELECT occupation
FROM parks_and_recreation.employee_salary
GROUP BY occupation
;

SELECT occupation, salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary
; -- Office Manage appears twice

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name DESC
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 
	gender,
    age
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 
	gender, 
	age DESC
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 
	age, 
	gender
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 
	5, 
	4
;