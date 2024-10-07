Create database JokingInventory;
go
use JokingInventory;
go


CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(50) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(50) NOT NULL
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Item (
    ItemID INT PRIMARY KEY IDENTITY,
    CategoryID INT NOT NULL,
    ItemName NVARCHAR(50) NOT NULL,
    ItemDescription TEXT,
    SalePrice DECIMAL(10, 2),
    Qty INT
);

CREATE TABLE StockMovement (
    MovementID INT PRIMARY KEY IDENTITY,
    ItemID INT,
    Qty INT,
    MovementType VARCHAR(10) NOT NULL,
    MovementDate DATE
);

CREATE TABLE TransactionLog (
    LogID INT PRIMARY KEY IDENTITY,
    MovementID INT,
    UserID INT,
    LogTimeStamp TIMESTAMP ,
	constraint fk_movementID_movement foreign key (MovementID) references StockMovement(MovementID),
);

CREATE TABLE OrderHeader (
    OrderID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    CONSTRAINT FK_OrderHeader_Customer FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY IDENTITY,
    OrderID INT,
    ItemID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    CONSTRAINT FK_OrderDetail_OrderHeader FOREIGN KEY (OrderID) REFERENCES OrderHeader (OrderID),
    CONSTRAINT FK_OrderDetail_Item FOREIGN KEY (ItemID) REFERENCES Item (ItemID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    CONSTRAINT FK_Payment_OrderHeader FOREIGN KEY (OrderID) REFERENCES OrderHeader (OrderID)
);