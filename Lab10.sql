CREATE DATABASE ashish2;
USE ashish2;

-- the "Products" table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- the "Categories" table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

-- Create the "Orders" table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL
);

-- Create the "Order_details" table
CREATE TABLE Order_details (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert into "Products" table
INSERT INTO Products (product_id, product_name, category_id, price)
VALUES
    (4321, 'Kurta Pajama Set', 1, 1499.99),
    (4325, 'Saree', 1, 2499.00),
    (5132, 'Smartphone', 2, 14999.00),
    (5134, 'Laptop', 2, 49999.00),
    (2106, 'The Immortals of Meluha', 3, 299.00),
    (3116, 'Refrigerator', 4, 24999.00),
    (3117, 'Washing Machine', 4, 17999.00),
    (1461, 'Gold Necklace', 5, 75000.00),
    (1470, 'Diamond Earrings', 5, 35000.00);

-- Insert into "Categories" table
INSERT INTO Categories (category_id, category_name)
VALUES
    ('1', 'Clothing'),
    ('2', 'Electronics'),
    ('3', 'Books'),
    ('4', 'Home Appliances'),
    ('5', 'Jewellery');    



-- Insert data into "Orders" table
INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
    (5516, 101, '2023-04-01'),
    (5518, 102, '2023-04-05'),
    (5519, 103, '2023-04-10'),
    (5520, 101, '2023-04-15'),
    (5521, 104, '2023-04-20');

-- Insert data into "Order_details" table
INSERT INTO Order_details (order_id, product_id, quantity)
VALUES
    (5516, 5134, 2),
    (5516, 2106, 1),
    (5518, 5132, 4),
    (5518, 4325, 1),
    (5519, 1470, 2),
    (5519, 3116, 1),
    (5520, 4321, 1),
    (5520, 3117, 1),
    (5521, 1461, 1);

CREATE VIEW monthly_sales AS
SELECT
	p.product_id,
    p.product_name,
    MONTH(o.order_date) AS order_month,
    YEAR(o.order_date) AS order_year,
    SUM(p.price * od.quantity) AS total_sales,
    SUM(od.quantity) AS total_quantity
FROM
    Products p
JOIN
    Order_details od ON p.product_id = od.product_id
JOIN
    Orders o ON od.order_id = o.order_id
GROUP BY
	p.product_id,
    p.product_name,
    MONTH(o.order_date),
    YEAR(o.order_date);
   
SELECT*FROM monthly_sales;
drop view monthly_sales;

-- Question 2
-- Create the MATCH table
CREATE TABLE MATCH_(
    Day INT,
    HomeTeam VARCHAR(50),
    AwayTeam VARCHAR(50),
    HomeGoal INT,
    AwayGoal INT,
    PRIMARY KEY (Day, HomeTeam, AwayTeam)
);

-- Create the STANDING table
CREATE TABLE STANDING (
    Day INT,
    Team VARCHAR(50),
    Score INT,
    PRIMARY KEY (Day, Team)
);

-- Trigger for home team victory
DELIMITER $$
CREATE TRIGGER home_team_win
AFTER INSERT ON MATCH_
FOR EACH ROW
BEGIN
    IF NEW.HomeGoal > NEW.AwayGoal THEN
        INSERT INTO STANDING (Day, Team, Score)
        VALUES (NEW.Day, NEW.HomeTeam, 3)
        ON DUPLICATE KEY UPDATE Score = Score + 3;

        INSERT INTO STANDING (Day, Team, Score)
        VALUES (NEW.Day, NEW.AwayTeam, 0)
        ON DUPLICATE KEY UPDATE Score = Score + 0;
    END IF;
END$$
DELIMITER ;

-- Trigger for away team victory
DELIMITER $$
CREATE TRIGGER away_team_win
AFTER INSERT ON MATCH_
FOR EACH ROW
BEGIN
    IF NEW.AwayGoal > NEW.HomeGoal THEN
        INSERT INTO STANDING (Day, Team, Score)
        VALUES (NEW.Day, NEW.AwayTeam, 3)
        ON DUPLICATE KEY UPDATE Score = Score + 3;

        INSERT INTO STANDING (Day, Team, Score)
        VALUES (NEW.Day, NEW.HomeTeam, 0)
        ON DUPLICATE KEY UPDATE Score = Score + 0;
    END IF;
END$$
DELIMITER ;

-- Trigger for tie
DELIMITER $$
CREATE TRIGGER tie_game
AFTER INSERT ON MATCH_
FOR EACH ROW
BEGIN
    IF NEW.HomeGoal = NEW.AwayGoal THEN
        INSERT INTO STANDING (Day, Team, Score)
        VALUES (NEW.Day, NEW.HomeTeam, 1)
        ON DUPLICATE KEY UPDATE Score = Score + 1;

        INSERT INTO STANDING (Day, Team, Score)
        VALUES (NEW.Day, NEW.AwayTeam, 1)
        ON DUPLICATE KEY UPDATE Score = Score + 1;
    END IF;
END$$
DELIMITER ;

-- Insert data into MATCH_ table to see standings and use triggers
INSERT INTO MATCH_ (Day, HomeTeam, AwayTeam, HomeGoal, AwayGoal)
VALUES
	(1, 'Team C', 'Team B', 1, 2),
    (1, 'Team D', 'Team A', 2, 1),
    (2, 'Team A', 'Team B', 1, 0),
    (2, 'Team C', 'Team D', 2, 1),
    (3, 'Team A', 'Team C', 2, 2),
    (3, 'Team B', 'Team D', 1, 1),
    (4, 'Team C', 'Team B', 0, 2),
    (4, 'Team D', 'Team A', 3, 1),
    (5, 'Team A', 'Team B', 1, 0),
    (5, 'Team C', 'Team D', 2, 1),
	(6, 'Team A', 'Team C', 7, 2),
    (6, 'Team B', 'Team D', 0, 1),
    (7, 'Team C', 'Team B', 0, 2),
    (7, 'Team D', 'Team A', 3, 4),
    (8, 'Team A', 'Team B', 1, 0),
    (8, 'Team C', 'Team D', 2, 1),
	(9, 'Team A', 'Team C', 3, 2),
    (9, 'Team B', 'Team D', 0, 1),
    (10, 'Team C', 'Team B', 5, 3),
    (10, 'Team D', 'Team A', 3, 4),
    (11, 'Team A', 'Team B', 1, 0),
    (11, 'Team C', 'Team D', 0, 1);


SELECT 
    team, SUM(score) AS totalscore
FROM
    (SELECT 
        team, score
    FROM
        standing
    WHERE
        day <= (SELECT 
                MAX(day)
            FROM
                standing)) AS subquery
GROUP BY team
ORDER BY totalscore DESC;

-- select*from standing order by day asc;

SELECT 
    s1.Day,
    s1.Team,
    SUM(s2.Score) AS TotalScore
FROM 
    Standing AS s1
JOIN 
    Standing AS s2 ON s1.Team = s2.Team AND s1.Day >= s2.Day
GROUP BY 
    s1.Day, s1.Team
ORDER BY 
    s1.Day, TotalScore DESC;
