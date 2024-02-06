create database Ashish;
use Ashish;
-- Create department table
CREATE TABLE dept (
    id INT PRIMARY KEY, 
    name VARCHAR(50)
);

-- primary key wali table parent table hoti hai aur foreign key wali child table hoti hai

-- Insert data into dept table
INSERT INTO dept (id, name) VALUES
(101, 'Hindi'),
(102, 'English'),
(103, 'Maths');

-- Create teacher table
CREATE TABLE teacher (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    foreign key (dept_id) references dept(id)
    -- agar ek table ke chanes dusre mein reflect krane ho to we use below commands
    on update cascade
    on delete cascade
);

-- Insert data into teacher table
INSERT INTO teacher (id, name, dept_id) VALUES
(101, 'john', 102),
(102, 'smith', 101),
(103, 'Jane', 102),
(104, 'Shawn', 103);


show tables;
select*from teacher;
select * from dept;

update dept set id = 104 where id= 102 ;