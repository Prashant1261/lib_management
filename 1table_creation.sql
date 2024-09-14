-- drop table if exists branch;
-- create table branch(
-- 			branch_id VARCHAR(10) PRIMARY KEY,
-- 			manager_id VARCHAR(10),
-- 			branch_address VARCHAR(50),
-- 			contact_no VARCHAR(15)
-- );

-- drop table if exists employees;
-- create table employees(
-- 		emp_id VARCHAR(10) PRIMARY KEY,
-- 		emp_name VARCHAR(30),
-- 		position VARCHAR(30),
-- 		salary DECIMAL(10,2),
-- 		branch_id VARCHAR(10),
-- 		FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
-- );


-- drop table if exists members;
-- create table members(
-- 			member_id VARCHAR(10) PRIMARY KEY,
--             member_name VARCHAR(30),
--             member_address VARCHAR(30),
--             reg_date DATE
-- );


-- DROP TABLE IF EXISTS books;
-- CREATE TABLE books
-- (
--             isbn VARCHAR(50) PRIMARY KEY,
--             book_title VARCHAR(80),
--             category VARCHAR(30),
--             rental_price DECIMAL(10,2),
--             status VARCHAR(10),
--             author VARCHAR(30),
--             publisher VARCHAR(30)
-- );


-- DROP TABLE IF EXISTS issued_status;
-- CREATE TABLE issued_status
-- (
--             issued_id VARCHAR(10) PRIMARY KEY,
--             issued_member_id VARCHAR(30),
--             issued_book_name VARCHAR(80),
--             issued_date DATE,
--             issued_book_isbn VARCHAR(50),
--             issued_emp_id VARCHAR(10),
-- 			FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
-- 			FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
-- 			FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn)
-- );


-- DROP TABLE IF EXISTS return_status;
-- CREATE TABLE return_status
-- (
--             return_id VARCHAR(10) PRIMARY KEY,
--             issued_id VARCHAR(30),
--             return_book_name VARCHAR(80),
--             return_date DATE,
--             return_book_isbn VARCHAR(50),
-- 			FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
-- );

-- INSERT INTO return_status(return_id, issued_id, return_date) 
-- VALUES
-- ('RS101', 'IS101', '2023-06-06'),
-- ('RS102', 'IS105', '2023-06-07'),
-- ('RS103', 'IS103', '2023-08-07'),
-- ('RS104', 'IS106', '2024-05-01'),
-- ('RS105', 'IS107', '2024-05-03'),
-- ('RS106', 'IS108', '2024-05-05'),
-- ('RS107', 'IS109', '2024-05-07'),
-- ('RS108', 'IS110', '2024-05-09'),
-- ('RS109', 'IS111', '2024-05-11'),
-- ('RS110', 'IS112', '2024-05-13'),
-- ('RS111', 'IS113', '2024-05-15'),
-- ('RS112', 'IS114', '2024-05-17'),
-- ('RS113', 'IS115', '2024-05-19'),
-- ('RS114', 'IS116', '2024-05-21'),
-- ('RS115', 'IS117', '2024-05-23'),
-- ('RS116', 'IS118', '2024-05-25'),
-- ('RS117', 'IS119', '2024-05-27'),
-- ('RS118', 'IS120', '2024-05-29');
-- SELECT * FROM issued_status;

select * from branch;

select * from employees;

select * from members;

select * from books;

select * from issued_status;

select * from return_status;

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books(isbn, book_title, category, rental_price, status, author, publisher)
	VALUES
		('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

select * from books;

-- Task 2: Update an Existing Member's Address

update members
set member_address = '125 Main St'
where member_id = 'C101';

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

select * from issued_status
where issued_id = 'IS121';

delete from issued_status
where issued_id = 'IS121'

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
	isu.issued_emp_id, 
	e.emp_name
FROM issued_status isu
join employees e
		on isu.issued_emp_id = e.emp_id
group by 1,2;

-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

-- create table book_cnts
-- as
-- select
-- 	b.isbn,
-- 	b.book_title,
-- 	count(ist.issued_id)
-- from
-- 	books b
-- join
-- 	issued_status ist
-- on 
-- 	b.isbn = ist.issued_book_isbn
-- group by 1,2
	
select * from book_cnts;

-- Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Classic'

-- Task 8: Find Total Rental Income by Category:

select b.category,
	   sum(b.rental_price),
	   count(*)
from books b
join
issued_status as ist
ON ist.issued_book_isbn = b.isbn
group by 1

-- List Members Who Registered in the Last 180 Days:
select *
from members
where reg_date >= current_date - interval '180 days'

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

-- CREATE TABLE books_price_greater_than_seven
-- AS    
-- SELECT * FROM books
-- WHERE rental_price > 7

SELECT * FROM 
books_price_greater_than_seven

-- Task 12: Retrieve the List of Books Not Yet Returned
select distinct iss.issued_book_name
from issued_status iss
left join return_status rss
on rss.issued_id = iss.issued_id
where rss.return_id is NULL

SELECT * FROM return_status











