CREATE DATABASE employee_q4;
USE employee_q4;

CREATE TABLE Employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Company (
    company_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE Works (
    employee_name VARCHAR(50),
    company_name VARCHAR(100),
    salary DECIMAL(12,2),

    PRIMARY KEY (employee_name, company_name),

    FOREIGN KEY (employee_name)
        REFERENCES Employee(employee_name)
        ON DELETE CASCADE,

    FOREIGN KEY (company_name)
        REFERENCES Company(company_name)
        ON DELETE CASCADE
);

CREATE TABLE Manages (
    employee_name VARCHAR(50) PRIMARY KEY,
    manages_name VARCHAR(50),

    FOREIGN KEY (employee_name)
        REFERENCES Employee(employee_name)
        ON DELETE CASCADE
);


INSERT INTO Employee VALUES
('Jibon', 'Road 1', 'Dhaka'),
('Akondo', 'Road 2', 'Dhaka'),
('Bilal', 'Road 3', 'Chittagong'),
('Mahin', 'Road 4', 'Barisal'),
('Rohan', 'Road 5', 'Dhaka'),
('Karim', 'Road 6', 'Sylhet'),
('Faruk', 'Road 7', 'Rajshahi');


INSERT INTO Company VALUES
('IFIC Bank Ltd.', 'Dhaka'),
('First Bank Corporation', 'Dhaka'),
('ABC Corporation', 'Chittagong'),
('Tech Solutions', 'Sylhet');

INSERT INTO Works VALUES
('Jibon', 'First Bank Corporation', 70000),
('Akondo', 'First Bank Corporation', 65000),
('Bilal', 'IFIC Bank Ltd.', 60000),
('Mahin', 'IFIC Bank Ltd.', 55000),
('Rohan', 'First Bank Corporation', 50000),
('Karim', 'Tech Solutions', 80000),
('Faruk', 'ABC Corporation', 45000);

INSERT INTO Manages VALUES
('Jibon', 'Rahman'),
('Akondo', 'Rahman'),
('Bilal', 'Karim'),
('Mahin', 'Karim'),
('Rohan', 'Rahman'),
('Karim', 'Hasan'),
('Faruk', 'Ahmed');


