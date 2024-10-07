CREATE TABLE Tbl_Country(
Code INT IDENTITY(111,1) PRIMARY KEY,
CountryName varchar(30) not null
);

create table Tbl_City(
	Code int identity(1,1) Primary key,
	CityName varchar(30) not null,
	CountryCode int not null ,
	foreign key (CountryCode) references Tbl_Country(Code) 
);

CREATE TABLE Tbl_Address (
    ID INT PRIMARY KEY identity(1,1),
    StreetLine1 VARCHAR(100) NOT NULL,
    CountryCode int not null,
    CityCode int NOT NULL,
    StateProvince VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(20) NOT NULL,
    foreign key(CityCode) references Tbl_City(Code),
	
);


CREATE TABLE Tbl_Branch (
BranchID INT PRIMARY KEY IDENTITY(1,1),
BranchName VARCHAR(50) NOT NULL,
PhoneNumber VARCHAR(20) NOT NULL,
);

CREATE TABLE Tbl_Department(
	ID int identity(1,1) Primary key,
	BranchID int not null,
	DeptName varchar(100) not null,
	foreign key(BranchID) references Tbl_Branch(BranchID)

);

CREATE TABLE Tbl_JobTitle(
	ID int identity(1,1) primary key,
	DeptID int  ,
	JobTitle varchar(100) not null,
	foreign key(DeptID) references Tbl_Department(ID)
);

CREATE TABLE Tbl_Employee (
    PersonalInfoID INT PRIMARY KEY identity(1,1),
	AddressID int not null,
	JobTitleID int,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    SocialSecurityNumber VARCHAR(20) NOT NULL,
	foreign key(AddressID) references Tbl_Address(ID),
	foreign key(JobTitleID) references Tbl_JobTitle(ID)
);



CREATE TABLE Tbl_Customer (
    CustomerID INT PRIMARY KEY identity(1,1),
	AddressID int not null,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    SocialSecurityNumber VARCHAR(20) NOT NULL,
	foreign key(AddressID) references Tbl_Address(ID)
);





CREATE TABLE Tbl_User(
UserID int identity(1,1) primary key,
FullName varchar(100) not null,
Username Varchar(100) not null,
Pass varchar(100) not null,
);

INSERT INTO Tbl_User (FullName, Username, Pass)
VALUES ('Abdullah Abdo Mohammed', 'Admin', 'Admin')

CREATE TABLE Tbl_AccountType(
AccountTypeID int identity(1,1) PRIMARY KEY,
AccountTypeName varchar(50)
);

CREATE TABLE Tbl_Account (
AccountNumber INT PRIMARY KEY,
CustomerID INT NOT NULL,
AccountTypeID int NOT NULL,
Balance DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Tbl_Customer(CustomerID),
FOREIGN KEY (AccountTypeID) REFERENCES Tbl_AccountType(AccountTypeID)
);

CREATE TABLE Tbl_TransactionType(
TransactionTypeID int identity(1,1)primary key,
TransactionTypeName varchar(50)
); 

CREATE TABLE Transactions (
TransactionID INT PRIMARY KEY identity(1,1),
AccountNumber INT NOT NULL,
TransactionTypeID int not NULL,
Amount DECIMAL(10, 2) NOT NULL,
TransactionDate DATETIME DEFAULT GETDATE(),

FOREIGN KEY (AccountNumber) REFERENCES Tbl_Account(AccountNumber),
FOREIGN KEY (TransactionTypeID) REFERENCES Tbl_TransactionType(TransactionTypeID)
);





