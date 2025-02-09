CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    region VARCHAR(50),
    sales_person VARCHAR(50),
    sale_date DATE,
    amount NUMERIC
);


INSERT INTO sales (region, sales_person, sale_date, amount) VALUES
('North', 'Alice', '2023-11-01', 500),
('North', 'Alice', '2023-11-02', 700),
('North', 'Alice', '2023-11-03', 300),
('North', 'Bob', '2023-11-01', 400),
('North', 'Bob', '2023-11-02', 600),
('North', 'Bob', '2023-11-03', 800),
('South', 'Charlie', '2023-11-01', 200),
('South', 'Charlie', '2023-11-02', 300),
('South', 'Charlie', '2023-11-03', 500),
('South', 'David', '2023-11-01', 400),
('South', 'David', '2023-11-02', 100),
('South', 'David', '2023-11-03', 200),
('East', 'Emma', '2023-11-01', 300),
('East', 'Emma', '2023-11-02', 600),
('East', 'Emma', '2023-11-03', 700),
('East', 'Frank', '2023-11-01', 200),
('East', 'Frank', '2023-11-02', 500),
('East', 'Frank', '2023-11-03', 600),
('West', 'Grace', '2023-11-01', 700),
('West', 'Grace', '2023-11-02', 800),
('West', 'Grace', '2023-11-03', 800),
('West', 'Grace', '2023-11-05', 900);


SELECT 
    id,
    region,
    sales_person,
    sale_date,
    amount,
    SUM(amount) OVER (PARTITION BY sales_person ORDER BY sale_date) AS running_total
FROM 
    sales
ORDER BY 
    sales_person, sale_date;


-- Example of ROW_NUMBER():

SELECT 
    id,
    region,
    sales_person,
    sale_date,
    amount,
    ROW_NUMBER() OVER (PARTITION BY sales_person ORDER BY amount DESC) AS row_number
FROM 
    sales
ORDER BY 
    sales_person, row_number;


SELECT *
FROM (
    SELECT
        id,
        sales_person,
        amount,
        sale_date,
        ROW_NUMBER() OVER(PARTITION BY sales_person ORDER BY amount DESC) AS row_num
    FROM sales
) AS ranked_sales
WHERE row_num = 1;	
	
-- Example of RANK():

SELECT 
    id,
    region,
    sales_person,
    sale_date,
    amount,
    RANK() OVER (PARTITION BY sales_person ORDER BY amount DESC) AS rank
FROM 
    sales
ORDER BY 
    sales_person, rank;
	

-- Example of DENSE_RANK(): 

SELECT 
    id,
    region,
    sales_person,
    sale_date,
    amount,
    DENSE_RANK() OVER (PARTITION BY sales_person ORDER BY amount DESC) AS dense_rank
FROM 
    sales
ORDER BY 
    sales_person, dense_rank;
	
	

