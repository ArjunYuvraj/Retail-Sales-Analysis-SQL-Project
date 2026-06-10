--Database Setup

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


--Data Cleaning

select
	count(*) as total_rows,   
	count(distinct(transaction_id)) as total_transactions,
	count(distinct(category)) as total_categories 	
from sales_transactions;

SELECT *
FROM sales_transactions
WHERE line_item_id IS NULL
   OR transaction_id IS NULL OR sale_date IS NULL
   OR customer_id IS NULL OR loyalty_member IS NULL
   OR product_id IS NULL OR product_name IS NULL
   OR category IS NULL OR brand IS NULL
   OR unit_price IS NULL OR quantity IS NULL
   OR line_total IS NULL OR discount_applied IS NULL
   OR net_amount IS NULL OR payment_method IS NULL
   OR cashier_id IS NULL;


delete from sales_transactions
WHERE line_item_id IS NULL
   OR transaction_id IS NULL OR sale_date IS NULL
   OR customer_id IS NULL OR loyalty_member IS NULL
   OR product_id IS NULL OR product_name IS NULL
   OR category IS NULL OR brand IS NULL
   OR unit_price IS NULL OR quantity IS NULL
   OR line_total IS NULL OR discount_applied IS NULL
   OR net_amount IS NULL OR payment_method IS NULL
   OR cashier_id IS NULL;


-- Sales Data Exploration

-- Total Line items listed.
select Count(*) as Total_lineitems from sales_transactions ;

-- Total Unique Transactions Occured.
SELECT COUNT(DISTINCT(transaction_id)) as Total_transactions from sales_transactions ;

-- Total Unique Category. 
SELECT COUNT(DISTINCT(category)) as Total_Category from sales_transactions ; 

-- Total Products listed.
SELECT COUNT(DISTINCT(Product_name)) as Total_Products from sales_transactions ; 

-- Total Net Revenue.
select sum(net_amount) as total_net_revenue from sales_transactions;

-- Average Transaction value.
select avg(net_amount) as Average_net_revenue from sales_transactions;





--Sales Data Analysis

--Monthly Revenue Analysis
SELECT 
    TO_CHAR(sale_date, 'Month') AS month_name,
    SUM(net_amount) AS total_sales
FROM sales_transactions
GROUP BY month_name
ORDER BY MIN(sale_date);

--Categorical Performance

SELECT 
    category,
	COUNT(line_item_id) as units_sold,
    ROUND(
        COUNT(line_item_id) * 100.0 / SUM(COUNT(line_item_id)) OVER (), 
        2
    ) || '%' AS percentage_share
FROM sales_transactions
GROUP BY category
ORDER BY Units_sold DESC;

-- TOP 10 Products by revenue

SELECT product_name,SUM(net_amount) AS revenue 
FROM sales_transactions
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;


--Transaction & Basket Analysis

-- Average Transaction Value

SELECT 
    SUM(net_amount) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    ROUND(SUM(net_amount)*1.0/COUNT(DISTINCT transaction_id),2) AS avg_transaction_value
FROM sales_transactions;

--Average Basket Size

SELECT 
	SUM(quantity) AS total_item_sold,
	COUNT(DISTINCT transaction_id) AS total_transactions,
	round(SUM(quantity)*1.0/COUNT(DISTINCT(transaction_id)),1) AS avg_basket_size 
FROM sales_transactions;

--Payment Method Distribution

SELECT 
	payment_method, COUNT(line_item_id) AS USAGE,
	SUM(net_amount) AS total_revenue , 
	ROUND(SUM(net_amount)*100.0/SUM(SUM(net_amount)) OVER (), 2) || '%' AS Usage_Percentage
FROM sales_transactions
GROUP BY payment_method
order by usage desc;


--Cashier & Operations

select cashier_id, count(line_item_id) as Units_processed ,
ROUND(
        count(line_item_id) * 100.0 / SUM(count(line_item_id)) OVER (), 
        2) || '%' AS Units_Processed_Percentage
from sales_transactions
group by cashier_id;
