-- Limit & Aliasing

SELECT *
FROM parks_and_recreation.employee_demographics
LIMIT 3
;

-- The 3 oldest employees
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 3
;

-- Take the third eldest employee
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 1 -- Start at position 2, take 1 after position 2.
;

-- Aliasing

SELECT gender, AVG(age) AS avg_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40
;
