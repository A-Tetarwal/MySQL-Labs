create database ashish2;
use ashish2;

create table paymentInfo
(customer_id int primary key, customer varchar(20), paymentMode varchar(20), city varchar(20));

INSERT INTO paymentInfo (customer_id, customer, paymentMode, city) VALUES 
(101, 'Olivia Barrett', 'Netbanking', 'Portland'),
(102, 'Ethan Sinclair', 'Credit Card', 'Miami'),
(103, 'Maya Hernandez', 'Credit Card', 'Seattle'),
(104, 'Liam Donovan', 'Netbanking', 'Denver'),
(105, 'Sophia Nguyen', 'Credit Card', 'New Orleans'),
(106, 'Caleb Foster', 'Debit Card', 'Minneapolis'),
(107, 'Ava Patel', 'Debit Card', 'Phoenix'),
(108, 'Lucas Carter', 'Netbanking', 'Boston'),
(109, 'Isabella Martinez', 'Netbanking', 'Nashville'),
(110, 'Jackson Brooks', 'Credit Card', 'Boston');

select paymentMode, count(paymentMode) from paymentInfo group by paymentMode;
select * from paymentInfo;

SET SQL_SAFE_UPDATES = 0;

UPDATE paymentInfo
SET city = 'Miami'
WHERE city = 'Portland';

update paymentInfo
set paymentMode="Credit Card"
where customer = "Olivia Barrett";

