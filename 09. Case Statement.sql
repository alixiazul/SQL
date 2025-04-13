-- Case Statements

SELECT *
FROM employee_demographics
;

-- Show employees that are less than 30 and display as young
SELECT
	first_name,
    last_name,
    age,
	CASE
		WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Old'
        WHEN age >= 50 THEN 'Very Old'
	END AS Age_Bracket
FROM employee_demographics
;


-- Pay Increase and Bonus
-- If they made < 50000 -> they get 5% bonus
-- If they made > 50000 -> they get 7% bonus
-- If they are in the Finance department -> they get 10% bonus
SELECT 
	first_name,
    last_name,
    salary,
    department_name,
    CASE
		WHEN salary < 50000 THEN salary * 1.05
        WHEN salary > 50000 THEN salary * 1.07
	END AS New_salary,
    CASE
		WHEN department_name = 'Finance' THEN salary * .1
	END AS Bonus
FROM employee_salary AS sal
JOIN parks_departments AS dep
	ON sal.dept_id = dep.department_id
;
