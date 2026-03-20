/*Answer-1
Why Data Quality Is More Than Just Data Cleaning:-

1️.Data Quality covers multiple dimensions
It includes:

.Accuracy
.Completeness
.Consistency
.Timeliness
.Validity
.Uniqueness

Cleaning only fixes errors — it does not ensure all these dimensions.

2.Data Quality involves validation, not just correction
ETL pipelines must validate data using business rules, schema checks, referential integrity, and constraints.
Cleaning alone cannot guarantee that data follows business logic.

3.Data Quality prevents bad data from entering the system
It includes:

.Source system checks
.Transformation validations
.Duplicate detection
.Referential integrity checks

Cleaning happens after issues occur; data quality ensures issues don’t occur.

4.Data Quality ensures trust in analytics
Even if data is cleaned, if it is:
.outdated
.inconsistent across systems
.missing key fields

…it still cannot be trusted.
Data quality ensures the data is fit for purpose.

ANSWER-2

1.Incorrect or Incomplete Data → Wrong Metrics
If the source data has errors, missing values, or duplicates, the KPIs shown on dashboards (sales, revenue, churn, etc.) become inaccurate.
Wrong data → wrong numbers → wrong insights.

2️.Inconsistent Data Across Systems
If different systems store different versions of the same data, dashboards will show conflicting results.
This confuses stakeholders and leads to poor decision‑making.

3️.Outdated or Delayed Data
If data is not refreshed properly, dashboards show old information.
Decisions based on outdated data can harm business performance.

4.Violated Business Rules
If data does not follow business rules (e.g., negative quantity, invalid dates), dashboards will display impossible or misleading values.

5️.Duplicate Records Inflate Metrics
Duplicate transactions or customers artificially increase totals, causing dashboards to over‑report revenue, sales, or counts.

ANSWER-3
Duplicate data refers to multiple records that represent the same real‑world entity (same customer, same transaction, same product) but appear more than once in the dataset.
These duplicates inflate counts, distort KPIs, and reduce data reliability.

*Three Causes of Duplicate Data in ETL Pipelines:-

1️.Multiple Source Systems (Data Integration Issues)
When data is collected from different systems (CRM, POS, website), the same customer or transaction may be recorded more than once.
Example: Customer “C101” appears multiple times in the Sales_Transactions table.

2.Missing or Weak Business Keys
If a unique identifier (like Customer_ID + Product_ID + Txn_Date + Txn_Amount) is not enforced, the ETL pipeline cannot detect duplicates.
This leads to repeated rows with identical values.

3️. Human or System Errors During Data Entry
Manual entry mistakes or system retries can create duplicate rows.
Example: A transaction is submitted twice due to a network retry or operator error.

ANSWER-4
1.Exact Duplicates
Two or more records are 100% identical across all columns.
Example:Same Customer_ID, Product_ID, Txn_Date, Txn_Amount repeated exactly.

Why it happens:
.System retry
.Same transaction loaded twice

2.Partial Duplicates
Records match on some key fields, but differ in others.
Example:Same Customer_ID and Product_ID, but different Quantity or City.

Why it happens:
.Manual entry variations
.Incomplete data
.Updates not synchronized

3.Fuzzy Duplicates
Records refer to the same real‑world entity, but values are similar, not identical.
Example:
“Rahul Mehta” vs “Rahul M.”
“Bengaluru” vs “Bangalore”

Why it happens: 
.Spelling mistakes
.Nicknames
.Different formats across systems

ANSWER-5
Data validation should be done during transformation because it prevents bad data from entering the warehouse,
ensures only accurate and consistent data is loaded, reduces reprocessing effort, and protects dashboards from incorrect insights.
 
ANSWER-6

Business rules validate data accuracy by enforcing logical conditions such as valid ranges, mandatory fields, and cross‑table consistency.
 For example:-
 A rule like “Quantity must be positive and Txn_Amount cannot be NULL” helps detect invalid transactions before loading them 
 into the warehouse.
 
 ANSWER-7
 */
 
 CREATE TABLE Sales_Transactions (
    Txn_ID        INT,
    Customer_ID   VARCHAR(10),
    Customer_Name VARCHAR(50),
    Product_ID    VARCHAR(10),
    Quantity      INT,
    Txn_Amount    INT,
    Txn_Date      DATE,
    City          VARCHAR(50)
);

INSERT INTO Sales_Transactions 
(Txn_ID, Customer_ID, Customer_Name, Product_ID, Quantity, Txn_Amount, Txn_Date, City)
VALUES
(201, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(202, 'C102', 'Anjali Rao', 'P12', 1, 1500, '2025-12-01', 'Bengaluru'),
(203, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(204, 'C103', 'Suresh Iyer', 'P13', 3, 6000, '2025-12-02', 'Chennai'),
(205, 'C104', 'Neha Singh', 'P14', NULL, 2500, '2025-12-02', 'Delhi'),
(206, 'C105', 'N/A', 'P15', 1, NULL, '2025-12-03', 'Pune'),
(207, 'C106', 'Amit Verma', 'P16', 1, 1800, NULL, 'Pune'),
(208, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai');



 SELECT 
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount,
    COUNT(*) AS duplicate_count
FROM Sales_Transactions
GROUP BY 
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount
HAVING COUNT(*) > 1;

##ANSWER -8

CREATE TABLE Customers_Master (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);
INSERT INTO Customers_Master (CustomerID, CustomerName, City) VALUES
('C101', 'Rahul Mehta', 'Mumbai'),
('C102', 'Anjali Rao', 'Bengaluru'),
('C103', 'Suresh Iyer', 'Chennai'),
('C104', 'Neha Singh', 'Delhi');



SELECT 
    st.Customer_ID
FROM Sales_Transactions st
LEFT JOIN Customers_Master cm
    ON st.Customer_ID = cm.CustomerID
WHERE cm.CustomerID IS NULL;
