--CREATE TABLE Publishers (
--    publisher_id INT PRIMARY KEY,
--    name VARCHAR(100),
--    address VARCHAR(100),
--    phone VARCHAR(20),
--    email VARCHAR(100)
--);

--CREATE TABLE Categories (
--    category_id INT PRIMARY KEY,
--    name VARCHAR(50)
--);

--CREATE TABLE Books (
--    book_id INT PRIMARY KEY,
--    title VARCHAR(100),
--    publisher_id INT,
--    category_id INT,
--    isbn VARCHAR(13),
--    year_published INT,
--    edition VARCHAR(20),
--    num_pages INT,
--    [language] VARCHAR(50),
--    [format] VARCHAR(20),
--    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id),
--    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
--);



--CREATE TABLE Authors (
--    author_id INT PRIMARY KEY,
--    first_name VARCHAR(50),
--    last_name VARCHAR(50),
--    dob DATE,
--    dod DATE,
--    country VARCHAR(50)
--);

--CREATE TABLE Members (
--    member_id INT PRIMARY KEY,
--    first_name VARCHAR(50),
--    last_name VARCHAR(50),
--    address VARCHAR(100),
--    phone VARCHAR(20),
--    email VARCHAR(100),
--    dob DATE,
--    registration_date DATE
--);

--CREATE TABLE Loans (
--    loan_id INT PRIMARY KEY,
--    book_id INT,
--    member_id INT,
--    loan_date DATE,
--    due_date DATE,
--    return_date DATE,
--    fine_amount DECIMAL(10, 2),
--    FOREIGN KEY (book_id) REFERENCES Books(book_id),
--    FOREIGN KEY (member_id) REFERENCES Members(member_id)
--);

--CREATE TABLE Reservations (
--    reservation_id INT PRIMARY KEY,
--    book_id INT,
--    member_id INT,
--    reservation_date DATE,
--    pickup_date DATE,
--    cancellation_date DATE,
--    FOREIGN KEY (book_id) REFERENCES Books(book_id),
--    FOREIGN KEY (member_id) REFERENCES Members(member_id)
--);

--CREATE TABLE Fines (
--    fine_id INT PRIMARY KEY,
--    loan_id INT,
--    fine_amount DECIMAL(10, 2),
--    fine_date DATE,
--    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
--);

--CREATE TABLE Employees (
--    employee_id INT PRIMARY KEY,
--    first_name VARCHAR(50),
--    last_name VARCHAR(50),
--    [address] VARCHAR(100),
--    phone VARCHAR(20),
--    email VARCHAR(100),
--    dob DATE,
--    hire_date DATE,
--    salary DECIMAL(10, 2)
--);

--CREATE TABLE Departments (
--    department_id INT PRIMARY KEY,
--    name VARCHAR(50)
--);

--CREATE TABLE Employee_Department (
--    employee_id INT,
--    department_id INT,
--    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
--    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
--);

--CREATE TABLE Administrators (
--    admin_id INT PRIMARY KEY,
--    employee_id INT,
--    username VARCHAR(50),
--    password VARCHAR(50),
--    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
--);

--CREATE TABLE Book_Author (
--    book_id INT,
--    author_id INT,
--    FOREIGN KEY (book_id) REFERENCES Books(book_id),
--    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
--);



-- Publishers
INSERT INTO Publishers (publisher_id, name, address, phone, email)
VALUES
(1, 'Penguin Books', '123 Main St, New York, NY', '555-1234', 'info@penguinbooks.com'),
(2, 'HarperCollins', '456 Elm St, Los Angeles, CA', '555-5678', 'info@harpercollins.com'),
(3, 'Random House', '789 Oak Ave, Chicago, IL', '555-9012', 'info@randomhouse.com'),
(4, 'Simon & Schuster', '321 Pine St, San Francisco, CA', '555-3456', 'info@simonandschuster.com'),
(5, 'Macmillan Publishers', '567 Maple St, Boston, MA', '555-7890', 'info@macmillanpublishers.com');

-- Categories
INSERT INTO Categories (category_id, name)
VALUES
(1, 'Fiction'),
(2, 'Non-fiction'),
(3, 'Biography'),
(4, 'History'),
(5, 'Science');

-- Authors
INSERT INTO Authors (author_id, first_name, last_name, dob, dod, country)
VALUES
(1, 'Jane', 'Austen', '1775-12-16', '1817-07-18', 'England'),
(2, 'Ernest', 'Hemingway', '1899-07-21', '1961-07-02', 'USA'),
(3, 'Toni', 'Morrison', '1931-02-18', '2019-08-05', 'USA'),
(4, 'J.K.', 'Rowling', '1965-07-31', NULL, 'England'),
(5, 'Stephen', 'Hawking', '1942-01-08', '2018-03-14', 'England'),
(6, 'Yuval', 'Noah Harari', '1976-02-24', NULL, 'Israel'),
(7, 'Angie', 'Thomas', '1987-09-20', NULL, 'USA'),
(8, 'Chimamanda Ngozi', 'Adichie', '1977-09-15', NULL, 'Nigeria'),
(9, 'Ta-Nehisi', 'Coates', '1975-09-30', NULL, 'USA'),
(10, 'Margaret', 'Atwood', '1939-11-18', NULL, 'Canada');

-- Books
INSERT INTO Books (book_id, title, publisher_id, category_id, isbn, year_published, edition, num_pages, language, format)
VALUES
(1, 'Pride and Prejudice', 1, 1, '9780141439518', 1813, 'Reprint edition', 432, 'English', 'Paperback'),
(2, 'The Old Man and the Sea', 2, 1, '9780684801223', 1952, '1st edition', 128, 'English', 'Hardcover'),
(3, 'Beloved', 3, 1, '9781400033416', 1987, '1st edition', 324, 'English', 'Paperback'),
(4, 'Harry Potter and the Philosopher''s Stone', 4, 1, '9780747532743', 1997, '1st edition', 223, 'English', 'Hardcover'),
(5, 'A Brief History of Time', 5, 2, '9780553380163', 1988, 'Reprint edition', 212, 'English', 'Paperback'),
(6, 'Sapiens: A Brief History of Humankind', 1, 2, '9780062316097', 2015, '1st edition', 464, 'English', 'Hardcover'),
(7, 'The Hate U Give', 2, 1, '9780062498533', 2017, '1st edition', 464, 'English', 'Paperback'),
(8, 'Americanah', 3, 1, '9780307271082', 2013, '1st edition', 588, 'English', 'Hardcover'),
(9, 'Between the World and Me', 4, 3, '9780812993547', 2015, '1st edition', 152, 'English', 'Paperback'),
(10, 'The Handmaid''s Tale', 5, 1, '9780385490818', 1985, '1st edition', 311, 'English', 'Hardcover');

-- Members

-- Members
INSERT INTO Members (member_id, first_name, last_name, address, phone, email, dob, registration_date)
VALUES
(1, 'John', 'Doe', '123 Main St, Anytown, USA', '555-1234', 'johndoe@email.com', '1980-01-01', '2021-01-01'),
(2, 'Jane', 'Doe', '456 Elm St, Anytown, USA', '555-5678', 'janedoe@email.com', '1985-05-01', '2021-01-15'),
(3, 'Bob', 'Smith', '789 Oak Ave, Anytown, USA', '555-9012', 'bobsmith@email.com', '1990-07-01', '2021-02-01'),
(4, 'Mary', 'Jones', '321 Pine St, Anytown, USA', '555-3456', 'maryjones@email.com', '1995-09-01', '2021-02-15'),
(5, 'Tom', 'Wilson', '567 Maple St, Anytown, USA', '555-7890', 'tomwilson@email.com', '2000-11-01', '2021-03-01');

-- Loans
INSERT INTO Loans (loan_id, book_id, member_id, loan_date, due_date, return_date, fine_amount)
VALUES
(1, 1, 1, '2021-01-01', '2021-01-08', '2021-01-09', 0),
(2, 2, 2, '2021-01-15', '2021-01-22', NULL, NULL),
(3, 3, 3, '2021-02-01', '2021-02-08', '2021-02-09', 0),
(4, 4, 4, '2021-02-15', '2021-02-22', NULL, NULL),
(5, 5, 5, '2021-03-01', '2021-03-08', '2021-03-09', 0);

-- Reservations
INSERT INTO Reservations (reservation_id, book_id, member_id, reservation_date, pickup_date, cancellation_date)
VALUES
(1, 1, 2, '2022-01-01', '2022-01-08', NULL),
(2, 2, 3, '2022-01-15', '2022-01-22', NULL),
(3, 3, 4, '2022-02-01', '2022-02-08', '2022-02-09'),
(4, 4, 5, '2022-02-15', '2022-02-22', NULL),
(5, 5, 1, '2022-03-01', '2022-03-08', '2022-03-09');

-- Fines
INSERT INTO Fines (fine_id, loan_id, fine_amount, fine_date)
VALUES
(1, 1, 0, NULL),
(2, 3, 0, NULL),
(3, 5, 0, NULL);

-- Employees
INSERT INTO Employees (employee_id, first_name, last_name, address, phone, email, dob, hire_date, salary)
VALUES
(1, 'Alice', 'Smith', '123 Main St, Anytown, USA', '555-1234', 'alice.smith@email.com', '1980-01-01', '2020-01-01', 50000),
(2, 'Bob', 'Johnson', '456 Elm St, Anytown, USA', '555-5678', 'bob.johnson@email.com', '1985-05-01', '2020-01-15', 60000),
(3, 'Charlie', 'Davis', '789 Oak Ave, Anytown, USA', '555-9012', 'charlie.davis@email.com', '1990-07-01', '2020-02-01', 70000);

-- Departments
INSERT INTO Departments (department_id, name)
VALUES
(1, 'Information Technology'),
(2, 'Human Resources'),
(3, 'Marketing');

-- Employee_Department
INSERT INTO Employee_Department (employee_id, department_id)
VALUES
(1, 1),
(2, 2),
(3, 3);

-- Administrators
INSERT INTO Administrators (admin_id, employee_id, username, password)
VALUES
(1, 1, 'admin1', 'password1'),
(2, 2, 'admin2', 'password2');