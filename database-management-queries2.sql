-- Create departments table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    department_name TEXT NOT NULL
);

INSERT INTO departments (department_name) 
VALUES
('Sales'),
('Marketing'),
('HR'),
('IT'),
('Finance');

SELECT * FROM departments;

-- Create employees table
CREATE TABLE informations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    date DATE,
    is_active BOOLEAN DEFAULT true,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO informations (name, salary, department_id, date, is_active) 
VALUES
('Γιάννης Παπαδόπουλος', 1800, 1, '2020-03-15', true),
('Ελένη Αλεξίου', 2500, 2, '2019-11-25', true),
('Αλέξανδρος Σταυρόπουλος', 1500, 3, '2021-05-10', true),
('Μαρία Καραγιάννη', 1200, 1, '2020-06-20', true),
('Δημήτρης Πέτρου', 2200, 4, '2018-07-30', true),
('Κωνσταντίνος Ιωαννίδης', 2000, 5, '2021-01-10', false),
('Αννα Βασιλείου', 1800, 2, '2019-02-10', true);

SELECT * FROM informations;

-- Create projects table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    expenses DECIMAL(15, 2) NOT NULL,
    start_date DATE,
    end_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO projects (name, expenses, start_date, end_date, department_id) 
VALUES
('Project Alpha', 50000, '2021-02-01', '2022-02-01', 1),
('Project Beta', 35000, '2020-07-01', '2021-07-01', 2),
('Project Gamma', 40000, '2020-10-01', '2021-10-01', 3),
('Project Delta', 60000, '2019-11-01', '2021-05-01', 4),
('Project Epsilon', 45000, '2021-03-01', '2022-03-01', 5);

SELECT * FROM projects;

---------------------------------------------------------------------

-- Change table name 'informations' to 'employees'.

ALTER TABLE informations
RENAME to employees;

-- Change column name 'date' to 'hire_data' of table informations.

ALTER TABLE employees
RENAME COLUMN date to hire_date;

-- Change column name 'expenses' to 'budget' of table projects.

ALTER TABLE projects
RENAME COLUMN expenses to budget;

-- Insert an empty column 'Success' (boolean) with a set default TRUE in projects table.

ALTER TABLE projects
ADD COLUMN Success BOOLEAN DEFAULT TRUE;

-- Insert an email column in employes with default emails: 'company1@email.com'

ALTER TABLE employees
ADD COLUMN email TEXT DEFAULT 'company1@email.com';

-- Insert a new NUMERIC columnn 'upgraded_budget' in projects table. For new column budget went up 10k in all projects.

ALTER TABLE projects
ADD COLUMN upgraded_budget NUMERIC;

UPDATE projects
SET upgraded_budget = budget + 10000;

SELECT * FROM projects;

-- Change the type of 'salary' to Numeric.

ALTER TABLE employees
ALTER COLUMN salary TYPE Numeric;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'employees'
AND column_name = 'salary';

-- Delete column 'end_date' in projects table.

ALTER TABLE projects
DROP COLUMN end_date;

-- Increase all the wages by 15%.

UPDATE employees
SET salary = salary*1.15;

-- Add new employee named ‘John Papadopoulos’, salary 1800€, hired today.

INSERT INTO employees
VALUES
(8,'John Papadopoulos',1800,NULL,'2025-04-09',TRUE);

SELECT *
FROM employees;

-- Change the salary of employee ‘Eleni Alexiou’ to 2500€.

UPDATE employees
SET salary = '2500'
WHERE name = 'Eleni Alexiou';

-- Rename the department 'Marketing' to 'Communications'.

UPDATE departments
SET department_name = 'Communications'
WHERE department_name = 'Marketing'

SELECT * FROM departments;

-- Create a new table ('projects_informations') with only name, and upgraded budget columns from projects table.

CREATE TABLE projects_informations (
    name TEXT,
    upgraded_budget NUMERIC
);

INSERT INTO projects_informations
SELECT 
    name,
    upgraded_budget
FROM projects;

SELECT * FROM projects_informations;

-- Delete only the data observations of projects_informations table

TRUNCATE TABLE projects_informations;

SELECT * FROM projects_informations;

-- Delete the table too.

DROP TABLE projects_informations;

-- Add a check for salary over 1200$

ALTER TABLE employees
ADD CONSTRAINT salary_check CHECK (salary>1200);

-- Make a table 'archived_employees' and put the non-active ones there.

CREATE TABLE archived_employees (
    id INT,
    name TEXT,
    salary NUMERIC,
    department_id INT,
    hire_date DATE,
    is_active BOOLEAN
);

INSERT INTO archived_employees
SELECT
    id,
    name,
    salary,
    department_id,
    hire_date,
    is_active
FROM employees
WHERE is_active = FALSE;

SELECT * FROM archived_employees;

-- Add constraint so that salary is never below 700.

ALTER TABLE employees
ADD CONSTRAINT salary check (salary>700);

-- Delete all projects with budget lower than 40k

DELETE FROM projects
WHERE budget <= 40000;

SELECT * FROM projects;

-- Delete all employes who arent active.

DELETE FROM employees
WHERE is_active = FALSE
RETURNING*;

-- Delete success column from projects.

ALTER TABLE projects
DROP COLUMN success;

-- Delete all data in projects table.

TRUNCATE TABLE projects;

