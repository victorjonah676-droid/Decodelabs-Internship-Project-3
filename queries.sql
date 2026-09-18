-- =====================================================================
-- Project 3: SQL Data Analysis
-- DecodeLabs Data Analytics Internship
-- Dataset: orders (1,200 e-commerce orders)
-- =====================================================================

-- 1. Business Overview
-- Total orders, total revenue, and average order value at a glance.
SELECT
    COUNT(*)            AS total_orders,
    SUM(TotalPrice)      AS total_revenue,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders;


-- 2. Revenue by Product
-- Which products drive the most revenue, and how many orders each has.
SELECT
    Product,
    COUNT(*)                  AS order_count,
    SUM(TotalPrice)            AS total_revenue,
    ROUND(AVG(TotalPrice), 2)  AS avg_order_value
FROM orders
GROUP BY Product
ORDER BY total_revenue DESC;


-- 3. Top 10 Highest-Value Orders
-- The single biggest transactions in the dataset.
SELECT
    OrderID,
    Date,
    Product,
    Quantity,
    TotalPrice
FROM orders
ORDER BY TotalPrice DESC
LIMIT 10;


-- 4. Order Status Breakdown
-- What share of orders complete successfully vs get cancelled/returned.
SELECT
    OrderStatus,
    COUNT(*) AS order_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders), 1) AS pct_of_total
FROM orders
GROUP BY OrderStatus
ORDER BY order_count DESC;


-- 5. Monthly Revenue Trend
-- Total revenue and order volume for each calendar month.
SELECT
    strftime('%Y-%m', Date) AS month,
    COUNT(*)                 AS order_count,
    SUM(TotalPrice)           AS total_revenue
FROM orders
GROUP BY month
ORDER BY month;


-- 6. Payment Method Preference
-- Which payment methods customers use most, and their average order size.
SELECT
    PaymentMethod,
    COUNT(*)                  AS order_count,
    ROUND(AVG(TotalPrice), 2)  AS avg_order_value
FROM orders
GROUP BY PaymentMethod
ORDER BY order_count DESC;


-- 7. Referral Source Performance
-- Revenue generated per acquisition channel.
SELECT
    ReferralSource,
    COUNT(*)                  AS order_count,
    SUM(TotalPrice)             AS total_revenue,
    ROUND(AVG(TotalPrice), 2)   AS avg_order_value
FROM orders
GROUP BY ReferralSource
ORDER BY total_revenue DESC;


-- 8. Repeat Customers
-- Customers who placed more than one order, ranked by total spend.
SELECT
    CustomerID,
    COUNT(*)          AS order_count,
    SUM(TotalPrice)     AS total_spent
FROM orders
GROUP BY CustomerID
HAVING COUNT(*) > 1
ORDER BY total_spent DESC
LIMIT 10;


-- 9. Coupon Impact on Order Value
-- Compares average order value for orders with vs without a coupon code.
SELECT
    CASE WHEN CouponCode IS NULL THEN 'No Coupon' ELSE CouponCode END AS coupon,
    COUNT(*)                  AS order_count,
    ROUND(AVG(TotalPrice), 2)  AS avg_order_value
FROM orders
GROUP BY coupon
ORDER BY avg_order_value DESC;


-- 10. High-Value Products (above the average unit price)
-- Filters products priced above the dataset-wide average unit price.
SELECT
    OrderID,
    Product,
    UnitPrice,
    TotalPrice
FROM orders
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM orders)
ORDER BY UnitPrice DESC
LIMIT 10;


-- 11. Cancelled and Returned Orders Detail
-- Pulls the specific orders that failed to complete, for follow up.
SELECT
    OrderID,
    Date,
    Product,
    OrderStatus,
    TotalPrice
FROM orders
WHERE OrderStatus IN ('Cancelled', 'Returned')
ORDER BY Date DESC
LIMIT 15;
