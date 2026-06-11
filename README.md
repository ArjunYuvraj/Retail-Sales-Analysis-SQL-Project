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
### Sales Data Analysis And findings
This analysis derives actionable insights from retail sales data by evaluating revenue trends, identifying top-performing products, and assessing category-level performance.

1.**Monthly Revenue Analysis**: Calculates total revenue for each month to identify sales trends over time.
```sql
SELECT 
    TO_CHAR(sale_date, 'Month') AS month_name,
    SUM(net_amount) AS total_sales
FROM sales_transactions
GROUP BY month_name
ORDER BY MIN(sale_date);
```
2.**Categorical Performance**: Analyzes revenue contribution by product category, including total sales, units sold, and percentage share.
```sql
SELECT 
    category,
	COUNT(line_item_id) as units_sold,
    ROUND(COUNT(line_item_id) * 100.0 / SUM(COUNT(line_item_id)) OVER (), 2) || '%' AS percentage_share
FROM sales_transactions
GROUP BY category
ORDER BY Units_sold DESC;
```
3.**Top Products by Revenue**: Identifies the top 10 products generating the highest revenue.
```sql
SELECT product_name,SUM(net_amount) AS revenue 
FROM sales_transactions
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;
```
### Transaction & Basket Analysis
4.**Average Transaction Value (ATV)**: Measures the average revenue generated per transaction.
```sql
SELECT 
    SUM(net_amount) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    ROUND(SUM(net_amount)*1.0/COUNT(DISTINCT transaction_id),2) AS avg_transaction_value
FROM sales_transactions;
```
5.**Average Basket Size**: Calculates the average number of items purchased per transaction.
```sql
SELECT 
	SUM(quantity) AS total_item_sold,
	COUNT(DISTINCT transaction_id) AS total_transactions,
	round(SUM(quantity)*1.0/COUNT(DISTINCT(transaction_id)),1) AS avg_basket_size 
FROM sales_transactions;
```
6.**Payment Method Distribution**: Shows how different payment methods contribute to total transactions and revenue.
```SQL
SELECT 
  payment_method, 
  COUNT(line_item_id) AS usage, 
  SUM(net_amount) AS total_revenue, 
  ROUND(SUM(net_amount)* 100.0/SUM(SUM(net_amount)) OVE(),2) || '%' AS Usage_Percentage 
FROM sales_transactions 
GROUP BY payment_method 
order by usage desc;
```
7.**Cashier & Operations**: Evaluates cashier performance based on the number of items processed and their contribution percentage.
```sql
SELECT
  cashier_id,
  COUNT(line_item_id) AS Units_processed,
  ROUND(COUNT(line_item_id)*100.0/SUM(COUNT(line_item_id)) OVER (),2) || '%' AS Units_Processed_Percentage
FROM sales_transactions
GROUP BY cashier_id;
```
## Findings

- **Revenue Insights:** Identified top-performing product categories contributing the highest share of total sales.
- **Sales Trends:** Analyzed monthly revenue patterns to highlight peak periods and seasonal demand.
- **Customer Behavior:** Evaluated average transaction value and basket size to understand purchasing habits.
- **Operational Efficiency:** Assessed payment methods and cashier performance to optimize transaction flow.
- **Data Quality:** Utilized a clean, complete dataset to ensure accurate and reliable analysis..

## **Report**
This repository also includes a detailed and well-documented report with deeper insights and explanations.

👉 [View Full Report](./Retail_Sales_Analysis_Report.pdf)

I’ve attached screenshots of the report for quick reference—feel free to check them out for a better understanding of the analysis and findings.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d8ca54f3-3198-46a8-850f-b63a7ec5ba4c" width="750" height="425"><br>
  <em>Dataset Overview Snapshot</em>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/d1b8c111-57f7-4cca-9cbd-e4ad2d26d23a" width="750" height="425"><br>
  <em>Monthly Revenue Trend Snapshot</em>
</p>


<p align="center">
  <img src="https://github.com/user-attachments/assets/f37ac6c3-9d70-4ef0-b988-31f4cf3cc151" width="750" height="425"><br>
  <em>Category Performance Snapshot</em>
</p>

## 📌 Using This Dataset

If you would like to use this dataset and project for your own learning or analysis, feel free to do so. Kindly follow the steps below:

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `Retail_Sales_Analysis.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `Retail_Sales_Analysis.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

