-- HAVING vs WHERE

SELECT 
	gender, 
    AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;

-- Next one displays error in the output.
-- AVG(age) occurs only after the GROUP BY.
-- The GROUP BY groups the rows together.
-- When we filter by using WHERE AVG(age) > 40 then it fails because
-- the AVG(age) hasn't been created yet, because the GROUP BY 
-- hasn't happened.

SELECT 
	gender, 
    AVG(age)
FROM parks_and_recreation.employee_demographics
WHERE AVG(age) > 40
GROUP BY gender
;

SELECT 
	gender, 
    AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT *
FROM parks_and_recreation.employee_salary
;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
GROUP BY occupation
;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%' -- Filtering at the row level
GROUP BY occupation
HAVING AVG(salary) > 75000 -- Filtering at the aggregate function level
;