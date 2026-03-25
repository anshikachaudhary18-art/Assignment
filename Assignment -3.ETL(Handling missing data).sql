/*ANSWER-1

1. Source system issues
.System errors or crashes: Data not captured due to application failures.
.Integration failures: API/connector issues causing partial loads.

2. Human and process errors
.Incomplete data entry: Users skip optional fields (e.g., income, phone).
.Manual overrides: Operators leave fields blank during corrections or updates.

3. Data design and business rules
.Optional or not applicable fields: Some attributes are genuinely not required for all records.
.Legacy systems: Older systems may not store certain fields that new systems expect.

4. ETL pipeline problems
.Transformation errors: Incorrect mapping or logic drops values.
.Load failures: Truncation, type mismatch, or constraint violations cause values to be lost.

5. Timing and latency issues
.Delayed updates: Data not yet available at extraction time (e.g., late-arriving facts).
.Incremental loads: New fields added later, so older records remain null.

ANSWER-2
Blindly deleting rows with missing values is a bad practice because it causes unnecessary data loss, 
introduces bias, reduces dataset size, and ignores the underlying reason for missingness. 
A thoughtful approach is needed to preserve data quality and business insights.

ANSWER-3
*Listwise Deletion
Meaning:
Remove entire rows where any required value is missing.

When to Use:
.When only a few rows have missing values.
.When those rows are not critical for analysis.
.When you want to maintain complete records for modeling.
Example Scenario:
If only 2 out of 1,000 customer records have missing Region, deleting those rows is safe.

*Column Deletion
Meaning:
Remove an entire column when most of its values are missing.

When to Use:
.When a column has very high missingness (e.g., 80–90%).
.When the column is not important for analysis or business decisions.
Example Scenario:
If the Income column is missing for 90% of customers, deleting the column is better than keeping unreliable data.

ANSWER-4

Median imputation is preferred for skewed data like income because the median is not affected by extreme outliers 
and provides a more realistic central value. Mean imputation gets distorted by very high or low values,
 leading to inaccurate analysis.
 
ANSWER-5
.Forward Fill
Forward fill (also called FFILL) is a technique where missing values are replaced with the last available non‑missing value from above.

Example:
If Monthly_Sales =
12000, NaN, NaN, 18000  
Forward fill becomes:
12000, 12000, 12000, 18000 

.Where Is Forward Fill Most Useful?
Forward fill is best suited for time‑series or sequential datasets, where values naturally carry forward until a new value appears.

Ideal scenarios:
.Daily/weekly/monthly sales data
.Stock prices
.Sensor readings
.Website traffic logs
.Customer activity timelines.

ANSWER-6
Flagging missing values before imputation is important because it preserves information about which values were originally missing.
This missingness can provide business insights,improve model performance, and prevent confusion after imputation. 
Once values are filled, the original missing pattern cannot be recovered without a flag.

ANSWER-7
Missing income values are not always “bad data.”
Sometimes the pattern of missingness reveals important business behaviour.

Missing income values can reveal important patterns. Customers who do not provide income may belong to a specific segment,
may have privacy concerns, or may behave differently (like lower purchases or higher churn). The pattern of missingness 
can also show operational issues such as data entry problems in certain regions or channels. So,
missing income itself provides useful business insights instead of being treated as bad data.
 */
 
 ##ANSWER-8

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Monthly_Sales INT,
    Income INT,
    Region VARCHAR(20)
);
INSERT INTO Customers (Customer_ID, Name, City, Monthly_Sales, Income, Region) VALUES
(101, 'Rahul Mehta', 'Mumbai', 12000, 65000, 'West'),
(102, 'Anjali Rao', 'Bengaluru', NULL, NULL, 'south'),
(103, 'Suresh Iyer', 'Chennai', 15000, 72000, 'south'),
(104, 'Neha Singh', 'Delhji', NULL, Null, 'north'),
(105, 'Amit Verma', 'Puna', 18000, 58000, Null),
(106, 'Karan Shah', 'Ahmedabad', NULL, 61000, 'west'),
(107, 'Pooja Das', 'Kolkata', 14000, NULL, 'east'),
(108, 'Riya Kapoor', 'Jaipur', 16000, 69000, 'north');
select*from customers;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM customers
WHERE Region IS NULL;

SET SQL_SAFE_UPDATES = 1;
## 1. affected 1 row (105)
##2. after deletion
select*from customers;
##3.
SELECT COUNT(*) AS missing_region_count
FROM sales_data
WHERE Region IS NULL;

##ANSWER -9
##apply forward fill
SELECT 
    c1.Customer_ID,
    c1.Name,
    c1.City,
    c1.Monthly_Sales AS BeforeValue,
    (
        SELECT c2.Monthly_Sales
        FROM CustomerData c2
        WHERE c2.Customer_ID <= c1.Customer_ID
          AND c2.Monthly_Sales IS NOT NULL
        ORDER BY c2.Customer_ID DESC
        LIMIT 1
    ) AS AfterValue
FROM CustomerData c1
ORDER BY c1.Customer_ID;

##before vs after
SELECT 
    c1.Customer_ID,
    c1.Name,
    c1.City,
    c1.Monthly_Sales AS BeforeValue,
    (
        SELECT c2.Monthly_Sales
        FROM CustomerData c2
        WHERE c2.Customer_ID <= c1.Customer_ID
          AND c2.Monthly_Sales IS NOT NULL
        ORDER BY c2.Customer_ID DESC
        LIMIT 1
    ) AS AfterValue
FROM CustomerData c1
ORDER BY c1.Customer_ID;

/*why forward fill suitable here--
Forward fill is suitable because Monthly_Sales is a sequential, time‑based field.
 Missing values likely represent unrecorded data rather than true zeros, and forward 
 fill preserves the natural sales trend by carrying forward the last known valid value.
*/

##ANSWER-10

SELECT 
    COUNT(*) AS Missing_Income_Count
FROM CustomerData
WHERE Income IS NULL;
##TASK-1
SELECT
    Customer_ID,
    Name,
    City,
    Monthly_Sales,
    Income,
    Region,
    CASE 
        WHEN Income IS NULL THEN 1
        ELSE 0
    END AS Income_Missing_Flag
FROM CustomerData;
##TASK--2
SELECT
    Customer_ID,
    Name,
    City,
    Monthly_Sales,
    Income,
    Region,
    CASE 
        WHEN Income IS NULL THEN 1
        ELSE 0
    END AS Income_Missing_Flag
FROM CustomerData;

##TASK--3
SELECT 
    COUNT(*) AS Missing_Income_Count
FROM CustomerData
WHERE Income IS NULL;















