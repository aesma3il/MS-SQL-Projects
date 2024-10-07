--create database MultiTierPricingStructure
--go
--use MultiTierPricingStructure
--go
-- Create Customer table
CREATE TABLE Customer (
    ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Fax VARCHAR(20)
);

-- Create PricingTier table
CREATE TABLE PricingTier (
    TierID INT PRIMARY KEY,
    TierName VARCHAR(50) NOT NULL,
    Description VARCHAR(255)
);

-- Create TierRate table
CREATE TABLE TierRate (
    TierID INT,
    MinQuantity INT,
    MaxQuantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (TierID) REFERENCES PricingTier(TierID)
);

-- Create Product table with TierID foreign key
CREATE TABLE Product (
    ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Unit VARCHAR(50),
    Price DECIMAL(10, 2),
    IsContinued BIT,
    TierID INT,
    FOREIGN KEY (TierID) REFERENCES PricingTier(TierID)
);

-- Create InvoiceHeader table
CREATE TABLE InvoiceHeader (
    ID INT PRIMARY KEY,
    InvoiceNumber VARCHAR(50),
    CustomerID INT,
    InvoiceDate DATE,
    Description VARCHAR(255),
    TaxRate DECIMAL(10, 2),
    Other DECIMAL(10, 2),
    Discount DECIMAL(10, 2),
    SubTotal DECIMAL(10, 2),
    InvoiceTotal DECIMAL(10, 2),
    Note VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customer(ID)
);

-- Create InvoiceDetail table with TierID foreign key
CREATE TABLE InvoiceDetail (
    DetailID INT PRIMARY KEY,
    InvoiceID INT,
    ProductID INT,
    Qty INT,
    UnitPrice DECIMAL(10, 2),
    Discount DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    TierID INT,
    FOREIGN KEY (InvoiceID) REFERENCES InvoiceHeader(ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ID),
    FOREIGN KEY (TierID) REFERENCES PricingTier(TierID)
);


-- Create SalesSummary table
CREATE TABLE SalesSummary (
    Year INT,
    Month INT,
    TotalSales DECIMAL(10, 2),
    PRIMARY KEY (Year, Month)
);

-- Populate SalesSummary table with aggregated data
Create view vw_SalesSummary as
SELECT
    YEAR(ih.InvoiceDate) AS Year,
    MONTH(ih.InvoiceDate) AS Month,
    SUM(id.Total) AS TotalSales
FROM
    InvoiceHeader ih
    JOIN InvoiceDetail id ON ih.ID = id.InvoiceID
GROUP BY
    YEAR(ih.InvoiceDate),
    MONTH(ih.InvoiceDate);



-- Create CustomerSales table
CREATE TABLE CustomerSales (
    CustomerID INT,
    CustomerName VARCHAR(100),
    TotalSales DECIMAL(10, 2),
    PRIMARY KEY (CustomerID)
);

-- Populate CustomerSales table with customer sales data
INSERT INTO CustomerSales (CustomerID, CustomerName, TotalSales)
create view vw_CustomerSales as
SELECT
    ih.CustomerID,
    c.Name AS CustomerName,
    SUM(id.Total) AS TotalSales
FROM
    InvoiceHeader ih
    JOIN InvoiceDetail id ON ih.ID = id.InvoiceID
    JOIN Customer c ON ih.CustomerID = c.ID
GROUP BY
    ih.CustomerID,
    c.Name;




-- Create ProductSales table
CREATE TABLE ProductSales (
    ProductID INT,
    ProductName VARCHAR(100),
    TotalSales DECIMAL(10, 2),
    PRIMARY KEY (ProductID)
);

-- Populate ProductSales table with product sales data
INSERT INTO ProductSales (ProductID, ProductName, TotalSales)
Create view vw_ProductSales as
SELECT
    id.ProductID,
    p.Name AS ProductName,
    SUM(id.Total) AS TotalSales
FROM
    InvoiceDetail id
    JOIN Product p ON id.ProductID = p.ID
GROUP BY
    id.ProductID,
    p.Name;