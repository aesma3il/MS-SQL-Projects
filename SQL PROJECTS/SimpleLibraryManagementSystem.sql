﻿CREATE DATABASE SimpleLibrary;
use SimpleLibrary;

-- Create Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    publisher_id INT,
    published_date DATE,
    isbn VARCHAR(20),
    quantity INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

-- Create Authors Table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Create Publishers Table
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    pname VARCHAR(100),
    paddress VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Create Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Create Borrowed Books Table
CREATE TABLE BorrowedBooks (
    borrowed_book_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrowed_date DATE,
    due_date DATE,
    returned_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Create Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);


CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);



-- Create Book Categories Table
CREATE TABLE BookCategories (
    book_category_id INT PRIMARY KEY,
    book_id INT,
    category_id INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);



--ALTERING ON THE TABLES

ALTER TABLE Authors
ADD age INT;

--DELETING ADDRESS COLUMN IN MEMBERS TABLE
ALTER TABLE Memebers
DROP COLUMN address

ALTER TABLE Members
ADD email NVARCHAR(50)

ALTER TABLE Members
ADD CONSTRAINT U_Member_Email UNIQUE(email)


ALTER TABLE Member
ADD CONSTRAINT D_MEBER_LASTNAME DEFAULT 'NULL' FOR last_name


ALTER TABLE Authors
ADD CONSTRAINT CK_AGE CHECK( age BETWEEN 16 and 90) 



--CREATING VIEWS

CREATE VIEW SelectAuthors
AS 
SELECT * FROM Authors;

DROP VIEW SelectAuthors



--INDEXING
CREATE INDEX indx_book ON Books( isbn );

DROP INDEX indx_book ON Books;


--ADDING DATA FROM ONE TABLE TO ANOTHER
INSERT INTO Category (category_id, category_name)
SELECT category_id, category_name FROM Categories;


--this will create a table called member2 and adding the data in members into it
SELECT * 
INTO Member2
FROM Members


SELECT * FROM Books
WHERE quantity = 5 AND book_id > 1

SELECT * FROM Books
WHERE quantity = 5 OR book_id > 1

SELECT book_id AS ID, title AS TITLE, author_id AS AUTHOR FROM Books
WHERE quantity = 5 OR book_id > 1


SELECT TOP 3 * FROM Books;

SELECT NEWID() AS ID, title AS TITLE FROM Books;

SELECT * FROM Books
ORDER BY NEWID();


SELECT DISTINCT author_id FROM Books;

SELECT * FROM Books
WHERE title LIKE 'A%'

SELECT * FROM Books
WHERE title LIKE '%A'


SELECT COUNT(*) FROM Books

SELECT SUM(	quantity) FROM Books;

SELECT MAX(quantity) FROM Books;
SELECT MIN(quantity) FROM Books;
SELECT AVG(quantity) FROM Books;


SELECT COUNT(author_id) AS 'NUMBER OF books the author published '
FROM Books
GROUP BY author_id;


SELECT COUNT(author_id) AS 'NUMBER OF books the author published '
FROM Books
GROUP BY author_id
HAVING author_id = 1;



--INSERTING DATA 
-- Insert data into Books Table
INSERT INTO Books VALUES (1, 'Crime and Punishment', 1, 1, '1866-01-01', '9781784871956', 5);
INSERT INTO Books VALUES (2, 'Pride and Prejudice', 2, 2, '1813-01-28', '9780486284736', 8);
INSERT INTO Books VALUES (3, 'To Kill a Mockingbird', 3, 3, '1960-07-11', '9780099549482', 6);
INSERT INTO Books VALUES (4, 'The Great Gatsby', 4, 4, '1925-04-10', '9780141182636', 7);
INSERT INTO Books VALUES (5, '1984', 5, 5, '1949-06-08', '9780452284234', 12);
INSERT INTO Books VALUES (6, 'Animal Farm', 5, 5, '1945-08-17', '9780451526342', 9);
INSERT INTO Books VALUES (7, 'One Hundred Years of Solitude', 6, 6, '1967-06-30', '9780060883287', 4);
INSERT INTO Books VALUES (8, 'Brave New World', 7, 7, '1932-02-01', '9780060850524', 3);
INSERT INTO Books VALUES (9, 'Lord of the Flies', 8, 8, '1954-09-17', '9780399501487', 5);
INSERT INTO Books VALUES (10, 'The Catcher in the Rye', 9, 9, '1951-07-16', '9780316769488', 2);

-- Insert data into Authors Table
INSERT INTO Authors VALUES (1, 'Fyodor', 'Dostoevsky');
INSERT INTO Authors VALUES (2, 'Jane', 'Austen');
INSERT INTO Authors VALUES (3, 'Harper', 'Lee');
INSERT INTO Authors VALUES (4, 'F. Scott', 'Fitzgerald');
INSERT INTO Authors VALUES (5, 'George', 'Orwell');
INSERT INTO Authors VALUES (6, 'Gabriel', 'Garcia Marquez');
INSERT INTO Authors VALUES (7, 'Aldous', 'Huxley');
INSERT INTO Authors VALUES (8, 'William', 'Golding');
INSERT INTO Authors VALUES (9, 'J.D.', 'Salinger');
INSERT INTO Authors VALUES (10, 'Leo', 'Tolstoy');

-- Insert data into Publishers Table
INSERT INTO Publishers VALUES (1, 'Vintage Classics', '20 Vauxhall Bridge Rd, London SW1V 2SA, United Kingdom', '+44 20 7840 8400');
INSERT INTO Publishers VALUES (2, 'Penguin Classics', '80 Strand, London WC2R 0RL, United Kingdom', '+44 20 3668 2000');
INSERT INTO Publishers VALUES (3, 'HarperCollins', '195 Broadway, New York, NY 10007, United States', '+1 212-207-7000');
INSERT INTO Publishers VALUES (4, 'Scribner', '1230 Avenue of the Americas, New York, NY 10020, United States', '+1 646-307-5000');
INSERT INTO Publishers VALUES (5, 'Penguin Books', '1745 Broadway, New York, NY 10019, United States', '+1 212-366-2000');
INSERT INTO Publishers VALUES (6, 'Cien anos de soledad', 'Barranquilla, Colombia', '+57 5 3727501');
INSERT INTO Publishers VALUES (7, 'Harper & Brothers', 'New York City, New York, United States', '+1 212-207-7000');
INSERT INTO Publishers VALUES (8, 'Faber and Faber', 'Bloomsbury House, 74-77 Great Russell St, Bloomsbury, London WC1B 3DA, United Kingdom', '+44 20 7927 3800');
INSERT INTO Publishers VALUES (9, 'Little, Brown and Company', '1290 Avenue of the Americas, New York, NY 10104, United States', '+1 212-364-1000');
INSERT INTO Publishers VALUES (10, 'Moscow News', 'Krasnoprudnaya ul., 16A, стр. 2, Moskva, Russia, 107140', '+7 495 644-50-40');



-- Insert data into Authors Table
INSERT INTO Authors VALUES (1, 'Paulo', 'Coelho');
INSERT INTO Authors VALUES (2, 'J.R.R.', 'Tolkien');
INSERT INTO Authors VALUES (3, 'Dan', 'Brown');
INSERT INTO Authors VALUES (4, 'Suzanne', 'Collins');
INSERT INTO Authors VALUES (5, 'Arthur Conan', 'Doyle');

-- Insert data into Publishers Table
INSERT INTO Publishers VALUES (1, 'HarperOne', '195 Broadway, New York, NY 10007, United States', '+1 212-207-7000');
INSERT INTO Publishers VALUES (2, 'Mariner Books', '222 Berkeley St, Boston, MA 02116, United States', '+1 617-351-1113');
INSERT INTO Publishers VALUES (3, 'Doubleday', '1745 Broadway, New York, NY 10019, United States', '+1 212-782-9000');
INSERT INTO Publishers VALUES (4, 'Scholastic Press', '557 Broadway, New York, NY 10012, United States', '+1 212-343-6100');
INSERT INTO Publishers VALUES (5, 'HarperPerennial Classics', '10 East 53rd Street, New York, NY 10022, United States', '+1 212-207-7000');

-- Insert data into Members Table
INSERT INTO Members VALUES (1, 'John', 'Doe', '123 Main St, Anytown USA', '+1 555-555-1234');
INSERT INTO Members VALUES (2, 'Jane', 'Doe', '456 Oak Ln, Anytown USA', '+1 555-555-5678');
INSERT INTO Members VALUES (3, 'Bob', 'Smith', '789 Elm Rd, Anytown USA', '+1 555-555-9012');
INSERT INTO Members VALUES (4, 'Samantha', 'Jones', '321 Pine Ave, Anytown USA', '+1 555-555-3456');
INSERT INTO Members VALUES (5, 'David', 'Brown', '654 Cedar Blvd, Anytown USA', '+1 555-555-7890');

-- Insert data into BorrowedBooks Table
INSERT INTO BorrowedBooks VALUES (1, 1, 1, '2023-06-01', '2023-06-29', NULL);
INSERT INTO BorrowedBooks VALUES (2, 2, 2, '2023-06-02', '2023-06-30', NULL);
INSERT INTO BorrowedBooks VALUES (3, 3, 3, '2023-06-03', '2023-07-01', NULL);
INSERT INTO BorrowedBooks VALUES (4, 4, 4, '2023-06-04', '2023-07-02', NULL);
INSERT INTO BorrowedBooks VALUES (5, 5, 5, '2023-06-05', '2023-07-03', NULL);

-- Insert data into Categories Table
INSERT INTO Categories VALUES (1, 'Fiction');
INSERT INTO Categories VALUES (2, 'Non-fiction');
INSERT INTO Categories VALUES (3, 'Mystery');
INSERT INTO Categories VALUES (4, 'Romance');
INSERT INTO Categories VALUES (5, 'Science Fiction');

-- Insert data into BookCategories Table
INSERT INTO BookCategories VALUES (1, 1, 1);
INSERT INTO BookCategories VALUES (2, 2, 2);
INSERT INTO BookCategories VALUES (3, 3, 3);
INSERT INTO BookCategories VALUES (4, 4, 4);
INSERT INTO BookCategories VALUES (5, 5, 5);
