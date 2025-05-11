create database employee_db;
Use employee_db;
-- Drop existing tables (if re-running script)
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Create departments table
CREATE TABLE departments (
    department_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (department_id)
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT UNSIGNED,
    hire_date DATE,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create salaries table with correct foreign key data type
CREATE TABLE salaries (
    salary_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    employee_id INT UNSIGNED,
    salary DECIMAL(10,2),
    effective_from DATE,
    PRIMARY KEY (salary_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);



INSERT INTO departments (department_name) VALUES
('HR'),
('Finance'),
('Engineering'),
('Marketing');

INSERT INTO employees (first_name, last_name, department_id, hire_date) VALUES
('Alice', 'Johnson', 1, '2021-01-10'),
('Bob', 'Smith', 2, '2020-05-23'),
('Charlie', 'Lee', 3, '2019-11-03'),
('Dana', 'White', 3, '2022-07-15'),
('Eve', 'Davis', 4, '2021-08-01');

INSERT INTO salaries (employee_id, salary, effective_from) VALUES
(1, 60000, '2023-01-01'),
(2, 75000, '2023-01-01'),
(3, 90000, '2023-01-01'),
(4, 95000, '2023-01-01'),
(5, 70000, '2023-01-01');


#  List Employees by Department
SELECT 
    d.department_name, 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
ORDER BY 
    d.department_name;

# Highest-Paid Employee per Department
SELECT 
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    s.salary
FROM 
    salaries s
JOIN 
    employees e ON s.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    (e.department_id, s.salary) IN (
        SELECT e2.department_id, MAX(s2.salary)
        FROM employees e2
        JOIN salaries s2 ON e2.employee_id = s2.employee_id
        GROUP BY e2.department_id
    );


# Total Headcount by Department

SELECT 
    d.department_name, 
    COUNT(e.employee_id) AS total_employees
FROM 
    departments d
LEFT JOIN 
    employees e ON d.department_id = e.department_id
GROUP BY 
    d.department_name
ORDER BY 
    total_employees DESC;

# Employees hired in the last 6 months
SELECT 
    CONCAT(first_name, ' ', last_name) AS employee_name,
    hire_date
FROM 
    employees
WHERE 
    hire_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY 
    hire_date DESC;

# Average salary by department
SELECT 
    d.department_name,
    ROUND(AVG(s.salary), 2) AS avg_salary
FROM 
    departments d
JOIN 
    employees e ON d.department_id = e.department_id
JOIN 
    salaries s ON e.employee_id = s.employee_id
GROUP BY 
    d.department_name
ORDER BY 
    avg_salary DESC;
#  List employees without salaries
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM 
    employees e
LEFT JOIN 
    salaries s ON e.employee_id = s.employee_id
WHERE 
    s.salary IS NULL;
    

