CSCI 585 DATABASE SYSTEMS - HW - 1
MONA TEJA KURAKULA

ENTITIES:

1. EMPLOYEE
2. MEETING
3. ATTENDANCE
4. SCAN
5. TEST
6. QUARANTINE
7. TRACK
8. EMAIL
9. CALL
10. SELF REPORT


Let's break down the data entry and data flow in the COVID-19 contact tracing system, along with a detailed explanation of each attribute's meaning and the cardinality, connections, and constraints between the entities.


ATTRIBUTES & CONSTRAINTS:

1. EMPLOYEE

Employee_ID (Primary Key): An unique identifier for each employee (Mandatory).
Full_Name: The name of the employee (Mandatory).
Mobile_Number: The employee's contact number (Mandatory).
Email_Address: The employee's email address (Optional).
App_Installed_Status: A flag indicating whether the employee has the app installed or not ("True" or "False")(Mandatory).
Employee_Health_Status: A Status Indicator denoting the current employee health status ('sick', 'hospitalized' or 'well')(Mandatory - Initialized to Well by default)
Last_Health_Status_Updated: Date and Time of when the Health Status is last modified. (Mandatory - Initialized to signup date and timestamp by default)

2. MEETING

Meeting_ID (Primary Key): An unique identifier for each meeting (Mandatory).
Meeting_Title: The name of the meeting (Mandatory).
Room_Number: The meeting room number for the meeting (Mandatory).
Floor: The Floor number for the meeting (Mandatory).
Start_Date_Time: Timestamp of the Meeting Start Time (Mandatory)
End_Date_Time: Timestamp of the Meeting End Time (Mandatory)
Meeting_Risk_Status: Risk Status of the meeting (Mandatory) it can be "Low" or "Medium" or "High"("Initialized to Low by deault").

3. ATTENDANCE (WEAK ENTITY)

Employee_ID (Primary Key, Foreign Key1): An unique identifier for each employee (Mandatory)- A Part of Composite Primary Key
Meeting_ID (Primary Key, Foreign Key2): An unique identifier for each meeting (Mandatory) - A Part of Composite Primary Key
Attendance_Status: A Boolean value that determines with the specific employee with the Employee_Id has attended the meeting with the Meeting_ID or not ("True" or "False")(Mandatory)
Meeting_Risk_Status: An Atrribute referenced from Meeting Table based on the meeting ID (Mandatory)
Employee_Risk_Status: An Attribute constantly updated if the employee with Employee_ID against the records tests positive for COVID(Mandatory)("Initialized to Low by deault")
Risk_Test_ID: Test_ID of the Employee with Employee_ID where the employee is tested for positive(Mandatory)("Initialized to Null by deault").

4. SCAN

Scan_ID (Primary Key): An unique identifier for each scan (Mandatory).
Employee_ID (Foreign Key): An identifier for employee who took the scan (Mandatory).
Temparature: A Decimal value indicating the temparature reported as per the scan (Mandatory).
Scan_Date_Time: Timestamp when the scan is conducted (Mandatory).
Test_Required: Determines whether the employee to be tested for COVID or not ("Yes" or "No" based on the temparature recorded) (Mandatory).

5. SELF REPORT

Report_ID (Primary Key): An unique identifier for each self report by an employee (Mandatory - Auto Increment).
Employee_ID (Foreign Key): A An identifier for employee who took the scan (Mandatory).
Symptom1: "Yes" or "No" based on the whether the Symptom 1 is identified (Mandatory).
Symptom2: "Yes" or "No" based on the whether the Symptom 2 is identified (Mandatory).
Symptom3: "Yes" or "No" based on the whether the Symptom 3 is identified (Mandatory).
Symptom4: "Yes" or "No" based on the whether the Symptom 4 is identified (Mandatory).
Symptom5: "Yes" or "No" based on the whether the Symptom 5 is identified (Mandatory).

6. TEST

Test_ID: An unique identifier for each Test conducted against an Employee_ID (Mandatory - Auto Increment).
Employee_ID: An identifier for employee who is came to get tested for COVID (Mandatory).
Test_Location: Location of where the particular test is conducted ('Onsite" or "Offsite").
Test_Result: Test Result for the test with Test_ID ("Positive" or "Negative)(Mandatory). 
Test_Date_Time: Timestamp  of the test conducted for the employee (Mandatory).
Symptom_Status: Symptoms Status i.e., ("Asymptomatice" or "Symptomatic" or "Pre-Symptomatic") (Mandatory).
Ref_Channel: Reason for Employee to do COVID Test ("Random-Selection" or "Self Report" or "Scan" or "Quarantine Daily Check")(Mandatory).
Notification_Received: Did the Employee receive any call or email from the company ("Yes" or "No")(Mandatory).
Notification_Date: If answered Yes for previous attribute when did the employee receive the communication from the company (Optional).
Scan_ID:An identifier of the scan by which the employee is redirected to get tested for COVID because of high temparature than threshold (Optional).
Scan_Date: If Ref_Channel is Scan then this attribute will record the timestamp when the Scan with Scan_ID is conducted (Optional).
Report_ID: If Ref_Channel is Self Report then this attribute will record the Report_ID of the self reported symptoms by the employee (Optional).
Employee_Risk_Status: If the Result is Positive it will be marked as "Very High", else if result is negative then it is marked as "Low" (Mandatory).


7. QUARANTINE

Quarantine_ID: An unique identifier for each Quarantine record against an Employee_ID (Mandatory - Auto Increment).
Employee_ID: An identifier for employee who is adviced to Quarantine based on the positive result in COVID test (Mandatory).
Last_Test_ID: Test_ID referenced from Test of the latest test conducted for the employee with this Quarantine ID (Mandatory).
Last_Test_Date_Time: Timestamp referenced from Test of the latest test conducted for the employee with this Last_Test_ID (Mandatory).
Last_Test_Result:Test referenced from Test of the latest test conducted for the employee with this Last_Test_ID (Mandatory).
Quarantine_Status: Status of this current Quarantine ID based on the Quarantine Start Date and End Date ("Active" or "Completed") (Mandatory).
Quarantine_Start_Date: Timestamp of when this current Quarantine ID started (Mandatory).
Quarantine_End_Date: Timestamp of when this current Quarantine ID is due (Mandatory).
Employee_Health_Status:Last updated Health Status of the employee ('sick', 'hospitalized' or 'well')(Mandatory - Initialized to Well by default).


8. TRACK

Trace_ID (Primary Key): An unique identifier for each attendance record whose Employee_ID is Contacted_Employee_ID, Meeting_ID is Source_Meeting_ID, Employee_Risk_Status is "Medium" or "High" (Mandatory - Auto Increment)
Contacted_Employee_ID (Foreign Key1): An unique identifier for each employee (Mandatory)
Source_Meeting_ID (Foreign Key2): An unique identifier for each meeting (Mandatory)
Employee_Risk_Status: An Attribute constantly updated if the employee with Employee_ID against the records tests positive for COVID(Mandatory)("Initialized to Low by deault")
Notification_Type: Attribute where the communication is decided based on the risk status i.e. "Call & Email", "Only Email" (Mandatory).
Email_Address: Email Address of the employee with the Employee_ID = Contacted_Employee_ID (Optional as some values can be Null if the Employee has not provided the Email Address).
Mobile_Number: Mobile_Number of the employee with the Employee_ID = Contacted_Employee_ID(Mandatory)

9. EMAIL

Notification_ID (Primary Key): A unique identifier for each email or message sent (Mandatory - Auto Increment).
Trace_ID (Foreign Key): An identifier for trace found for potential employee who might be potentially COVID positive (Mandatory).
Contacted_Employee_ID: An identifier for employee who might be potentially COVID positive (Mandatory).
Message_Date: Timestamp captured of the email of notification sent to an employee against the particular Trace_ID (Mandatory).
Email_Address: Email Address of the employee with the Employee_ID = Contacted_Employee_ID (Optional as some values can be Null if the Employee has not provided the Email Address).

10. CALL

CALl_ID (Primary Key): A unique identifier for each Call by HR to the candidate who came in close proximity wiht the COVID positive colleague (Mandatory - Auto Increment).
Trace_ID (Foreign Key): An identifier for trace found for potential employee who might be potentially COVID positive (Mandatory).
Contacted_Employee_ID: An identifier for employee who might be potentially COVID positive (Mandatory).
Message_Date: Timestamp captured of the email of notification sent to an employee against the particular Trace_ID (Mandatory).
Mobile_Number: Mobile_Number of the employee with the Employee_ID = Contacted_Employee_ID(Mandatory).


CONNECTIONS:

-> EMPLOYEE to SELF REPORT: One Employee can have 0 or multiple Self Reports. One Self Report  can have one and only Employee associated with it.
-> EMPLOYEE to SCAN: One Employee can have 0 or multiple Scan records. One Scan can have one and only Employee associated with it.
-> EMPLOYEE to TEST: One Employee can have 0 or multiple Test records. One Test can have one and only Employee associated with it.
-> EMPLOYEE to QUARANTINE: One Employee can have 0 or multiple Quarantine records. Each Quarantine can have one and only Employee associated with it.
-> EMPLOYEE to ATTENDANCE: One Employee can have 0 or multiple Attendance records. Each Attendance record can have one and only Employee associated with it.
-> EMPLOYEE to TRACK: One Employee can have 0 or multiple Track records. Each Track record can have one and only Employee associated with it.
-> SCAN to TEST: One Scan can have 0 or 1 Test record. Each Test can have 0 or 1 Test record.
-> SELF REPORT to TEST: One Self Report Will have 1 and only 1 Test record (as Self reporting is done only when employee identifies the symptoms). Whereas each Test record can have 0 or 1 Self Report as test can be conducted from other Ref_Channel than Self Report. 
-> TEST to QUARANTINE: One Test Record can have 0 or 1 Quarantine records based on the Test_Result. Each Quarantine record has one or many Test Records associated with it due to the Daily Quarantine Tests.
-> QUARANTINE to EMPLOYEE: One Quarantine record will have 1 and only 1 Employee record associated with it it updates the health_Status of the employee on the employee table). Whereas an Employee can have 0 to multiple Quartine records based on how many times the particular employee is tested poisitive for COVID.
-> TEST to ATTENDANCE: One Test result can impact 0(if employee not tested before) or mutiple Attendance records using Employee_ID whose Test Result is positive and updates Employee-Risk_Status in the records where the Employee_ID is matching with Employee_ID of positive Test Result. One attendance record can have 0 (If never tested for COVID) or 1 record in the Test Table (as per the Last_Test_ID).
-> MEETING to ATTENDANCE: One Meeting can have 1 or multiple Attendance records. Each Attendance record can have one and only Meeting associated with it.

-> ATTENDANCE to TRACK: One Attendance Record can have 0 or 1 Track records based on the Employee_Risk_Status. One Track Record can have one and only Attendance record associated with it as it used the primary key of attendance i.e., Employee_ID and Meeting_ID as a foreign key.
-> TRACK to EMAIL: One Track Record can have 0 or 1 Email records based on availability of email address of the specific employee as it is an optional field in Employee details. One Email Record can have one and only Track record associated with it.
-> TRACK to CALL: One Track Record can have 1 and only 1 Call records. One Call Record can have one and only Track record associated with it.


DATA FLOW:

1. Each Employee is asked to install the app and register. If they don't using the App_Installed_Status attribute in the EMPLOYEE table we can notify them to install the application. Once the employee installs the application and registers, we can mark the App_Installed_Status True.
2. An employee is scanned randomly and if the temparature is high than a threshold then they will be redirected to the On-Site COVID Test. 
3. If any employee is working from home or identifies any of the company listed symptoms. They can report it using the app and then will be redirected for the COVID Test at any location of their choice.
4. Employees can be tested randomly (this is to catch presymptomatic or asymptomatic cases).
5. Above are the 3 ways where employees can end up in testing for COVID i.e., Direct Check, Through Scan when temparature is high, and Through Self Report. Another instance where employee is tested for COVID is when the particular employee is in Quarantine.
6. Based on the Source mode of the TEST the attribute called Ref_Channel will be filled. If the mode is through Scan. Scan_ID and Scan_Date will be populated and vice-versa for appropriate modes. Notification_Received and Notification_Date are 2 attributes that capture whether the employee is contacted by HR via call or Email Notification. These are optional fields.
7. Only Test_ID, Employee_ID, Test_Location, Test_Result, Test_Date_Time, Ref_Channel, Symptom_Status are the mandatory fields in the TEST table rest are subject to communication recevied by the employee or the mode of their arrival for COVID Test i.e., Scan (or) Self Report (or) Direct Check.
8. If an employee is tested positive for the first time, the particular employee will be given a Quarantine_ID and asked to self isolate for 2 weeks. This now translates to Quarantine_Start_Date, Quarantine_End_Date, Quarantine_Status, Last_Test_ID, Last_Test_Date, Last_Test_Result, and Employee_Health_Status. And the employee who is already in the Quaratine Status will be tested everyday during the isolation and all the applicable fields will be updated except fields like Quarantine_ID and Employee_ID.
9. This Last updated health status will be translated to the Employee table and updates the Employee_Health_Status to 'sick', 'hospitalized' or 'well'.
10. In Parallel after step 8, when an employee is tested COVID Positive, This will now translate to the attendance table where all the meeting attendance entries of the Employee will be recorded and update Employee_Risk_Status to "Very High" of all the records where the Employee_ID of the employee who is tested positive for COVID is recorded. Now in RL, We can get all the meetings attended by this employee in last 2 weeks or a specific duration using SQL and get that meeting IDs. Meeting_Risk_Status will be updated to "High" for all these meeting with these Meeting_IDs in the Meeting Table.
11. Also, Meetings that have start time recorded between the start time and end time of the meetings whose Meeting_Risk_Status is high and on same floor will be updated with the Meeting_Risk_Status "Medium".
12. Now, Meeting_Risk_Status in Attendance is referenced from Meeting Table and remember when the attendance record is created initially by default Meeting_Risk_Status is set to "Low", Employee_Risk_Status is set to "Low" and Last_Test_Id to be "N/A".
13.Now, We end up with meetings with 3 categories of Meeting_Risk_Status i.e. Low, Medium, and High. Now using SQL, we can update the Employee_Risk_Status using Meeting_Risk_Status except for Employees with Employee_Risk_Status "Very High" as they are tested positive. Now we will end up with the attendance records having 4 categories i.e., Low (No Contact with COVID), Medium (On the Same Floor where a COVID positive candidate has attended the meeting), High (Present in the same meeting as the COVID positive candidate), Very High (COVID Positive candidate).
14. Now if the Employee_Risk_Status is Medium or Very High, we will generate a Trace ID to notify the candidates to get tested for COVID.If the Employee Risk Status is Medium they will be noitified via email or messages to test for COVID at their choice. If the Employee_Risk_Status is High, then these employees will be notified via email or message to test for COVID as soon as possible and report to the company. A HR live call will be initiated as well for these employees with Employee_Risk_Status "High"

