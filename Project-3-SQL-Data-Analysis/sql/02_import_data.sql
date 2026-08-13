USE ecommerce_analytics;

-- Recommended for MySQL Workbench:
-- Use Table Data Import Wizard to import:
-- data/ecommerce_sales.csv
-- into ecommerce_analytics.ecommerce_sales.
--
-- If LOCAL INFILE is enabled, you can alternatively use:
-- LOAD DATA LOCAL INFILE 'C:/YOUR/PATH/ecommerce_sales.csv'
-- INTO TABLE ecommerce_sales
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (order_id, order_date, customer_id, product, quantity, unit_price,
--  shipping_address, payment_method, order_status, tracking_number,
--  items_in_cart, coupon_code, referral_source, total_price);
