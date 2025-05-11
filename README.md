🧑‍💼 Employee Management System (SQL)

A simple HR-oriented database project designed using MySQL/PostgreSQL. This system includes normalized relational tables and commonly used HR queries for efficient data analysis and reporting.

📁 Files Included

`employee_management.sql`: SQL script to create the database schema, insert sample data, and run queries.

📊 Schema Design

Three normalized tables:
`departments`: Stores department information.
`employees`: Stores employee information and foreign key to department.
`salaries`: Stores salary details with effective dates linked to employees.

Entity Relationship Diagram (ERD)


departments
  └── department_id (PK)

  └── department_name

employees

  └── employee_id (PK)

  └── first_name

  └── last_name

  └── department_id (FK)

  └── hire_date

salaries

  └── salary_id (PK)

  └── employee_id (FK)

  └── salary

  └── effective_from

🛠 Setup Instructions

1. Clone the Repository

git clone https://github.com/yourusername/employee-management-sql.git
cd employee-management-sql


2. Load into MySQL or PostgreSQL
mysql -u your_username -p < employee_management.sql

Or open it in MySQL Workbench / pgAdmin and execute the statements.

🔍 Sample Queries Included

List employees by department
Find highest-paid employee per department
Count total employees per department
List employees hired in the last 6 months
Average salary by department
List employees without salaries

📤 Export Data to CSV

To export employees to CSV from MySQL:

SELECT * 
INTO OUTFILE '/var/lib/mysql-files/employees.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM employees;


📄 License

This project is open-source and free to use for educational purposes.

👤 Developed by [Ankit Chauhan]  
🌐 GitHub: [yourusername](https://github.com/singhshaab-ankit)
