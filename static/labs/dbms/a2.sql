SELECT company_name,
COUNT(*) AS employee_count
FROM Works
GROUP BY company_name
ORDER BY employee_count DESC
LIMIT 1;


SELECT company_name,
AVG(salary) AS average_salary
FROM Works
GROUP BY company_name;


SELECT e.employee_name
FROM Employee e
JOIN Works w
ON e.employee_id = w.employee_id
JOIN Company c
ON w.company_name = c.company_name
WHERE e.city = 'Barisal'
AND c.city <> 'Barisal';


SELECT e.employee_name
FROM Employee e
JOIN Works w
ON e.employee_id = w.employee_id
WHERE w.company_name = 'First Bank Corporation';
