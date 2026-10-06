-- E-Commerce Customer & Product Analysis
-- SQL Business Analysis

-- 1. Total Revenue
SELECT
    SUM(Sales) AS Total_Revenue
FROM sales;


-- 2. Total Orders
SELECT
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM sales;


-- 3. Revenue by Country
SELECT
    Country,
    SUM(Sales) AS Total_Revenue
FROM sales
GROUP BY Country
ORDER BY Total_Revenue DESC;


-- 4. Top 10 Products by Revenue
SELECT
    Description,
    SUM(Sales) AS Total_Revenue
FROM sales
WHERE Description IS NOT NULL
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 5. Top 10 Customers by Revenue
SELECT
    CustomerID,
    SUM(Sales) AS Total_Revenue
FROM sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 6. Monthly Revenue
SELECT
    strftime('%Y-%m', InvoiceDate) AS Month,
    SUM(Sales) AS Total_Revenue
FROM sales
GROUP BY Month
ORDER BY Month;


-- 7. One-Time vs Repeat Customers
WITH customer_orders AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS Order_Count
    FROM sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT
    CASE
        WHEN Order_Count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS Customer_Type,
    COUNT(*) AS Customer_Count
FROM customer_orders
GROUP BY Customer_Type
ORDER BY Customer_Count DESC;


-- 8. Average Order Value by Country
SELECT
    Country,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT InvoiceNo),
        2
    ) AS Average_Order_Value
FROM sales
GROUP BY Country
ORDER BY Average_Order_Value DESC;