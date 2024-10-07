

CREATE TABLE Country (
  CountryID INT IDENTITY(1,1) PRIMARY KEY,
  CountryName VARCHAR(255) NOT NULL
);

CREATE TABLE CityGroup (
  GroupID INT IDENTITY(1,1) PRIMARY KEY,
  GroupName VARCHAR(255) NOT NULL
);

CREATE TABLE City (
  CityID INT IDENTITY(1,1) PRIMARY KEY,
  CityName VARCHAR(255) NOT NULL,
  GroupID INT,
  CountryID INT,
  
);


CREATE TABLE Person (
  PersonID INT IDENTITY(1,1) PRIMARY KEY,
  NationalNo VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255) NOT NULL,
  FatherName VARCHAR(255) NOT NULL,
  GrandfatherName VARCHAR(255) NOT NULL,
  FamilyName VARCHAR(255) NOT NULL,
  DateOfBirth DATE NOT NULL,
  Gender VARCHAR(10) NOT NULL,
  MaritalStatus VARCHAR(20) NOT NULL,
  BloodType VARCHAR(10) NOT NULL,
  PrimaryPhone VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  AddressLine1 VARCHAR(500) NOT NULL,
  ImagePath VARCHAR(max) NOT NULL,
  CityID INT,
  BranchID INT,
 
);




CREATE TABLE Degree (
  DegreeID INT IDENTITY(1,1) PRIMARY KEY,
  DegreeName VARCHAR(255) NOT NULL
);

CREATE TABLE Department (
  DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
  DepartmentName VARCHAR(255) NOT NULL,
  BranchID INT,
  ManagerID INT
);

CREATE TABLE Job (
  JobID INT IDENTITY(1,1) PRIMARY KEY,
  JobName VARCHAR(255) NOT NULL,
  DepartmentID INT,
 
);

CREATE TABLE Qualification (
  QualificationID INT IDENTITY(1,1) PRIMARY KEY,
  QualificationName VARCHAR(255) NOT NULL
);

CREATE TABLE Section (
  SectionID INT IDENTITY(1,1) PRIMARY KEY,
  SectionName VARCHAR(255) NOT NULL,
  DepartmentID INT,
 
);

CREATE TABLE Speciality (
  SpecialityID INT IDENTITY(1,1) PRIMARY KEY,
  SpecialityName VARCHAR(255) NOT NULL
);


CREATE TABLE Employee (
  EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
  PersonID INT unique,
  HireDate DATE,
  EmployeeStatus VARCHAR(50),
  DepartmentID INT,
  JobID INT,
  SpecialityID INT,
  DegreeID INT,
 
);

alter table Employee
add QualificationID INT


-- Create the AccountType table
CREATE TABLE AccountType (
  TypeID INT PRIMARY KEY,
  TypeName VARCHAR(50)
);

-- Create the Account table
CREATE TABLE Account (
  AccountID INT PRIMARY KEY,
  AccountCode VARCHAR(50),
  AccountName VARCHAR(255),
  NormalBalance VARCHAR(50),
  AccountTypeID INT,
  
);

-- Create the Transactions table
CREATE TABLE Transactions (
  TransactionID INT PRIMARY KEY,
  TransactionDate DATE,
  Description VARCHAR(255),
  ReferenceNumber VARCHAR(50)
);

-- Create the JournalEntry table
CREATE TABLE JournalEntries (
  EntryID INT PRIMARY KEY,
  TransactionID INT,
  AccountID INT,
  Debit DECIMAL(18, 2),
  Credit DECIMAL(18, 2),
  Description VARCHAR(255),
  IsPosted BIT

);

-- Create the AccountBalance table
CREATE TABLE AccountBalance (
  AccountID INT PRIMARY KEY,
  Balance DECIMAL(18, 2),
 
);

create Proc sp_PostJournal
as
begin
UPDATE Balances
SET Balance = Balance + 
  (SELECT SUM(Debit - Credit)
  FROM JournalEntries
  WHERE AccountID = Balances.AccountID)
WHERE AccountID IN (SELECT AccountID FROM JournalEntries);
end