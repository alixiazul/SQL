-- Triggers and Events

-- When a new employee is hired	they're put into the employee_salary table
-- But that info is not put in the employee_demographics table.
-- We want to add/update people automatically to the demographics table

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary -- This is the EVENT. It happens after an insertion in this table. It could also be "BEFORE".
    FOR EACH ROW -- The trigger is going to be activated for each row that is inserted --> not the most optimal way
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); -- For updates, we can use the "OLD" keyword
END $$
DELIMITER ;


-- Microsotf SQL Server has: batch triggers, table level triggers
-- Those triggers only trigger once for all 4 of them

-- Triggers CANNOT BE CHANGED

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Alicia', 'Rodriguez', 'Data Engineer at BAH', 37000, 1);


-- EVENTS <-- Scheduled automator.
-- Useful for:
-- 1) Importing data
-- 2) Pull data from a specific file path on a scheule
-- 3) Build reports that are exported to a file on a schedule
-- 4) Daily, weekly, monthly, yearly automations

-- Retire people over 60 immediately and give them life-time pay
-- Create an event that checks every month or every day and delete people from the table, which means retiring them

SELECT *
    FROM employee_demographics
    WHERE age >= 60;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;


SHOW VARIABLES LIKE 'event%';
