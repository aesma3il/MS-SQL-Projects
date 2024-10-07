--CREATE DATABASE SuperMarket1;
--GO

--USE SuperMarket1;
--GO

CREATE TABLE tbl_Customers (
   CustomerID INT PRIMARY KEY,
   FirstName VARCHAR(50) NOT NULL,
   LastName VARCHAR(50) NOT NULL,
   Email VARCHAR(100) UNIQUE,
   Phone VARCHAR(20) UNIQUE,
   Address1 VARCHAR(100),
   City VARCHAR(50),
   ZipCode VARCHAR(20),
   Country VARCHAR(50)
);

CREATE TABLE Categories (
   CategoryID INT PRIMARY KEY,
   CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(50) NOT NULL,
   Price FLOAT NOT NULL,
   CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
   QuantityInStock INT NOT NULL DEFAULT 0,
   CONSTRAINT CHK_Price CHECK (Price >= 0),
   CONSTRAINT CHK_QuantityInStock CHECK (QuantityInStock >= 0)
);

CREATE TABLE tbl_Orders (
   OrderID INT PRIMARY KEY,
   CustomerID INT FOREIGN KEY REFERENCES tbl_Customers(CustomerID),
   OrderDate DATETIME NOT NULL,
   TotalAmount FLOAT NOT NULL,
   CONSTRAINT CHK_TotalAmount CHECK (TotalAmount >= 0)
);

CREATE TABLE OrderDetails (
   OrderID INT FOREIGN KEY REFERENCES tbl_Orders(OrderID),
   ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
   Quantity INT NOT NULL,
   PricePerUnit FLOAT NOT NULL,
   CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID),
   CONSTRAINT CHK_Quantity CHECK (Quantity > 0),
   CONSTRAINT CHK_PricePerUnit CHECK (PricePerUnit >= 0)
);


