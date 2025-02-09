-- 1. Create Table


CREATE TABLE IF NOT EXISTS  data_professionals (
    employee_name VARCHAR(100),
    job_role VARCHAR(50),
    department VARCHAR(50),
    joining_date DATE,
    gender CHAR(1)
);

CREATE TABLE  IF NOT EXISTS  salary_history (
    employee_name VARCHAR(100),
    salary NUMERIC(10, 2),
    effective_date DATE
);


CREATE TABLE IF NOT EXISTS aiq_data_professionals (
    data_professional_name VARCHAR(100),
    gender CHAR(1),
    job_role VARCHAR(50),
    joining_date DATE,
    monthly_salary NUMERIC(10, 2)
);

--- INSERT DATA:

delete from aiq_data_professionals 

INSERT INTO aiq_data_professionals (data_professional_name, gender, job_role, joining_date, monthly_salary) VALUES 
('Alice Johnson', 'F', 'Data Engineer', '2023-01-10', 12000.00),
('Bob Smith', 'M', 'Data Engineer', '2023-02-12', 15000.00),
('Carol White', 'F', 'ML Engineer', '2023-03-14', 8000.00),
('David Brown', 'M', 'Data Analyst', '2023-04-15', 7000.00),
('Eve Davis', 'F', 'Data Engineer', '2023-05-18', 13000.00),
('Frank Wilson', 'M', 'Data Engineer', '2023-06-20', 14000.00),
('Grace Martinez', 'F', 'Data Analyst', '2023-07-22', 16000.00),
('Henry Anderson', 'M', 'Data Analyst', '2023-08-25', 4000.00),
('Ivy Thomas', 'F', 'Data Engineer', '2023-09-27', 13500.00),
('Jack Moore', 'M', 'Data Scientist', '2023-10-29', 17000.00),
('Kathy Taylor', 'F', 'ML Engineer', '2023-11-01', 17500.00),
('Leo Harris', 'M', 'Data Analyst', '2023-12-03', 14500.00),
('Mia Clark', 'F', 'Data Engineer', '2024-01-05', 15500.00),
('Nate Lewis', 'M', 'Data Scientist', '2024-02-07', 16500.00),
('Olivia Lee', 'F', 'Data Analyst', '2024-03-09', 18500.00),
('Paul Walker', 'M', 'Data Analyst', '2024-04-11', 11500.00),
('Quinn Hall', 'F', 'Data Engineer', '2024-05-13', 4000.00),
('Ryan Young', 'M', 'Data Engineer', '2024-06-15', 13500.00),
('Sophia King', 'F', 'ML Engineer', '2024-07-17', 4500.00),
('Tom Scott', 'M', 'Data Analyst', '2024-08-19', 15500.00);


select *
from aiq_data_professionals;



INSERT INTO data_professionals (employee_name, job_role, department, joining_date, gender) VALUES
('John Doe', 'Data Scientist', 'Engineering', '2020-01-15', 'M'),
('Jane Smith', 'Software Engineer', 'Engineering', '2019-05-20', 'F'),
('Emily Brown', 'Data Analyst', 'Operations', '2021-03-10', 'F'),
('Mark Johnson', 'Consultant', 'Engineering', '2018-11-05', 'M');


INSERT INTO salary_history (employee_name, salary, effective_date) VALUES
('John Doe', 80000.00, '2024-01-01'),
('Jane Smith', 75000.00, '2024-01-01'),
('Emily Brown', 70000.00, '2024-01-01'),
('Chris Lee', 90000.00, '2023-12-01'),
('Patricia Wong', 85000.00, '2023-06-01');


SELECT *
FROM data_professionals;

SELECT *
FROM salary_history;

--------------------------------------------------------- JOINS ---------------------------

SELECT 
    dp.employee_name,
    dp.job_role,
    dp.department,
    dp.joining_date,
    dp.gender,
    sh.salary,
    sh.effective_date
FROM 
    data_professionals dp
INNER JOIN 
    salary_history sh ON dp.employee_name = sh.employee_name;



SELECT 
    dp.employee_name,
    dp.job_role,
    dp.department,
    dp.joining_date,
    dp.gender,
    sh.salary,
    sh.effective_date
FROM 
    data_professionals dp
LEFT JOIN 
    salary_history sh ON dp.employee_name = sh.employee_name;


SELECT 
    dp.employee_name,
    dp.job_role,
    dp.department,
    dp.joining_date,
    dp.gender,
    sh.salary,
    sh.effective_date
FROM 
    data_professionals dp
RIGHT JOIN 
    salary_history sh ON dp.employee_name = sh.employee_name;


SELECT 
    dp.employee_name,
    dp.job_role,
    dp.department,
    dp.joining_date,
    dp.gender,
    sh.salary,
    sh.effective_date
FROM 
    data_professionals dp
FULL OUTER JOIN 
    salary_history sh ON dp.employee_name = sh.employee_name;



--------------------------------------------------------- ALIAS ---------------------------

SELECT 
    dp.employee_name,
    dp.job_role,
    dp.department,
    dp.joining_date,
    dp.gender
FROM 
    data_professionals AS dp;

--------------------------------------------------------- MERGE ---------------------------

CREATE TABLE temp_customers(
    name VARCHAR(255),
    gender char(1),
    email VARCHAR(255),
	address VARCHAR(255),
	dob date
);


CREATE TABLE customers(
    customer_id SERIAL,
    name VARCHAR(255) NOT NULL,
    gender char(1),   
    email VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255),
	dob date
);



--- First, insert rows into the temp_customers table:

INSERT INTO temp_customers
VALUES
   ('Smith','M','david.smith@gmail.com','123 Maple Street','1990-05-25'),
   ('Robert Johnson','M', 'robert.johnson@example.com','456 Oak Avenue','1988-03-01'),
   ('Olivia','F','olivia.robert@example.com','789 Pine Road','1995-11-20');

select *
from temp_customers;


-- Second, insert rows from the temp_customers table into the customers table using the MERGE statement:

MERGE INTO customers c
USING temp_customers t ON c.email = t.email
WHEN NOT MATCHED THEN 
   INSERT (name,gender,email,address,dob)
   VALUES(t.name,t.gender,t.email,t.address,t.dob);



SELECT * FROM customers;


-- MERGE statement to update and insert rows from the source table into the table

-- First, insert a new row into the temp_customers table and update the name:

INSERT into temp_customers
values ('Michael Brown','M','michael@gmail.com','101 Birch Boulevard','1985-06-02');
	
UPDATE temp_customers
SET name = 'David Smith'
WHERE email='david.smith@gmail.com';

SELECT * FROM temp_customers;


-- Add the new row from temp_customers table to the customers table and update the name for the updated row:

MERGE INTO customers c
USING temp_customers t ON c.email = t.email
WHEN NOT MATCHED THEN 
   INSERT (name,gender,email,address,dob)
   VALUES(t.name,t.gender,t.email,t.address,t.dob)
WHEN MATCHED THEN
   UPDATE SET 
      name = t.name;

----------------------------------------------------------------------- CASE ------------------------------------------------

SELECT data_professional_name,gender,job_role,joining_date,monthly_salary,
    CASE
        WHEN monthly_salary >= 10000 THEN 'High Salary'
        WHEN monthly_salary >= 5000 AND monthly_salary < 10000 THEN 'Medium Salary'
        ELSE 'Low Salary' END AS salary_category
FROM aiq_data_professionals;


SELECT job_role,
    SUM(CASE WHEN monthly_salary >= 10000 THEN 1 ELSE 0 END) AS high_salary_count,
    SUM(CASE WHEN monthly_salary >= 5000 AND monthly_salary < 10000 THEN 1 ELSE 0 END) AS medium_salary_count,
    SUM(CASE WHEN monthly_salary < 5000 THEN 1 ELSE 0 END) AS low_salary_count
FROM aiq_data_professionals
GROUP BY job_role;


----------------------------------------------------------------------- VIEWS ------------------------------------------------

CREATE OR REPLACE VIEW vw_data_professionals AS
SELECT data_professional_name, gender, joining_date, job_role, monthly_salary
FROM aiq_data_professionals
WHERE monthly_salary <= 12000;

SELECT *
FROM vw_data_professionals;


UPDATE vw_data_professionals
SET monthly_salary=monthly_salary*1.05
WHERE job_role = 'Data Engineer';


SELECT *
FROM vw_data_professionals;



CREATE OR REPLACE VIEW vw_professional_salary AS
SELECT dp.employee_name,dp.job_role,dp.department,dp.joining_date,dp.gender,sh.salary,sh.effective_date
FROM data_professionals dp
INNER JOIN salary_history sh ON dp.employee_name = sh.employee_name
WHERE dp.department = 'Engineering'; 


UPDATE vw_professional_salary
SET salary = 90000
WHERE employee_name = 'John Doe';


--------------------------------------- ALTER TABLE -------------------------

--Adding a single column:

ALTER TABLE aiq_data_professionals 
ADD COLUMN date_of_birth DATE;


--Adding multiple columns:

ALTER TABLE aiq_data_professionals
ADD COLUMN email VARCHAR(100),
ADD COLUMN phone_number VARCHAR(20),
ADD COLUMN address TEXT;


--Rename column:

ALTER TABLE aiq_data_professionals 
RENAME COLUMN email TO email_address;


--Drop a column:

ALTER TABLE aiq_data_professionals 
DROP COLUMN date_of_birth;

--Rename table:

ALTER TABLE aiq_data_professionals
RENAME TO aiq_data_professionals_info;


-- Table data removal 

DELETE FROM aiq_data_professionals_info;

TRUNCATE TABLE aiq_data_professionals_info;


-- DROP TABLE

DROP TABLE aiq_data_professionals;

DROP TABLE IF EXISTS aiq_data_professionals;

DROP TABLE IF EXISTS aiq_data_professionals_info;
