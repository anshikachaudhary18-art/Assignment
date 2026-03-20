##Table 1 CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Robert White', 'Houston'),
(5, 'Nancy Miller', 'Miami');
select*from customers;

##Table 2 ORDERS
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount INT
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 6, '2024-10-10', 450),   
(105, 3, '2024-10-12', 400);
SELECT*FROM ORDERS;

##Table 3 PAYMENTS
CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    CustomerID INT,
    PaymentDate DATE,
    Amount INT
);

INSERT INTO Payments (PaymentID, CustomerID, PaymentDate, Amount) VALUES
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);
select*from payments;

##Table 4 EMPLOYEE
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeName VARCHAR(50),
    ManagerID INT
);

INSERT INTO Employee (EmployeeID, EmployeName, ManagerID) VALUES
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'Eva Smith', 2),
(5, 'David Kim', 2);
select*from employee;

##ANSWER 1..
SELECT DISTINCT c.*
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID;
    
##ANSWER 2..    
SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID;
    
##ANSWER 3..    
SELECT o.OrderID, o.CustomerID, o.OrderDate, o.Amount,
       c.CustomerName, c.City
FROM Customers c
RIGHT JOIN Orders o
    ON c.CustomerID = o.CustomerID;
    
##ANSWER 4..    
SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID

UNION

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM Customers c
RIGHT JOIN Orders o
    ON c.CustomerID = o.CustomerID;
    
##ANSWER 5..  
SELECT c.CustomerID, c.CustomerName, c.City
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

##ANSWER 6..
SELECT DISTINCT p.CustomerID, c.CustomerName, c.City
FROM Payments p
LEFT JOIN Orders o
    ON p.CustomerID = o.CustomerID
JOIN Customers c
    ON p.CustomerID = c.CustomerID
WHERE o.CustomerID IS NULL;

##ANSWER 7..
SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM Customers c
CROSS JOIN Orders o;

##ANSWER 8..
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City,
    o.Amount AS OrderAmount,
    p.Amount AS PaymentAmount
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
    ON c.CustomerID = p.CustomerID;
    
##ANSWER 9... 
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN Payments p
    ON c.CustomerID = p.CustomerID;
   



  



    






