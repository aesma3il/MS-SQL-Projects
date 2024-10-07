----create database SalesManagement
--USE EmployeeManagementSystem
--use SalesManagement
create table Tbl_Country(
	Code int primary key identity(1,1),
	CountryName varchar(100)
);

Create table Tbl_City(
Code int primary key identity(1,1),
CityName nvarchar(100)
);

CREATE TABLE Tbl_Department(
	
	ID INT PRIMARY KEY identity(1,1),
	DName VARCHAR(50) NOT NULL

);

CREATE TABLE Tbl_JobTitle(

	ID INT PRIMARY KEY identity(1,1),
	JobTitle VARCHAR(50) NOT NULL

);


CREATE TABLE Tbl_Employee(
	
	ID INT PRIMARY KEY identity(1,1),
	FirstName VARCHAR(20),
	LastName	VARCHAR(20),
	DateOfBirth DATETIME ,
	Gender	VARCHAR(10),
	Email VARCHAR(30),
	Phone VARCHAR(30),
	Username varchar(100),
	Pass varchar(100),
	[Address] varchar(50),
	CityCode int,
	CountryCode int,
	JobTitleID INT,
	DeptID INT,

	CONSTRAINT FK_DEPT_EMPLOYEE FOREIGN KEY(DeptID) REFERENCES Tbl_Department(ID),
	CONSTRAINT FK_JOBTITLE_EMPLOYEE FOREIGN KEY(JobTitleID)	REFERENCES Tbl_JobTitle(ID) ,
	CONSTRAINT FK_CITYOFEMPLOYEE FOREIGN KEY(CityCode)	REFERENCES Tbl_City(Code) ,
	CONSTRAINT FK_countryOFEMPLOYEE FOREIGN KEY(CountryCode)	REFERENCES Tbl_Country(Code) 

);


create table Tbl_Customer(
CustomerID int primary key identity(1,1) ,
CustomerName varchar(100),
Email varchar(50),
Phone varchar(50),
CityID int,
Picture IMAGE,
constraint fk_Cust_City foreign key(CityID) references Tbl_City(Code)
);

create table Tbl_User(
ID int primary key identity(1,1),
FullName varchar(100),
Email  varchar(100),
Phone varchar(100),
Username varchar(100),
Pass varchar(100),
);


create table Tbl_Store(
ID int primary key identity(1,1),
StoreName varchar(100)
);


create table Tbl_Category(
ID int primary key identity(1,1),
CategoryName varchar(100),
CategoryImage Varchar(Max)
);


create table Tbl_Product(
ID int primary key identity(1,1),
CategoryID int NOT NULL,
StoreID int NOT NULL,
ProductName varchar(100) NOT NULL,
[Description] varchar(200),
[Quantity] int not null default 0,
Price Varchar(20),
Picture Image,
constraint fk_cat_produ foreign key(CategoryID) references Tbl_Category(ID) ,
constraint fk_stor_produ foreign key(StoreID) references Tbl_Store(ID) 
);

CREATE TABLE Inventory (
    InventoryId INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    LastUpdated DATETIME NOT NULL,
    CONSTRAINT FK_Inventory_Products FOREIGN KEY (ProductId)
        REFERENCES Tbl_Product(ID)
);



create table Tbl_Order(
ID int primary key identity(1,1),
OrderDate Date,
TotalAmount float,
CustomerID int,
constraint fk_customerOrder foreign key(CustomerID) references Tbl_Customer(CustomerID) on  update cascade
);

CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY,
    OrderId INT NOT NULL UNIQUE,
    PaymentDate DATETIME NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES Tbl_Order(ID) 
);

create Table Tbl_OrderItems(
	OrderItemID int primary key identity(1,1),
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Price float NOT NULL,
	Quantity int NOT NULL,
	SubTotal as Quantity * Price,

	constraint fk_o_Oitems foreign key(OrderID) references Tbl_Order(ID),
	constraint fk_o_p foreign key(ProductID) references Tbl_Product(ID)

);





--CREATE TRIGGER UpdateOrderTotalAmount
--ON OrderItems
--AFTER INSERT, UPDATE, DELETE
--AS
--BEGIN
--    UPDATE Orders
--    SET TotalAmount = (
--        SELECT SUM(Quantity * Price)
--        FROM OrderItems
--        WHERE OrderItems.OrderId = Orders.OrderId
--    )
--    WHERE Orders.OrderId IN (
--        SELECT OrderId
--        FROM inserted
--        UNION
--        SELECT OrderId
--        FROM deleted
--    );
--END;





---- Insert data into Tbl_Department
--INSERT INTO Tbl_Department (ID, DName)
--VALUES 
--    (6, 'Purchasing'),
--    (7, 'Adminstrative'),
--    (8, 'Employement'),
--    (9, ' advertising'),
--    (10, 'software design');

---- Insert data into Tbl_JobTitle
--INSERT INTO Tbl_JobTitle (ID, JobTitle)
--VALUES 
--    (1, 'Marketing Manager'),
--    (2, 'Sales Representative'),
--    (3, 'Financial Analyst'),
--    (4, 'HR Specialist'),
--    (5, 'Software Engineer');


--	INSERT INTO Tbl_JobTitle (ID, JobTitle)
--VALUES 
--    (6, 'Programmer ');


--	-- Insert data into Tbl_Employee
--INSERT INTO Tbl_Employee (ID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, JobTitleID, DeptID)
--VALUES 
--    (16, 'KHALID', 'kam', '1980-01-01', 'Male', 'KHA@example.com', '456-1234', 1, 1),
--    (17, 'SAIF', 'Doe', '1985-02-15', 'male', 'SAF@example.com', '789-5678', 1, 2),
--    (18, 'HODA', 'Smith', '1990-03-30', 'feMale', 'HODA@example.com', '543-2468', 1, 2),
--    (19, 'HANAN', 'MOHAMMED', '1995-04-15', 'female', 'HANA@example.com', '908-1357', 1, 4),
--    (20, 'HAYFA', 'HOW', '2000-05-01', 'FeMale', 'HA@example.com', '9098-7890', 1, 3);


--	SELECT * FROM Tbl_Employee
--	WHERE DeptID = 2 AND JobTitleID = 1


--	SELECT ID FROM Tbl_JobTitle
--	INTERSECT
--	SELECT JobTitleID FROM Tbl_Employee

--	SELECT ID FROM Tbl_JobTitle
--	EXCEPT
--	SELECT JobTitleID FROM Tbl_Employee

--	SELECT ID FROM Tbl_JobTitle
--	UNION
--	SELECT JobTitleID FROM Tbl_Employee

--	SELECT ID FROM Tbl_JobTitle
--	UNION ALL
--	SELECT JobTitleID FROM Tbl_Employee

--	SELECT * FROM Tbl_Employee
--	WHERE DeptID  NOT IN (SELECT ID FROM Tbl_Department)

--	SELECT * FROM Tbl_Employee 
--	WHERE ID IN (SELECT ID FROM Tbl_Employee
--					WHERE Gender ='Male' or Gender = 'male'				
--									);


									
--	SELECT * FROM Tbl_Employee 
--	WHERE ID IN (SELECT ID FROM Tbl_Employee
--					WHERE Gender ='Female' or Gender = 'feMale'				
--									);


									
--	SELECT * FROM Tbl_Employee 
--	WHERE ID IN (SELECT ID FROM Tbl_Employee
--					WHERE DeptID in(select DeptID from Tbl_Employee where JobTitleID in (1,2,3,4,5))		
--									);



									
--select e.FirstName, e.LastName, e.Email, e.Phone,e.Gender, d.DName, j.JobTitle
--from Tbl_Employee e
--inner join Tbl_Department d on (e.DeptID = d.ID )
--inner join Tbl_JobTitle j on (e.JobTitleID = j.ID)
