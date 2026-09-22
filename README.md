# Chinook SQL Analysis



## Project Overview



This project analyzes the Chinook music store database using SQL to answer business-related questions about revenue, customers, employees, and purchasing trends.



The analysis was performed using Microsoft SQL Server and SQL Server Management Studio (SSMS).



## Tools Used



- Microsoft SQL Server

- SQL Server Management Studio (SSMS)

- SQL



## Dataset



The project uses the Chinook music store database containing information about customers, employees, artists, albums, tracks, invoices, invoice lines, genres, media types, and playlists.



## Business Questions



The analysis answers the following questions:



1. Which music genres generate the highest revenue?

2. Which artists generate the highest revenue?

3. Who are the top 10 customers by total spending?

4. What is the monthly revenue trend over time?

5. Which countries generate the most revenue?

6. Which employees support the most customers?

7. Within each country, who are the top 3 customers by total spending?

8. How does monthly revenue compare with the previous month?

9. How can customers be classified based on their total spending?

10. Which customers have never made a purchase?



## Key Findings



- Rock generated the highest genre revenue at 826.65, followed by Latin at 382.14.
- Iron Maiden generated the highest artist revenue at 138.60, followed by U2 at 105.93.
- Helena Holy had the highest total spending among the top 10 customers at 49.62.
- The USA generated the highest country revenue at 523.06, followed by Canada at 303.96 and France at 195.50.
- Jane Peacock supported the most customers, with 21 customers, followed by Margaret Park with 20 and Steve Johnson with 18.
- Every customer in the dataset had made at least one purchase.




## SQL Concepts Demonstrated



- SELECT statements

- INNER JOIN

- LEFT JOIN

- Aggregate functions

- GROUP BY

- ORDER BY

- CASE WHEN

- Common Table Expressions (CTEs)

- Window functions

- DENSE_RANK()

- LAG()

- Date functions

- NULL handling

- Multi-table analysis



## Project Structure

```text
Chinook-SQL-Analysis/
│
├── chinook_analysis.sql
├── README.md
└── screenshots/
    ├── q1_genre_revenue.png
    ├── q2_artist_revenue.png
    ├── q3_top_customers.png
    ├── q4_monthly_revenue.png
    └── q8_monthly_revenue_lag.png