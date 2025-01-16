-- MONA TEJA KURAKULA (6853-8634-52) --

-- Oracle Live SQL - https://livesql.oracle.com/ --

-- The Management would like to know the stats for a given period (between start, end dates i.e., for example I have considered 08-Oct-2023 and 10-Oct-2023), on the following: --


-- NUMBER OF SCANS --

SELECT COUNT(*) AS scan_count FROM Scan WHERE Scan_Date BETWEEN TO_DATE('2023-10-08', 'YYYY-MM-DD') AND TO_DATE('2023-10-10', 'YYYY-MM-DD');


-- NUMBER OF TESTS --

SELECT COUNT(*) AS test_count FROM Test WHERE Test_Date BETWEEN TO_DATE('2023-10-08', 'YYYY-MM-DD') AND TO_DATE('2023-10-10', 'YYYY-MM-DD');


-- NUMBER OF EMPLOYEES WHO SELF-REPORTED SYMPTOMS --

SELECT COUNT(DISTINCT Employee_ID) AS self_reported_count FROM Symptom WHERE Reported_Date BETWEEN TO_DATE('2023-10-08', 'YYYY-MM-DD') AND TO_DATE('2023-10-10', 'YYYY-MM-DD');


-- NUMBER OF POSITIVE CASES RECORDED --

SELECT COUNT(*) AS positive_case_count FROM Test WHERE Test_Result = 'positive' AND Test_Date BETWEEN TO_DATE('2023-10-08', 'YYYY-MM-DD') AND TO_DATE('2023-10-10', 'YYYY-MM-DD');