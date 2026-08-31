DROP DATABASE IF EXISTS car_insurance;
CREATE DATABASE car_insurance;

USE car_insurance;

CREATE TABLE Person (
    driver_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Car (
    license VARCHAR(20) PRIMARY KEY,
    model VARCHAR(50),
    `year` INT
);

CREATE TABLE Accident (
    report_number VARCHAR(20) PRIMARY KEY,
    `date` DATE,
    location VARCHAR(100)
);

CREATE TABLE Owns (
    driver_id VARCHAR(20),
    license VARCHAR(20),

    PRIMARY KEY (driver_id, license),

    FOREIGN KEY (driver_id)
        REFERENCES Person(driver_id)
        ON DELETE CASCADE,

    FOREIGN KEY (license)
        REFERENCES Car(license)
        ON DELETE CASCADE
);

CREATE TABLE Participated (
    driver_id VARCHAR(20),
    car VARCHAR(20),
    report_number VARCHAR(20),
    damage_amount DECIMAL(12,2),

    PRIMARY KEY (driver_id, car, report_number),

    FOREIGN KEY (driver_id)
        REFERENCES Person(driver_id)
        ON DELETE CASCADE,

    FOREIGN KEY (car)
        REFERENCES Car(license)
        ON DELETE CASCADE,

    FOREIGN KEY (report_number)
        REFERENCES Accident(report_number)
        ON DELETE CASCADE
);

INSERT INTO Person VALUES
('D001', 'Simanto', 'Dhaka'),
('D002', 'Rahim', 'Chittagong'),
('D003', 'Karim', 'Dhaka'),
('D004', 'Nabila', 'Sylhet');

INSERT INTO Car VALUES
('DHAKA 4000', 'Toyota', 2018),
('DHAKA 5000', 'Honda', 2020),
('CTG 1234', 'Toyota', 2019),
('SYL 1111', 'Nissan', 2021);

INSERT INTO Accident VALUES
('AR 2197', '2020-05-15', 'Dhaka'),
('AR 2198', '2020-09-20', 'Chittagong'),
('AR 2199', '2019-03-10', 'Dhaka'),
('AR 2200', '2021-07-12', 'Sylhet');

INSERT INTO Owns VALUES
('D001', 'DHAKA 4000'),
('D002', 'DHAKA 5000'),
('D003', 'CTG 1234'),
('D004', 'SYL 1111');

INSERT INTO Participated VALUES
('D001', 'DHAKA 4000', 'AR 2197', 25000),
('D002', 'DHAKA 5000', 'AR 2198', 10000),
('D003', 'CTG 1234', 'AR 2197', 5000),
('D004', 'SYL 1111', 'AR 2200', 15000);
