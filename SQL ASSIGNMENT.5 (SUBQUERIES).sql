CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(10),
    salary INT
);

INSERT INTO Employees (emp_id, name, department_id, salary) VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

select*from employees;

CREATE TABLE Departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO Departments (department_id, department_name, location) VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');

select*from departments;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE
);

INSERT INTO Sales (sale_id, emp_id, sale_amount, sale_date) VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');

select*from sales;
##BASIC LEVEL
##ANSWER-1
SELECT name
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees

);
##ANSWER -2
SELECT name, department_id, salary
FROM Employees
WHERE department_id = (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    ORDER BY AVG(salary) desc
    limit 1
    
);

##ANSWER-3
SELECT name
FROM Employees
WHERE emp_id IN (
    SELECT emp_id
    FROM Sales
);

##ANSWER-4
SELECT name, sale_amount
FROM Employees
JOIN Sales ON Employees.emp_id = Sales.emp_id
WHERE sale_amount = (
    SELECT MAX(sale_amount)
    FROM Sales
);

##ANSWER-5
SELECT name, salary
FROM Employees
WHERE salary > (
    SELECT salary
    FROM Employees
    WHERE name = 'Shubham'
);

##INTERMEDIATE LEVEL

##ANSWER -1
SELECT name, department_id
FROM Employees
WHERE department_id = (
    SELECT department_id
    FROM Employees
    WHERE name = 'Abhishek'
);

##ANSWER -2
SELECT department_id
FROM Departments
WHERE department_id IN (
    SELECT department_id
    FROM Employees
    WHERE salary > 60000
);

##ANSWER -3
SELECT department_name
FROM Departments
WHERE department_id = (
    SELECT department_id
    FROM Employees
    WHERE emp_id = (
        SELECT emp_id
        FROM Sales
        ORDER BY sale_amount DESC
        LIMIT 1
    )
);

##ANSWER -4
SELECT name, sale_amount
FROM Employees
JOIN Sales ON Employees.emp_id = Sales.emp_id
WHERE sale_amount > (
    SELECT AVG(sale_amount)
    FROM Sales
);

##ANSWER-5
SELECT SUM(sale_amount) AS total_sales
FROM Sales
WHERE emp_id IN (
    SELECT emp_id
    FROM Employees
    WHERE salary > (
        SELECT AVG(salary)
        FROM Employees
    )
);

##ADVANCED LEVEL
##ANSWER-1
SELECT name
FROM Employees
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Sales
);

##ANSWER-2

SELECT department_name
FROM Departments
WHERE department_id IN (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

##ANSWER-3
SELECT department_name
FROM Departments
WHERE department_id IN (
    SELECT department_id
    FROM Employees
    WHERE emp_id IN (
        SELECT emp_id
        FROM Sales
        GROUP BY emp_id
        HAVING SUM(sale_amount) > 10000
    )
);

##ANSWER-4
SELECT name
FROM Employees
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    ORDER BY sale_amount DESC
    LIMIT 1 OFFSET 1
);

##ANSWER-5
SELECT name
FROM Employees
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM Sales
);


















