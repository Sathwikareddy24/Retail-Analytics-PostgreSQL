SECTION 1: DATABASE SCHEMA 

-- 1. Products Table (Dimension)
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

-- 2. Stores Table (Dimension)
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    region VARCHAR(50), -- e.g., North, South, West
    manager_name VARCHAR(100)
);

-- 3. Sales Transactions (Fact Table - The 300k+ row table)
CREATE TABLE sales_transactions (
    transaction_id SERIAL PRIMARY KEY,
    transaction_date DATE,
    product_id INT REFERENCES products(product_id),
    store_id INT REFERENCES stores(store_id),
    qunatity_sold INT,
    total_amount DECIMAL(12, 2),
    customer_segment VARCHAR(50),
    checkout_status VARCHAR(20) -- e.g., 'Completed', 'Dropped'
);


SECTION 2: SAMPLE DATA POPULATION 

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(101, 'Pro Laptop 15', 'Electronics', 1200.00),
(102, 'Wireless Mouse', 'Electronics', 25.00),
(103, 'Ergonomic Chair', 'Furniture', 250.00),
(104, 'Desk Lamp', 'Furniture', 45.00),
(105, 'USB-C Hub', 'Electronics', 60.00);


INSERT INTO stores (store_id, store_name, region, manager_name) VALUES
(1, 'Downtown Tech', 'North', 'Alice Smith'),
(2, 'Suburban Living', 'South', 'Bob Jones'),
(3, 'City Center', 'West', 'Charlie Brown');


INSERT INTO sales_transactions (transaction_date, product_id, store_id, qunatity_sold, total_amount, customer_segment, checkout_status) VALUES
('2026-01-01', 101, 1, 1, 1200.00, 'Corporate', 'Completed'),
('2026-01-02', 102, 1, 2, 50.00, 'Consumer', 'Completed'),
('2026-01-02', 101, 2, 0, 0.00, 'Consumer', 'Dropped'), 
('2026-01-03', 103, 3, 1, 250.00, 'Corporate', 'Completed'),
('2026-01-04', 105, 1, 5, 300.00, 'Small Business', 'Completed'),
('2026-01-05', 101, 3, 0, 0.00, 'Consumer', 'Dropped'), 
('2026-01-05', 104, 2, 3, 135.00, 'Consumer', 'Completed');


SECTION 3: ANALYTICAL QUERIES 

Query 1: Total Revenue per Product
Goal: Which product is making the most money?


SELECT 
    p.product_name, 
    SUM(t.total_amount) AS total_revenue
FROM sales_transactions t
JOIN products p ON t.product_id = p.product_id
WHERE t.checkout_status = 'Completed'
GROUP BY p.product_name
ORDER BY total_revenue DESC;


Query 2: Transaction Count by Store
Goal: Which store is the busiest?


SELECT 
    s.store_name, 
    COUNT(t.transaction_id) AS total_transactions
FROM sales_transactions t
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_name;


Query 3: Calculating the Checkout Drop-off Rate
Goal: What percentage of people are leaving without buying?


SELECT 
    checkout_status, 
    COUNT(*) AS total_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM sales_transactions
GROUP BY checkout_status;


Query 4: Identifying "High Value" Customers
Goal: Who are the corporate clients spending a lot?


SELECT 
    customer_segment, 
    AVG(total_amount) AS avg_order_value
FROM sales_transactions
WHERE checkout_status = 'Completed'
GROUP BY customer_segment
HAVING AVG(total_amount) > 100;


Query 5: Revenue Contribution by Category
Goal: Which department (Electronics vs. Furniture) brings in the most money?



SELECT 
    p.category, 
    SUM(t.total_amount) AS category_revenue,
    ROUND(SUM(t.total_amount) * 100.0 / SUM(SUM(t.total_amount)) OVER(), 2) AS contribution_pct
FROM sales_transactions t
JOIN products p ON t.product_id = p.product_id
WHERE t.checkout_status = 'Completed'
GROUP BY p.category;



Query 6: Finding the "Most Abandoned" Product
Goal: Is there a specific product that people keep dropping from their carts?


SELECT 
    p.product_name, 
    COUNT(*) AS times_dropped
FROM sales_transactions t
JOIN products p ON t.product_id = p.product_id
WHERE t.checkout_status = 'Dropped'
GROUP BY p.product_name
ORDER BY times_dropped DESC;



Query 7: Store Performance Ranking
Goal: Use a "Window Function"  to rank stores by revenue.



SELECT 
    s.store_name, 
    s.region,
    SUM(t.total_amount) AS revenue,
    RANK() OVER (ORDER BY SUM(t.total_amount) DESC) as revenue_rank
FROM sales_transactions t
JOIN stores s ON t.store_id = s.store_id
WHERE t.checkout_status = 'Completed'
GROUP BY s.store_name, s.region;


Query 8: Daily Sales Trend
Goal: How much did we sell each day? (Demonstrates Time-Series analysis).


SELECT 
    transaction_date, 
    COUNT(transaction_id) AS daily_transactions,
    SUM(total_amount) AS daily_revenue
FROM sales_transactions
WHERE checkout_status = 'Completed'
GROUP BY transaction_date
ORDER BY transaction_date;
