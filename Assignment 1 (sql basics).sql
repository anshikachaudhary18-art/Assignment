##ANSWER 1...
CREATE DATABASE COMPANY_DB;
USE COMPANY_DB;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_nemployeesame VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

##ANSWER 2...
INSERT INTO employees (employee_id, first_name, last_name, department, salary, hire_date)
VALUES
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');

SELECT*FROM EMPLOYEES;

##ANSWER 3...
SELECT *
FROM employees
ORDER BY salary ASC ;

##ANSWER 4...
SELECT*FROM employees
ORDER BY department ASC , 
 salary DESC  ;
 
 ##ANSWER 5...
 
 SELECT *
FROM employees
WHERE department = 'IT'
ORDER BY hire_date;

##ANSWER 6...
CREATE TABLE sales (
    sale_id INT,
    customer_name VARCHAR(50),
    amount INT,
    sale_date DATE
);

INSERT INTO sales (sale_id, customer_name, amount, sale_date)
VALUES
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');
SELECT*FROM SALES;

##ANSWER 7...
SELECT *FROM sales
ORDER BY amount DESC;

##ANSWER 8...
SELECT *
FROM sales
WHERE customer_name = 'Aditi';

##ANSWER 9...
##Primary Key:A primary key is a column (or set of columns) that uniquely identifies each row in a table.

##Key points:
#It must be unique,It cannot be NULL,Each table can have only one primary key
#Example: employee_id in the employees table,
##Foreign Key:A foreign key is a column that creates a link between two tables.It refers to the primary key of another table.
#Key points:
#It is used to maintain relationships between tables
#It can have duplicate values,It can contain NULL (unless restricted)
#Ensures referential integrity (data consistency)

##ANSWER 10...
#Constraints are rules applied to table columns in SQL to control what type of data can be stored in a table.
#They help maintain accuracy, reliability, and consistency of the data in a database.

# Why Constraints Are Used:
#Prevent invalid data from being inserted
#Ensure data accuracy
#Maintain relationships between tables
#Protect data integrity
#Avoid duplication or errors








