# Retail Sales Analysis SQL Project
## Project Overview 
**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: Postgresql `retail_analysis_db`

This project demonstrates core PostgreSQL skills used by data analysts to store, clean, and analyze retail sales data. It involves database creation, data import, cleaning, exploratory data analysis (EDA), and solving business problems using SQL queries.

The goal is to simulate a real-world retail dataset and extract meaningful insights using PostgreSQL features like aggregations, window functions, and filtering. 


## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
## Project Structure
### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_analysis_db`.
- **Table Creation**: A table named `Sales_transactions` is created to store the sales data. The table structure includes columns for Line item ID, Transaction ID, Sale date, Customer ID, Loyalty member, Product ID, Category, Brand, Unit price, Quantity, Line total, Discount Applied, Net amount, Payment method, Cashier ID.

```sql
CREATE DATABASE retail_analysis_db;

CREATE TABLE sales_transaction 
(
	line_item_id varchar(10) PRIMARY KEY,
	transaction_id VARCHAR(10),
	sale_date DATE,
	customer_id VARCHAR(20),
	loyalty_member BOOLEAN,
	product_id VARCHAR(50),
	product_name VARCHAR(25),
	category VARCHAR(15),
	brand VARCHAR(15),
	unit_price DECIMAL(10,2) CHECK (unit_price >= 0),
	quantity INTEGER CHECK (quantity > 0),
	line_total DECIMAL(10,2),
	discount_applied DECIMAL(10,2) CHECK (discount_applied >= 0),
	net_amount DECIMAL(10,2) Check (net_amount >= 0),
	payment_method VARCHAR(5),
	cashier_id VARCHAR(5)

);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM sales_transactions;
SELECT COUNT(DISTINCT customer_id) FROM sales_transactions;
SELECT DISTINCT category FROM sales_transactions;

SELECT * FROM sales_transactions
WHERE line_item_id IS NULL OR transaction_id IS NULL OR sale_date IS NULL
   OR customer_id IS NULL OR loyalty_member IS NULL OR product_name IS NULL
   OR product_id IS NULL OR category IS NULL OR brand IS NULL
   OR unit_price IS NULL OR quantity IS NULL OR cashier_id IS NULL;
   OR line_total IS NULL OR discount_applied IS NULL OR payment_method IS NULL
   OR net_amount IS NULL 

DELETE from sales_transactions
WHERE line_item_id IS NULL OR transaction_id IS NULL OR sale_date IS NULL
   OR customer_id IS NULL OR loyalty_member IS NULL OR cashier_id IS NULL;
   OR product_id IS NULL OR product_name IS NULL OR payment_method IS NULL
   OR category IS NULL OR brand IS NULL OR net_amount IS NULL 
   OR unit_price IS NULL OR quantity IS NULL OR discount_applied IS NULL
   OR line_total IS NULL 
```


