-- CTEs: Common Table Expression
-- They allow you to define a subquery block that you can then reference within the main query
-- REASON 1 to use CTEs: perform more advanced calculations, something you can't do easily or at all within just one query
-- REASON 2: readability

WITH CTE_Example AS
(	
SELECT 
	gender,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
	MIN(salary) AS min_salary,
	COUNT(salary) AS count_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) -- YOU HAVE TO USE IT RIGHT BELOW. IT'S NOT STORED ANYWHERE.
-- Average salary between both males and females
SELECT AVG(avg_salary)
FROM CTE_Example
;

-- Same query but with subqueries. We'll see the readability is not the same
SELECT AVG(avg_salary)
FROM 
(	
SELECT 
	gender,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
	MIN(salary) AS min_salary,
	COUNT(salary) AS count_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) AS Example_subquery
;

-- Creation of multiple CTEs within one CTE --> to do a more complex query or joining more complex queries together
WITH CTE_Example AS
(	
	SELECT 
		employee_id,
		gender,
		birth_date
	FROM employee_demographics
	WHERE birth_date > '1985-01-01'
),
CTE_Example_2 AS
(
	SELECT 
		employee_id,
        salary
    FROM employee_salary
    WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example_2
	ON CTE_Example.employee_id = CTE_Example_2.employee_id
;

-- Redefinition of the columns, overriding the ones inside the query. It looks more like a normal table.
WITH CTE_Example (Gender, AVG_salary, MAX_salary, MIN_salary, COUNT_salary) AS
(	
SELECT 
	gender,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
	MIN(salary) AS min_salary,
	COUNT(salary) AS count_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) -- YOU HAVE TO USE IT RIGHT BELOW. IT'S NOT STORED ANYWHERE.
-- Average salary between both males and females
SELECT *
FROM CTE_Example
;