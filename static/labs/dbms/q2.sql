DROP DATABASE IF EXISTS EmployeeDB;
CREATE DATABASE employeeDB;
USE employeeDB;

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO Employee VALUES
(1, 'Jim', 'Road 1', 'Dhaka'),
(2, 'Alia', 'Road 2', 'Dhaka'),
(3, 'Bintu', 'Road 3', 'Chittagong'),
(4, 'Camelia', 'Road 4', 'Barisal'),
(5, 'Disha', 'Road 5', 'Dhaka'),
(6, 'Eva', 'Road 6', 'Sylhet'),
(7, 'Firoza', 'Road 7', 'Barisal');




CREATE TABLE Company (
    company_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(50)
);

INSERT INTO Company VALUES
('First Bank Corporation', 'Dhaka'),
('IFIC Bank Ltd.', 'Dhaka'),
('ABC Corporation', 'Chittagong'),
('Tech Solutions', 'Sylhet');



CREATE TABLE Works (
    employee_id INT,
    company_name VARCHAR(100),
    salary DECIMAL(12,2),

    PRIMARY KEY (employee_id, company_name),

    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)
        ON DELETE CASCADE,

    FOREIGN KEY (company_name)
        REFERENCES Company(company_name)
        ON DELETE CASCADE
);

INSERT INTO Works VALUES
(1, 'First Bank Corporation', 70000),
(2, 'First Bank Corporation', 65000),
(3, 'IFIC Bank Ltd.', 60000),
(4, 'IFIC Bank Ltd.', 55000),
(5, 'First Bank Corporation', 50000),
(6, 'Tech Solutions', 80000),
(7, 'ABC Corporation', 45000);



CREATE TABLE Manager (
    employee_id INT PRIMARY KEY,
    manager_name VARCHAR(50),

    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)
        ON DELETE CASCADE
);

INSERT INTO Manager VALUES
(1, 'Ms. Rahman'),
(2, 'Mrs. Rahman'),
(3, 'Ms. Karim'),
(4, 'Ms. Karim'),
(5, 'Mrs. Rahman'),
(6, 'Ms. Hasan'),
(7, 'Mrs. Ahmed');


