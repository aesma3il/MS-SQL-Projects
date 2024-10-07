
CREATE SCHEMA PersonalInfo;
go;


CREATE TABLE PersonalInfo.Country
(
    GuidID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    Number INT IDENTITY(1,1) unique,
	Code NVARCHAR(255) NOT NULL UNIQUE,
    Name NVARCHAR(255) NOT NULL UNIQUE
   
);


Create TABLE PersonalInfo.Person
(
    GuidID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID()  ,
    Number INT IDENTITY(1,1)  ,
    Code NVARCHAR(255) NOT NULL  ,
    Name NVARCHAR(255) NOT NULL,
    Gender CHAR(1) NOT NULL,
    BirthDate DATE   NOT NULL,
    MobileNumber NVARCHAR(20) NOT NULL,
    PhoneNumber NVARCHAR(20)    ,
    Email NVARCHAR(255) NOT NULL,
    NationalID NVARCHAR(255) not null      ,
    Nationality UNIQUEIDENTIFIER,
    PhotoPath NVARCHAR(255)    ,
    IsActive BIT  ,  
    CreatedAt DATETIME    ,
    CreatedBy INT  ,
    UpdatedAt DATETIME  ,
    UpdatedBy INT  ,
    IsUpdated BIT  ,
    DeletedAt DATETIME ,
    DeletedBy INT  ,
    IsDeleted BIT  ,
    ActivatedAt DATETIME  ,
    ActivatedBy INT  ,
    UpdateTimes INT  ,
    ActivateTimes  INT,
    DeleteTimes INT ,
    AccessedTimes INT 
   
);

create schema Users
 go
 
CREATE TABLE Users.Users
(
    UserID INT PRIMARY KEY IDENTITY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL  ,
    IsActive BIT DEFAULT 1 ,
    CreatedAt DATETIME DEFAULT GETDATE()
);


 

-- Unique Key Constraints
ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT UQ_Person_Number UNIQUE (Number);

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT UQ_Person_Code UNIQUE (Code);

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT UQ_Person_NationalID UNIQUE (NationalID);

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT UQ_Person_Email UNIQUE (Email);

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT UQ_Person_MobileNumber UNIQUE (MobileNumber);

-- Foreign Key Constraint
ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT FK_Person_Country FOREIGN KEY (Nationality)
REFERENCES PersonalInfo.Country(GuidID);

-- Check Constraint
ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT CK_Person_Gender CHECK (Gender IN ('M', 'F', 'O'));

-- Default Constraints
GO
 -- Default Constraints

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_PhoneNumber DEFAULT NULL FOR PhoneNumber;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_PhotoPath DEFAULT NULL FOR PhotoPath;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_IsActive DEFAULT 0 FOR IsActive;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_CreatedAt DEFAULT GETDATE() FOR CreatedAt;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_CreatedBy DEFAULT 0 FOR CreatedBy;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_UpdatedAt DEFAULT NULL FOR UpdatedAt;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_UpdatedBy DEFAULT 0 FOR UpdatedBy;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_IsUpdated DEFAULT 0 FOR IsUpdated;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_DeletedAt DEFAULT NULL FOR DeletedAt;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_DeletedBy DEFAULT 0 FOR DeletedBy;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_IsDeleted DEFAULT 0 FOR IsDeleted;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_ActivatedAt DEFAULT NULL FOR ActivatedAt;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_ActivatedBy DEFAULT 0 FOR ActivatedBy;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_UpdateTimes DEFAULT 0 FOR UpdateTimes;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_ActivateTimes DEFAULT 0 FOR ActivateTimes;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_DeleteTimes DEFAULT 0 FOR DeleteTimes;

ALTER TABLE PersonalInfo.Person
ADD CONSTRAINT DF_Person_AccessedTimes DEFAULT 0 FOR AccessedTimes;

--		HR

CREATE SCHEMA HR;


-- Create the Department table
CREATE TABLE HR.Department
(
    GuidID UNIQUEIDENTIFIER NOT NULL,
    Number INT NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    IsActive BIT NOT NULL,
    CreatedAt DATETIME NOT NULL,
    CreatedBy INT NOT NULL,
    UpdatedAt DATETIME NULL,
    UpdatedBy INT NULL,
    IsUpdated BIT NOT NULL,
    DeletedAt DATETIME NULL,
    DeletedBy INT NULL,
    IsDeleted BIT NOT NULL,
    ActivatedAt DATETIME NULL,
    ActivatedBy INT NULL,
    UpdateTimes INT NOT NULL,
    ActivateTimes INT NOT NULL,
    DeleteTimes INT NOT NULL,
    AccessedTimes INT NOT NULL,
    CONSTRAINT PK_Department PRIMARY KEY (GuidID)
);
 -- Add foreign key constraint
ALTER TABLE HR.Department
ADD CONSTRAINT FK_Department_CreatedBy FOREIGN KEY (CreatedBy)
REFERENCES Users.Users(UserID);

-- Add default constraints
ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_IsActive DEFAULT 0 FOR IsActive;

ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_CreatedAt DEFAULT GETDATE() FOR CreatedAt;

ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_IsUpdated DEFAULT 0 FOR IsUpdated;

ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_IsDeleted DEFAULT 0 FOR IsDeleted;

ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_UpdateTimes DEFAULT 0 FOR UpdateTimes;

ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_ActivateTimes DEFAULT 0 FOR ActivateTimes;

ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_DeleteTimes DEFAULT 0 FOR DeleteTimes;

ALTER TABLE HR.Department
ADD CONSTRAINT DF_Department_AccessedTimes DEFAULT 0 FOR AccessedTimes;

-- Add check constraint
ALTER TABLE HR.Department
ADD CONSTRAINT CK_Department_IsActive CHECK (IsActive IN (0, 1));

-- Add unique constraint
ALTER TABLE HR.Department
ADD CONSTRAINT UQ_Department_Number UNIQUE (Number);

ALTER TABLE HR.Department
ADD CONSTRAINT UQ_Department_Code UNIQUE (Code);

ALTER TABLE HR.Department
ADD CONSTRAINT UQ_Department_Name UNIQUE (Name);






create schema CustomerManagement;

CREATE TABLE CustomerManagement.Customer (
    GuidID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PersonGuidID UNIQUEIDENTIFIER NOT NULL,
    Number INT IDENTITY(1,1) UNIQUE,
    Code VARCHAR(50),
    -- Additional customer-specific attributes
    FOREIGN KEY (PersonGuidID) REFERENCES PersonalInfo.Person(GuidID)
);



-- Create the Employee table
CREATE TABLE HR.Employee (
    GuidID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PersonGuidID UNIQUEIDENTIFIER,
    Number INT IDENTITY(1,1) UNIQUE,
    Code VARCHAR(50),
    HireDate DATE,
    JobTitle nVARCHAR(50),
    EmploymentStatus nVARCHAR(50),
    DepartmentGuidID UNIQUEIDENTIFIER,
    -- Additional columns...
);

-- Add primary key constraint
 

-- Add foreign key constraint
ALTER TABLE HR.Employee
ADD CONSTRAINT FK_Employee_Person FOREIGN KEY (PersonGuidID)
REFERENCES PersonalInfo.Person(GuidID);

-- Add default constraint
ALTER TABLE HR.Employee
ADD CONSTRAINT DF_Employee_JobTitle DEFAULT ('Employee') FOR JobTitle;

-- Add check constraint
ALTER TABLE HR.Employee
ADD CONSTRAINT CK_Employee_EmploymentStatus CHECK (EmploymentStatus IN ('Full-Time', 'Part-Time', 'Contractor'));

-- Add unique constraint
ALTER TABLE HR.Employee
ADD CONSTRAINT UQ_Employee_Code UNIQUE (Code);

-- Add foreign key constraint for DepartmentGuidID
ALTER TABLE HR.Employee
ADD CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentGuidID)
REFERENCES HR.Department(GuidID);






--create schema Accounts;
-- Create the Account table
CREATE TABLE Accounts.Account (
    GuidID UNIQUEIDENTIFIER primary key default newid(),
    CustomerGuid UNIQUEIDENTIFIER,
    Number INT IDENTITY(1,1) UNIQUE,
    Code NVARCHAR(50),
    Name NVARCHAR(50),
    Type NVARCHAR(50),
    Balance DECIMAL(18, 2),
    IsActive BIT,
    CreatedAt DATETIME,
    CreatedBy INT,
    UpdatedAt DATETIME,
    UpdatedBy INT,
    IsUpdated BIT,
    DeletedAt DATETIME,
    DeletedBy INT,
    IsDeleted BIT,
    ActivatedAt DATETIME,
    ActivatedBy INT,
    UpdateTimes INT,
    ActivateTimes INT,
    DeleteTimes INT,
    AccessedTimes INT,
    -- Additional columns...
);

 

-- Add foreign key constraint
ALTER TABLE Accounts.Account
ADD CONSTRAINT FK_Account_Customer FOREIGN KEY (CustomerGuid)
REFERENCES CustomerManagement.Customer(GuidID);

-- Add default constraint
ALTER TABLE Accounts.Account
ADD CONSTRAINT DF_Account_IsActive DEFAULT (1) FOR IsActive;

-- Add check constraint
ALTER TABLE Accounts.Account
ADD CONSTRAINT CK_Account_Balance CHECK (Balance >= 0);

-- Add unique constraint
ALTER TABLE Accounts.Account
ADD CONSTRAINT UQ_Account_Code UNIQUE (Code);

-- Add foreign key constraint for CreatedBy
ALTER TABLE Accounts.Account
ADD CONSTRAINT FK_Account_CreatedBy FOREIGN KEY (CreatedBy)
REFERENCES Users.Users(UserID);

-- Add foreign key constraint for UpdatedBy
ALTER TABLE Accounts.Account
ADD CONSTRAINT FK_Account_UpdatedBy FOREIGN KEY (UpdatedBy)
REFERENCES Users.Users(UserID);

-- Add foreign key constraint for DeletedBy
ALTER TABLE Accounts.Account
ADD CONSTRAINT FK_Account_DeletedBy FOREIGN KEY (DeletedBy)
REFERENCES Users.Users(UserID);

-- Add foreign key constraint for ActivatedBy
ALTER TABLE Accounts.Account
ADD CONSTRAINT FK_Account_ActivatedBy FOREIGN KEY (ActivatedBy)
REFERENCES Users.Users(UserID);












create schema Transactions;

 

-- Create the Transactions table
CREATE TABLE Transactions.Transactions (
    TransactionGuidID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Number int identity(1,1) unique,
    Code VARCHAR(50),
    AccountGuidID UNIQUEIDENTIFIER,
    Debit DECIMAL(18, 2),
    Credit DECIMAL(18, 2),
    TransactionDate DATETIME default getdate(),
    Narrative nVARCHAR(100),
    CreatedBy int,
    CreatedAt DATETIME default getdate(),
    FOREIGN KEY (AccountGuidID) REFERENCES Accounts.Account(GuidID)
);

-- Create the Deposit table
CREATE TABLE Deposit (
    GuidID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Number int identity(1,1) unique,
    Code VARCHAR(50),
    TransactionGuidID UNIQUEIDENTIFIER,
    FOREIGN KEY (TransactionGuidID) REFERENCES Transactions.Transactions(TransactionGuidID)
);

-- Create the Withdrawal table
CREATE TABLE Withdrawal (
    GuidID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Number int identity(1,1) unique,
    Code VARCHAR(50),
    TransactionGuidID UNIQUEIDENTIFIER,
    FOREIGN KEY (TransactionGuidID) REFERENCES Transactions.Transactions(TransactionGuidID)
);

-- Create the Transfer table
CREATE TABLE Transfer (
    GuidID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Number int identity(1,1) unique,
    Code VARCHAR(50),
    TransactionGuidID UNIQUEIDENTIFIER,
    FOREIGN KEY (TransactionGuidID) REFERENCES Transactions.Transactions(TransactionGuidID)
);




-- Create the CheckingAccount table (specialized table)
CREATE TABLE Accounts.CheckingAccount (
    AccountGuidID UNIQUEIDENTIFIER PRIMARY KEY,
    OverdraftLimit DECIMAL(18, 2),
    FOREIGN KEY (AccountGuidID) REFERENCES Accounts.Account(GuidID)
);

-- Create the SavingAccount table (specialized table)
CREATE TABLE Accounts.SavingAccount (
    AccountGuidID UNIQUEIDENTIFIER PRIMARY KEY,
    InterestRate DECIMAL(5, 2),
    FOREIGN KEY (AccountGuidID) REFERENCES Accounts.Account(GuidID)
);

























