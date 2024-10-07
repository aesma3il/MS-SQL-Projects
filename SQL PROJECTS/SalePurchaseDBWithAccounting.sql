Create database SalePurchase;
go
use SalePurchase;
go
CREATE SCHEMA People;
go
-- Create the Countries table
CREATE TABLE People.Country (
    CountryID INT PRIMARY KEY identity,
    CountryName VARCHAR(100),
    Continent VARCHAR(100)
    -- Add other country-related attributes as needed
);

-- Create the Cities table
CREATE TABLE People.City (
    CityID INT PRIMARY KEY identity,
    CityName VARCHAR(100),
    CountryID INT not null,
    FOREIGN KEY (CountryID) REFERENCES People.Country(CountryID)
);


-- Create the Addresses table
CREATE TABLE People.AddressPlace (
    AddressID INT PRIMARY KEY identity,
    AddressLine1 VARCHAR(255),
    AddressLine2 VARCHAR(255),
    CityID INT not null,
    CountryID int not null,
    FOREIGN KEY (CityID) REFERENCES People.City(CityID),
	 FOREIGN KEY (CountryID) REFERENCES People.Country(CountryID)
);

CREATE TABLE People.PersonType (
    PersonTypeID INT PRIMARY KEY identity,
    PersonTypeName VARCHAR(50)
);

-- Create the Persons table
CREATE TABLE People.Person (
    PersonID INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(255) not null,
    LastName VARCHAR(255) not null,
    DateOfBirth DATE not null,
    Gender VARCHAR(10) not null,
	MaritalStatus VARCHAR(50),
    BloodType VARCHAR(10),
	NationalNo NVARCHAR(50) NOT NULL UNIQUE,
    PassportNumber VARCHAR(20) null,
	Email VARCHAR(255) not null,
    Phone VARCHAR(20) not null,
    EmergencyContactPhone VARCHAR(20),
	AddressID INT not null,
	PersonTypeID INT,

	constraint fk_person_address foreign key(AddressID) references People.AddressPlace(AddressID),
	constraint fk_persontypeid_persontype foreign key(AddressID) references People.PersonType(PersonTypeID)
    
);


create schema Users;
go
CREATE TABLE Users.UserLogin (
    UserID INT PRIMARY KEY identity,
    PersonID INT NOT NULL UNIQUE,
    Username VARCHAR(50),
    UserPassword VARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES People.Person(PersonID)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY identity,
    PersonID INT not null UNIQUE,
    CustomerType VARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES People.Person(PersonID),
);


CREATE TABLE Company (
    CompanyID INT PRIMARY KEY identity,
    PersonID INT not null UNIQUE,
    FOREIGN KEY (PersonID) REFERENCES People.Person(PersonID),
);





CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY identity,
	CompanyID INT,
    PersonID INT not null UNIQUE,
    FOREIGN KEY (PersonID) REFERENCES People.Person(PersonID),
	FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)

);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY identity,
    PersonID INT not null UNIQUE,
    EmployeeCode VARCHAR(50),
    Department VARCHAR(100),
    EmploymentType VARCHAR(50),
	JobTitle VARCHAR(50),
    JoinDate DATE,
    Salary DECIMAL(10, 2),
    ManagerID INT,
    FOREIGN KEY (PersonID) REFERENCES People.Person(PersonID),
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);


Create schema Accounting;
go

create table Accounting.AccountType(
AccountTypeID INT PRIMARY KEY IDENTITY,
AccountTypeName nvarchar(50) not null
);

CREATE TABLE Accounting.ChartOfAccounts (
    AccountID INT PRIMARY KEY IDENTITY,
    AccountCode VARCHAR(10) NOT NULL unique,
    AccountName VARCHAR(255),
    AccountTypeID INT NOT NULL,
    AccountHolderID INT NOT NULL,
    CONSTRAINT fk_account_accounttype FOREIGN KEY (AccountTypeID) REFERENCES Accounting.AccountType(AccountTypeID),
    CONSTRAINT fk_accountholder_person FOREIGN KEY (AccountHolderID) REFERENCES People.Person(PersonID)
);

CREATE TABLE Accounting.GeneralLedger (
    EntryID INT PRIMARY KEY identity,
	TransactionID INT,
    TransactionDate DATE,
    Description NVARCHAR(200) NOT NULL
);

CREATE TABLE GeneralLedgerLine (
    LineID INT PRIMARY KEY IDENTITY,
    EntryID INT,
    AccountID INT,
    Amount DECIMAL(10, 2),
    TransactionType VARCHAR(50), --credit or debit
    Reference VARCHAR(255),
    FOREIGN KEY (EntryID) REFERENCES Accounting.GeneralLedger(EntryID),
    FOREIGN KEY (AccountID) REFERENCES Accounting.ChartOfAccounts(AccountID)
);
GO
--query for report of account:
	create proc Report_GetAccountReportForAPerson
	@AccountCode nvarchar(50)
	as 
begin
SELECT
    COA.AccountCode,
    COA.AccountName,
    GL.Description,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE 0 END) AS DebitAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Credit' THEN GLL.Amount ELSE 0 END) AS CreditAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE -GLL.Amount END) AS Balance
FROM
    ChartOfAccounts COA
    INNER JOIN GeneralLedgerLine GLL ON COA.AccountID = GLL.AccountID
    INNER JOIN GeneralLedger GL ON GLL.EntryID = GL.EntryID
WHERE COA.AccountID = @AccountCode or COA.AccountID = CONVERT(INT, @AccountCode)

GROUP BY
    COA.AccountCode,
    COA.AccountName,
    GL.Description;

end;

go
create proc Report_GetAccountReportForAllPerson
	@AccountCode nvarchar(50)
	as 
begin
SELECT
    COA.AccountCode,
    COA.AccountName,
    GL.Description,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE 0 END) AS DebitAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Credit' THEN GLL.Amount ELSE 0 END) AS CreditAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE -GLL.Amount END) AS Balance
FROM
    ChartOfAccounts COA
    INNER JOIN GeneralLedgerLine GLL ON COA.AccountID = GLL.AccountID
    INNER JOIN GeneralLedger GL ON GLL.EntryID = GL.EntryID
GROUP BY
    COA.AccountCode,
    COA.AccountName,
    GL.Description;


end;



	GO
	--THIS TRIGGER WILL PUT THE NAME OF PERSON IS THE SAME AS THE ACCOUNTNAME
	CREATE TRIGGER Trg_UpdateAccountName
ON ChartOfAccounts
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE COA
    SET COA.AccountName = P.FirstName+' '+ p.FirstName
    FROM ChartOfAccounts COA
    INNER JOIN inserted i ON COA.AccountID = i.AccountID
    INNER JOIN Person P ON COA.AccountHolderID = P.PersonID
    WHERE i.AccountHolderID = COA.AccountHolderID
          AND COA.AccountName <> P.FirstName+' '+ p.FirstName; -- Only update if the AccountName is different
    
END;


--this is to integrate the schema:
--To integrate invoices or purchases with the account schema to record amounts, you can introduce additional tables and relationships to capture the relevant information. Here's a suggested approach:

--Create an Invoices table and a Purchases table to store the invoice and purchase information, respectively. These tables should include columns such as InvoiceID, PurchaseID, AccountID, Amount, and any other relevant fields.

--Establish foreign key relationships between the Invoices and Purchases tables and the ChartOfAccounts table. This allows you to associate each invoice or purchase with the corresponding account.

--When inserting or updating an invoice or purchase, ensure that the AccountID is provided to link it to the appropriate account in the ChartOfAccounts table.

--Modify the trigger on the ChartOfAccounts table to include logic that updates the balance of the associated account whenever an invoice or purchase is inserted or updated.

--Here's an example of how the trigger can be modified:

--sql
--Copy
go

--CREATE TRIGGER UpdateAccountBalance
--ON Invoices
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    UPDATE COA
--    SET COA.Balance = COA.Balance + i.Amount
--    FROM ChartOfAccounts COA
--    INNER JOIN inserted i ON COA.AccountID = i.AccountID;
--END;






Create Table Category(
CategoryID INT PRIMARY KEY IDENTITY(1,1),
CategoryName nvarchar(50) not null

);

-- Create the Products table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
	CategoryID INT not null,
    ProductName nVARCHAR(255),
	ProductDescription nvarchar(200) null,
    PurchasePrice DECIMAL(10, 2) default null,
	SellingPrice DECIMAL(10, 2) default null,
	ProductImage varchar(max) default null,
	ProductionDate date not null,
	ExpDate date not null,
	AddedAt date default getdate(),
	constraint fk_product_category foreign key(CategoryID) references Category(CategoryID)
    -- Add other product-related columns as needed
);

-- Create the Stores table
CREATE TABLE Store (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(255) not null,
	Phone nvarchar(50) not null,
	ManagerID INT,

	constraint fk_store_manager_employee foreign key(ManagerID) references Employee(EmployeeID)
   
   
);

-- Create the Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    StoreID INT,
    Quantity INT,
	MinimumInventoryLevel INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);



go


-- Create the Sale schema
CREATE SCHEMA Sale;

-- Create the SaleTransactionType table
CREATE TABLE Sale.SaleTransactionType (
    TransactionTypeID INT PRIMARY KEY,
    TransactionTypeName VARCHAR(50) NOT NULL
);

-- Create the SaleTransaction table
CREATE TABLE Sale.SaleTransaction (
    TransactionID INT PRIMARY KEY,
    TransactionTypeID INT,
    TransactionDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2),
	DiscountAmount DECIMAL(10, 2),
    TaxAmount DECIMAL(10, 2),
    FOREIGN KEY (TransactionTypeID) REFERENCES Sale.SaleTransactionType(TransactionTypeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create the SaleTransactionDetail table
CREATE TABLE Sale.SaleTransactionDetail (
    TransactionDetailID INT PRIMARY KEY,
    TransactionID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    LineTotal DECIMAL(10, 2),
    FOREIGN KEY (TransactionID) REFERENCES Sale.SaleTransaction(TransactionID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);



CREATE TABLE Sale.ReturnTransaction (
    TransactionID INT PRIMARY KEY,
    SalesTransactionID INT,
    CustomerID INT,
    ReturnDate DATE,
    ReturnReason VARCHAR(255),
    RefundAmount DECIMAL(10, 2),
    Notes TEXT,
    CONSTRAINT fk_sales_transaction
        FOREIGN KEY (SalesTransactionID)
        REFERENCES Sale.SaleTransaction (TransactionID),
    CONSTRAINT fk_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customer (CustomerID)
);

CREATE TABLE Sale.ReturnItem (
    ReturnItemID INT PRIMARY KEY,
    ReturnTransactionID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT fk_return_transaction
        FOREIGN KEY (ReturnTransactionID)
        REFERENCES Sale.ReturnTransaction (TransactionID),
    CONSTRAINT fk_product
        FOREIGN KEY (ProductID)
        REFERENCES Product (ProductID)
);




CREATE TABLE Sale.AccountsReceivableTransactions (
    ID INT PRIMARY KEY IDENTITY,
	SaleTransactionID INT,
    CustomerID INT,
    TransactionDate DATE,
    TotalAmount DECIMAL(10, 2),
    PaidAmount DECIMAL(10, 2),
    RemainingAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (SaleTransactionID) REFERENCES Sale.SaleTransaction(TransactionID)
);


-- Create the SalePayment table
--CREATE TABLE Sale.SalePayment (
--    PaymentID INT PRIMARY KEY,
   
--    PaymentDate DATE,
--    Amount DECIMAL(10, 2),
    
);
--go
---- Create the Purchase schema
--CREATE SCHEMA Purchase;

---- Create the PurchaseTransactionType table
--CREATE TABLE Purchase.PurchaseTransactionType (
--    TransactionTypeID INT PRIMARY KEY,
--    TransactionTypeName VARCHAR(50) NOT NULL
--);

---- Create the PurchaseTransaction table
--CREATE TABLE Purchase.PurchaseTransaction (
--    TransactionID INT PRIMARY KEY,
--    TransactionTypeID INT,
--    TransactionDate DATE,
--    VendorID INT,
--    TotalAmount DECIMAL(10, 2),
--	DiscountAmount DECIMAL(10, 2),
--    TaxAmount DECIMAL(10, 2),
--    FOREIGN KEY (TransactionTypeID) REFERENCES Purchase.PurchaseTransactionType(TransactionTypeID),
--    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
--);

---- Create the PurchaseTransactionDetail table
--CREATE TABLE Purchase.PurchaseTransactionDetail (
--    TransactionDetailID INT PRIMARY KEY,
--    TransactionID INT,
--    ProductID INT,
--    Quantity INT,
--    UnitPrice DECIMAL(10, 2),
--    LineTotal DECIMAL(10, 2),
--    FOREIGN KEY (TransactionID) REFERENCES Purchase.PurchaseTransaction(TransactionID),
--    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
--);


--CREATE TABLE AccountsPayableTransactions (
--    TransactionID INT PRIMARY KEY,
--	PurchaseTransactionID INT,
--    VendorID INT,
--    TransactionDate DATE,
--    TotalAmount DECIMAL(10, 2),
--    PaidAmount DECIMAL(10, 2),
--    RemainingAmount DECIMAL(10, 2),
--    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID),
-- FOREIGN KEY (PurchaseTransactionID) REFERENCES	Purchase.PurchaseTransaction
--);


------ Create the PurchasePayment table
----CREATE TABLE Purchase.PurchasePayment (
----    PaymentID INT PRIMARY KEY,s
----    TransactionID INT,
----    PaymentDate DATE,
----    Amount DECIMAL(10, 2),
----    FOREIGN KEY (TransactionID) REFERENCES Purchase.PurchaseTransaction(TransactionID)
----);




---- Create the Transactions schema
--CREATE SCHEMA Transactions;

---- Create the TransactionTypes table
--CREATE TABLE Transactions.TransactionTypes (
--    TransactionTypeID INT PRIMARY KEY,
--    TransactionTypeName VARCHAR(50)
--);

---- Create the TransactionSubTypes table
--CREATE TABLE Transactions.TransactionSubTypes (
--    TransactionSubTypeID INT PRIMARY KEY,
--    TransactionTypeID INT,
--    TransactionSubTypeName VARCHAR(50),
--    FOREIGN KEY (TransactionTypeID) REFERENCES Transactions.TransactionTypes(TransactionTypeID)
--);

---- Create the Transactions table
--CREATE TABLE Transactions.Transactions (
--    TransactionID INT PRIMARY KEY,
--    TransactionTypeID INT,
--    TransactionSubTypeID INT,
--    TransactionDate DATE,
--    PeronBusinessID INT,
--    VendorID INT,
--    SubtotalAmount DECIMAL(10, 2),
--    DiscountAmount DECIMAL(10, 2),
--    TaxAmount DECIMAL(10, 2),
--    TotalAmount DECIMAL(10, 2),
--    Notes VARCHAR(200),
--    TrackingNumber VARCHAR(50),
--    IsCancelled BIT,
--    CancellationReason VARCHAR(200),
--    SalespersonID INT,
--    FOREIGN KEY (TransactionTypeID) REFERENCES Transactions.TransactionTypes(TransactionTypeID),
--    FOREIGN KEY (TransactionSubTypeID) REFERENCES Transactions.TransactionSubTypes(TransactionSubTypeID),
--    FOREIGN KEY (PeronBusinessID) REFERENCES Person(PersonID),
   
--    FOREIGN KEY (SalespersonID) REFERENCES Employee(EmployeeID)
--);

---- Create the PaymentTypes table
--CREATE TABLE Transactions.PaymentTypes (
--    PaymentTypeID INT PRIMARY KEY,
--    PaymentTypeName VARCHAR(50)
--);

---- Create the Invoice table
--CREATE TABLE Transactions.Invoices (
--    InvoiceID INT PRIMARY KEY,
--    TransactionID INT,
--    InvoiceNumber VARCHAR(50),
--    InvoiceDate DATE,
--    DueDate DATE,
--    SubtotalAmount DECIMAL(10, 2),
--    TaxAmount DECIMAL(10, 2),
--    TotalAmount DECIMAL(10, 2),
--    FOREIGN KEY (TransactionID) REFERENCES Transactions.Transactions(TransactionID)
--);


---- Create the Payments table
--CREATE TABLE Transactions.Payments (
--    PaymentID INT PRIMARY KEY,
--    TransactionID INT,
--    PaymentTypeID INT,
--    PaymentDate DATE,
--    Amount DECIMAL(10, 2),
--    FOREIGN KEY (TransactionID) REFERENCES Transactions.Transactions(TransactionID),
--    FOREIGN KEY (PaymentTypeID) REFERENCES Transactions.PaymentTypes(PaymentTypeID)
--);
