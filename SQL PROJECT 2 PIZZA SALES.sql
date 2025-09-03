-- EXPLORATORY DATA ANALYTICS PORTFOLIO PROJECT ON PIZZA SALES

USE pizzasales;
select * from pizza_sales;

SELECT order_date, STR_TO_DATE(order_date, '%d-%m-%Y') AS converted_date
FROM pizza_sales;

SET SQL_SAFE_UPDATES = 0;				# Disabling safe updates to update data type of column

UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

ALTER TABLE pizza_sales
MODIFY COLUMN order_date DATE;			# Changing order_date to DATE type

SELECT * FROM pizza_sales;

SELECT order_time, STR_TO_DATE(order_time, '%H:%i:%s')
FROM pizza_sales;

UPDATE pizza_sales
SET order_time = STR_TO_DATE(order_time, '%H:%i:%s');

ALTER TABLE pizza_sales
MODIFY COLUMN order_time TIME;			# Changing order_time to TIME type

-- KEY PERFORMANCE INDICATORS
-- Finding the total revenue

SELECT SUM(total_price) from pizza_sales;
SELECT ROUND(SUM(total_price)) from pizza_sales;

-- To determine average order values

SELECT SUM(total_price)/COUNT(DISTINCT order_id) as avg_order_value
FROM pizza_sales;

SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id), 2) as avg_order_value
FROM pizza_sales;

-- Total number of pizzas sold

SELECT SUM(quantity) AS Total_pizzas_sold
FROM pizza_sales;

-- Total number of orders placed

SELECT COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales;

-- Average number of pizzas per order

SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS avg_pizzas
FROM pizza_sales;

SELECT ROUND(SUM(quantity)/COUNT(DISTINCT order_id), 1) AS avg_pizzas
FROM pizza_sales;

-- VALUES NEEDED FOR VISUALIZATION IN EXCEL
-- Daily trend for total orders

SELECT DATE_FORMAT(order_date, '%W') AS order_day, COUNT(DISTINCT order_id) as total_orders 
FROM pizza_sales
GROUP BY DATE_FORMAT(order_date, '%W');

-- Hourly trend for total orders, to find peak time for orders

SELECT HOUR(order_time) as order_hour, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

-- Percentage of pizza sales by category

SELECT pizza_category, SUM(total_price) AS total_price_categ, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) as sales_percentage
FROM pizza_sales
GROUP BY pizza_category;

SELECT pizza_category, SUM(total_price) AS total_price_categ, 
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1 ) as sales_percentage
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;					# Only for January

SELECT pizza_category, SUM(total_price) AS total_price_categ, 
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) <= 4) as sales_percentage
FROM pizza_sales
WHERE MONTH(order_date) <= 4
GROUP BY pizza_category;					# For first Quarter

-- Percentage of sales by pizza size

SELECT pizza_size, SUM(total_price) AS total_price_size, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) as sales_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY sales_percentage desc;

SELECT pizza_size, ROUND(SUM(total_price), 2) AS total_price_size,
ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) as sales_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY sales_percentage desc; 				# To round off to two decimal places

-- Total pizzas sold by pizza category

SELECT pizza_category, SUM(quantity) as num_of_pizzas
FROM pizza_sales
GROUP BY pizza_category;

-- Top 5 best sellers by total pizzas sold

SELECT pizza_name, SUM(quantity) as num_of_pizzas
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 5;

-- Bottom 5 sellers by total pizzas sold

SELECT pizza_name, SUM(quantity) as num_of_pizzas
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 5;













 


