--CREATE TABLE statement example

CREATE TABLE IF NOT EXISTS aiquest_data_engr_students(
    student_id INT,
    student_name VARCHAR(50) NOT NULL,
    mobile_no VARCHAR(50),
    email_id VARCHAR(50)  UNIQUE NOT NULL,
    gender CHAR(1),
    enrollment_date DATE,
    student_age INT
);

-- Insert data into table

INSERT INTO aiquest_data_engr_students (student_id,student_name,mobile_no,email_id,gender,enrollment_date,student_age)
VALUES(101,'David','01711123456' ,'david@gmail.com','M', '2024-05-21',25);

INSERT INTO aiquest_data_engr_students 
VALUES(102,'John','01911123456','John@gmail.com','M', '2024-05-25',30);

INSERT INTO aiquest_data_engr_students(student_id,student_name,email_id,enrollment_date,student_age)
VALUES(103,'Smith','smith@gmail.com','2024-05-21',35);

INSERT INTO aiquest_data_engr_students (student_id, student_name, mobile_no, email_id, gender, enrollment_date, student_age)
VALUES (104, 'Michael Brown', '01811123456', 'michael@example.com', 'M', '2024-06-23', 21);

INSERT INTO aiquest_data_engr_students (student_id, student_name, mobile_no, email_id, gender, enrollment_date, student_age)
VALUES (105, 'Emily Davis', '01511123456', 'emily@example.com', 'F', '2024-06-24', 24);

-- Select data from table

SELECT student_name 
FROM aiquest_data_engr_students;

SELECT student_name,mobile_no,email_id,enrollment_date
FROM aiquest_data_engr_students;

SELECT * 
FROM aiquest_data_engr_students;

SELECT * 
FROM aiquest_data_engr_students
WHERE student_id = 101;

SELECT NOW();

-- Update data in table

-- 1:
UPDATE aiquest_data_engr_students
SET email_id = 'john.williams@gmail.com'
WHERE student_id = 102;

-- 2:
UPDATE aiquest_data_engr_students
SET student_name='Smith Taylor',
       email_id = 'smith.taylor@gmail.com',
       gender = 'M'
WHERE student_name = 'Smith';

-- Delete data from table

-- 1:
DELETE FROM aiquest_data_engr_students
WHERE student_id=101;


-- 2:
DELETE FROM aiquest_data_engr_students
WHERE student_id IN (102,103);

-- 3: 
DELETE FROM aiquest_data_engr_students;
