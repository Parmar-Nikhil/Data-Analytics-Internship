USE ecommerce_analytics;

-- =========================================================
-- PROJECT 3: SQL DATA ANALYSIS
-- E-Commerce Sales Dataset
-- MySQL 8+
-- =========================================================

-- 01. View all records
SELECT *
FROM ecommerce_sales
LIMIT 20;

-- 02. Select important columns
SELECT order_id, order_date, customer_id, product, quantity, total_price
FROM ecommerce_sales
LIMIT 20;

-- 03. Filter delivered orders
SELECT *
FROM ecommerce_sales
WHERE order_status = 'Delivered';

-- 04. Find high-value orders
SELECT order_id, product, total_price, order_status
FROM ecommerce_sales
WHERE total_price > 2500
ORDER BY total_price DESC;

-- 05. Top 10 orders by value
SELECT order_id, product, total_price, order_status
FROM ecommerce_sales
ORDER BY total_price DESC
LIMIT 10;

-- 06. Basic aggregate statistics
SELECT
    COUNT(*) AS total_orders,
    SUM(total_price) AS total_recorded_sales,
    AVG(total_price) AS average_order_value,
    MIN(total_price) AS minimum_order_value,
    MAX(total_price) AS maximum_order_value
FROM ecommerce_sales;

-- 07. Product-wise sales
SELECT
    product,
    COUNT(*) AS orders,
    SUM(quantity) AS quantity_sold,
    SUM(total_price) AS sales,
    AVG(total_price) AS avg_order_value
FROM ecommerce_sales
GROUP BY product
ORDER BY sales DESC;

-- 08. Products with sales greater than 180,000
SELECT
    product,
    SUM(total_price) AS sales
FROM ecommerce_sales
GROUP BY product
HAVING SUM(total_price) > 180000
ORDER BY sales DESC;

-- 09. Payment-method analysis
SELECT
    payment_method,
    COUNT(*) AS orders,
    SUM(total_price) AS sales,
    AVG(total_price) AS avg_order_value
FROM ecommerce_sales
GROUP BY payment_method
ORDER BY sales DESC;

-- 10. Order-status analysis
SELECT
    order_status,
    COUNT(*) AS orders,
    SUM(total_price) AS sales
FROM ecommerce_sales
GROUP BY order_status
ORDER BY orders DESC;

-- 11. Referral-source analysis
SELECT
    referral_source,
    COUNT(*) AS orders,
    SUM(total_price) AS sales
FROM ecommerce_sales
GROUP BY referral_source
ORDER BY sales DESC;

-- 12. Monthly sales trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(*) AS orders,
    SUM(total_price) AS sales
FROM ecommerce_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 13. Year-wise sales
SELECT
    YEAR(order_date) AS year,
    COUNT(*) AS orders,
    SUM(total_price) AS sales
FROM ecommerce_sales
GROUP BY YEAR(order_date)
ORDER BY year;

-- 14. Orders placed during 2024
SELECT
    COUNT(*) AS orders,
    SUM(total_price) AS sales
FROM ecommerce_sales
WHERE order_date >= '2024-01-01'
  AND order_date < '2025-01-01';

-- 15. Cancelled and returned orders
SELECT
    order_status,
    COUNT(*) AS orders,
    SUM(total_price) AS recorded_value
FROM ecommerce_sales
WHERE order_status IN ('Cancelled', 'Returned')
GROUP BY order_status
ORDER BY recorded_value DESC;

-- 16. Classify orders by value using CASE
SELECT
    order_id,
    total_price,
    CASE
        WHEN total_price < 500 THEN 'Low Value'
        WHEN total_price < 1500 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_category
FROM ecommerce_sales
ORDER BY total_price DESC;

-- 17. Customers with more than one order
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM ecommerce_sales
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY order_count DESC;

-- 18. Top customers by recorded spend
SELECT
    customer_id,
    COUNT(*) AS orders,
    SUM(total_price) AS total_spend,
    AVG(total_price) AS avg_order_value
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;

-- 19. Orders above the overall average order value
SELECT
    order_id,
    customer_id,
    product,
    total_price
FROM ecommerce_sales
WHERE total_price > (
    SELECT AVG(total_price)
    FROM ecommerce_sales
)
ORDER BY total_price DESC;

-- 20. Conditional aggregation: status summary
SELECT
    SUM(CASE WHEN order_status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
    SUM(CASE WHEN order_status = 'Shipped' THEN 1 ELSE 0 END) AS shipped_orders,
    SUM(CASE WHEN order_status = 'Pending' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders
FROM ecommerce_sales;

-- 21. Rank products by sales using a window function
WITH product_sales AS (
    SELECT
        product,
        SUM(total_price) AS sales
    FROM ecommerce_sales
    GROUP BY product
)
SELECT
    product,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM product_sales
ORDER BY sales_rank;

-- 22. Product sales contribution to total sales
WITH product_sales AS (
    SELECT
        product,
        SUM(total_price) AS sales
    FROM ecommerce_sales
    GROUP BY product
)
SELECT
    product,
    sales,
    ROUND(100 * sales / SUM(sales) OVER (), 2) AS sales_percentage
FROM product_sales
ORDER BY sales DESC;

-- 23. Monthly sales with month-over-month change
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_price) AS sales
    FROM ecommerce_sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    sales,
    LAG(sales) OVER (ORDER BY month) AS previous_month_sales,
    ROUND(
        100 * (sales - LAG(sales) OVER (ORDER BY month))
        / NULLIF(LAG(sales) OVER (ORDER BY month), 0),
        2
    ) AS mom_growth_percentage
FROM monthly_sales
ORDER BY month;

-- 24. Running total of monthly sales
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_price) AS sales
    FROM ecommerce_sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    sales,
    SUM(sales) OVER (ORDER BY month) AS running_sales
FROM monthly_sales
ORDER BY month;

-- 25. Highest-value order for each product
WITH ranked_orders AS (
    SELECT
        order_id,
        product,
        total_price,
        order_status,
        ROW_NUMBER() OVER (
            PARTITION BY product
            ORDER BY total_price DESC
        ) AS rn
    FROM ecommerce_sales
)
SELECT
    order_id,
    product,
    total_price,
    order_status
FROM ranked_orders
WHERE rn = 1
ORDER BY total_price DESC;

-- 26. Top 3 products by quantity sold
SELECT
    product,
    SUM(quantity) AS quantity_sold
FROM ecommerce_sales
GROUP BY product
ORDER BY quantity_sold DESC
LIMIT 3;

-- 27. Coupon performance
SELECT
    COALESCE(coupon_code, 'No Coupon') AS coupon,
    COUNT(*) AS orders,
    SUM(total_price) AS sales,
    AVG(total_price) AS avg_order_value
FROM ecommerce_sales
GROUP BY COALESCE(coupon_code, 'No Coupon')
ORDER BY sales DESC;

-- 28. Product + payment combination analysis
SELECT
    product,
    payment_method,
    COUNT(*) AS orders,
    SUM(total_price) AS sales
FROM ecommerce_sales
GROUP BY product, payment_method
ORDER BY sales DESC;

-- 29. Business question: which referral source has the highest average order value?
SELECT
    referral_source,
    COUNT(*) AS orders,
    AVG(total_price) AS avg_order_value
FROM ecommerce_sales
GROUP BY referral_source
ORDER BY avg_order_value DESC;

-- 30. Final executive summary
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_price), 2) AS total_recorded_sales,
    ROUND(AVG(total_price), 2) AS average_order_value,
    ROUND(MIN(total_price), 2) AS min_order_value,
    ROUND(MAX(total_price), 2) AS max_order_value
FROM ecommerce_sales;
