CREATE TABLE City (
    CityID INT PRIMARY KEY,
    CityName NVARCHAR(255)
);

CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName NVARCHAR(255)
);

CREATE TABLE Address (
    AddressID INT PRIMARY KEY,
    StreetLine1 NVARCHAR(255),
    StreetLine2 NVARCHAR(255),
    PostalCode NVARCHAR(20),
	CityID INT,
    CountryID INT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    AddedBy INT,

    CONSTRAINT FK_Address_City FOREIGN KEY (CityID) REFERENCES City(CityID),
    CONSTRAINT FK_Address_Country FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE ContactInfo (
    ID INT PRIMARY KEY,
    Email NVARCHAR(255),
    PrimaryPhone NVARCHAR(20),
    SecondaryPhone NVARCHAR(20),
    WorkPhone NVARCHAR(20),
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed
);


CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName NVARCHAR(255),
    AddressID INT, 
	CEOID INT,
	ContactInfoID INT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed
);

CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    CompanyID INT,
    BranchName NVARCHAR(255),
    AddressID INT,
	ManagerID INT,
	ContactInfoID INT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed

    
);


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(255),
    Description NVARCHAR(MAX),
    ManagerID INT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed
);

CREATE TABLE JobTitle (
    JobTitleID INT PRIMARY KEY,
    JobTitleName NVARCHAR(255),
    Description NVARCHAR(MAX),
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed
);

CREATE TABLE Gender (
    GenderID INT PRIMARY KEY,
    GenderName NVARCHAR(50),
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed
);

CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    GenderID INT,
    DateOfBirth DATE,
    AddressID INT,
	ContactID INT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed

    CONSTRAINT FK_Person_Gender FOREIGN KEY (GenderID) REFERENCES Gender(GenderID)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    PersonID INT,
    DepartmentID INT,
    JobTitleID INT,
    HireDate DATE,
    Salary DECIMAL(12, 2),
    IsActive BIT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME
    -- Additional columns as needed

    CONSTRAINT FK_Employee_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    CONSTRAINT FK_Employee_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    CONSTRAINT FK_Employee_JobTitle FOREIGN KEY (JobTitleID) REFERENCES JobTitle(JobTitleID)
);