-- MONA TEJA KURAKULA (6853-8634-52) --

-- Oracle Live SQL - https://livesql.oracle.com/ --

-- Given that each person can report mutiple symptoms and mutiple times, the above code returns the symptom or symptoms(if there are two symptoms) reported exactly maximum number of times.--

WITH Self_Reported_Count AS (SELECT Symptom_ID, COUNT(Symptom_ID) as Max_Reported FROM Symptom GROUP BY Symptom_ID ORDER BY Max_Reported DESC) SELECT * FROM Self_Reported_Count WHERE Max_Reported = (SELECT MAX(Max_Reported) FROM Self_Reported_Count);

