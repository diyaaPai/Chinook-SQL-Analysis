USE Chinook;

-- =========================================================
-- CHINOOK DATABASE ANALYSIS
-- SQL Server | SSMS
-- =========================================================


-- Q.1) Which music genres generate the highest revenue?
SELECT
    g.Name AS Genre,
    SUM(il.Quantity * il.UnitPrice) AS Revenue
FROM Genre AS g
JOIN Track AS t
    ON g.GenreId = t.GenreId
JOIN InvoiceLine AS il
    ON t.TrackId = il.TrackId
GROUP BY
    g.Name
ORDER BY
    Revenue DESC;


-- Q.2) Which artists generate the highest revenue?
SELECT
    a.Name AS Artist,
    SUM(il.Quantity * il.UnitPrice) AS Revenue
FROM Artist AS a
JOIN Album AS al
    ON a.ArtistId = al.ArtistId
JOIN Track AS t
    ON al.AlbumId = t.AlbumId
JOIN InvoiceLine AS il
    ON t.TrackId = il.TrackId
GROUP BY
    a.Name
ORDER BY
    Revenue DESC;


-- Q.3) Who are the top 10 customers by total spending?
SELECT TOP 10
    c.CustomerId,
    c.FirstName,
    c.LastName,
    SUM(i.Total) AS Total_Spending
FROM Customer AS c
JOIN Invoice AS i
    ON c.CustomerId = i.CustomerId
GROUP BY
    c.CustomerId,
    c.FirstName,
    c.LastName
ORDER BY
    Total_Spending DESC;


-- Q.4) What is the monthly revenue trend over time?
SELECT
    YEAR(i.InvoiceDate) AS Year,
    DATENAME(MONTH, i.InvoiceDate) AS Month,
    SUM(il.Quantity * il.UnitPrice) AS Revenue
FROM Invoice AS i
JOIN InvoiceLine AS il
    ON i.InvoiceId = il.InvoiceId
GROUP BY
    YEAR(i.InvoiceDate),
    DATENAME(MONTH, i.InvoiceDate)
ORDER BY
    Year,
    MONTH(MIN(i.InvoiceDate));


-- Q.5) Which countries generate the most revenue?
SELECT
    BillingCountry AS Country,
    SUM(Total) AS Revenue
FROM Invoice
GROUP BY
    BillingCountry
ORDER BY
    Revenue DESC;


-- Q.6) Which employees support the most customers?
SELECT
    e.EmployeeId,
    e.FirstName,
    e.LastName,
    COUNT(*) AS Customer_Count
FROM Employee AS e
JOIN Customer AS c
    ON e.EmployeeId = c.SupportRepId
GROUP BY
    e.EmployeeId,
    e.FirstName,
    e.LastName
ORDER BY
    Customer_Count DESC;


-- Q.7) Within each country, who are the top 3 customers
--     by total spending?

WITH Customer_Totals AS (
    SELECT
        c.CustomerId,
        c.FirstName,
        c.LastName,
        c.Country,
        SUM(i.Total) AS Total_Spending
    FROM Customer AS c
    JOIN Invoice AS i
        ON c.CustomerId = i.CustomerId
    GROUP BY
        c.CustomerId,
        c.FirstName,
        c.LastName,
        c.Country
),
Ranked_Customers AS (
    SELECT
        FirstName,
        LastName,
        Country,
        Total_Spending,
        DENSE_RANK() OVER (
            PARTITION BY Country
            ORDER BY Total_Spending DESC
        ) AS Customer_Rank
    FROM Customer_Totals
)
SELECT
    *
FROM Ranked_Customers
WHERE Customer_Rank <= 3
ORDER BY
    Country,
    Total_Spending DESC;


-- Q.8) How does monthly revenue compare with the previous month?

WITH Monthly_Revenue AS (
    SELECT
        YEAR(i.InvoiceDate) AS Year,
        MONTH(i.InvoiceDate) AS Month_Number,
        DATENAME(MONTH, i.InvoiceDate) AS Month,
        SUM(il.Quantity * il.UnitPrice) AS Revenue
    FROM Invoice AS i
    JOIN InvoiceLine AS il
        ON i.InvoiceId = il.InvoiceId
    GROUP BY
        YEAR(i.InvoiceDate),
        MONTH(i.InvoiceDate),
        DATENAME(MONTH, i.InvoiceDate)
)
SELECT
    Year,
    Month,
    Revenue,
    LAG(Revenue) OVER (
        ORDER BY Year, Month_Number
    ) AS Previous_Month_Revenue
FROM Monthly_Revenue
ORDER BY
    Year,
    Month_Number;


-- Q.9) How can customers be classified based on their total spending?

WITH Customer_Totals AS (
    SELECT
        c.CustomerId,
        c.FirstName,
        c.LastName,
        SUM(i.Total) AS Total_Spending
    FROM Customer AS c
    JOIN Invoice AS i
        ON c.CustomerId = i.CustomerId
    GROUP BY
        c.CustomerId,
        c.FirstName,
        c.LastName
),
Customer_Categories AS (
    SELECT
        CustomerId,
        FirstName,
        LastName,
        Total_Spending,
        CASE
            WHEN Total_Spending >= 40
                THEN 'High Spender'
            WHEN Total_Spending BETWEEN 20 AND 39.99
                THEN 'Medium Spender'
            ELSE 'Low Spender'
        END AS Customer_Category
    FROM Customer_Totals
)
SELECT
    *
FROM Customer_Categories;


-- Q.10) Which customers have never made a purchase?

SELECT
    c.CustomerId,
    c.FirstName,
    c.LastName
FROM Customer AS c
LEFT JOIN Invoice AS i
    ON c.CustomerId = i.CustomerId
WHERE i.CustomerId IS NULL;