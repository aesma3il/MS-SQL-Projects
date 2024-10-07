CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,2),
    CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    ProductName NVARCHAR(50) NOT NULL,
    Quantity INT,
    Price DECIMAL(10,2),
    Picture VARBINARY(MAX),
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50),
    Telephone NVARCHAR(20),
    Email NVARCHAR(50),
    Picture VARBINARY(MAX)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,2) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT FK_OrderDetails_Order FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_OrderDetails_Product FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50),
    Username NVARCHAR(50) NOT NULL,
    Pass NVARCHAR(50) NOT NULL
);