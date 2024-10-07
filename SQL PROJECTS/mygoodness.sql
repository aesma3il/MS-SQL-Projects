--CREATE database MyBestEffort
--use MybestEffort
-- Create Country table
CREATE TABLE Country (
    CountryID INT PRIMARY KEY IDENTITY(1,1) ,
    CountryName NVARCHAR(100) NOT NULL,
  
);

-- Create City table
CREATE TABLE City (
    CityID INT PRIMARY KEY  IDENTITY(1,1),
    CityName NVARCHAR(100) NOT NULL,
    CountryID INT NOT NULL,
  
);



-- Create Department table
-- Create Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY  IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL,
    ManagerID INT ,
    Budget DECIMAL(18, 2),
    

);


INSERT INTO Department (DepartmentName, Budget)
VALUES ('IT',  100000.00);

INSERT INTO Department (DepartmentName,  Budget)
VALUES ('Software Development', 80000.00);


insert into Department (DepartmentName) values ('dept')

select * from Department

-- Create Jobtitle table
CREATE TABLE Jobtitle (
    JobtitleID INT PRIMARY KEY  IDENTITY(1,1),
    JobtitleName NVARCHAR(100)NOT NULL,
    JobDescription NVARCHAR(100) NOT NULL,
	Salary DECIMAL(10,2) NOT NULL
);

-- Create Gender table
CREATE TABLE Gender (
    GenderID INT PRIMARY KEY  IDENTITY(1,1),
    GenderName NVARCHAR(20) NOT NULL
);


INSERT INTO Gender (GenderName)
VALUES ('Male');

INSERT INTO Gender (GenderName)
VALUES ('Female');

-- Add more genders as needed


-- Create Person table
CREATE TABLE Person (
    PersonID INT PRIMARY KEY  IDENTITY(1,1),
    FirstName	NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50),
    DateOfBirth DATE  NOT NULL,
	Phone NVARCHAR(20),
    Email NVARCHAR(100),
	PersonImage varchar(max) NOT NULL,
    CityID INT NOT NULL,
	GenderID INT  NOT NULL,
    
   
);

select * from Gender
INSERT INTO Person (FirstName, LastName, DateOfBirth, Phone, Email, PersonImage, CityID, GenderID)
VALUES ('Mohammed', 'Esmail', '1985-01-01', '73847499', 'mahmd.ye@example.com', 'image.jpg', 44694, 1);



INSERT INTO Jobtitle (JobtitleName, JobDescription, Salary)
VALUES ('Software Developer', 'Develop software applications', 5000.00);

INSERT INTO Jobtitle (JobtitleName, JobDescription, Salary)
VALUES ('Network Administrator', 'Manage and maintain network infrastructure', 4000.00);

-- Add more job titles as needed


-- Add more person records as needed

CREATE TABLE Employee(
 EmployeeID INT PRIMARY KEY,
 DepartmentID INT,
 JobtitleID INT,

);

select * from Department, Jobtitle
insert into Employee(EmployeeID ,DepartmentID, JobtitleID) values(1,4,1)



select * from City
order by CityID desc



-- Create UserAccount table
CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    RegistrationDate DATE default getdate(),
    LastLoginDate DATETIME,
    IsActive BIT default 0
);




-- Create Category table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100),
    Description VARCHAR(255)
);


alter table 


-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(18, 2),
    StockQuantity INT,
    
);




CREATE TABLE InvoiceType (
    InvoiceTypeID INT PRIMARY KEY,
    InvoiceTypeName VARCHAR(100),
   
);

-- Create TransactionHeader table
CREATE TABLE InvoiceHeader (
    InvoiceHeaderID INT PRIMARY KEY,
    InvoiceTypeID INT,
	ReferenceNumber VARCHAR(100),
	EmployeeID INT,
	BusinessEntityID INT,
    TransactionDate DATETIME,
    TotalAmount DECIMAL(18, 2),
   
);

-- Create TransactionDetail table
CREATE TABLE InvoiceDetail (
    DetailID INT PRIMARY KEY,
    InvoiceHeaderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(18, 2),
   
);


CREATE TABLE AccountType (
    AccountTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50)
);

alter table AccountType
drop constraint PK__AccountT__8F95854FD58FE800 


CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    AccountName VARCHAR(100),
    AccountTypeID INT,
	PersonID INT,
    ParentAccountID INT,
    FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID),
    FOREIGN KEY (ParentAccountID) REFERENCES Account(AccountID),
	FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Create Transaction table
CREATE TABLE [Transaction] (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATETIME,
	InvoiceHeaderID INT,
    [Description] VARCHAR(255),
    Amount DECIMAL(18, 2)
);


-- Create TransactionDetail table
CREATE TABLE TransactionDetail (
    DetailID INT PRIMARY KEY,
    TransactionID INT,
    AccountID INT,
    DebitAmount DECIMAL(18, 2),
    CreditAmount DECIMAL(18, 2),
    FOREIGN KEY (TransactionID) REFERENCES [Transaction](TransactionID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);



create table TempWorld(
City nvarchar(50),
Country NVARCHAR(50)
);

BULK INSERT TempWorld
FROM 'D:\csv\worldcities.csv'
WITH (
    FIRSTROW = 2, -- If the first row in the CSV contains column headers, set it to 2. Otherwise, use 1.
    FIELDTERMINATOR = ',', -- Specify the delimiter used in your CSV file.
    ROWTERMINATOR = '\n' -- Specify the row terminator used in your CSV file (e.g., '\n' for a line break).
);

INSERT INTO Country (CountryName)
SELECT DISTINCT Country FROM TempWorld;


INSERT INTO City (CityName, CountryID)
SELECT City, c.CountryID
FROM TempWorld t
JOIN Country c ON t.Country = c.CountryName;


select * from City

select * from Country ct
inner join City c on ct.CountryID = c.CountryID
where ct.CountryID = 110


SELECT p.PersonID, p.FirstName, p.LastName, concat(p.FirstName,' ', p.LastName)as FullName, p.Phone, p.Email, p.DateOfBirth AS 'Date Of Birth',
DATEDIFF(YEAR, p.DateOfBirth,GETDATE())AS Age,G.GenderName AS Gender, cty.CityName AS City, C.CountryName AS Country,
d.DepartmentName as Department, job.JobtitleName as 'Job Title'
FROM Person p
inner join Employee em on p.PersonID = em.EmployeeID
INNER JOIN City cty on p.CityID = cty.CityID
INNER JOIN Country c on cty.CountryID = c.CountryID
INNER JOIN Gender G ON p.GenderID = G.GenderID
inner join Department d on em.DepartmentID = d.DepartmentID
inner join Jobtitle job on em.JobtitleID = job.JobtitleID



ALTER TABLE City
ADD CONSTRAINT FK_City_Country FOREIGN KEY(CountryID) REFERENCES Country(CountryID)

ALTER TABLE Department
ADD CONSTRAINT FK_Department_Employee FOREIGN KEY(ManagerID) REFERENCES Employee(EmployeeID)

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Person FOREIGN KEY (CustomerID) REFERENCES Person(PersonID)

ALTER TABLE Supplier
ADD CONSTRAINT FK_Supplier_Person FOREIGN KEY(SupplierID) REFERENCES Person(PersonID)


ALTER TABLE  Person
ADD CONSTRAINT FK_Person_Gender FOREIGN KEY(GenderID) REFERENCES Gender(GenderID)

ALTER TABLE Person
ADD CONSTRAINT FK_Person_City FOREIGN KEY(CityID) REFERENCES City(CityID)


ALTER TABLE	Employee
ADD CONSTRAINT FK_Employee_Person FOREIGN KEY(EmployeeID) REFERENCES Person(PersonID)




ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Department_ FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID)

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_JobTitle FOREIGN KEY(JobTitleID) REFERENCES JobTitle(JobTitleID)

ALTER TABLE Product
ADD CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)

ALTER TABLE InvoiceHeader
ADD CONSTRAINT FK_TransHeader_InvoiceType  FOREIGN KEY (InvoiceTypeID) REFERENCES InvoiceType(InvoiceTypeID)

ALTER TABLE InvoiceDetail
ADD CONSTRAINT FK_InvoiceDetail_InvoiceHeader  FOREIGN KEY (InvoiceHeaderID) REFERENCES InvoiceHeader(InvoiceHeaderID)

ALTER TABLE InvoiceDetail
ADD CONSTRAINT  FK_TransDetail_Product  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)


ALTER TABLE InvoiceHeader
ADD CONSTRAINT FK_TransHeader_Emp_Person FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)


ALTER TABLE InvoiceHeader
ADD CONSTRAINT FK_TransHeader_CustomerOrSupplier FOREIGN KEY(BusinessEntityID) REFERENCES Person(PersonID)


ALTER TABLE [Transaction]
ADD CONSTRAINT FK_Trans_Invoice FOREIGN KEY(InvoiceHeaderID) REFERENCES InvoiceHeader(InvoiceHeaderID)

go

---store procedures:
CREATE PROCEDURE dbo.InsertCountry
    @CountryName NVARCHAR(100)
AS
BEGIN
    INSERT INTO Country (CountryName)
    VALUES (@CountryName)
END

go
CREATE PROCEDURE dbo.GetCountryByID
    @CountryID INT
AS
BEGIN
    SELECT *
    FROM Country
    WHERE CountryID = @CountryID
END
go
CREATE PROCEDURE dbo.UpdateCountry
    @CountryID INT,
    @CountryName NVARCHAR(100)
AS
BEGIN
    UPDATE Country
    SET CountryName = @CountryName
    WHERE CountryID = @CountryID
END

go
CREATE PROCEDURE dbo.DeleteCountry
    @CountryID INT
AS
BEGIN
    DELETE FROM Country
    WHERE CountryID = @CountryID
END
go
CREATE PROCEDURE GetAllCountry
AS
BEGIN
	 SELECT * FROM Country
END
go
CREATE proc InsertCity
@CityName VARCHAR(50),
@CountryID INT
as
begin
insert into City(CityName, CountryID) values (@CityName, @CountryID)
end
go
create Proc UpdateCity
@CityID INT,
@CityName varchar(50),
@CountryID INT
as 
begin
update City 
set CityName = @CityName,
CountryID = @CountryID
where CityID =@CityID


go

create proc uspUpdateCategory
@CategoryID INT,
@CategoryName nvarchar(50),
@Description nvarchar(50)
as
begin

update Category 
set CategoryName = @CategoryName,
Description = @Description
where CategoryID = @CategoryID


end;

go
create proc uspDeleteCategory
@ID INT
as
begin
delete from Category 
where CategoryID = @ID
end;

go

create proc uspGetAllCategory
as
begin
select *  from Category 

end;










--Queies for accounts:
--SELECT
--    A.AccountID,
--    A.AccountName,
--    T.TransactionDate,
--    T.Description,
--    TD.DebitAmount,
--    TD.CreditAmount
--FROM
--    Account A
--    INNER JOIN TransactionDetail TD ON A.AccountID = TD.AccountID
--    INNER JOIN [Transaction] T ON TD.TransactionID = T.TransactionID;




--	SELECT
--    A.AccountID,
--    A.AccountName,
--    SUM(TD.DebitAmount) AS TotalDebits,
--    SUM(TD.CreditAmount) AS TotalCredits
--FROM
--    Account A
--    INNER JOIN TransactionDetail TD ON A.AccountID = TD.AccountID
--GROUP BY
--    A.AccountID,
--    A.AccountName;




--show the transaction with the balance at each line 

--SELECT
--    A.AccountID,
--    A.AccountName,
--    T.TransactionDate,
--    T.Description,
--    TD.DebitAmount,
--    TD.CreditAmount,
--    SUM(TD.DebitAmount - TD.CreditAmount) OVER (PARTITION BY A.AccountID ORDER BY T.TransactionDate, T.TransactionID) AS Balance
--FROM
--    Account A
--    INNER JOIN TransactionDetail TD ON A.AccountID = TD.AccountID
--    INNER JOIN [Transaction] T ON TD.TransactionID = T.TransactionID;




















--If you have an interface with textboxes for the credit account and debit account, you can process the transaction successfully by following these steps:

--1. **Retrieve Account Information:** When the user enters the account information in the credit and debit account textboxes, retrieve the corresponding AccountIDs from the Account table in the database. You can use these AccountIDs to identify the accounts involved in the transaction.

--1. **Create Transaction Record:** Generate a new transaction record in the Transaction table. Assign a unique TransactionID, set the TransactionDate, and provide a brief Description for the transaction. You can also retrieve the transaction amount from the user if it's not already predetermined.

--1. **Insert Transaction Details:** Insert records into the TransactionDetail table to capture the debit and credit amounts for the accounts involved in the transaction. Use the TransactionID from the newly created transaction record, as well as the AccountIDs retrieved from the credit and debit account textboxes. Determine the appropriate debit and credit amounts based on the specific transaction scenario.

--1. **Update Account Balances:** Update the balances of the credit and debit accounts in the Account table based on the debit and credit amounts specified in the TransactionDetail table. You can calculate the new balances by subtracting the debit amount from the debit account and adding the credit amount to the credit account.

--1. **Display Success Message:** Once the transaction and account updates are processed successfully, display a success message to the user indicating that the transaction was completed.

--It's important to perform appropriate error handling and validation throughout the process to ensure data integrity and handle any exceptional scenarios that may arise. This may include checking if the entered account information is valid, verifying that the accounts have sufficient funds for debit transactions, and handling any database errors that may occur during the transaction processing.

--Additionally, consider implementing appropriate security measures, such as input sanitization and authentication, to protect against unauthorized access and ensure the integrity of the transaction processing system.



--To integrate the account and transaction data with a bill in your system, you can follow these steps:

--1. **Design a Bill Table:** Start by designing a table to represent the bill or invoice in your system. The structure of this table will depend on the specific requirements of your billing process, such as customer information, line items, total amount, and any other relevant details.

--1. **Link Bill to Transaction:** Add a foreign key column in the Bill table to reference the Transaction table. This column will establish a relationship between the bill and the corresponding transaction in the system. For example, you can add a column named `TransactionID` to the Bill table.

--1. **Retrieve Transaction Data:** When generating a bill, retrieve the relevant transaction data from the Transaction table using the `TransactionID`. This will allow you to access details such as the transaction date, description, and amount associated with the bill.

--1. **Calculate Bill Total:** Calculate the total amount for the bill by summing up the relevant amounts from the transaction details. You can use the `TransactionID` to join the TransactionDetail table and retrieve the debit and credit amounts. Apply appropriate logic based on your specific requirements, such as considering only debit amounts or netting debit and credit amounts.

--1. **Update Bill Table:** Populate the Bill table with the necessary information, including customer details, line items, and the calculated total amount. This will create a record of the bill associated with the relevant transaction.

--By integrating the account and transaction data with the bill, you can ensure that each bill is linked to the corresponding financial transaction in your system. This allows for accurate tracking, reporting, and reconciliation of financial data.

--Remember to adjust the table structures, data types, and column names based on your specific needs and naming conventions. Additionally, you may need to incorporate additional tables or logic to handle more complex billing requirements, such as tax calculations, discounts, or multiple line items.