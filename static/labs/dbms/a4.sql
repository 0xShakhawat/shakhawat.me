SELECT e.employee_name, e.city, w.salary
FROM Employee e
JOIN Works w
    ON e.employee_name = w.employee_name
WHERE w.company_name = 'IFIC Bank Ltd.';


SELECT company_name, SUM(salary) AS total_salary
FROM Works
GROUP BY company_name;


UPDATE Works
SET salary = salary * 1.20
WHERE company_name = 'First Bank Corporation';


SELECT e.employee_name
FROM Employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM Works w
    WHERE w.employee_name = e.employee_name
      AND w.company_name = 'First Bank Corporation'
);
