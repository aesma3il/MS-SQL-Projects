--create database ProductManagementDB;
--use ProductManagementDB
-- Create the Country table
-- Create the Country table
CREATE TABLE Country (
	ID INT IDENTITY(1,1) UNIQUE,
    CountryID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CountryName NVARCHAR(100) NOT NULL
);

-- Create the Person table
CREATE TABLE Person (
ID INT IDENTITY(1,1) UNIQUE,
    PersonID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    NationalNo NVARCHAR(100) UNIQUE,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Gender CHAR(1),
    BirthDate DATE,
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    ImagePath NVARCHAR(255),
    CountryID UNIQUEIDENTIFIER,
    FOREIGN KEY (CountryID) REFERENCES Country (CountryID)
);

-- Create the Customer table
CREATE TABLE Customer (
	ID INT IDENTITY(1,1) UNIQUE,
    CustomerID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PersonID UNIQUEIDENTIFIER,
    CreatedAt DATETIME,
    CreatedBy UNIQUEIDENTIFIER,
    FOREIGN KEY (PersonID) REFERENCES Person (PersonID)
);

-- Create the Users table
CREATE TABLE Users (
	ID INT IDENTITY(1,1) UNIQUE,
    UserID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Username NVARCHAR(100) UNIQUE,
    Password NVARCHAR(100),
    Permission NVARCHAR(100),
    IsActive BIT,
    PersonID UNIQUEIDENTIFIER,
    CreatedAt DATETIME,
    CreatedBy UNIQUEIDENTIFIER,
    FOREIGN KEY (PersonID) REFERENCES Person (PersonID)
);

-- Create the Category table
CREATE TABLE Category (
	ID INT IDENTITY(1,1) UNIQUE,
    CategoryID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CategoryName NVARCHAR(100) NOT NULL
);

-- Create the Product table
CREATE TABLE Product (
	ID INT IDENTITY(1,1) UNIQUE,
    ProductID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ProductCode NVARCHAR(100) UNIQUE,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2),
    Qty INT,
    CategoryID UNIQUEIDENTIFIER,
    CreatedAt DATETIME,
    CreatedBy UNIQUEIDENTIFIER,
    FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

-- Create the Transactions table
CREATE TABLE Transactions (
	ID INT IDENTITY(1,1) UNIQUE,
    TransactionID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TransactionNumber NVARCHAR(100) UNIQUE,
    TransactionDate DATE,
    TransactionAmount DECIMAL(10, 2),
    Description NVARCHAR(255),
    CustomerID UNIQUEIDENTIFIER,
    CreatedAt DATETIME,
    CreatedBy UNIQUEIDENTIFIER,
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

-- Create the TransactionDetail table
CREATE TABLE TransactionDetail (
	ID INT IDENTITY(1,1) UNIQUE,
    DetailID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TransactionID UNIQUEIDENTIFIER,
    ProductID UNIQUEIDENTIFIER,
    Price DECIMAL(10, 2),
    Qty INT,
    TotalLine DECIMAL(10, 2),
    FOREIGN KEY (TransactionID) REFERENCES Transactions (TransactionID),
    FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);

-- Create the GeneralLedger table
CREATE TABLE GeneralLedger (
	ID INT IDENTITY(1,1) UNIQUE,
    LedgerID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CustomerID UNIQUEIDENTIFIER,
    Debit DECIMAL(10, 2),
    Credit DECIMAL(10, 2),
    Description NVARCHAR(255),
    TransactionDate DATE,
    TransactionID UNIQUEIDENTIFIER,
    CreatedAt DATETIME,
    CreatedBy UNIQUEIDENTIFIER,
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions (TransactionID)
);