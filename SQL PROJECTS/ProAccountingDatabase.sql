--CREATE DATABASE ProAccountingDatabase;
use ProAccountingDatabase
-- Create the Currency table
create schema Accounting.;

CREATE TABLE Accounting.Currency (
    CurrencyID INT PRIMARY KEY IDENTITY,
    CurrencyName VARCHAR(20) unique
);


-- Create the AccountType table
CREATE TABLE Accounting.AccountType (
    AccountTypeID INT PRIMARY KEY IDENTITY,
    AccountTypeName VARCHAR(20)
);

-- Create the ReportType table
CREATE TABLE Accounting.ReportType (
    ReportTypeID INT PRIMARY KEY IDENTITY,
    ReportTypeName VARCHAR(20)
);

-- Create the Accounts table
CREATE TABLE Accounting.Account (
    AccountID INT PRIMARY KEY IDENTITY,
    AccountCode INT NOT NULL,
    AccountParentID INT,
    AccountName VARCHAR(100) NOT NULL,
    AccountTypeID INT NOT NULL,
    IsDebit BIT not null ,
    Level INT,
    CurrencyID INT,
    IsLocked BIT,
    ReportTypeID INT not null,
    RelatedAccountID INT,
    CONSTRAINT FK_AccountType FOREIGN KEY (AccountTypeID)
        REFERENCES Accounting.AccountType (AccountTypeID),
    CONSTRAINT FK_Currency FOREIGN KEY (CurrencyID)
        REFERENCES Accounting.Currency (CurrencyID),
    CONSTRAINT FK_ReportType FOREIGN KEY (ReportTypeID)
        REFERENCES Accounting.ReportType (ReportTypeID),
    CONSTRAINT FK_RelatedAccount FOREIGN KEY (RelatedAccountID)
        REFERENCES Accounting.Account (AccountID),
		CONSTRAINT FK_ParentAccount FOREIGN KEY (AccountParentID)
        REFERENCES Accounting.Account (AccountID)
);


-- Insert data into the Currency table
INSERT INTO Accounting.Currency (CurrencyName)
VALUES ('USD'), ('EUR'), ('GBP');

-- Insert data into the AccountType table
INSERT INTO Accounting.AccountType (AccountTypeName)
VALUES ('Main'), ('Sub');

alter table Accounting.AccountType
add constraint UQ_AccountTypeName unique(AccountTypeName)

-- Insert data into the ReportType table
INSERT INTO Accounting.ReportType (ReportTypeName)
VALUES ('Balance Sheet'), ('Income Statement'), ('Cash Flow Statement');

alter table Accounting.ReportType
add constraint UQ_ReportTypeName unique(ReportTypeName)
alter table Accounting.Account
Add constraint UQ_AccountName unique(AccountName)
-- Insert data into the Accounts table

INSERT INTO Accounting.Account (AccountCode, AccountParentID, AccountName, AccountTypeID, IsDebit, Level, CurrencyID, IsLocked, ReportTypeID, RelatedAccountID)
VALUES (1001, NULL, 'Assets', 1, 0, 1, 1, 0, 1, NULL),
       (1002, 1, 'Cash', 2, 0, 2, 1, 0, 1, NULL),
       (1003, 1, 'Accounts Receivable', 2, 0, 2, 1, 0, 1, NULL),
       (2001, NULL, 'Liabilities', 1, 0, 1, 1, 0, 1, NULL),
       (2002, 4, 'Accounts Payable', 2, 0, 2, 1, 0, 1, NULL),
       (2003, 4, 'Loans Payable', 2, 0, 2, 1, 0, 1, NULL);

-- Verify the data in the tables
SELECT * FROM Currency;
SELECT * FROM AccountType;
SELECT * FROM ReportType;
SELECT * FROM MasterView;




-- Create a master view combining Currency, AccountType, and ReportType
CREATE VIEW Accounting.MasterView AS
SELECT 
    A.AccountID,
    A.AccountCode,
    A.AccountParentID,
    A.AccountName,
    AT.AccountTypeName,
    CASE WHEN A.IsDebit = 1 THEN 'Debit' ELSE 'Credit' END AS IsDebit,
    A.Level,
    C.CurrencyName,
	CASE WHEN A.IsLocked = 0 THEN 'Yes' ELSE 'NO' END AS IsLocked ,
    RT.ReportTypeName,
    R.AccountName AS RelatedAccountName
FROM Accounting.Account A
JOIN  Accounting.Currency C ON A.CurrencyID = C.CurrencyID
JOIN  Accounting.AccountType AT ON A.AccountTypeID = AT.AccountTypeID
JOIN  Accounting.ReportType RT ON A.ReportTypeID = RT.ReportTypeID
LEFT JOIN  Accounting.Account R ON A.RelatedAccountID = R.AccountID;




create proc Accounting.AccountHierarchyProcedure
as
WITH AccountHierarchy AS (
    SELECT AccountID, AccountParentID, 1 AS Level
    FROM Accounting.Account
    WHERE AccountParentID IS NULL
    UNION ALL
    SELECT a.AccountID, a.AccountParentID, ah.Level + 1
    FROM Accounting.Account a
    JOIN AccountHierarchy ah ON a.AccountParentID = ah.AccountID
)
UPDATE Accounting.Account
SET Level = ah.Level
FROM AccountHierarchy ah
WHERE Account.AccountID = ah.AccountID;






-- Create the Country table
CREATE TABLE Person.Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100)
);

-- Create the CityType table
CREATE TABLE Person.CityType (
    CityTypeID INT PRIMARY KEY,
    CityTypeName VARCHAR(100)
);

-- Create the City table
CREATE TABLE Person.City (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(100),
    CityTypeID INT,
    CountryID INT,
    CONSTRAINT FK_CityType FOREIGN KEY (CityTypeID)
        REFERENCES Person.CityType (CityTypeID),
    CONSTRAINT FK_Country FOREIGN KEY (CountryID)
        REFERENCES Person.Country (CountryID)
);


-- Create the SocialStatus lookup table
CREATE TABLE Person.SocialStatus (
    SocialStatusID INT PRIMARY KEY,
    SocialStatusName VARCHAR(100)
);

-- Insert sample data into the SocialStatus table
INSERT INTO Person.SocialStatus (SocialStatusID, SocialStatusName)
VALUES
    (1, 'Single'),
    (2, 'Married'),
    (3, 'Divorced'),
    (4, 'Widowed'),
    (5, 'Separated');


-- Create the Gender lookup table
CREATE TABLE Person.Gender (
    GenderID INT PRIMARY KEY,
    GenderName VARCHAR(20)
);

-- Insert sample data into the Gender table
INSERT INTO Person.Gender (GenderID, GenderName)
VALUES
    (1, 'Male'),
    (2, 'Female'),
    (3, 'Other');








-- Create the Person table
CREATE TABLE Person.Person (
    PersonID INT PRIMARY KEY IDENTITY,
	PersonGuid  UNIQUEIDENTIFIER DEFAULT NEWID() UNIQUE,
    FirstName VARCHAR(100) NOT NULL,
    SecondName VARCHAR(100) NOT NULL,
    ThirdName VARCHAR(100) NULL,
    LastName VARCHAR(100) NOT  NULL,
    GenderID INT NOT NULL,
    BirthDate DATE not null,
    SocialStatusID iNT nOT NULL,
    PrimaryPhone VARCHAR(20) not null,
    Email VARCHAR(100) not null unique,
	Street varchar(50) not null,
    ProfileImage VARCHAR(255) null,
	CityID INT ,



	CONSTRAINT FK_Person_SocialStatus FOREIGN KEY (SocialStatusID)
    REFERENCES Person.SocialStatus (SocialStatusID),
 CONSTRAINT FK_Person_Gender FOREIGN KEY (GenderID)
    REFERENCES Person.Gender (GenderID)


);

-- Create the Identification table with PersonID as the primary key
CREATE TABLE Person.Identification (
    PersonGuid  UNIQUEIDENTIFIER DEFAULT NEWID() UNIQUE,
	PersonID INT PRIMARY KEY,
	NationalNo VARCHAR(50) NOT NULL,
    PassportNumber VARCHAR(100),
    DriverLicenseNumber VARCHAR(100),
    SocialSecurityNumber VARCHAR(100),
    CONSTRAINT FK_Identification_Person FOREIGN KEY (PersonID)
        REFERENCES Person.Person (PersonID)
);


-- Create the Phone table
CREATE TABLE Person.PersonPhone (
    PhoneID INT PRIMARY KEY identity,
    PersonID INT not null,
    PhoneNumber VARCHAR(20),
	PhoneType nvarchar(20) null,
    CONSTRAINT FK_Phone_Person FOREIGN KEY (PersonID)
        REFERENCES Person.Person (PersonID)
);



-- Create schema for Inventory
CREATE SCHEMA Inventory;

-- Create table for Category
CREATE TABLE Inventory.Category (
    CategoryID INT PRIMARY KEY identity,
    CategoryName VARCHAR(100),
    Description VARCHAR(500)
);

-- Create table for SubCategory
CREATE TABLE Inventory.SubCategory (
    SubCategoryID INT PRIMARY KEY identity,
    SubCategoryName VARCHAR(100),
    CategoryID INT,
    Description VARCHAR(500),
    CONSTRAINT FK_SubCategory_Category FOREIGN KEY (CategoryID)
        REFERENCES Inventory.Category (CategoryID)
);

-- Create table for Product
CREATE TABLE Inventory.Product (
    ProductID INT PRIMARY KEY identity,
	ProductBarcode nvarchar(max) null,
	ProductCode Nvarchar(max) not null,
    ProductName VARCHAR(100),
    SubCategoryID INT,
    ProductDescription VARCHAR(500),
    UnitPrice DECIMAL(10, 2),
    QuantityInStock INT,
    CONSTRAINT FK_Product_SubCategory FOREIGN KEY (SubCategoryID)
        REFERENCES Inventory.SubCategory (SubCategoryID)
);







-- Create schema for Sale
CREATE SCHEMA Sale;

-- Create table for CustomerGroup
CREATE TABLE Sale.CustomerGroup (
    CustomerGroupID INT PRIMARY KEY identity,
    CustomerGroupName VARCHAR(100),
    
);



-- Create table for Customer
CREATE TABLE Sale.Customer (
    CustomerID INT PRIMARY KEY identity,
    PersonID INT unique,
    CustomerGroupID INT,
    CONSTRAINT FK_Customer_Person FOREIGN KEY (PersonID)
        REFERENCES Person.Person (PersonID),
    CONSTRAINT FK_Customer_CustomerGroup FOREIGN KEY (CustomerGroupID)
        REFERENCES Sale.CustomerGroup (CustomerGroupID)
);

-- Create table for SaleTransactionType
CREATE TABLE Sale.SaleTransactionType (
    TransactionTypeID INT PRIMARY KEY identity,
    TransactionTypeName VARCHAR(100) not null,
  
);

-- Create table for SaleTransaction
CREATE TABLE Sale.SaleTransaction (
    TransactionID INT PRIMARY KEY identity,
    CustomerID INT not null,
    TransactionTypeID INT not null,
    TransactionDate DATE,
	 Subtotal DECIMAL(10, 2),
    Discount DECIMAL(10, 2),
    Tax DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2),
    Notes VARCHAR(500),
	UserID INT,
    CONSTRAINT FK_SaleTransaction_Customer FOREIGN KEY (CustomerID)
        REFERENCES Sale.Customer (CustomerID),
    CONSTRAINT FK_SaleTransaction_TransactionType FOREIGN KEY (TransactionTypeID)
        REFERENCES Sale.SaleTransactionType (TransactionTypeID)
);

-- Create table for SaleTransactionDetail
CREATE TABLE Sale.SaleTransactionDetail (
    TransactionDetailID INT PRIMARY KEY identity,
	TransactionDate date,
    TransactionID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    Discount DECIMAL(10, 2),
    Tax DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2),
    CONSTRAINT FK_SaleTransactionDetail_SaleTransaction FOREIGN KEY (TransactionID)
        REFERENCES Sale.SaleTransaction (TransactionID),
    CONSTRAINT FK_SaleTransactionDetail_Product FOREIGN KEY (ProductID)
        REFERENCES Inventory.Product (ProductID)
);

-- Create table for Invoice
CREATE TABLE Sale.Invoice (
    InvoiceID INT PRIMARY KEY identity,
	InvNumber int,
    TransactionID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(10, 2),
    CONSTRAINT FK_Invoice_SaleTransaction FOREIGN KEY (TransactionID)
        REFERENCES Sale.SaleTransaction (TransactionID)
);

-- Create table for Payment
CREATE TABLE Sale.Payment (
    PaymentID INT PRIMARY KEY identity,
    InvoiceID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    CONSTRAINT FK_Payment_Invoice FOREIGN KEY (InvoiceID)
        REFERENCES Sale.Invoice (InvoiceID)
);






-- General Ledger Table
CREATE TABLE Accounting.GeneralLedger (
    EntryID INT PRIMARY KEY,
    AccountID INT,
    Date DATE,
    Description VARCHAR(255),
    Debit DECIMAL(10, 2),
    Credit DECIMAL(10, 2),
    Balance DECIMAL(10, 2),
    CONSTRAINT FK_GeneralLedger_Account FOREIGN KEY (AccountID)
        REFERENCES Accounting.Account (AccountID)
);


-- Transactions Table
CREATE TABLE Accounting.Transactions (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    Description VARCHAR(255),
    Amount DECIMAL(10, 2),
    Currency VARCHAR(10),
    CustomerID INT,
    VendorID INT,
    AccountID INT,
    PaymentMethod VARCHAR(50),
    -- Additional attributes as per your requirements
);

-- Journal Table
CREATE TABLE Accounting.Journal (
    JournalID INT PRIMARY KEY,
    JournalName VARCHAR(50),
    Description VARCHAR(255),
    -- Additional attributes as per your requirements
);

-- Journal Entry Table
CREATE TABLE Accounting.JournalEntry (
    EntryID INT PRIMARY KEY,
    JournalID INT,
    TransactionID INT,
    AccountID INT,
    Debit DECIMAL(10, 2),
    Credit DECIMAL(10, 2),
    -- Additional attributes as per your requirements
    CONSTRAINT FK_JournalEntry_Journal FOREIGN KEY (JournalID)
        REFERENCES Journal (JournalID),
    CONSTRAINT FK_JournalEntry_Transactions FOREIGN KEY (TransactionID)
        REFERENCES Accounting.Transactions (TransactionID),
    CONSTRAINT FK_JournalEntry_Account FOREIGN KEY (AccountID)
        REFERENCES Accounting.Account (AccountID)
);

-- General Journal Table




CREATE TABLE Accounting.CashBook (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    Description VARCHAR(100),
    Inflow DECIMAL(18, 2),
    Outflow DECIMAL(18, 2),
    CashBalance DECIMAL(18, 2)
);