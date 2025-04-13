-- Temporary tables
-- Tables created and only visible to the session that they're created in 
-- If you exit MySQL and come back again, the temporary tables won't be there

-- As a data analyst, temporary tables are useful for storing intermediate results for complex queries,
-- somewhat like a CTE, but also for using it to manipulate data before you insert it into a permanent table

-- The temporary table just exist insider our memory, it is not created in the database.
-- You can insert data into them. They can be reused over and over again.

-- 2 ways of creating a temporary table

-- Way 1:
CREATE TEMPORARY TABLE temp_table
(
	first_name VARCHAR(50),
    last_name VARCHAR(50),
    favourite_movie VARCHAR(100)
);

INSERT INTO temp_table
VALUES ('Alicia','Rodriguez','The flight of the navigator');

SELECT *
FROM temp_table;


-- Way 2:
CREATE TEMPORARY TABLE salary_over_50K
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

SELECT *
FROM salary_over_50K;