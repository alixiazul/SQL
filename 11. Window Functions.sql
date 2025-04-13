-- Window Functions

-- Take the gender and compare it to the actual salaries
-- GROUP BY: It rolls everything up into 1 row
SELECT gender, AVG(salary) AS average_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

-- The same using WINDOW FUNCTIONS
-- Take the gender and average salary OVER everything
-- We're looking at the average salary for the ENTIRE column (not by groups)
SELECT gender, AVG(salary) OVER()
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- If you want to kind of grouping it, then you have to partition it
-- This doesn't roll everything up but it is going to perform the calculation of the
-- average salary based off of the different genders
SELECT gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- Why would we want to have the average in all rows?
-- In case we want to add more information
SELECT 
	dem.first_name, 
    dem.last_name,
    gender,
	AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- I want to know how much money all the females and all the
-- males are making 
SELECT 
	dem.first_name, 
    dem.last_name,
    gender,
	SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- Using rolling total: it starts at a specific value and add on values
-- from subsequent rows based off of the partition
-- This basically:
-- 1) Partition based on the gender
SELECT 
	dem.first_name, 
    dem.last_name,
    gender,
    salary,
	SUM(salary) 
		OVER( PARTITION BY gender 
        ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- Row number
-- RANK
-- DENSE RANK
SELECT 
	dem.employee_id,
	dem.first_name, 
    dem.last_name,
    gender,
    salary,
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,  -- Row number based off of the gender, partitioned by the gender, ranked with the highest salary first
    RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;