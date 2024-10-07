CREATE DATABASE dbTransactions
Go
use dbTransactions
GO



CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL,
   
);

CREATE TABLE Item (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    CategoryID INT NOT NULL,
    ItemName VARCHAR(50) NOT NULL,
    [Description] VARCHAR(100) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY IDENTITY(1,1),
    TransactionTypeName VARCHAR(50) NOT NULL
   
);

CREATE TABLE TransactionHeader (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    TransactionTypeID INT NOT NULL,
	
    [Date] DATE DEFAULT GETDATE(),
    ResponsibleParty VARCHAR(50) NOT NULL,
    FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(TransactionTypeID)
);

ALTER TABLE TransactionHeader
add [Description] VARCHAR(200) NOT NULL


CREATE TABLE TransactionDetail (
    DetailID INT PRIMARY KEY IDENTITY(2,2),
    TransactionID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    AdditionalDetails VARCHAR(100) NULL,
    FOREIGN KEY (TransactionID) REFERENCES TransactionHeader(TransactionID)
);



INSERT INTO Category (CategoryName, [Description])
VALUES
    ('Produce', 'Fresh fruits and vegetables'),
    ('Dairy', 'Milk, cheese, and other dairy products'),
    ('Meat and Poultry', 'Fresh and frozen meat and poultry'),
    ('Bakery', 'Breads, pastries, and baked goods'),
    ('Canned Goods', 'Canned fruits, vegetables, and soups'),
    ('Snacks', 'Chips, cookies, and snack items'),
    ('Beverages', 'Soft drinks, juices, and bottled water'),
    ('Frozen Foods', 'Frozen meals, vegetables, and desserts'),
    ('Condiments', 'Sauces, dressings, and spices'),
    ('Grains and Pasta', 'Rice, pasta, and other grain products');




-- Inserting records into the Item table for the 'Produce' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (1, 'Apples', 'Fresh and juicy red apples'),
    (1, 'Bananas', 'Ripe and yellow bananas'),
    (1, 'Lettuce', 'Crisp and green lettuce'),
    (1, 'Tomatoes', 'Ripe and juicy tomatoes');

-- Inserting records into the Item table for the 'Dairy' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (2, 'Milk', 'Fresh cows milk'),
    (2, 'Cheese', 'Assorted cheese varieties'),
    (2, 'Yogurt', 'Creamy and flavored yogurt');

-- Inserting records into the Item table for the 'Meat and Poultry' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (3, 'Chicken Breast', 'Boneless chicken breast'),
    (3, 'Ground Beef', 'Lean ground beef'),
    (3, 'Pork Chops', 'Tender and juicy pork chops');

-- Inserting records into the Item table for the Bakery' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (4, 'Baguette', 'Freshly baked French baguette'),
    (4, 'Croissant', 'Buttery and flaky croissant'),
    (4, 'Cupcakes', 'Assorted flavors of cupcakes');

-- Inserting records into the Item table for the Canned Goods' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (5, 'Canned Peaches', 'Sweet and juicy canned peaches'),
    (5, 'Canned Corn', 'Golden and flavorful canned corn');

-- Inserting records into the Item table for the Snacks' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (6, 'Potato Chips', 'Crunchy and salty potato chips'),
    (6, 'Chocolate Cookies', 'Rich and indulgent chocolate cookies');

-- Inserting records into the Item table for the Beverages' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (7, 'Cola', 'Carbonated cola drink'),
    (7, 'Orange Juice', 'Freshly squeezed orange juice');

-- Inserting records into the Item table for the 'Frozen Foods' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (8, 'Frozen Pizza', 'Delicious and cheesy frozen pizza'),
    (8, 'Ice Cream', 'Assorted flavors of creamy ice cream');

-- Inserting records into the Item table for the 'Condiments' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (9, 'Ketchup', 'Classic tomato ketchup'),
    (9, 'Mayonnaise', 'Creamy and tangy mayonnaise');

-- Inserting records into the Item table for the Grains and Pasta' category
INSERT INTO Item (CategoryID, ItemName, [Description])
VALUES
    (10, 'Rice', 'Long-grain white rice'),
    (10, 'Spaghetti', 'Traditional spaghetti pasta');


	INSERT INTO TransactionType (TransactionTypeName, [Description])
VALUES ('Stock in', 'stock incoming'),
       ('Stock out', 'stock outgoing');


	 INSERT INTO [Transaction] (TransactionTypeID, ResponsibleParty,[Description])
VALUES (1,  'abdullah esmail', 'purchase of groceries');


-- Assuming the TransactionID of the transaction we want to associate the details with is 1

INSERT INTO TransactionDetail (TransactionID, ItemID, Quantity, Price, AdditionalDetails)
VALUES
    (1, 1, 33, 2.99, 'Special discount applied'),
    (1, 2, 55, 1.49, NULL),
    (1, 3, 18, 3.99, 'Organic product'),
    (1, 4, 49, 0.99, 'Buy one, get one free'),
    (1, 5, 29, 4.50, 'Limited stock');

	SELECT *
FROM Category;

SELECT Item.*, Category.CategoryName
FROM Item
JOIN Category ON Item.CategoryID = Category.CategoryID;



SELECT *
FROM TransactionType;


--Retrieve all transactions with their details:
SELECT  [Transaction].*, TransactionDetail.*
FROM [Transaction]
JOIN TransactionDetail ON [Transaction].TransactionID = TransactionDetail.TransactionID;

--Retrieve a summary of transactions by transaction type:
SELECT TransactionType.TransactionTypeName, COUNT([Transaction].TransactionID) AS TransactionCount
FROM TransactionType
LEFT JOIN [Transaction] ON TransactionType.TransactionTypeID = [Transaction].TransactionTypeID
GROUP BY TransactionType.TransactionTypeName;

--Retrieve a summary of transaction details by item:
SELECT Item.ItemName, SUM(TransactionDetail.Quantity) AS TotalQuantity, SUM(TransactionDetail.Price) AS TotalPrice
FROM Item
LEFT JOIN TransactionDetail ON Item.ItemID = TransactionDetail.ItemID
GROUP BY Item.ItemName;

--Retrieve a detailed report of transactions with item details:
SELECT [Transaction].TransactionID, [Transaction].ResponsibleParty, [Transaction].Description AS TransactionDescription,
       Item.ItemName, TransactionDetail.Quantity, TransactionDetail.Price, TransactionDetail.AdditionalDetails
FROM [Transaction]
JOIN TransactionDetail ON [Transaction].TransactionID = TransactionDetail.TransactionID
JOIN Item ON TransactionDetail.ItemID = Item.ItemID;

--Retrieve a sales report showing the total sales amount for each transaction:
SELECT [Transaction].TransactionID, [Transaction].ResponsibleParty, SUM(TransactionDetail.Quantity * TransactionDetail.Price) AS TotalSalesAmount
FROM [Transaction]
JOIN TransactionDetail ON [Transaction].TransactionID = TransactionDetail.TransactionID
GROUP BY [Transaction].TransactionID, [Transaction].ResponsibleParty;

--Retrieve a sales report showing the total sales amount for each transaction
SELECT Item.ItemName, SUM(TransactionDetail.Quantity) AS TotalQuantitySold
FROM Item
JOIN TransactionDetail ON Item.ItemID = TransactionDetail.ItemID
GROUP BY Item.ItemName
ORDER BY TotalQuantitySold DESC;

--Retrieve a report showing the total sales amount for each category
SELECT Category.CategoryName, SUM(TransactionDetail.Quantity * TransactionDetail.Price) AS TotalSalesAmount
FROM Category
JOIN Item ON Category.CategoryID = Item.CategoryID
JOIN TransactionDetail ON Item.ItemID = TransactionDetail.ItemID
GROUP BY Category.CategoryName;

--Retrieve a report showing the total sales amount for each month:
SELECT YEAR([Transaction].[Date]) AS Year, MONTH([Transaction].[Date]) AS Month, SUM(TransactionDetail.Quantity * TransactionDetail.Price) AS TotalSalesAmount
FROM [Transaction]
JOIN TransactionDetail ON [Transaction].TransactionID = TransactionDetail.TransactionID
GROUP BY YEAR([Transaction].[Date]), MONTH([Transaction].[Date])
ORDER BY Year, Month;


--Daily 
SELECT [Transaction].[Date] AS TransactionDate, SUM(TransactionDetail.Quantity * TransactionDetail.Price) AS TotalSalesAmount
FROM [Transaction]
JOIN TransactionDetail ON [Transaction].TransactionID = TransactionDetail.TransactionID
GROUP BY [Transaction].[Date]
ORDER BY [Transaction].[Date];


--Retrieve a report showing the average price of items in each category:
SELECT Category.CategoryName, AVG(TransactionDetail.Price) AS AveragePrice
FROM Category
JOIN Item ON Category.CategoryID = Item.CategoryID
JOIN TransactionDetail ON Item.ItemID = TransactionDetail.ItemID
GROUP BY Category.CategoryName;




select * from [Transaction]


--Retrieve a summary of transactions by transaction type:
SELECT TransactionType.TransactionTypeName, COUNT([Transaction].TransactionID) AS TransactionCount
FROM TransactionType
LEFT JOIN [Transaction] ON TransactionType.TransactionTypeID = [Transaction].TransactionTypeID
GROUP BY TransactionType.TransactionTypeName;

--------------------new schema

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);



CREATE TABLE TransactionMode (
    TransactionModeID INT PRIMARY KEY IDENTITY(1,1),
    TransactionModeName VARCHAR(50) NOT NULL,
    [Description] VARCHAR(100) NOT NULL
);

CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY IDENTITY(1,1),
    TransactionModeID INT NOT NULL,
    TransactionTypeName VARCHAR(50) NOT NULL,
    [Description] VARCHAR(100) NOT NULL,
    FOREIGN KEY (TransactionModeID) REFERENCES TransactionMode(TransactionModeID)
);

CREATE TABLE TransactionHeader (
    TransactionHeaderID INT PRIMARY KEY IDENTITY(1,1),
    TransactionModeID INT NOT NULL,
    TransactionTypeID INT NOT NULL,
    [Date] DATE DEFAULT GETDATE(),
    ResponsibleParty VARCHAR(50) NOT NULL,
    [Description] VARCHAR(200) NOT NULL,
    CustomerID INT NULL,
    SupplierID INT NULL,
    FOREIGN KEY (TransactionModeID) REFERENCES TransactionMode(TransactionModeID),
    FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(TransactionTypeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE TransactionDetail (
    DetailID INT PRIMARY KEY IDENTITY(2,2),
    TransactionHeaderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    AdditionalDetails VARCHAR(100) NULL,
    FOREIGN KEY (TransactionHeaderID) REFERENCES TransactionHeader(TransactionHeaderID)
);


-----------------------------------------------jjjjjjjjjjjjjjjjjjjj
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL,
    [Description] VARCHAR(100) NOT NULL
);

CREATE TABLE Item (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    CategoryID INT NOT NULL,
    ItemName VARCHAR(50) NOT NULL,
    [Description] VARCHAR(100) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE TransactionMode (
    TransactionModeID INT PRIMARY KEY IDENTITY(1,1),
    TransactionModeName VARCHAR(50) NOT NULL,
    [Description] VARCHAR(100) NOT NULL
);

CREATE TABLE TransactionHeader (
    TransactionHeaderID INT PRIMARY KEY IDENTITY(1,1),
    TransactionModeID INT NOT NULL,	
    [Date] DATE DEFAULT GETDATE(),
    ResponsibleParty VARCHAR(50) NOT NULL,
    [Description] VARCHAR(200) NOT NULL,
    CustomerID INT NULL,
    SupplierID INT NULL,
    FOREIGN KEY (TransactionModeID) REFERENCES TransactionMode(TransactionModeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE TransactionDetail (
    DetailID INT PRIMARY KEY IDENTITY(2,2),
    TransactionHeaderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    AdditionalDetails VARCHAR(100) NULL,
    FOREIGN KEY (TransactionHeaderID) REFERENCES TransactionHeader(TransactionHeaderID)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);