use ashish2;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
--     birthdate DATE,
--     email VARCHAR(100)
-- );

-- INSERT INTO Students (student_id, student_name, birthdate, email) VALUES
-- (3, 'Raj Patel', '2001-07-25', 'raj.patel@iiitv.ac.in'),
-- (4, 'Priya Sharma', '2002-03-12', 'priya.sharma@iiitv.ac.in'),
-- (5, 'Amit Kumar', '2001-11-05', 'amit.kumar@iiitv.ac.in'),
-- (6, 'Neha Gupta', '2000-02-18', 'neha.gupta@iiitv.ac.in'),
-- (7, 'Sandeep Verma', '2002-09-30', 'sandeep.verma@iiitv.ac.in');

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO Instructors (instructor_id, instructor_name, department) VALUES
(103, 'Dr. Gupta', 'Physics'),
(104, 'Prof. Singh', 'Chemistry'),
(105, 'Ms. Verma', 'Biology'),
(106, 'Dr. Reddy', 'Mathematics'),
(107, 'Prof. Patel', 'Computer Science');

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

INSERT INTO Courses (course_id, course_name, instructor_id) VALUES
(503, 'Quantum Mechanics', 103),
(504, 'Organic Chemistry', 104),
(505, 'Genetics', 105),
(506, 'Calculus I', 106),
(507, 'Introduction to Programming', 107);

CREATE TABLE Grades (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    cpi FLOAT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Grades (enrollment_id, student_id, course_id, grade, cpi) VALUES
(1004, 3, 503, 'A-', 9.11),
(1005, 4, 503, 'B', 8.56),
(1006, 3, 504, 'A', 9.85),
(1007, 5, 505, 'B+', 8.88),
(1008, 4, 505, 'A-', 9.23),
(1009, 6, 506, 'B', 8.77),
(1010, 7, 507, 'A', 9.72),
(1011, 3, 507, 'A-', 9.46),
(1012, 5, 506, 'B+', 8.56),
(1013, 3, 503, 'A', 9.64);

CREATE TABLE Gradepoint (
    grade VARCHAR(2) PRIMARY KEY,
    points DECIMAL(3, 2)
);

INSERT INTO Gradepoint (grade, points) VALUES
('A-', 3.7),
('B', 3.0),
('A', 4.0),
('B+', 3.3);
truncate table grades;

-- answer 1
select course_id, count(student_id) as no_of_students_enrolled from Grades group by course_id order by count(student_id) desc limit 1;

-- answer 2
select student_id, count(course_id) as no_of_courses from Grades group by student_id having count(course_id)>1;

-- answer 3
select student_id, count(distinct grade) as no_of_distinct_grades from grades group by student_id;

-- answer 12
select avg(cpi) from grades;
    
-- answer 14
alter table gradepoint modify column points float;
