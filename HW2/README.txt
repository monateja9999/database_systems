Given, to create the tables according to the schema and ER Diagram provided. I have used -- Oracle Live SQL - https://livesql.oracle.com/ -- to execute my home work.

Q1) For Q1 we have to create the tables and relationships between the entities based on their cardinality. In order to perform certain operations on the table the first thing we need is some sample data. Hence, we will create 5 to 15 rows for each table as our inputs following the constraints.

Q2) For Q2 we need to find the symptom or symptom which is self-reported the most. I have written a SQL Query which retrieves the symptom which is self reported the most number of times. If there are multiple symptoms which have tie and reported maximum number of times. 

Q3) For Q3 we need to find the floor from which there are most number of employees who became sick. Assuming that the employee might record negative after positive and vice-versa, we can look for a range of dates or a particular date and find out the sickest floor. If we need a status update of people who have already reported positive before and quarantined or hospitalized. we can run a similar query on Health_Status table.

Q4) For Q4, The Management would like stats, for a given period (between start, end dates), on the following: Number of Scans, Number of Tests, Number of Employees who self-reported symptoms, Number of Positive cases. In Q4.sql we have written count queries to output the number of records that fall between given time period.

Q5) For Q5, we need to create a question to query - "Which employees have reported symptoms and tested positive for COVID-19, and what is their current health status?"

To answer this question, we will need to retrieve information from multiple tables: Employee, Symptom, Test, and Health_Status. We need to use table division to find employees who reported symptoms and tested positive and then determine their current health status by their Name.

The SQL query to answer this question is clearly mentioned in Q5.sql