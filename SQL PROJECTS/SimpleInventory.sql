----create database SimpleInventory;
----use SimpleInventory

CREATE TABLE Suppliers (
  SupplierID INT PRIMARY KEY identity,
  SupplierName VARCHAR(255) NOT NULL,
  ContactName VARCHAR(255),
  Phone VARCHAR(20),
  Email VARCHAR(255)
);

CREATE TABLE Categories (
  CategoryID INT PRIMARY KEY identity,
  CategoryName VARCHAR(255) NOT NULL,
  Description varchar(50)
);
CREATE TABLE Inventory (
  InventoryID INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Description TEXT,
  UnitPrice DECIMAL(10, 2) NOT NULL,
  QuantityInStock INT DEFAULT 0,
  ReorderLevel INT DEFAULT 0,
  ReorderTimeInDays INT DEFAULT 0,
  QuantityInReorder INT DEFAULT 0,
  Discontinued BIT DEFAULT 0,
  SupplierID INT,
  CategoryID INT,
  FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
  FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


CREATE TABLE Transactions (
  TransactionID INT PRIMARY KEY,
  InventoryID INT,
  TransactionDate DATE,
  Quantity INT,
  TransactionType VARCHAR(50),
  FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
);


CREATE TABLE PurchaseInvoice (
  InvoiceID INT PRIMARY KEY,
  SupplierID INT,
  InvoiceDate DATE DEFAULT getdate(),
  TotalAmount DECIMAL(10, 2),
  FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE InvoiceItems (
  InvoiceItemID INT PRIMARY KEY,
  InvoiceID INT,
  InventoryID INT,
  Quantity INT,
  UnitPrice DECIMAL(10, 2),
  TotalPrice DECIMAL(10, 2) ,
  FOREIGN KEY (InvoiceID) REFERENCES PurchaseInvoice(InvoiceID),
  FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
);






































--CREATE TABLE Suppliers (
--  SupplierID INT PRIMARY KEY,
--  SupplierName VARCHAR(255),
--  ContactName VARCHAR(255),
--  Phone VARCHAR(20),
--  Email VARCHAR(255)
--);

--CREATE TABLE Categories (
--  CategoryID INT PRIMARY KEY,
--  CategoryName VARCHAR(255),
--  Description VARCHAR(255)
--);

--CREATE TABLE Inventory (
--  InventoryID INT PRIMARY KEY,
--  Name VARCHAR(255),
--  Description VARCHAR(255),
--  UnitPrice DECIMAL(10, 2),
--  QuantityInStock INT,
--  InventoryValue DECIMAL(10, 2),
--  ReorderLevel INT,
--  ReorderTimeInDays INT,
--  QuantityInReorder INT,
--  Discontinued BIT,
--  SupplierID INT,
--  CategoryID INT,
--  FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
--  FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
--);

--CREATE TABLE Transactions (
--  TransactionID INT PRIMARY KEY,
--  InventoryID INT,
--  TransactionDate DATE,
--  Quantity INT,
--  TransactionType VARCHAR(50),
--  FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
--);