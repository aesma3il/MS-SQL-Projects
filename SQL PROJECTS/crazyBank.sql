

CREATE TABLE Person (
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Addresss VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    [State] VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL
);



-- Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
	PersonID INT NOT NULL
   CONSTRAINT FK_Customer_PERSON FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

-- Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1) ,
	PersonID INT NOT NULL,
    HireDate DATE NOT NULL,
    JobTitle VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
	CONSTRAINT FK_EMP_PERSON FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

-- Transaction Type table
CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY IDENTITY(1,1),
    TransactionTypeName VARCHAR(50) NOT NULL
);

-- Transaction table


-- Account Type table
CREATE TABLE AccountType (
    AccountTypeID INT PRIMARY KEY IDENTITY(1,1),
    AccountTypeName VARCHAR(50) NOT NULL
);

-- Account table
CREATE TABLE Account (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    AccountTypeID INT NOT NULL,
    Balance DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID)
);

CREATE TABLE [Transaction] (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    TransactionTypeID INT NOT NULL,
    TransactionDate DATETIME NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(TransactionTypeID)
);


CREATE TABLE TransactionDetails (
    TransactionDetailID INT PRIMARY KEY IDENTITY(1,1),
    TransactionID INT NOT NULL,
    [Description] VARCHAR(100) NOT NULL,
    FOREIGN KEY (TransactionID) REFERENCES [Transaction](TransactionID)
);