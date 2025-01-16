-- MONA TEJA KURAKULA (6853-8634-52) --

-- Oracle Live SQL - https://livesql.oracle.com/ --

-- Given that any employee can become sick and well depending on the date, we can calculate the most sickest floor as per the date range. Given range of the dates, the below query will return the floor from which most of the Employees reported COVID Positive (who have their offices on that floor) between those dates. --

WITH FloorSickCounts AS (
    SELECT e.Office_Floor, COUNT(*) AS Sick_Count
    FROM Employee e
    JOIN Test t ON e.Employee_ID = t.Employee_ID
    WHERE t.Test_Result = 'positive'
    AND t.Test_Date BETWEEN TO_DATE('2023-10-08', 'YYYY-MM-DD') AND TO_DATE('2023-10-09', 'YYYY-MM-DD')
    GROUP BY e.Office_Floor
),
MaxSickCount AS (
    SELECT MAX(Sick_Count) AS Max_Count
    FROM FloorSickCounts
)
SELECT Office_Floor, Sick_Count
FROM FloorSickCounts
WHERE Sick_Count = (SELECT Max_Count FROM MaxSickCount);

-- We can also run similar query on Health_Status date for specific date to know the sick status of employees for a particular day and then map it to employee table to find out the sickest floor. --