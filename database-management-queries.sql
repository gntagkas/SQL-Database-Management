-- Create departments table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT
);

-- Create employees table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    salary INTEGER,
    hire_date DATE,
    is_active BOOLEAN DEFAULT true,
    department_id INTEGER REFERENCES departments(id)
);

-- Insert data

INSERT INTO departments (name, location) VALUES
('IT', 'Athens'),
('HR', 'Thessaloniki');

INSERT INTO employees (first_name, last_name, salary, hire_date, department_id) VALUES
('Giorgos', 'Papas', 1500, '2022-01-01', 1),
('Maria', 'Kosta', 1700, '2021-03-15', 2),
('Kostas', 'Karras', 1200, '2023-08-20', 1);


SELECT * FROM departments;

SELECT * FROM employees;

-- Add an email column to the employees table

ALTER TABLE employees
ADD COLUMN email TEXT;

-- Change the type of salary from INTEGER to FLOAT

ALTER TABLE employees
ALTER COLUMN salary TYPE FLOAT;

-- Rename the hire_date column to started_on

ALTER TABLE employees
RENAME COLUMN hire_date to started_on;

-- Make all salaries +10%

UPDATE employees
SET salary = salary*1.1;

-- Change is_active to false for everyone before 2022

UPDATE employees
SET is_active = false
WHERE started_on <= '2021-12-31';

-- Change ‘Kostas Karras’ salary to 1800

UPDATE employees
SET salary = 1800
WHERE first_name = 'Kostas' and last_name = 'Karras'

-- Make all employees in HR department called 'TEST TEST'

UPDATE employees
SET first_name = 'test', last_name = 'test'
WHERE department_id = (
    SELECT id FROM departments
    WHERE name = 'HR'
);

-- Add new employee: Eleni Gkeka, salary 1400, hire_date = today, department_id = 1

INSERT INTO employees 
VALUES (4,'Eleni','Gkeka',1400, '2025-04-08','TRUE',1,'NULL');

-- Add 2 more departments: 'Sales' & 'Finance'

INSERT INTO departments
VALUES (3,'Sales',NULL),
(4,'Finance',NULL);

-- Add CHECK so that salary >= 1000

ALTER TABLE employees
ADD CONSTRAINT salary_check CHECK (salary >= 1000);

-- Put DEFAULT value 1000 in salary

ALTER TABLE employees
ALTER COLUMN salary SET DEFAULT 1000;

-- Make the email column UNIQUE

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- TRUNCATE the employees (deletes all rows)

TRUNCATE TABLE employees;

-- Delete the employees table completely

DROP TABLE employees;

