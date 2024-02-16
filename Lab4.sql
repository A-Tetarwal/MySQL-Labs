use ashish;

-- Creating Employee table
CREATE TABLE Employee (
    Emp_num INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Department_ID INT,
    Salary DECIMAL(10, 2),
    Joining_year INT,
    Email VARCHAR(255)
);

-- Creating Department table
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_name VARCHAR(255)
);

-- Creating Increment table
CREATE TABLE Increment (
    Emp_name VARCHAR(255),
    Salary_Increment DECIMAL(10, 2),
    Emp_num INT,
    FOREIGN KEY (Emp_num) REFERENCES Employee(Emp_num)
);

-- Creating Teachers table without Teacher_ID as PRIMARY KEY
CREATE TABLE Teachers (
    Teacher_ID INT,
    Teacher_name VARCHAR(255)
);

ALTER TABLE Teachers
ADD INDEX idx_teacher_id (Teacher_ID);


-- Creating Students table
CREATE TABLE Students (
    Std_ID INT PRIMARY KEY,
    Teacher_ID INT,
    FOREIGN KEY (Teacher_ID) REFERENCES Teachers(Teacher_ID)
);

-- Inserting data into Employee table
INSERT INTO Employee (Emp_num, Emp_name, Department_ID, Salary, Joining_year, Email) VALUES 
(1, 'John Doe', 101, 50000, 2020, 'johndoe@gmail.com'),
(2, 'Jane Smith', 102, 60000, 2019, 'janesmith@gmail.com'),
(3, 'Helly Smith', 103, 80000, 2017, 'hellymith@gmail.com'),
(4, 'David Shaw', 102, 60000, 2019, 'davidshaw@gmail.com'),
(5, 'Bill Hoe', 101, 90000, 2016, 'billhoe@gmail.com'),
(6, 'Robert Johnson', 103, 70000, 2018, 'robertjohnson@gmail.com');

-- Inserting data into Department table
INSERT INTO Department (Department_ID, Department_name) VALUES 
(101, 'Sales'),
(102, 'Marketing'),
(103, 'HR');

-- Inserting data into Increment table
INSERT INTO Increment (Emp_name, Salary_Increment, Emp_num) VALUES 
('John Doe', 5000, 1),
('Jane Smith', 6000, 2),
('Helly Smith', 7000, 3),
('David Shaw', 5000, 4),
('Bill Hoe', 6000, 5),
('Robert Johnson', 7000, 6);

-- Inserting data into Teachers table
INSERT INTO Teachers (Teacher_ID, Teacher_name) VALUES 
(1, 'Mrs. Davis'),
(2, 'Mr. Thompson'),
(1, 'Mrs. Davis'),
(3, 'Ms. Martinez');

-- Inserting data into Students table
INSERT INTO Students (Std_ID, Teacher_ID) VALUES 
(1, 1),
(2, 2),
(3, 3);


-- query 1
select * from employee order by salary limit 1 offset 1;

-- query 2
select * from teachers group by teacher_id, teacher_name having count(*)>1;

-- query 3
select emp_num, emp_name, salary/12 as monthly_salary from employee;

-- query 4
select * from employee limit 1;

-- query 5
select * from department order by department_id desc limit 1;

-- query 6;
select * from employee limit 5;

-- query 7
select * from employee order by salary desc limit 3;

-- query 8
CREATE TABLE NewTable LIKE Employee;

-- query 9
select * from employee where emp_num <=(select count(*)/2 from employee);

-- query 10
select * from students inner join teachers on students.teacher_id=teachers.teacher_id;

-- query 11
select * from employee where department_id is null;

-- query 12
select emp_name, salary_increment from increment group by emp_name, salary_increment;

-- query 13
select * from employee where emp_name in('XYZ', 'PQR');

-- query 14
select * from employee where emp_name not in('XYZ', 'PQR');

-- query 15
select substring('ABCDE', n, 1) as Output
from (select 1 as n union all select 2 union all select 3 union all select 4 union all select 5) as Numbers;

-- query 16
select * from employee having joining_year=2017;

-- query 17
select max(salary), department_name 
from department as d left join employee as e 
on d.department_id= e.department_id group by department_name;
-- or
select department_id, max(salary) from employee group by department_id;

-- query 18
select * from employee having joining_year=2016 and salary>10000;

-- query 19
select repeat('*', n) as Output
from (select 1 as n union all select 2 union all select 3) as Numbers;

-- query 20
alter table employee add constraint chk_email check (Email like '%_@_%._%');

-- query 21
select n as Number 
from (select row_number() over (order by(select null)) as n from employee) 
as Number where n <=100;

-- query 22 //there are no duplicate rows in employee table
select emp_name, count(*) as count from employee group by emp_name having count(*)>1;

-- query 23
with CTE as (
    select row_number() over (partition by Emp_name order by Emp_name) as rn
    from Employee
)
delete from CTE where rn > 1;

-- query 24
-- Inner Join
select *
from Teachers T
inner join Students S on T.Teacher_ID = S.Teacher_ID;

-- Left Outer Join
select *
from Teachers T
left outer join Students S on T.Teacher_ID = S.Teacher_ID;

-- Right Outer Join
select *
from Teachers T
right outer join Students S on T.Teacher_ID = S.Teacher_ID;

-- outer join
select *
from Teachers T
left join Students S on T.Teacher_ID = S.Teacher_ID
union
select *
from Teachers T
right join Students S on T.Teacher_ID = S.Teacher_ID;

-- query 25
select department_name, department_id from department;

-- query 26
select emp_name, department_name from employee as e 
left join department as d on e.department_id= d.department_id;

-- query 27
select department_name , emp_name from employee as e 
left join department as d on e.department_id= d.department_id;

-- query 28
SELECT E.Emp_name, D.Department_name, I.Salary_Increment
FROM Employee E
JOIN Department D ON E.Department_ID = D.Department_ID
JOIN Increment I ON E.Emp_num = I.Emp_num;


select * from employee;
