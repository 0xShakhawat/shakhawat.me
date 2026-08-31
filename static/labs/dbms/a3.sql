SELECT DISTINCT d.customer_name
FROM Depositor d
JOIN Borrower b
ON d.customer_name = b.customer_name;

UPDATE Saving_account sa
JOIN Depositor d
ON sa.account_number = d.account_number
SET sa.balance =
CASE
WHEN EXISTS (
SELECT 1
FROM Borrower b
WHERE b.customer_name = d.customer_name
)
THEN sa.balance * 0.97
ELSE sa.balance * 0.95
END;

UPDATE Saving_account sa
JOIN Depositor d
ON sa.account_number = d.account_number
SET sa.balance =
CASE
WHEN EXISTS (
SELECT 1
FROM Borrower b
WHERE b.customer_name = d.customer_name
)
THEN sa.balance * 0.97
ELSE sa.balance * 0.95
END;
