show databases;
DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank;
USE bank;
CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets DECIMAL(15,2)
);


INSERT INTO Branch VALUES
('Mohammadpur', 'Dhaka', 5000000),
('Dhanmondi', 'Dhaka', 8000000),
('Uttara', 'Dhaka', 6000000),
('Chittagong', 'Chittagong', 4000000);



CREATE TABLE Customer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(100),
    customer_city VARCHAR(50)
);

INSERT INTO Customer VALUES
('Shakhawat', 'Road 1', 'Dhaka'),
('Israk', 'Road 2', 'Dhaka'),
('Rafa', 'Road 3', 'Chittagong'),
('Bushra', 'Road 4', 'Sylhet'),
('Tahmid', 'Road 5', 'Rajshahi');



CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(12,2),
    FOREIGN KEY (branch_name)
        REFERENCES Branch(branch_name)
        ON DELETE CASCADE
);

INSERT INTO Loan VALUES
(101, 'Mohammadpur', 15000),
(102, 'Dhanmondi', 5000),
(103, 'Uttara', 30000),
(104, 'Mohammadpur', 22000),
(105, 'Chittagong', 300);

CREATE TABLE Borrower (
    customer_name VARCHAR(50),
    loan_number INT,
    PRIMARY KEY (customer_name, loan_number),
    FOREIGN KEY (customer_name)
        REFERENCES Customer(customer_name)
        ON DELETE CASCADE,
    FOREIGN KEY (loan_number)
        REFERENCES Loan(loan_number)
        ON DELETE CASCADE
);

INSERT INTO Borrower VALUES
('Shakhawat', 101),
('Israk', 102),
('Rafa', 103),
('Shakhawat', 104),
('Rafa', 105);



CREATE TABLE Account (
    account_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance DECIMAL(12,2),
    FOREIGN KEY (branch_name)
        REFERENCES Branch(branch_name)
        ON DELETE CASCADE
);

INSERT INTO Account VALUES
(201, 'Dhanmondi', 8000),
(202, 'Mohammadpur', 12000),
(203, 'Uttara', 500),
(204, 'Chittagong', 20000);



CREATE TABLE Depositor (
    customer_name VARCHAR(50),
    account_number INT,
    PRIMARY KEY (customer_name, account_number),
    FOREIGN KEY (customer_name)
        REFERENCES Customer(customer_name)
        ON DELETE CASCADE,
    FOREIGN KEY (account_number)
        REFERENCES Account(account_number)
        ON DELETE CASCADE
);

INSERT INTO Depositor VALUES
('Shakhawat', 201),
('Israk', 202),
('Bushra', 203),
('Tahmid', 204);

