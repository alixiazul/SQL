-- Stored Procedures
-- A way of save your SQL code that you can reuse over and over again
-- When you save them, you can call that stored procedure and execute the code.
-- Helpful for:
-- 1) Storing complex queries
-- 2) Simplifying repetitive code
-- 3) Enhancing performance

--  This is the query
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

-- USE parks_and_recreation <<-- This is sometimes useful 
-- Way 1 of Creating a very SIMPLE stored procedure
CREATE PROCEDURE large_salaries()
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000
	;
    
-- Calling the stored procedure
CALL large_salaries();


-- Way 2 of Creating another stored procedure
DELIMITER $$
CREATE PROCEDURE large_salaries_2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
    SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries_2();

-- Way 3 of Creating another stored procedure, with parameters
DELIMITER $$
CREATE PROCEDURE large_salaries_3(p_employee_id INT)
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = p_employee_id
    ;
END $$
DELIMITER ;

CALL large_salaries_3(1);