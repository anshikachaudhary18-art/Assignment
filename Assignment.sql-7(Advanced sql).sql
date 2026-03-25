/*ANSWER-1
A CTE (Common Table Expression) is a temporary, named result set that you define using the WITH keyword.
It exists only for the duration of the query that follows it.

Example structure:
sql
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;

 **How a CTE improves SQL readability
A CTE improves readability and maintainability in several ways:

1. Makes complex queries easier to understand
Instead of writing long nested subqueries, you break the logic into clear, named blocks.

2. Allows reusing the same result set
You can reference the CTE multiple times in the main query, avoiding duplication.

3. Improves logical flow
The query reads top‑to‑bottom like steps in a process, making it easier to follow.

4. Helps with recursive queries
CTEs support recursion, which is useful for hierarchical data (e.g., org charts, category trees).

ANSWER-2
Some views are updatable because they are based on a single table without aggregates, joins,
 or grouping,allowing SQL to map each row in the view to a specific row in the base table.
 Views that include joins, GROUP BY, aggregates, or DISTINCT become read‑only because 
 SQL cannot determine how updates should be applied to the underlying tables.
 EXAMPLE:-
 -->>UPDATEABLE=-
 CREATE VIEW vw_Simple AS
SELECT ProductID, ProductName, Price
FROM Products;
-->>READ ONLY
CREATE VIEW vw_Summary AS
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

ANSWER-3
Stored procedures offer several important benefits over writing the same SQL queries repeatedly.
1. Reusability
A stored procedure is saved in the database and can be executed anytime without rewriting the SQL.
This avoids duplication and saves time.
 2. Better Performance
Stored procedures are precompiled and optimized by the database engine.
This means they run faster than raw SQL typed each time.
You can:
.Restrict direct table access
.Grant users permission to execute the procedure only
.Prevent exposure of underlying table structure
.This protects sensitive data.
4. Easier Maintenance
If logic needs to change, you update the procedure once, and all applications using it automatically get the updated logic.
5. Reduced Errors
Since the logic is stored centrally, you avoid mistakes that happen when writing the same SQL repeatedly.3. Improved Security

ANSWER-4
A trigger is a special type of stored program that automatically executes in response to specific events on a table, such as:
.INSERT
.UPDATE
.DELETE
Triggers help enforce rules, maintain data integrity, automate tasks, and ensure consistency without requiring manual execution.

⭐ One essential use case
Use Case: Automatically creating an audit log when a row is deleted
When a record is deleted from a table, you may want to keep a history of what was removed.
A DELETE trigger can automatically insert the deleted row into an archive or audit table.
Example scenario:
Table: Products
Archive table: ProductArchive
Trigger: AFTER DELETE → store deleted product details + timestamp
This ensures no deleted data is lost, which is essential for auditing, compliance, and recovery.

ANSWER-5
Data modelling is needed to design a clear, logical structure for the database by defining tables, relationships, and constraints.
 Normalization is needed to reduce redundancy, prevent anomalies, and maintain data integrity. 
 Together, they ensure the database is efficient, consistent, scalable, and easy to maintain.
 
 ANSWER-6 TO 9*/
 
 CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');

##ANSWER-6
 WITH RevenueCTE AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        p.Price,
        s.Quantity,
        (p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s 
        ON p.ProductID = s.ProductID
)
SELECT *
FROM RevenueCTE
WHERE Revenue > 3000;

##ANSWER-7
CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

##ANSWER-8
CREATE VIEW vw_ProductBasic AS
SELECT 
    ProductID,
    ProductName,
    Price
FROM Products;

UPDATE vw_ProductBasic
SET Price = 1500
WHERE ProductID = 1;

##ANSWER-9

DELIMITER $$

CREATE PROCEDURE GetProductsByCategory(IN CategoryName VARCHAR(50))
BEGIN
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price
    FROM Products
    WHERE Category = CategoryName;
END $$

DELIMITER ;

CALL GetProductsByCategory('Electronics');
CALL GetProductsByCategory('Furniture');

##ANSWER-10
CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);

DELIMITER $$

CREATE TRIGGER trg_AfterProductDelete
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (
        ProductID,
        ProductName,
        Category,
        Price,
        DeletedAt
    )
    VALUES (
        OLD.ProductID,
        OLD.ProductName,
        OLD.Category,
        OLD.Price,
        NOW()
    );
END $$

DELIMITER ;








