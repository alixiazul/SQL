SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT 
	first_name,
	last_name,
    birth_date,
    age,
    (age + 10) * 10 + 10
FROM parks_and_recreation.employee_demographics;
# PEMDAS = Order of operations or calculations to run within MySQL: Parenthesis, Exponent, Multiplication, Division, Addition, Substraction

SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;