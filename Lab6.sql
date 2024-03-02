-- Question 1

-- Create Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR2(100) NOT NULL
);

-- Create Books table
CREATE TABLE Books (
    book_id INT  PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    author_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_author
        FOREIGN KEY (author_id)
        REFERENCES Authors(author_id)
        DEFERRABLE INITIALLY DEFERRED,
    CONSTRAINT chk_price
        CHECK (price >= 99),
    CONSTRAINT chk_quantity
        CHECK (quantity >= 0)
);

-- CREATE ASSERTION CheckBookPrice
--     CHECK (
--         NOT EXISTS (
--             SELECT 1
--             FROM Books
--             WHERE price < 99
--         )
--     );

-- Create a view to display book details
CREATE VIEW BookDetails AS
    SELECT b.title, a.author_name, b.price
    FROM Books b
    INNER JOIN Authors a ON b.author_id = a.author_id;

-- Insert some sample data with Indian authors and books
INSERT INTO Authors (author_id, author_name) VALUES (1, 'Chetan Bhagat'); 
INSERT INTO Authors (author_id, author_name) VALUES (2, 'Arundhati Roy');
INSERT INTO Authors (author_id, author_name) VALUES (3, 'Ruskin Bond');

INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (233, 'Five Point Someone', 1, 150.00, 10);
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (342, 'The God of Small Things', 2, 250.00, 8);
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (170, 'The Blue Umbrella', 3, 120.00, 15);

SELECT * FROM BookDetails;


--Question 2

-- Create Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL,
    department_head VARCHAR2(100) NOT NULL
     -- CONSTRAINT chk_max_students
     --    CHECK ((SELECT COUNT(*) 
    	-- FROM Students 
    	-- WHERE Students.department_id = Departments.department_id) <= 100)
);

-- Create Students table with a NOT NULL constraint on department_id
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    gpa DECIMAL(3, 2) NOT NULL,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
        DEFERRABLE INITIALLY DEFERRED,
    CONSTRAINT chk_gpa
        CHECK (gpa >= 0 AND gpa <= 4)
);

-- Create an assertion to ensure that every student belongs to at least one department
-- CREATE ASSERTION student_belongs_to_department
-- CHECK (
--     (SELECT COUNT(*) FROM Students) = (SELECT COUNT(*) FROM Departments)
-- );


-- Create a view to display students with their department details
CREATE VIEW StudentDetails AS
    SELECT s.student_name, d.department_name, s.gpa
    FROM Students s
    INNER JOIN Departments d ON s.department_id = d.department_id;

-- Insert some sample data with Indian names
INSERT INTO Departments (department_id, department_name, department_head) VALUES (1, 'Computer Science', 'Dr. Rajesh Kumar');
INSERT INTO Departments (department_id, department_name, department_head) VALUES (2, 'Mathematics', 'Dr. Priya Sharma');

INSERT INTO Students (student_id, student_name, department_id, gpa) VALUES (1100453, 'Amit Kumar', 1, 3.5);
INSERT INTO Students (student_id, student_name, department_id, gpa) VALUES (1100496, 'Priya Patel', 1, 3.2);
INSERT INTO Students (student_id, student_name, department_id, gpa) VALUES (1100497, 'Rahul Singh', 2, 3.8);

