CREATE TABLE customers (
customer_id VARCHAR(20),
name VARCHAR(50),
city VARCHAR(50),
age	INT,
gender VARCHAR(20)
)

CREATE TABLE orders(
order_id INT,
customer_id VARCHAR(20),
product_id INT,
order_date DATE,
quantity INT,
total_amount INT
)

CREATE TABLE products (	
product_id INT,
product_name VARCHAR(20),
category VARCHAR(50),
price INT
)

SELECT * FROM customers
SELECT * FROM orders 
SELECT * FROM products 


-- Q1 -- Get all orders placed between '2023-06-01' and '2023-06-30'.

SELECT * FROM orders 
WHERE order_date BETWEEN '2023-06-01' AND '2023-06-30'

-- Q2 Show products with a price > 1000 ordered by price descending.

SELECT * FROM orders 
WHERE total_amount >= 1000
ORDER BY total_amount  DESC

-- Q3 Find all customers whose name starts with 'R'.

SELECT * FROM customers 
WHERE name LIKE 'R%' 

-- Q4 Get orders where the quantity is not equal to 1.

SELECT * FROM orders 
WHERE quantity <> 1
ORDER BY quantity ASC 

-- Q5 Find all products in category 'Electronics' or 'Books'.

SELECT * FROM products
WHERE category = 'Electronics' OR
      category = 'Books'

-- Q6 Get the top 10 orders by total_amount.

SELECT * FROM orders
ORDER BY total_amount DESC
LIMIT 10

-- 🔹 Aggregate Functions

-- Q7 Find the total revenue (sum of total_amount) for the year 2023.

SELECT SUM(total_amount)
FROM orders 
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'

-- Q8 Show the average price of products in each category.

SELECT * FROM products

SELECT category, ROUND(AVG(price):: NUMERIC ,2 )
FROM products 
GROUP BY category

-- Q9 Count how many orders each customer has placed.

SELECT * FROM customers
SELECT * FROM orders 

SELECT o.customer_id, c.name,  COUNT(o.order_id) AS Total_order_place
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.name
ORDER BY Total_order_place DESC

-- Q10 List product names and their total quantity sold.

SELECT p.product_name, o.product_id, SUM(o.quantity) AS Toatl_quantity
FROM products AS p
JOIN orders AS o
ON p.product_id = o.product_id 
GROUP BY p.product_name, o.product_id 

-- Q11 Show the minimum and maximum category prices.

SELECT category, MAX(price), MIN(price)
FROM products
GROUP BY category 

	SELECT *,
	MAX(price) OVER(PARTITION BY category ) AS Max_price_value,
	MIN(price) OVER(PARTITION BY category ) AS Min_price_value
	FROM products 

--🔹 GROUP BY + HAVING 

-- Q12 Find all customers who placed more than 3 orders.

SELECT o.customer_id, c.name, c.city, o.customer_id, o.quantity
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id 
WHERE quantity > 3

-- Q13 Show all product categories with average price > 800.

SELECT category, ROUND(AVG(price):: NUMERIC,2)
FROM products 
GROUP BY category 

-- Q14 Get the total revenue per month using GROUP BY.

SELECT * FROM products 
SELECT * FROM orders 
SELECT * FROM customers 

SELECT EXTRACT(month FROM order_date) AS Month_no, SUM(total_amount) AS Total_revenue 
FROM orders 
GROUP BY Month_no
ORDER BY Month_no ASC

--🔹 JOINS

-- Q15 List customer name, product name, quantity, and total amount for all orders.

SELECT c.name, p.product_name, o.quantity, o.total_amount
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN products AS p
ON p.product_id = o.product_id

-- Q16 Show all products that have never been ordered.

SELECT o.product_id, p.product_name
FROM orders AS o
JOIN products AS p
ON o.product_id = p.product_id
WHERE p.product_id IN (SELECT product_id
                              FROM orders

-------------------------------OR--------------------------------------------

SELECT p.product_id, p.product_name
FROM products AS p
LEFT JOIN orders AS o ON p.product_id = o.product_id
WHERE o.product_id IS NULL;



-- Q17 Get the names of customers who bought 'Product_5'.

SELECT c.name, c.city, p.product_name, p.category
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN products AS p
ON p.product_id = o.product_id 
WHERE p.product_name = 'Product_5'


--🔹 Subqueries

-- Q18 Get customers who spent more than the average total_amount per order.

SELECT * 
FROM orders 
WHERE total_amount >= (SELECT ROUND(AVG(total_amount):: NUMERIC, 2)
                          FROM orders )
ORDER BY total_amount DESC						  

-- Q19 Find the most expensive product in each category using a subquery.

SELECT * FROM (
SELECT *,
MAX(price) OVER(PARTITION BY category ) AS max_value,
RANK() OVER(PARTITION BY category ORDER BY price DESC) AS ranking
FROM products )
WHERE ranking = 1

----------------------------------OR------------------------------------------

SELECT product_id, product_name, category, price
FROM products AS p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category = p.category
);


-- Q20 Show products that have the same price as the cheapest product.

SELECT * 
FROM products 
WHERE price = (
                SELECT MIN(price)
                   FROM products )

--🔹 Window Functions

-- Q21 Assign a row number to each order per customer ordered by order_date.

SELECT *,
ROW_NUMBER() OVER(ORDER BY order_date) AS cusutomer_ordered
FROM orders 

-- Q22 Calculate a running total of total_amount for each customer.

SELECT *,
SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY total_amount ) AS final_total
FROM orders 

-- Q23 For each product, rank orders by highest quantity using RANK().

SELECT *,
RANK() OVER(PARTITION BY product_id ORDER BY quantity DESC) AS product_quantity_sale
FROM orders 

-- Q24 Use CUME_DIST() to find how expensive each product is compared to others.

SELECT *, percentage || '%' AS final_Value
FROM (
SELECT *,
ROUND(CUME_DIST() OVER(ORDER BY total_amount):: NUMERIC * 100, 2) AS percentage
FROM orders ) AS x

---------------------------OR-----------------------------------------------------------

SELECT *, 
ROUND(CUME_DIST() OVER( ORDER BY price):: NUMERIC * 100, 2) AS price_percentage
FROM products



	