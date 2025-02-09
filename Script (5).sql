
----------------------------BLOCK---------------------

-- 1. Create Table


CREATE TABLE IF NOT EXISTS aiq_data_professionals (
    data_professional_name VARCHAR(100),
    gender CHAR(1),
    job_role VARCHAR(50),
    joining_date DATE,
    monthly_salary NUMERIC(10, 2)
);

--- INSERT DATA:

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


DO $$

<<data_professionals_block>>

DECLARE
    professional_count INTEGER := 0;

BEGIN
    
    SELECT COUNT(*) 
    INTO professional_count
    FROM aiq_data_professionals;
    
    RAISE NOTICE 'The number of data professionals is %', professional_count;

END data_professionals_block;

$$;


-- Dollar quoted($$) string delimiter


DO $$

BEGIN
    RAISE NOTICE 'This is first class on PL/pgSQL!';
END;

$$;



DO $$

BEGIN
    RAISE NOTICE 'It''s first class of PL/pgSQL!';
END;

$$;



DO $$
DECLARE
    v_first_name VARCHAR(50) := 'David';
    v_last_name VARCHAR(50) := 'Brown';
    v_age INT := 30;
BEGIN
    RAISE NOTICE 'Name: % %, Age: %', v_first_name, v_last_name, v_age;
END;
$$;


-- PL/pgSQL variables

DO $$
DECLARE
    counter        INTEGER := 1;
    job_title      VARCHAR(50) := 'Data Engineer';
    salary         NUMERIC := 85000;
    gender         CHAR(1) := 'M';
    dob            DATE := '1985-06-15';
BEGIN
    RAISE NOTICE 'Professional %: % earns BDT % annually, gender: %, DOB: %', 
        counter, 
        job_title, 
        salary, 
        gender, 
        dob;
END;
$$;

-- PL/pgSQL constant


DO $$
DECLARE
    pi CONSTANT NUMERIC := 3.14159;
    radius NUMERIC := 5;
    area NUMERIC;
BEGIN
    --pi := 3.50;
	area := pi * radius * radius;
    RAISE NOTICE 'The area of the circle with radius % is %', radius, area;
END;
$$;

-- PL/pgSQL SELECT INTO statement


DO $$
DECLARE
    v_name VARCHAR(50);
    v_salary     NUMERIC(11);
    v_gender     CHAR(1);
    v_job_role   VARCHAR(50);
BEGIN   
    SELECT data_professional_name, monthly_salary, gender, job_role
    INTO v_name, v_salary, v_gender, v_job_role
    FROM aiq_data_professionals
    WHERE data_professional_name = 'Bob Smith'; 
   
    RAISE NOTICE 'Name: %, Salary: %, Gender: %, DOB: %', v_name, v_salary, v_gender, v_job_role;
END;
$$;


-------------------------------- IF ---------------------

DO $$
DECLARE
    v_salary NUMERIC(11,2);
BEGIN

    SELECT monthly_salary 
    INTO v_salary 
    FROM aiq_data_professionals 
    WHERE data_professional_name = 'Alice Johnson';

    IF v_salary > 10000 THEN
        RAISE NOTICE 'The monthly salary is greater than 10000';
    END IF;
END;
$$;




DO $$
DECLARE
    v_salary NUMERIC(11,2);
BEGIN

    SELECT monthly_salary 
    INTO v_salary 
    FROM aiq_data_professionals 
    WHERE data_professional_name = 'David Brown';

    IF v_salary > 12000 THEN
        RAISE NOTICE 'The monthly salary is greater than 12000';
    ELSE
        RAISE NOTICE 'The monthly salary is 12000 or less';
    END IF;
END;
$$;




DO $$
DECLARE
    avg_month_salary NUMERIC(11,2);
BEGIN

    SELECT AVG(monthly_salary) INTO avg_month_salary FROM aiq_data_professionals;

    IF avg_month_salary > 15000 THEN
        RAISE NOTICE 'The average monthly salary of all professionals is high: % BDT', avg_month_salary;
    ELSIF avg_month_salary > 12000 THEN
        RAISE NOTICE 'The average monthly salary of all professionals is mid-tier: % BDT', avg_month_salary;
    ELSE
        RAISE NOTICE 'The average monthly salary of all professionals is low: % BDT', avg_month_salary;
    END IF;
END;
$$;


---------------------------Loop-----------------------------

DO $$
DECLARE
    counter INT := 0;
BEGIN
    LOOP
        counter := counter + 1;
        RAISE NOTICE 'Counter: %', counter;
        EXIT WHEN counter >= 10;
    END LOOP;
END;
$$;


DO $$
DECLARE
    counter INT := 0;
BEGIN
    WHILE counter < 10 LOOP
        counter := counter + 1;
        RAISE NOTICE 'Counter: %', counter;
    END LOOP;
END;
$$;



--Simple Forward Loop

DO $$
BEGIN
    FOR loop_counter IN 1..10 LOOP
        RAISE NOTICE 'Counter: %', loop_counter;
    END LOOP;
END;
$$;

--Simple Reverse Loop

DO $$
BEGIN
    FOR loop_counter IN REVERSE 10..1 LOOP
        RAISE NOTICE 'Counter: %', loop_counter;
    END LOOP;
END;
$$;


--Loop with Step Value

DO $$
BEGIN
    FOR loop_counter IN 1..10 BY 2 LOOP
        RAISE NOTICE 'Counter: %', loop_counter;
    END LOOP;
END;
$$;


--Loop with Reverse and Step Value

DO $$
BEGIN
    FOR loop_counter IN REVERSE 10..1 BY 2 LOOP
        RAISE NOTICE 'Counter: %', loop_counter;
    END LOOP;
END;
$$;


DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT data_professional_name, job_role, monthly_salary
        FROM aiq_data_professionals
    LOOP
        RAISE NOTICE 'Name: %, Job Role: %, Salary: %', rec.data_professional_name, rec.job_role, rec. monthly_salary;
    END LOOP;
END;
$$;



DO $$ 
DECLARE
    cnt_gender RECORD;
    male_count INT := 0;
    female_count INT := 0;
BEGIN
    FOR cnt_gender IN
        SELECT * FROM aiq_data_professionals
    LOOP
        IF cnt_gender.gender = 'M' THEN
            male_count := male_count + 1;
        ELSIF cnt_gender.gender = 'F' THEN
            female_count := female_count + 1;
        END IF;
    END LOOP;
    RAISE NOTICE 'Male Professionals: %, Female Professionals: %', male_count, female_count;
END;
$$;

