CREATE TABLE UserAccount (
    UserId INT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    CONSTRAINT UC_UserAccount_Username UNIQUE (Username),
    CONSTRAINT UC_UserAccount_Email UNIQUE (Email)
);

CREATE TABLE UserInformation (
    UserId INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20),
    FOREIGN KEY (UserId) REFERENCES UserAccount(UserId)
);

CREATE TABLE Category (
    CategoryId INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Book (
    BookId INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CategoryId INT,
    CONSTRAINT FK_Book_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20)
);

CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    CustomerId INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE OrderItems (
    OrderItemId INT PRIMARY KEY,
    OrderId INT,
    BookId INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_OrderItems_Order FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_OrderItems_Book FOREIGN KEY (BookId) REFERENCES Book(BookId)
);

CREATE TABLE Payment (
    PaymentId INT PRIMARY KEY,
    OrderId INT,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Payment_Order FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);