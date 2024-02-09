use ashish2;

CREATE TABLE Staff (
    ID INT PRIMARY KEY,
    Staff_NAME VARCHAR(255),
    Staff_AGE INT,
    STAFF_ADDRESS VARCHAR(255),
    Monthly_Package INT
);

INSERT INTO Staff (ID, Staff_NAME, Staff_AGE, STAFF_ADDRESS, Monthly_Package) VALUES 
(1, 'ARYAN', 22, 'MUMBAI', 18000),
(2, 'SUSHIL', 32, 'DELHI', 20000),
(3, 'MONTY', 25, 'MOHALI', 22000),
(4, 'AMIT', 20, 'ALLAHABAD', 12000);

CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    DATE DATE,
    Staff_ID INT,
    AMOUNT DECIMAL(10 ,2)
);

INSERT INTO Payments (Payment_ID, DATE ,Staff_ID ,AMOUNT) VALUES 
(101,'2009-12-30' ,1 ,3000.00 ),
(102,'2010-02-22' ,3 ,2500.00 ),
(103,'2010-02-23' ,4 ,3500.00 );


-- Exercise(A)
-- 1
select * from staff inner join payments on staff.ID=payments.staff_ID;

-- 2
select * from staff left join payments on staff.ID=payments.staff_ID;

-- 3
select * from staff right join payments on staff.ID=payments.staff_ID;

-- 4
select * from staff left join payments on staff.ID=payments.staff_ID 
union
select * from staff right join payments on staff.ID=payments.staff_ID;


-- Exercise(B-1)

-- Creating Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    C_Name VARCHAR(255),
    Email VARCHAR(255),
    Address VARCHAR(255)
);

-- Inserting data into Customer table
INSERT INTO Customer (Customer_Id, C_Name, Email, Address) VALUES 
(100, 'Aarav', 'aarav@gmail.com', 'Ahmedabad'),
(101, 'Aryan', 'aryan@yahoo.com', 'Delhi'),
(102, 'Dhruv', 'dhruv@outlook.com', 'Mumbai'),
(103, 'Nitya', 'nitya@gmail.com', 'Pune'),
(104, 'Vikram','vikram@yahoo.com', 'Chennai'),
(105,'Yuvika','yuvika@gmail.com','Kolkata');

-- Creating Order table
CREATE TABLE Order1 (
    Order_Id INT,
    DATE DATE,
    Customer_Id INT PRIMARY KEY,
    Contact BIGINT,
    FOREIGN KEY (Customer_Id) REFERENCES Customer(Customer_Id)
);

-- Inserting data into Order table
INSERT INTO Order1 (Order_Id, DATE ,Customer_Id ,Contact ) VALUES 
('202262005','2012-09-18','100','9123564615'), 
('202262001','2021-07-28','101','7990254615'), 
('202263003','2022-12-10' ,'102','8795162381'), 
('202262004','2017-05-19' ,'103','9898785123'), 
('202263005','2019-01-10','104','7895136324'), 
('202262002','2011-06-13','105','6351789641');

-- query 1
SELECT Customer_Id, C_Name
FROM Customer
WHERE Email LIKE '%gmail.com';

-- query 2
SELECT *
FROM Customer
WHERE C_Name NOT LIKE 'A%';

-- query 3
SELECT C.C_Name, O.Date, O.Contact, C.Email, C.Address
FROM Customer C
JOIN Order1 O ON C.Customer_Id = O.Customer_Id;

-- query 4
SELECT Customer_Id, C_Name, Email, Address, Contact
FROM Customer
join order1 on Customer.customer_id= order1.customer_id;


-- Exercise(B-2)

-- Creating Books table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Title VARCHAR(255),
    Unit_price INT,
    Author_Name VARCHAR(255),
    Publisher_name VARCHAR(255),
    Publish_year INT
);

-- Inserting data into Books table
INSERT INTO Books (ISBN, Title, Unit_price, Author_Name, Publisher_name, Publish_year) VALUES 
(1001, 'Harry Potter', 3100, 'J.K Rowling', 'Scholastic Press', 1998),
(1002, 'The Hitchhiker''s Guide to the Galaxy', 4500, 'Douglas Adams', 'Mass Market Paperback', 2000),
(1003, 'Changeling', 800, 'Delia Sherman', 'Springer', 2008),
(1004, 'Giving Good Weight', 1280,'John McPhee','Spiegel & Grau' ,2006), 
(1005,'Writing' ,1700,'Marguerite Duras','Paperback' ,2001);

ALTER TABLE Books
ADD INDEX idx_author_name (Author_Name);


-- Creating Authors table with foreign key reference to Books table
CREATE TABLE Authors (
    Author VARCHAR(255) PRIMARY KEY,
    Country VARCHAR(255),
    FOREIGN KEY (Author) REFERENCES Books(Author_Name)
);

-- Inserting data into Authors table
INSERT INTO Authors (Author,Country) VALUES 
('J.K Rowling','U.K.'), 
('Douglas Adams','U.K.'), 
('Delia Sherman','Japan'), 
('John McPhee','U.S.A'), 
('Marguerite Duras','Germany');

-- query 1
SELECT COUNT(*) AS Total_Books
FROM Books;

-- query 2
SELECT *
FROM Books
LIMIT 3;

-- query 3
SELECT Title
FROM Books
WHERE Unit_price BETWEEN 1000 AND 3000;

-- query 4
SELECT B.Title, B.Author_Name, A.Country
FROM Books B
JOIN Authors A ON B.Author_Name = A.Author
WHERE B.Publish_year = 2000;

-- query 5
SELECT Title
FROM Books
WHERE Publisher_name IN ('Scholastic Pressor', 'Paperback');

-- query 6
SELECT B.Title, B.Author_Name, A.Country
FROM Books B
JOIN Authors A ON B.Author_Name = A.Author;

-- query 7
SELECT B.Author_Name, B.Title
FROM Books B
JOIN Authors A ON B.Author_Name = A.Author
WHERE A.Country = 'UK';

-- query to find second maximum unit_price in table Books 
SELECT unit_price
FROM Books
ORDER BY unit_price DESC
LIMIT 1 OFFSET 1;


-- Exercise(B-3)

-- Creating Salesman table
CREATE TABLE Salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(5,2)
);

-- Inserting data into Salesman table
INSERT INTO Salesman (salesman_id, name, city, commission) VALUES 
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.12);

-- Creating Customer table
CREATE TABLE Customer_ (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES Salesman(salesman_id)
);

-- Inserting data into Customer_ table
INSERT INTO Customer_ (customer_id, cust_name, city, grade, salesman_id) VALUES 
(3002,'Brad swift','New York',300 ,5001 ),
(3003,'Becky parker','California' ,200 ,5002 ),
(3004,'William Bowery','London' ,100 ,5005 ),
(3005,'Steve Chen','Paris' ,100 ,5006 ),
(3006,'Just in rudd','New Jersey' ,300 ,5007 );

-- query 2
select * from salesman as s inner join customer_ as c on s.city= c.city;

-- query 3
select * from salesman as s left join customer_ as c on s.city != c.city;


-- trials for query 3
SELECT city, COUNT(*) AS num_salesmen, COUNT(c.city) AS num_customers
FROM (
    SELECT s.salesman_id, s.name AS salesman_name, s.city AS salesman_city, 
           c.customer_id, c.cust_name AS customer_name, c.city AS customer_city
    FROM salesman s
    LEFT JOIN customer_ c ON s.city != c.city
) AS joined_data
GROUP BY city;

SELECT s.salesman_id, s.name AS salesman_name, s.city AS salesman_city
FROM Salesman s
LEFT JOIN Customer_ c ON s.city = c.city AND s.salesman_id = c.salesman_id
WHERE c.city IS NULL;

