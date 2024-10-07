CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(50),
    Address VARCHAR(100),
    Phone VARCHAR(20)
);


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(100),
    Phone VARCHAR(20),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(100),
    Phone VARCHAR(20),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE AccountType (
    AccountTypeID INT PRIMARY KEY,
    AccountTypeName VARCHAR(50)
);

CREATE TABLE Currency (
    CurrencyID INT PRIMARY KEY,
    CurrencyCode VARCHAR(3),
    CurrencyName VARCHAR(50)
);

CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountNumber VARCHAR(20),
    AccountTypeID INT,
    CurrencyID INT,
    Balance DECIMAL(10, 2),
    BranchID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID),
    FOREIGN KEY (CurrencyID) REFERENCES Currency(CurrencyID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY,
    TransactionTypeName VARCHAR(50)
);

CREATE TABLE _Transaction (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATETIME,
    CreditAmount DECIMAL(10, 2),
    DebitAmount DECIMAL(10, 2),
    AccountID INT,
    TransactionTypeID INT,
    EmployeeID INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(TransactionTypeID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE TransactionDetail (
    TransactionDetailID INT PRIMARY KEY,
    TransactionID INT,
    Location VARCHAR(50),
    Fee DECIMAL(10, 2),
    FOREIGN KEY (TransactionID) REFERENCES _Transaction(TransactionID)
);

CREATE TABLE TransactionHistory (
    TransactionHistoryID INT PRIMARY KEY,
    AccountID INT,
    TransactionID INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (TransactionID) REFERENCES _Transaction(TransactionID)
);

CREATE TABLE FeeType (
    FeeTypeID INT PRIMARY KEY,
    FeeTypeName VARCHAR(50)
);

CREATE TABLE Fee (
    FeeID INT PRIMARY KEY,
    FeeTypeID INT,
    Amount DECIMAL(10, 2),
    TransactionID INT,
    FOREIGN KEY (FeeTypeID) REFERENCES FeeType(FeeTypeID),
    FOREIGN KEY (TransactionID) REFERENCES _Transaction(TransactionID)
);

CREATE TABLE Note (
    NoteID INT PRIMARY KEY,
    AccountID INT,
    NoteText VARCHAR(MAX),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);


create table UserTable(
	UserID INT PRIMARY KEY identity(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(100),
    Phone VARCHAR(20)

);

Create table UserLogin(
UserID int unique references UserTable(UserID),
Username varchar(100) not null unique,
PW varchar(100) not null
);