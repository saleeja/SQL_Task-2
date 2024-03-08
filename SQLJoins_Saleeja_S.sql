-- Set suitable SQL constraints to columns while creating tables:
CREATE TABLE customer_master (
    Customer_ID VARCHAR(10) PRIMARY KEY,
    Customer VARCHAR(255) NOT NULL,
    Region VARCHAR(50) NOT NULL
);

CREATE TABLE sales_order (
    Sales_ID INT PRIMARY KEY,
    OrderDate DATE,
    Customer_ID VARCHAR(10),
    Item VARCHAR(255),
    Units INT,
    Unit_Cost DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES customer_master(Customer_ID)
);

-- Write a command to display the first 10 rows:
SELECT * FROM customer_master LIMIT 10;

-- Identify unique items:
SELECT DISTINCT Item FROM sales_order;

-- change the column name to unit_cost:
ALTER TABLE sales_order
CHANGE COLUMN `Unit Cost` Unit_cost DECIMAL(10, 2);

-- Identify if any unit cost is negative:
SELECT * FROM sales_order WHERE Unit_cost < 0;

-- Identify the minimum and maximum unit price for the same item:
SELECT Item, MIN(Unit_Cost) AS min_unit_cost, MAX(Unit_Cost) AS max_unit_cost
FROM sales_order
GROUP BY Item;

-- Identify the total sales that happened in the year 2021:
SELECT SUM(Total) AS total_sales
FROM sales_order
WHERE YEAR(OrderDate) = 2021;

-- Which item is sold the maximum in the year 2021:
SELECT Item, SUM(Units) AS total_units
FROM sales_order
WHERE YEAR(STR_TO_DATE(OrderDate, '%d-%m-%Y')) = 2021
GROUP BY Item
ORDER BY total_units DESC
LIMIT 1;

-- Identify the region with the highest and lowest sales:
SELECT c.Region, SUM(so.Total) AS total_sales
FROM customer_master c
JOIN sales_order so ON c.Customer_ID = so.Customer_ID
GROUP BY c.Region
ORDER BY total_sales DESC LIMIT 1; -- For highest sales

SELECT c.Region, SUM(so.Total) AS total_sales
FROM customer_master c
JOIN sales_order so ON c.Customer_ID = so.Customer_ID
GROUP BY c.Region
ORDER BY total_sales ASC LIMIT 1; -- For lowest sales

-- Identify the customer name having the highest sales for the year 2022:
SELECT c.Customer, SUM(so.Total) AS total_sales
FROM customer_master c
JOIN sales_order so ON c.Customer_ID = so.Customer_ID
WHERE YEAR(STR_TO_DATE(so.OrderDate, '%d-%m-%Y')) = 2022
GROUP BY c.Customer
ORDER BY total_sales DESC
LIMIT 1;

-- Which item has the highest and lowest unit cost:
SELECT Item, MAX(Unit_Cost) AS max_unit_cost
FROM sales_order
GROUP BY Item
ORDER BY max_unit_cost DESC
LIMIT 1; -- For highest unit cost

SELECT Item, MIN(Unit_Cost) AS min_unit_cost
FROM sales_order
GROUP BY Item
ORDER BY min_unit_cost ASC
LIMIT 1; -- For lowest unit cost

-- Identify items that start with the letter 'P':
SELECT * FROM sales_order WHERE Item LIKE 'P%';

-- Filter the table to include only items 'Pen' and 'Pencil':
SELECT * FROM sales_order WHERE Item IN ('Pen', 'Pencil');

-- Filter the table with unit cost between 1 and 100:
SELECT * FROM sales_order WHERE Unit_Cost BETWEEN 1 AND 100;

-- Identify the customer with the most number of transactions (entries):
SELECT c.Customer, COUNT(*) AS transaction_count
FROM customer_master c
JOIN sales_order so ON c.Customer_ID = so.Customer_ID
GROUP BY c.Customer
ORDER BY transaction_count DESC
LIMIT 1;

-- Identify which item has the maximum sales in each region:
SELECT c.Region, so.Item, SUM(so.Total) AS max_sales
FROM customer_master c
JOIN sales_order so ON c.Customer_ID = so.Customer_ID
GROUP BY c.Region, so.Item;

-- Create 5 more scenarios using important inbuilt functions of MySQL:

-- Use the CONCAT function to concatenate first and last names:
SELECT CONCAT(Customer, ' ', Region) AS full_name FROM customer_master;

 -- Use the UPPER function to convert item names to uppercase:
 SELECT UPPER(Item) AS uppercase_item FROM sales_order;

-- Use the AVG function to calculate the average unit price:
SELECT Item, AVG(Unit_Cost) AS avg_unit_cost FROM sales_order GROUP BY Item;

-- Calculate the total cost, rounded up to the nearest integer, for each item:
SELECT Item, SUM(CEIL(Units * Unit_Cost)) AS total_cost
FROM sales_order
GROUP BY Item;

-- Count the total number of sales orders:
SELECT COUNT(*) AS total_orders
FROM sales_order;

-- Calculate the absolute difference between two numeric columns:
SELECT Item, Units, ABS(Units - 50) AS units_difference_from_50
FROM sales_order;

-- Display the current date and time in a custom format:
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s') AS formatted_current_datetime;






