DROP DATABASE IF EXISTS bank_q3;
CREATE DATABASE bank_q3;
USE bank_q3;

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
('Alam', 'Road 1', 'Dhaka'),
('Badol', 'Road 2', 'Dhaka'),
('Nazmul', 'Road 3', 'Chittagong'),
('Emon', 'Road 4', 'Sylhet'),
('Evan', 'Road 5', 'Rajshahi');

CREATE TABLE Loan_account (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(12,2),
    FOREIGN KEY (branch_name)
        REFERENCES Branch(branch_name)
        ON DELETE CASCADE
);

INSERT INTO Loan_account VALUES
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
        REFERENCES Loan_account(loan_number)
        ON DELETE CASCADE
);

INSERT INTO Borrower VALUES
('Alam', 101),
('Badol', 102),
('Nazmul', 103),
('Alam', 104),
('Nazmul', 105);

CREATE TABLE Saving_account (
    account_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance DECIMAL(12,2),

    FOREIGN KEY (branch_name)
        REFERENCES Branch(branch_name)
        ON DELETE CASCADE
);

INSERT INTO Saving_account VALUES
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
        REFERENCES Saving_account(account_number)
        ON DELETE CASCADE
);

INSERT INTO Depositor VALUES
('Alam', 201),
('Badol', 202),
('Emon', 203),
('Evan', 204);


