Project 3: SQL Data Analysis
DecodeLabs Data Analytics Internship, Batch 2026

Overview
This project analyzes 1,200 e-commerce orders using SQL to answer real business questions: which products and channels drive revenue, where orders are being lost, who the repeat customers are, and whether coupons actually move order value. Every number below comes directly from the queries in queries.sql run against orders.db, a SQLite database built from the raw dataset.

Tools
SQLite for the database, plain SQL for every calculation (SELECT, WHERE, GROUP BY, HAVING, ORDER BY, subqueries, CASE). No spreadsheet formulas, no external libraries.

Dataset
orders table, 1,200 rows: OrderID, Date, CustomerID, Product, Quantity, UnitPrice, ShippingAddress, PaymentMethod, OrderStatus, TrackingNumber, ItemsInCart, CouponCode, ReferralSource, TotalPrice.

How to run it
Open a terminal, then:
sqlite3 orders.db
Then paste in any query from queries.sql, or run the whole file:
sqlite3 orders.db < queries.sql

Key Findings

Business overview. 1,200 orders totaling $1,264,761.96 in revenue, averaging $1,053.97 per order.

Revenue by product. Chair leads total revenue at $195,620, just ahead of Printer at $195,613, with Laptop close behind. Laptop has the highest average order value at $1,110.56, Phone the lowest at $972.58.

Order status. Orders split almost evenly across five statuses, but Cancelled (20.8%) and Returned (20.6%) together account for about 41% of all orders, meaning roughly two out of every five orders never complete. That is the clearest opportunity in this dataset: fixing whatever is driving cancellations and returns would recover more revenue than any marketing change.

Payment method. Credit Card orders carry the highest average value at $1,127.55, while Debit Card orders average the lowest at $1,001.56. Online is the most used method (258 orders).

Referral source. Instagram drives both the most orders (259) and the most total revenue ($275,285), making it the strongest acquisition channel in the data. Facebook has fewer orders than Instagram or Email but the second highest average order value at $1,098.29.

Repeat customers. Only a small number of customers placed more than one order. The top repeat customer, C38840, placed 2 orders totaling $5,723.23, well above the typical repeat customer spend of $1,000 to $2,000. Repeat purchase rate is low across the board, worth flagging for a retention strategy.

Coupon impact. Orders using FREESHIP have the highest average value ($1,070.41), and orders with no coupon at all have the lowest ($1,043.37) apart from WINTER15 ($1,035.90). The spread is small (under $35), suggesting coupons here are not strongly changing basket size, just adding a discount.

High value products. The highest unit price items skew toward Laptop, Tablet, and Desk, several crossing $2,700 to $2,800 in total order value when bought in quantity.

Recommendation
The order completion rate is the single biggest lever visible in this data. With 41% of orders ending in cancellation or return, the next step should be a deeper query joining this against payment method or shipping data (if available) to isolate whether failed orders cluster around a specific payment type, product, or time window.

Files
queries.sql: 11 commented SQL queries covering aggregation, filtering, grouping, subqueries, and joins-equivalent logic.
orders.db: SQLite database containing the orders table, ready to query directly.
