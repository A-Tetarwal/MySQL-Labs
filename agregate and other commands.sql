create database Ashish;
use Ashish;
-- Create Authors table
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);

-- Insert data into Authors table
INSERT INTO authors (author_id, author_name) VALUES
(1, 'Jane Doe'),
(2, 'John Smith'),
(3, 'Alice Johnson');

-- Create Books table
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    publication_year INT,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Insert data into Books table
INSERT INTO books (book_id, title, publication_year, author_id) VALUES
(101, 'The Art of Fiction', 2005, 1),
(102, 'Data Science Basics', 2019, 2),
(103, 'Into the Unknown', 2015, 1),
(104, 'SQL Mastery', 2020, 2),
(105, 'Web Development Fundamentals', 2018, 3);

select * from authors order by author_id desc limit 2;
select avg(author_id) from authors;
select min(publication_year) from books;
select sum(book_id) from books;
select count(author_id) from authors;

select author_id, count(title) from books group by author_id;

SELECT author_id, COUNT(title) AS book_count
FROM books
GROUP BY author_id;

select author_id, avg(book_id) from books group by author_id order by author_id asc;
select author_id, avg(book_id) from books group by author_id order by avg(book_id) asc;