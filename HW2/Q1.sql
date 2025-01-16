-- MONA TEJA KURAKULA (6853-8634-52) --

-- Oracle Live SQL - https://livesql.oracle.com/ --

-- SQL commands to create the tables and populate them with data --


CREATE TABLE Employee ( 
    Employee_ID INT PRIMARY KEY, 
    Full_Name VARCHAR(255) NOT NULL, 
    Office_Number VARCHAR(20) UNIQUE, 
    Office_Floor INT CHECK (Office_Floor BETWEEN 1 AND 10), 
    Phone_Number VARCHAR(15) NOT NULL, 
    Email_Address VARCHAR(255) NOT NULL UNIQUE 
);


CREATE TABLE Meeting ( 
    Meeting_ID INT PRIMARY KEY, 
    First_Employee_ID INT NOT NULL, 
    Second_Employee_ID INT NOT NULL, 
    Room_Number INT NOT NULL, 
    Floor_Number INT CHECK (Floor_Number BETWEEN 1 AND 10) NOT NULL, 
    Meeting_Date DATE NOT NULL, 
    Start_Time INT CHECK (Start_Time BETWEEN 8 AND 18) NOT NULL, 
    FOREIGN KEY (First_Employee_Id) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Second_Employee_Id) REFERENCES Employee(Employee_ID),
    CHECK (First_Employee_Id <> Second_Employee_Id)
);


CREATE TABLE Scan ( 
    Scan_ID INT PRIMARY KEY, 
    Scan_Date DATE NOT NULL, 
    Scan_Time INT CHECK (Scan_Time BETWEEN 0 AND 23) NOT NULL, 
    Employee_ID INT NOT NULL, 
    Temperature FLOAT NOT NULL, 
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) 
);


CREATE TABLE Symptom ( 
    Row_ID INT PRIMARY KEY, 
    Employee_ID INT NOT NULL, 
    Reported_Date DATE NOT NULL, 
    Symptom_ID INT CHECK (Symptom_ID BETWEEN 1 AND 5) NOT NULL, 
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


CREATE TABLE Test ( 
    Test_ID INT PRIMARY KEY, 
    Location VARCHAR(50) NOT NULL, 
    Test_Date DATE NOT NULL, 
    Test_Time INT CHECK (Test_Time BETWEEN 0 AND 23) NOT NULL, 
    Employee_ID INT, 
    Row_ID INT UNIQUE, 
    Scan_ID INT UNIQUE,
    Test_Result VARCHAR(10) CHECK (Test_Result IN ('positive', 'negative')) NOT NULL, 
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID), 
    FOREIGN KEY (Row_ID) REFERENCES Symptom(Row_ID), 
    FOREIGN KEY (Scan_ID) REFERENCES Scan(Scan_ID), 
    CHECK (
        (Employee_ID IS NOT NULL) OR
        (Row_ID IS NOT NULL) OR
        (Scan_ID IS NOT NULL)
    )
);


CREATE TABLE Notification ( 
    Notification_ID INT PRIMARY KEY, 
    Employee_ID INT NOT NULL, 
    Meeting_ID INT NOT NULL,
    Test_ID INT,
    Notification_Date DATE NOT NULL, 
    Notification_Type VARCHAR(10) CHECK (Notification_Type IN ('mandatory', 'optional'))NOT NULL, 
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Meeting_ID) REFERENCES Meeting(Meeting_ID),
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID) 
);


CREATE TABLE Case_Record ( 
    Case_ID INT PRIMARY KEY, 
    Case_Date DATE NOT NULL, 
    Test_ID INT UNIQUE NOT NULL, 
    Employee_ID INT NOT NULL,
    Resolution VARCHAR(50) CHECK (Resolution IN ('in quarantine', 'back to work', 'left the company', 'deceased')) NOT NULL, 
    FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


CREATE TABLE Health_Status ( 
    Status_ID INT PRIMARY KEY, 
    Case_ID INT NOT NULL, 
    Health_Reported_Date DATE NOT NULL, 
    Employee_ID INT NOT NULL,
    Status VARCHAR(50) CHECK (Status IN ('sick', 'hospitalized', 'well')) NOT NULL, 
    FOREIGN KEY (Case_ID) REFERENCES Case_Record(Case_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (1, 'Akiko Tanaka', 'A123', 4, '555-123-4567', 'akiko.tanaka@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (2, 'Yuki Nakamura', 'B456', 3, '555-234-5678', 'yuki.nakamura@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (3, 'Satoshi Yamamoto', 'C789', 4, '555-345-6789', 'satoshi.yamamoto@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (4, 'Hiroshi Suzuki', 'D012', 2, '555-456-7890', 'hiroshi.suzuki@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (5, 'Aisha Khan', 'E345', 3, '555-567-8901', 'aisha.khan@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (6, 'Jung-Hoon Lee', 'F678', 7, '555-678-9012', 'jung-hoon.lee@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (7, 'Li Wei', 'G901', 8, '555-789-0123', 'li.wei@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (8, 'Priya Patel', 'H234', 1, '555-890-1234', 'priya.patel@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (9, 'Ravi Singh', 'I567', 8, '555-901-2345', 'ravi.singh@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (10, 'Mei Ling', 'J890', 6, '555-012-3456', 'mei.ling@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (11, 'Takashi Watanabe', 'K123', 5, '555-111-2222', 'takashi.watanabe@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (12, 'Hye-Jin Kim', 'L456', 3, '555-222-3333', 'hye-jin.kim@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (13, 'Chen Xiang', 'M789', 7, '555-333-4444', 'chen.xiang@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (14, 'Anushka Sharma', 'N012', 2, '555-444-5555', 'anushka.sharma@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (15, 'Kenjiro Tanaka', 'O345', 9, '555-555-6666', 'kenjiro.tanaka@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (16, 'Mei-Mei Chang', 'P678', 4, '555-666-7777', 'mei-mei.chang@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (17, 'Jian Li', 'Q901', 10, '555-777-8888', 'jian.li@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (18, 'Seo-Yeon Park', 'R234', 1, '555-888-9999', 'seo-yeon.park@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (19, 'Rahul Gupta', 'S567', 8, '555-999-0000', 'rahul.gupta@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (20, 'Xiao Zhang', 'T890', 6, '555-000-1111', 'xiao.zhang@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (21, 'Arun Kumar', 'U123', 5, '555-123-2345', 'arun.kumar@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (22, 'Hanako Sato', 'V456', 3, '555-234-3456', 'hanako.sato@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (23, 'Ji-Woo Kim', 'W789', 7, '555-345-4567', 'ji-woo.kim@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (24, 'Linh Nguyen', 'X012', 2, '555-456-5678', 'linh.nguyen@example.com');

INSERT INTO Employee (Employee_ID, Full_Name, Office_Number, Office_Floor, Phone_Number, Email_Address)
VALUES (25, 'Rahul Verma', 'Y345', 9, '555-567-6789', 'rahul.verma@example.com');

-- Meeting 1
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (1, 1, 2, 101, 5, TO_DATE('2023-10-08', 'YYYY-MM-DD'), 10);

-- Meeting 2
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (2, 3, 4, 102, 6, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 14);

-- Meeting 3
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (3, 5, 6, 103, 7, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 15);

-- Meeting 4
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (4, 7, 8, 104, 8, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 11);

-- Meeting 5
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (5, 9, 10, 105, 9, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 13);

-- Meeting 6
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (6, 11, 12, 106, 10, TO_DATE('2023-10-13', 'YYYY-MM-DD'), 16);

-- Meeting 7
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (7, 13, 14, 107, 5, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 12);

-- Meeting 8
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (8, 15, 16, 108, 6, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 10);

-- Meeting 9
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (9, 17, 18, 109, 7, TO_DATE('2023-10-16', 'YYYY-MM-DD'), 15);

-- Meeting 10
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (10, 19, 20, 110, 8, TO_DATE('2023-10-17', 'YYYY-MM-DD'), 9);

-- Meeting 11
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (11, 21, 22, 111, 9, TO_DATE('2023-10-18', 'YYYY-MM-DD'), 14);

-- Meeting 12
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (12, 23, 24, 112, 10, TO_DATE('2023-10-19', 'YYYY-MM-DD'), 17);

-- Meeting 13
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (13, 1, 3, 113, 5, TO_DATE('2023-10-20', 'YYYY-MM-DD'), 11);

-- Meeting 14
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (14, 5, 7, 114, 6, TO_DATE('2023-10-21', 'YYYY-MM-DD'), 12);

-- Meeting 15
INSERT INTO Meeting (Meeting_ID, First_Employee_ID, Second_Employee_ID, Room_Number, Floor_Number, Meeting_Date, Start_Time)
VALUES (15, 9, 11, 115, 7, TO_DATE('2023-10-22', 'YYYY-MM-DD'), 16);


-- Scan 1
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (1, TO_DATE('2023-10-08', 'YYYY-MM-DD'), 8, 1, 98.6);

-- Scan 2
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (2, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 9, 2, 99.0);

-- Scan 3
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (3, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 10, 3, 98.2);

-- Scan 4
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (4, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 11, 4, 98.9);

-- Scan 5
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (5, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 12, 5, 99.5);

-- Scan 6
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (6, TO_DATE('2023-10-13', 'YYYY-MM-DD'), 13, 6, 98.4);

-- Scan 7
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (7, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 14, 7, 99.2);

-- Scan 8
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (8, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 15, 8, 98.8);

-- Scan 9
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (9, TO_DATE('2023-10-16', 'YYYY-MM-DD'), 16, 9, 99.1);

-- Scan 10
INSERT INTO Scan (Scan_ID, Scan_Date, Scan_Time, Employee_ID, Temperature)
VALUES (10, TO_DATE('2023-10-17', 'YYYY-MM-DD'), 17, 10, 98.7);

-- Symptom 1
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (1, 1, TO_DATE('2023-10-08', 'YYYY-MM-DD'), 1);

-- Symptom 2
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (2, 1, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 3);

-- Symptom 3
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (3, 1, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 2);

-- Symptom 4
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (4, 2, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 3);

-- Symptom 5
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (5, 2, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 1);

-- Symptom 6
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (6, 2, TO_DATE('2023-10-13', 'YYYY-MM-DD'), 4);

-- Symptom 7
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (7, 3, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 1);

-- Symptom 8
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (8, 3, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 4);

-- Symptom 9
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (9, 3, TO_DATE('2023-10-16', 'YYYY-MM-DD'), 3);

-- Symptom 10
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (10, 4, TO_DATE('2023-10-17', 'YYYY-MM-DD'), 4);

-- Symptom 11
INSERT INTO Symptom (Row_ID, Employee_ID, Reported_Date, Symptom_ID)
VALUES (11, 5, TO_DATE('2023-10-18', 'YYYY-MM-DD'), 3);


-- Test 1
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (1, 'Location A', TO_DATE('2023-10-08', 'YYYY-MM-DD'), 8, 1, 1, NULL, 'positive');

-- Test 2
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (2, 'Location B', TO_DATE('2023-10-08', 'YYYY-MM-DD'), 9, 2, NULL, 2, 'negative');

-- Test 3
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (3, 'Location C', TO_DATE('2023-10-08', 'YYYY-MM-DD'), 10, 3, 3, NULL, 'positive');

-- Test 4
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (4, 'Location D', TO_DATE('2023-10-08', 'YYYY-MM-DD'), 11, 4, NULL, 4, 'negative');

-- Test 5
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (5, 'Location E', TO_DATE('2023-10-09', 'YYYY-MM-DD'), 12, 5, NULL, 5, 'positive');

-- Test 6
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (6, 'Location F', TO_DATE('2023-10-09', 'YYYY-MM-DD'), 13, 6, NULL, 6, 'negative');

-- Test 7
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (7, 'Location G', TO_DATE('2023-10-09', 'YYYY-MM-DD'), 14, 7, NULL, 7, 'positive');

-- Test 8
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (8, 'Location H', TO_DATE('2023-10-09', 'YYYY-MM-DD'), 15, 8, NULL, 8, 'negative');

-- Test 9
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (9, 'Location I', TO_DATE('2023-10-09', 'YYYY-MM-DD'), 16, 9, NULL, NULL, 'positive');

-- Test 10
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (10, 'Location J', TO_DATE('2023-10-10', 'YYYY-MM-DD'), 17, 10, NULL, 10, 'negative');

-- Test 11
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (11, 'Location A', TO_DATE('2023-10-10', 'YYYY-MM-DD'), 18, 11, NULL, NULL, 'positive');

-- Test 12
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (12, 'Location B', TO_DATE('2023-10-10', 'YYYY-MM-DD'), 19, 12, NULL, NULL, 'negative');

-- Test 13
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (13, 'Location A', TO_DATE('2023-10-11', 'YYYY-MM-DD'), 20, 13, NULL, NULL, 'positive');

-- Test 14
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (14, 'Location C', TO_DATE('2023-10-11', 'YYYY-MM-DD'), 21, 14, NULL, NULL, 'negative');

-- Test 15
INSERT INTO Test (Test_ID, Location, Test_Date, Test_Time, Employee_ID, Row_ID, Scan_ID, Test_Result)
VALUES (15, 'Location D', TO_DATE('2023-10-12', 'YYYY-MM-DD'), 22, 15, NULL, NULL, 'positive');

-- Notification 1
INSERT INTO Notification (Notification_ID, Employee_ID, Meeting_ID, Test_ID, Notification_Date, Notification_Type)
VALUES (1, 1, 1, 1, TO_DATE('2023-10-08', 'YYYY-MM-DD'), 'optional');

-- Notification 2
INSERT INTO Notification (Notification_ID, Employee_ID, Meeting_ID, Test_ID, Notification_Date, Notification_Type)
VALUES (2, 2, 2, NULL, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 'mandatory');

-- Notification 3
INSERT INTO Notification (Notification_ID, Employee_ID, Meeting_ID, Test_ID, Notification_Date, Notification_Type)
VALUES (3, 3, 3, 3, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 'optional');

-- Notification 4
INSERT INTO Notification (Notification_ID, Employee_ID, Meeting_ID, Test_ID, Notification_Date, Notification_Type)
VALUES (4, 4, 4, NULL, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 'mandatory');

-- Notification 5
INSERT INTO Notification (Notification_ID, Employee_ID, Meeting_ID, Test_ID, Notification_Date, Notification_Type)
VALUES (5, 5, 5, 5, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 'optional');

-- Case Record 1
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (1, TO_DATE('2023-10-08', 'YYYY-MM-DD'), 1, 1, 'in quarantine');

-- Case Record 2
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (2, TO_DATE('2023-10-08', 'YYYY-MM-DD'), 3, 3, 'back to work');

-- Case Record 3
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (3, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 5, 5, 'deceased');

-- Case Record 4
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (4, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 7, 7, 'left the company');

-- Case Record 5
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (5, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 9, 9, 'back to work');

-- Case Record 6
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (6, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 11, 11, 'in quarantine');

-- Case Record 7
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (7, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 13, 13, 'back to work');

-- Case Record 8
INSERT INTO Case_Record (Case_ID, Case_Date, Test_ID, Employee_ID, Resolution)
VALUES (8, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 15, 15, 'deceased');

-- Health Status 1 (For Case_ID = 1)
INSERT INTO Health_Status (Status_ID, Case_ID, Health_Reported_Date, Employee_ID, Status)
VALUES (1, 1, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 1, 'sick');

-- Health Status 2 (For Case_ID = 2)
INSERT INTO Health_Status (Status_ID, Case_ID, Health_Reported_Date, Employee_ID, Status)
VALUES (2, 1, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 1, 'sick');

-- Health Status 3 (For Case_ID = 5)
INSERT INTO Health_Status (Status_ID, Case_ID, Health_Reported_Date, Employee_ID, Status)
VALUES (3, 1, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 1, 'hospitalized');

-- Health Status 4 (For Case_ID = 6)
INSERT INTO Health_Status (Status_ID, Case_ID, Health_Reported_Date, Employee_ID, Status)
VALUES (4, 2, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 3, 'well');

-- Health Status 5 (For Case_ID = 7)
INSERT INTO Health_Status (Status_ID, Case_ID, Health_Reported_Date, Employee_ID, Status)
VALUES (5, 5, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 9, 'well');

-- Health Status 6 (For Case_ID = 7)
INSERT INTO Health_Status (Status_ID, Case_ID, Health_Reported_Date, Employee_ID, Status)
VALUES (6, 6, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 11, 'sick');

-- Health Status 7(For Case_ID = 7)
INSERT INTO Health_Status (Status_ID, Case_ID, Health_Reported_Date, Employee_ID, Status)
VALUES (7, 6, TO_DATE('2023-10-12', 'YYYY-MM-DD'), 11, 'sick');



