--CREATE DATABASE SimpleBookstore;
use SimpleBookstore


CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1, 1),
    CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Author (
    AuthorID INT PRIMARY KEY IDENTITY(1, 1),
    AuthorName NVARCHAR(100) NOT NULL,
    Nationality NVARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Bio TEXT NULL
);

CREATE TABLE Book (
    BookID INT PRIMARY KEY IDENTITY(1, 1),
    AuthorID INT,
    CategoryID INT,
    PublicationDate DATE,
    Title NVARCHAR(100) NOT NULL,
    ISBN NVARCHAR(50) NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    CONSTRAINT FK_Book_Author FOREIGN KEY (AuthorID) REFERENCES Author (AuthorID),
    CONSTRAINT FK_Book_Category FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

CREATE TABLE UserAccount (
    AccountID INT PRIMARY KEY IDENTITY(1, 1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    PasswordHash VARCHAR(50) NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(50) NOT NULL
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1, 1),
    PaymentDate DATE DEFAULT GETDATE(),
    Amount DECIMAL(10, 2) NOT NULL,
    UserID INT NOT NULL,
    CONSTRAINT FK_Payment_User FOREIGN KEY (UserID) REFERENCES UserAccount (AccountID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1, 1),
    CustomerID INT NOT NULL,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    UserID INT NOT NULL,
    PaymentID INT NOT NULL,
    CONSTRAINT FK_Order_Payment FOREIGN KEY (PaymentID) REFERENCES Payment (PaymentID),
    CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
    CONSTRAINT FK_Order_User FOREIGN KEY (UserID) REFERENCES UserAccount (AccountID)
);

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1, 1),
    OrderID INT NOT NULL,
    BookID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10, 2) NOT NULL,
    SubTotal AS (Quantity * UnitPrice),
	CONSTRAINT FK_OrderItem_Book FOREIGN KEY(BookID) REFERENCES Book(BookID),
	CONSTRAINT FK_OrderItem_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


CREATE INDEX IX_BookTtile ON Book(Title);
CREATE INDEX IX_CustomerEmail ON Customer(Email);