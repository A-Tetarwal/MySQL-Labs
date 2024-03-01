CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    quantity INT CHECK (quantity >= 0),
    price DECIMAL(10, 2) CHECK (price >= 99),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) DEFERRABLE INITIALLY DEFERRED
);

-- Insert sample books
INSERT INTO Books (book_id, title, author, quantity, price, category_id)
VALUES
    (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 50, 299.99, 1),
    (2, 'To Kill a Mockingbird', 'Harper Lee', 30, 199.50, 2),
    (3, 'Pride and Prejudice', 'Jane Austen', 20, 149.75, 1);

-- Insert sample categories
INSERT INTO Category (category_id, category_name)
VALUES
    (1, 'Fiction'),
    (2, 'Classics');
    
    
-- Create a view to display book details
CREATE VIEW BookDetails AS
SELECT b.book_id, b.title, b.author, b.price, c.category_name
FROM Books b
JOIN Category c ON b.category_id = c.category_id;



    
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    gpa DECIMAL(3, 2) CHECK (gpa >= 0 AND gpa <= 4),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL,
    department_head_id INT NOT NULL,
    FOREIGN KEY (department_head_id) REFERENCES Employees(employee_id)
);


-- Create a view to display student details with department names
CREATE VIEW StudentDetails AS
SELECT s.student_id, s.student_name, s.gpa, d.department_name
FROM Students s
JOIN Departments d ON s.department_id = d.department_id;
