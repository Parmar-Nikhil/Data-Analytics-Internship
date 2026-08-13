CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

DROP TABLE IF EXISTS ecommerce_sales;

CREATE TABLE ecommerce_sales (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATETIME NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    product VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    shipping_address VARCHAR(255),
    payment_method VARCHAR(30),
    order_status VARCHAR(30),
    tracking_number VARCHAR(30),
    items_in_cart INT,
    coupon_code VARCHAR(30),
    referral_source VARCHAR(30),
    total_price DECIMAL(12,2) NOT NULL
);
