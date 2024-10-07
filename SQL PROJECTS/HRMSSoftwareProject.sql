-- Users table


-- Roles table
CREATE TABLE UserRole (
    RoleID INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) NOT NULL
);

-- Permissions table
CREATE TABLE Permission (
    PermissionID INT PRIMARY KEY IDENTITY,
    PermissionName NVARCHAR(50) NOT NULL
);

-- RolePermissions table
CREATE TABLE RolePermission (
    RoleID INT,
    PermissionID INT,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES UserRole (RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permission (PermissionID)
);


CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY IDENTITY,
	FullName nvarchar(50) not null,
    Username NVARCHAR(50) NOT NULL,
    UserPassword NVARCHAR(50) NOT NULL,
	IsActive BIT ,
    RoleID INT NOT NULL,
    FOREIGN KEY (RoleId) REFERENCES UserRole (RoleID)
);

CREATE TABLE AuditTrail (
  AuditID INT PRIMARY KEY identity,
  TableName VARCHAR(100),
  RecordID INT,
  ActionType VARCHAR(50),
  ActionDate DATETIME,
  UserID INT foreign key REFERENCES UserAccount(UserID)
);


-- Create the Country table
CREATE TABLE Country (
  CountryID INT PRIMARY KEY identity,
  CountryName VARCHAR(50)
);



-- Create the City table
CREATE TABLE City (
  CityID INT PRIMARY KEY identity,
  CityName VARCHAR(50),
  CountryID INT not null,
  FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);


-- Create the Company table
CREATE TABLE Company (
  CompanyID INT PRIMARY KEY IDENTITY(1,1),
  CompanyName nVARCHAR(100) NOT NULL,
  AddressLine nVARCHAR(200) NOT NULL,
  ZipCode nVARCHAR(20),
  Phone nvARCHAR(20) NOT NULL,
  Email nVARCHAR(100)NOT NULL,
  Logo nVARCHAR(MAX) NULL,
  Stamp nVARCHAR(MAX) NULL,
  Header nVARCHAR(MAX) NULL,
  Terms nVARCHAR(MAX) NULL,
  CityID INT not null,
  CONSTRAINT FK_City FOREIGN KEY (CityID) REFERENCES City(CityID)
);


CREATE TABLE Branch (
  BranchID INT PRIMARY KEY IDENTITY,
  BranchName nVARCHAR(100) NOT NULL,
  ZipCode VARCHAR(20),
  Phone VARCHAR(20),
  Email VARCHAR(100),
  ManagerID INT,
  CityID INT,
  CompanyID INT,
  FOREIGN KEY (CityID) REFERENCES City(CityID),
   FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

ALTER TABLE USERAccount
add BranchID INT foreign key references Branch(BranchID)

CREATE TABLE Positions (
    PositionID INT PRIMARY KEY identity,
    PositionTitle nVARCHAR(50)
);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY identity,
    DepartmentName nVARCHAR(50),
    DepartmentHead nVARCHAR(100)
);
-- Create Employees table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName nVARCHAR(50),
    LastName nVARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    AddressLine nVARCHAR(200),
    Email VARCHAR(100),
    Phone VARCHAR(20),
	MaritalStatus VARCHAR(50),
    BloodType VARCHAR(10),
	NationalNo NVARCHAR(50) NOT NULL UNIQUE,
    PassportNumber VARCHAR(20) null,
    PositionID INT,
    DepartmentID INT,
	CityID INT,
	ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (PositionID) REFERENCES Positions(PositionID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
	 FOREIGN KEY (CityID) REFERENCES City(CityID)
);

-- Create Positions table


-- Create Contracts table
CREATE TABLE Contracts (
    ContractID INT PRIMARY KEY,
    EmployeeID INT,
    ContractNumber VARCHAR(50),
    ContractStartDate DATE,
    ContractEndDate DATE,
    ContractType VARCHAR(50),
    Salary DECIMAL(10,2),
    Benefits VARCHAR(100),
    ContractStatus VARCHAR(50),
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create ContractTerms table
CREATE TABLE ContractTerms (
    ContractTermID INT PRIMARY KEY,
    ContractID INT,
    TermTitle VARCHAR(50),
    TermDescription VARCHAR(200),
    FOREIGN KEY (ContractID) REFERENCES Contracts(ContractID)
);

-- Create ContractAttachments table
CREATE TABLE ContractAttachments (
    AttachmentID INT PRIMARY KEY,
    ContractID INT,
    AttachmentName VARCHAR(100),
    AttachmentType VARCHAR(50),
    AttachmentData VARBINARY(MAX),
    FOREIGN KEY (ContractID) REFERENCES Contracts(ContractID)
);



