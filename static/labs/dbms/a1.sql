SELECT DISTINCT customer_name
FROM Depositor
WHERE customer_name NOT IN (
SELECT customer_name
FROM Borrower
);


DELETE FROM Loan
WHERE amount BETWEEN 10000 AND 25000;


SELECT DISTINCT b.customer_name
FROM Borrower b
JOIN Loan l
ON b.loan_number = l.loan_number
WHERE l.branch_name = 'Perryridge';


DELETE FROM Loan
WHERE amount BETWEEN 0 AND 500;
