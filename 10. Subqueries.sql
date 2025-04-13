-- Subqueries: a query within another query

SELECT *
FROM employee_demographics
;

SELECT *
FROM employee_salary
;


SELECT employee_id, dept_id
FROM employee_salary
WHERE dept_id = 1
;
        
-- Select only the employees that works in the Parks department
SELECT *
FROM employee_demographics
WHERE employee_id IN
	(
		SELECT employee_id
        FROM employee_salary
        WHERE dept_id = 1
	)
;

-- All the salaries with an additional column that contains the average salary
-- This solution is not good because it's looking at the average salary
-- FOR EACH UNIQUE ROW
SELECT 
	first_name, 
    salary, 
    AVG(salary)
FROM employee_salary
GROUP BY 
	first_name, 
    salary
;

-- We want the average salary of the ENTIRE COLUMN salary
-- regardless of GROUP BY or anything else
SELECT 
	first_name, 
    salary, 
    (
		SELECT AVG(salary) AS average_salary
        FROM employee_salary
	) AS average_salary
FROM employee_salary
;

SELECT 
	gender, 
    AVG(age), 
    MAX(age), 
    MIN(age), 
    COUNT(age)
FROM employee_demographics
GROUP BY gender
;

-- Average of the OLDEST ages
-- Average of the YOUNGEST ages
-- Average count is for males and females

SELECT AVG(max_age)
FROM
(
	SELECT 
		gender, 
		AVG(age) AS average_age, 
		MAX(age) AS max_age, 
		MIN(age) AS min_age, 
		COUNT(age) AS count_age
	FROM employee_demographics
	GROUP BY gender
) AS Agg_table
;

-- Average age of the eldest female + eldest male
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;

SELECT AVG(max_age)
FROM (
	SELECT 
		gender, 
		MAX(age) AS max_age
	FROM employee_demographics
	GROUP BY gender
) AS Agg_table
;