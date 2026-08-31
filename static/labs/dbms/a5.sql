INSERT INTO Accident
    (report_number, `date`, location)
VALUES
    ('AR 2201', '2022-01-15', 'Dhaka');


DELETE c
FROM Car c
JOIN Owns o
    ON c.license = o.license
JOIN Person p
    ON o.driver_id = p.driver_id
WHERE c.model = 'Toyota'
  AND p.name = 'Simanto';


SELECT COUNT(DISTINCT o.driver_id) AS total_people
FROM Owns o
JOIN Participated p
    ON o.license = p.car
JOIN Accident a
    ON p.report_number = a.report_number
WHERE YEAR(a.`date`) = 2020;


UPDATE Participated
SET damage_amount = 30000
WHERE car = 'DHAKA 4000'
  AND report_number = 'AR 2197';
