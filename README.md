# 💲 QuickBasket Hub – SQL Analysis Project

Welcome to **QuickBasket Hub**, a fictional retail store database designed for practicing and demonstrating SQL data analysis skills. This project includes over 500 records across three interrelated tables: customers, products, and orders. It covers everything from basic querying to advanced analytics using window functions, subqueries, joins, and aggregations.

---

## 📅 Dataset Overview

* **customers**: Customer ID, Name, City, Gender, Age
* **products**: Product ID, Product Name, Category, Price
* **orders**: Order ID, Customer ID, Product ID, Order Date, Quantity, Total Amount

---

## 🔧 Skills & Concepts Practiced

* **Filtering**: `WHERE`, `IN`, `BETWEEN`, `LIKE`, `OR`, `NOT`
* **Aggregations**: `SUM`, `COUNT`, `AVG`, `MAX`, `MIN`
* **Grouping**: `GROUP BY`, `HAVING`
* **Ordering and Limiting**: `ORDER BY`, `LIMIT`
* **Joins**: `INNER JOIN`, `LEFT JOIN`
* **Subqueries**: `IN`, `NOT IN`, correlated subqueries
* **Window Functions**: `RANK()`, `ROW_NUMBER()`, `CUME_DIST()`, `LAG()`, `SUM() OVER`

---

## 📊 Example Use Cases

* Retrieve top 10 highest spending customers
* Identify most and least expensive products by category
* Get products that have never been ordered
* Compare product prices using `CUME_DIST()`
* Find average and total order value per customer
* Detect high-volume customers using `HAVING` clause
* Generate running totals and order ranks using window functions

---

## 🔹 Sample Queries Included

1. Customers who ordered more than 3 times
2. Total revenue per product
3. Most expensive product in each category
4. Products in the top 10% by price using `CUME_DIST()`
5. All products never ordered (using `LEFT JOIN` and `NOT IN`)
6. Running total of revenue per customer
7. Customer names who bought 'Product\_5'

---

## 🌐 Getting Started

You can load the dataset into any SQL environment (e.g., PostgreSQL, MySQL, SQLite, BigQuery) using the provided CSVs:

* `customers.csv`
* `products.csv`
* `orders.csv`

---

## 📆 Author

**Pushpkar Roy**
📧 [Pushpkarroy880@gmail.com](mailto:Pushpkarroy880@gmail.com)
🔗 [LinkedIn](https://www.linkedin.com/in/pushpkar-roy)
💻 [GitHub](https://github.com/PushpkarRoy)

---

> *"From raw rows to actionable retail insights — powered by SQL."*
