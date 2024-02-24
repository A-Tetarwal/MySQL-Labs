use ashish;

-- question 1

-- Creating the Student table
CREATE TABLE Student (
    Roll_No INT PRIMARY KEY,
    Name VARCHAR(100),
    Dob DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    BCode INT
);

-- Creating the Branch table
CREATE TABLE Branch (
    BCode INT PRIMARY KEY,
    BName VARCHAR(50)
);

-- Creating the Course table
CREATE TABLE Course (
    CCode INT PRIMARY KEY,
    CName VARCHAR(100),
    Credits INT,
    BCode INT,
    FOREIGN KEY (BCode) REFERENCES Branch(BCode)
);

-- Creating the Enrolled_Students table
CREATE TABLE Enrolled_Students (
    Roll_No INT,
    Name VARCHAR(100),
    CCode INT,
    CName VARCHAR(100),
    BCode INT,
    PRIMARY KEY (Roll_No, CCode),
    FOREIGN KEY (Roll_No) REFERENCES Student(Roll_No),
    FOREIGN KEY (CCode) REFERENCES Course(CCode)
);

-- Creating the Sports table
CREATE TABLE Sports (
    Sport_id CHAR(10) CHECK (Sport_id LIKE 'S%'),
    Sport_name VARCHAR(50),
    Rollno INT,
    Student_name VARCHAR(100),
    Gender ENUM('Male', 'Female', 'Other'),
    FOREIGN KEY (Rollno) REFERENCES Student(Roll_No)
);


-- Inserting data into the Student table
INSERT INTO Student (Roll_No, Name, Dob, Gender, BCode) VALUES
(111220, 'Rajesh Kumar', '1998-05-15', 'Male', 101),
(111221, 'Priya Singh', '1999-02-20', 'Female', 102),
(111222, 'Amit Sharma', '2000-10-10', 'Other', 101),
(111223, 'Sneha Patel', '1997-07-25', 'Female', 103),
(111224, 'Aishwarya', '1999-11-15', 'Female', 103),
(111225, 'Amish', '2000-10-12', 'Male', 101),
(111226, 'Rahul Verma', '1998-12-30', 'Male', 104);

-- Inserting data into the Branch table
INSERT INTO Branch (BCode, BName) VALUES
(101, 'Computer Science Engineering'),
(102, 'Information Technology'),
(103, 'Electronics and Communication Engineering'),
(104, 'Mechanical Engineering');

-- Inserting data into the Course table
INSERT INTO Course (CCode, CName, Credits, BCode) VALUES
(201, 'Database Management System', 4, 101),
(202, 'Operating Systems', 3, 102),
(203, 'Mathematics', 3, 103),
(205, 'Statistics', 1, 102),
(204, 'Computer Networks', 3, 104);

-- Inserting data into the Enrolled_Students table
INSERT INTO Enrolled_Students (Roll_No, Name, CCode, CName, BCode) VALUES
(111220, 'Rajesh Kumar', 201, 'Database Management System', 101),
(111221, 'Priya Singh', 202, 'Operating Systems', 102),
(111222, 'Amit Sharma', 201, 'Database Management System', 101),
(111223, 'Sneha Patel', 203, 'Mathematics', 103),
(111224, 'Aishwarya', 201, 'Database Management System', 103),
(111225, 'Amish', 204, 'Computer Networks', 101),
(111225, 'Amish', 201, 'Database Management System', 101),
(111225, 'Amish', 203, 'Mathematics', 101),
(111226, 'Rahul Verma', 205, 'Statistics', 102),
(111226, 'Rahul Verma', 204, 'Computer Networks', 104);

-- Inserting data into the Sports table
INSERT INTO Sports (Sport_id, Sport_name, Rollno, Student_name, Gender) VALUES
('S001', 'Chess', 111220, 'Rajesh Kumar', 'Male'),
('S002', 'Table Tennis', 111221, 'Priya Singh', 'Female'),
('S001', 'Chess', 111220, 'Rajesh Kumar', 'Male'),
('S003', 'Carrom', 111222, 'Amit Sharma', 'Other'),
('S004', 'Dart', 111223, 'Sneha Patel', 'Female'),
('S004', 'Dart', 111224, 'Aishwarya', 'Female'),
('S004', 'Dart', 111225, 'Amish', 'Male'),
('S005', 'Volleyball', 111226, 'Rahul Verma', 'Male');


-- query 1
SELECT 
    roll_no, name, gender
FROM
    student
WHERE
    roll_no IN (SELECT 
            roll_no
        FROM
            enrolled_students
        WHERE
            CName IN ('Database Management System' , 'Operating Systems'));

-- query 2
SELECT 
    COUNT(gender) AS female_students
FROM
    sports
WHERE
    gender = 'female';

-- query 3
SELECT 
    *
FROM
    Student
WHERE
    Roll_No IN (SELECT 
            Roll_No
        FROM
            Enrolled_Students
        WHERE
            CName = 'Database Management System')
        AND Roll_No IN (SELECT 
            Rollno
        FROM
            Sports);

-- query 4
SELECT 
    *
FROM
    Student
WHERE
    Roll_No IN (SELECT 
            Rollno
        FROM
            Sports
        WHERE
            Sport_name = 'Chess')
        AND MONTH(Dob) BETWEEN 11 AND 12;

-- query 5
SELECT 
    name, cname, sport_name
FROM
    enrolled_students AS es
        LEFT JOIN
    sports AS s ON es.roll_no = s.rollno
WHERE
    es.name LIKE 'A%';

-- query 6
SELECT 
    COUNT(sport_name) AS student_participated, sport_name
FROM
    sports
GROUP BY sport_name
ORDER BY COUNT(sport_name) DESC;

-- query 7
SELECT 
    COUNT(ccode) AS students_enrolled, cname AS course
FROM
    enrolled_students
GROUP BY cname
ORDER BY COUNT(ccode); 

-- query 8
SELECT 
    COUNT(bcode) AS students_enrolled, bcode AS branch
FROM
    enrolled_students
GROUP BY bcode
ORDER BY COUNT(bcode) DESC;


-- query 9
SELECT 
    COUNT(ccode) AS students_enrolled, cname AS course
FROM
    enrolled_students
GROUP BY cname
HAVING COUNT(ccode) > 3; 


-- query 10
SELECT 
    cname, ccode, credits
FROM
    course
HAVING credits = 1 OR credits = 2; -- yahan pe kuch edit krna h

-- query 11
SELECT *
FROM Student
WHERE Roll_No IN (
    SELECT Roll_No
    FROM Enrolled_Students
    WHERE CCode IN (
        SELECT CCode
        FROM Course
        WHERE Credits IN (1, 2)
    )
);

-- query 12
SELECT 
    s1.Student_name
FROM
    Sports s1
        JOIN
    Sports s2 ON s1.Sport_name = s2.Sport_name
        AND s1.Student_name != s2.Student_name;


-- query 13
SELECT *
FROM Student
WHERE Roll_No IN (
    SELECT Rollno
    FROM Sports
    WHERE Sport_name = 'Chess'
) AND Roll_No NOT IN (
    SELECT Roll_No
    FROM Enrolled_Students
    WHERE CName IN ('Mathematics', 'Statistics')
);


-- query 14
UPDATE Student
SET Name = 'Ram', Dob = '2000-01-01', Gender = 'Male', BCode = 101
WHERE Roll_No = 111222;

SELECT *
FROM Student
WHERE Roll_No = 111222;

-- query 15
CREATE TEMPORARY TABLE temp AS (
    SELECT Roll_No
    FROM Enrolled_Students
    WHERE CName = 'Mathematics'
    AND Roll_No IN (
        SELECT Rollno
        FROM Sports
        WHERE Sport_name = 'Volleyball'
    )
);

DELETE FROM Enrolled_Students
WHERE Roll_No IN (
    SELECT Roll_No
    FROM temp
);

DROP TABLE temp;

-- query 16
SELECT DISTINCT e1.CName
FROM Enrolled_Students e1
WHERE EXISTS (
    SELECT *
    FROM Enrolled_Students e2
    WHERE e1.CName = e2.CName AND e1.Roll_No != e2.Roll_No
);


-- query 17
SELECT 
    Name
FROM
    Student
WHERE
    DATEDIFF(CURDATE(), Dob) > ALL (SELECT 
            DATEDIFF(CURDATE(), Dob)
        FROM
            Student
        WHERE
            Roll_No IN (SELECT 
                    Rollno
                FROM
                    Sports
                WHERE
                    Sport_name = 'Chess'));

-- query 18
SELECT 
    s1.Student_name
FROM
    Sports s1
        JOIN
    Sports s2 ON s1.Sport_name = s2.Sport_name
        AND s1.Student_name != s2.Student_name
        JOIN
    Enrolled_Students e1 ON s1.Rollno = e1.Roll_No
        JOIN
    Enrolled_Students e2 ON s2.Rollno = e2.Roll_No
        AND e1.CCode = e2.CCode;


-- query 19
SELECT 
    CName
FROM
    Course
WHERE
    CCode NOT IN (SELECT 
            CCode
        FROM
            Enrolled_Students
        WHERE
            Roll_No IN (SELECT 
                    Rollno
                FROM
                    Sports
                WHERE
                    Sport_name = 'Table Tennis'));


-- query 20
SELECT 
    COUNT(ccode) as no_of_courses, name
FROM
    enrolled_students
GROUP BY name
HAVING COUNT(ccode) > 1;





-- Question 2

CREATE TABLE employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department_ID INT
);

CREATE TABLE departments (
    ID INT PRIMARY KEY,
    Name VARCHAR(100)
);

INSERT INTO departments (ID, Name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Marketing');

INSERT INTO employees (ID, Name, Department_ID) VALUES
(101, 'Rajesh Kumar', 1),
(102, 'Priya Singh', 2),
(103, 'Amit Sharma', 3),
(104, 'Sneha Patel', 1);

-- Query
SELECT 
    *
FROM
    departments d
WHERE
    EXISTS( SELECT 
            1
        FROM
            employees e
        WHERE
            e.Department_ID = d.ID);


SELECT * FROM Student;