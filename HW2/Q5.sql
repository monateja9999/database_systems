-- MONA TEJA KURAKULA (6853-8634-52) --

-- Oracle Live SQL - https://livesql.oracle.com/ --

WITH EmployeesWithSymptoms AS (
    SELECT DISTINCT s.Employee_ID
    FROM Symptom s
    WHERE s.Symptom_ID = 1  -- Assuming Symptom_ID 1 represents COVID-19 symptoms
),
EmployeesPositiveTests AS (
    SELECT DISTINCT t.Employee_ID
    FROM Test t
    WHERE t.Test_Result = 'positive'
)
SELECT e.Full_Name AS Employee_Name, e.Email_Address AS Employee_Email, hs.Status AS Current_Health_Status
FROM Employee e
JOIN Health_Status hs ON e.Employee_ID = hs.Employee_ID
WHERE e.Employee_ID IN (
    SELECT Employee_ID
    FROM EmployeesWithSymptoms
    INTERSECT
    SELECT Employee_ID
    FROM EmployeesPositiveTests
);
