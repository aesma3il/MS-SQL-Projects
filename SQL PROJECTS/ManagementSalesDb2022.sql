--create database SalesManagement
--drop database SalesManagement
--use SalesManagement

CREATE TABLE Tbl_Country (
  Code int PRIMARY KEY IDENTITY (1, 1),
  CountryName varchar(100),
  CreatedAt	DATE DEFAULT  GETDATE()
);

CREATE TABLE Tbl_City (
  Code int PRIMARY KEY IDENTITY (1, 1),
  CityName nvarchar(100),
  CountryID int REFERENCES Tbl_Country (Code),
    CreatedAt	DATE DEFAULT  GETDATE()
);

CREATE TABLE Tbl_Department (

  ID int PRIMARY KEY IDENTITY (1, 1),
  DName varchar(50) NOT NULL,
  CreatedAt	DATE DEFAULT  GETDATE()

);

CREATE TABLE Tbl_JobTitle (
  ID int PRIMARY KEY IDENTITY (1, 1),
  JobTitle varchar(50) NOT NULL,
  CreatedAt	DATE DEFAULT  GETDATE()
);


CREATE TABLE Tbl_Employee (

  ID int PRIMARY KEY IDENTITY (1, 1),
  FirstName varchar(20),
  LastName varchar(20),
  DateOfBirth datetime,
  Gender varchar(10),
  Email varchar(30),
  Phone varchar(30),
  Username varchar(100),
  Pass varchar(100),
  [Address] varchar(50),
  CityCode int,
  CountryCode int,
  JobTitleID int,
  DeptID int,
  CreatedAt	DATE DEFAULT  GETDATE(),

  CONSTRAINT FK_DEPT_EMPLOYEE FOREIGN KEY (DeptID) REFERENCES Tbl_Department (ID),
  CONSTRAINT FK_JOBTITLE_EMPLOYEE FOREIGN KEY (JobTitleID) REFERENCES Tbl_JobTitle (ID),
  CONSTRAINT FK_CITYOFEMPLOYEE FOREIGN KEY (CityCode) REFERENCES Tbl_City (Code),
  CONSTRAINT FK_countryOFEMPLOYEE FOREIGN KEY (CountryCode) REFERENCES Tbl_Country (Code)

);


CREATE TABLE Tbl_Customer (
  CustomerID int PRIMARY KEY IDENTITY (1, 1),
  CustomerName varchar(100),
  Email varchar(50),
  Phone varchar(50),
  CityID int,
  Picture image,
  CreatedAt	DATE DEFAULT  GETDATE(),
  CONSTRAINT fk_Cust_City FOREIGN KEY (CityID) REFERENCES Tbl_City (Code)
);

CREATE TABLE Tbl_User (
  ID int PRIMARY KEY IDENTITY (1, 1),
  FullName varchar(100),
  Email varchar(100),
  Phone varchar(100),
  Username varchar(100),
  Pass varchar(100),
  CreatedAt	DATE DEFAULT  GETDATE()
);


CREATE TABLE Tbl_Store (
  ID int PRIMARY KEY IDENTITY (1, 1),
  StoreName varchar(100),
  CreatedAt	DATE DEFAULT  GETDATE()

);


CREATE TABLE Tbl_Category (
  ID int PRIMARY KEY IDENTITY (1, 1),
  CategoryName varchar(100),
  CategoryImage varchar(max),
  CreatedAt	DATE DEFAULT  GETDATE()
);


CREATE TABLE Tbl_Product (
  ID int PRIMARY KEY IDENTITY (1, 1),
  CategoryID int NOT NULL,
  StoreID int NOT NULL,
  ProductName varchar(100) NOT NULL,
  [Description] varchar(200),
  [Quantity] int NOT NULL DEFAULT 0,
  Price varchar(20),
  Picture image,
  CreatedAt	DATE DEFAULT  GETDATE(),
  CONSTRAINT fk_cat_produ FOREIGN KEY (CategoryID) REFERENCES Tbl_Category (ID),
  CONSTRAINT fk_stor_produ FOREIGN KEY (StoreID) REFERENCES Tbl_Store (ID)
);

CREATE TABLE Tbl_Inventory (
  InventoryId int PRIMARY KEY IDENTITY (1, 1),
  ProductId int NOT NULL,
  Quantity int NOT NULL,
  LastUpdated datetime NOT NULL DEFAULT GETDATE(),
  CONSTRAINT FK_Inventory_Product FOREIGN KEY (ProductId)
  REFERENCES Tbl_Product (ID)
);



CREATE TABLE Tbl_Order (
	OrderID int PRIMARY KEY IDENTITY (1, 1),
	OrderDate date,
	[Description] varchar(50),
    TotalAmount float,
    CustomerID int,
    EmployeeID int,
	CreatedAt	DATE DEFAULT  GETDATE(),
  CONSTRAINT fk_customerOrder FOREIGN KEY (CustomerID) REFERENCES Tbl_Customer (CustomerID),
  CONSTRAINT fk_EMPLOYEEOrder FOREIGN KEY (EmployeeID) REFERENCES Tbl_Employee (ID)
);

CREATE TABLE Tbl_Payment (
  PaymentId int PRIMARY KEY,
  OrderId int NOT NULL UNIQUE,
  PaymentDate datetime NOT NULL,
  PaymentAmount decimal(10, 2) NOT NULL,
  PaymentMethod varchar(50) NOT NULL,
  CreatedAt	DATE DEFAULT  GETDATE(),
  CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES Tbl_Order (OrderID)
);

CREATE TABLE Tbl_OrderItems (
  OrderItemID int PRIMARY KEY IDENTITY (1, 1),
  OrderID int NOT NULL,
  ProductID int NOT NULL,
  Price float NOT NULL,
  Quantity int NOT NULL,
  SubTotal AS Quantity * Price,
  CreatedAt	DATE DEFAULT  GETDATE(),
  CONSTRAINT fk_o_Oitems FOREIGN KEY (OrderID) REFERENCES Tbl_Order (OrderID),
  CONSTRAINT fk_o_p FOREIGN KEY (ProductID) REFERENCES Tbl_Product (ID)

);

--queries



--CREATE PROCEDURE sp_GetCustomerOrders
--    @CustomerID INT
--AS
--BEGIN
--    SELECT OrderID, OrderDate, [Description], TotalAmount
--    FROM Tbl_Order
--    WHERE CustomerID = @CustomerID;
--END;

--CREATE PROCEDURE sp_GetProductInventory
--    @ProductID INT
--AS
--BEGIN
--    SELECT ProductID, Quantity
--    FROM Tbl_Inventory
--    WHERE ProductID = @ProductID;
--END;

--CREATE PROCEDURE sp_AddOrderItem
--    @OrderID INT,
--    @ProductID INT,
--    @Price FLOAT,
--    @Quantity INT
--AS
--BEGIN
--    INSERT INTO Tbl_OrderItems (OrderID, ProductID, Price, Quantity)
--    VALUES (@OrderID, @ProductID, @Price, @Quantity);
--END;

--CREATE PROCEDURE sp_UpdateProductInventory
--    @ProductID INT,
--    @Quantity INT
--AS
--BEGIN
--    UPDATE Tbl_Inventory
--    SET Quantity = @Quantity, LastUpdated = GETDATE()
--    WHERE ProductID = @ProductID;
--END;

--CREATE PROCEDURE sp_UpdateOrderTotalAmount
--    @OrderID INT
--AS
--BEGIN
--    UPDATE Tbl_Order
--    SET TotalAmount = (
--        SELECT SUM(SubTotal)
--        FROM Tbl_OrderItems
--        WHERE OrderID = @OrderID
--    )
--    WHERE OrderID = @OrderID;
--END;

--CREATE PROCEDURE sp_DeleteOrderItem
--    @OrderItemID INT
--AS
--BEGIN
--    DELETE FROM Tbl_OrderItems
--    WHERE OrderItemID = @OrderItemID;
--END;

--CREATE PROCEDURE sp_GetOrdersByEmployee
--    @EmployeeID INT
--AS
--BEGIN
--    SELECT OrderID, OrderDate, [Description], TotalAmount
--    FROM Tbl_Order
--    WHERE EmployeeID = @EmployeeID;
--END;

--CREATE PROCEDURE sp_GetProductByCategory
--    @CategoryID INT
--AS
--BEGIN
--    SELECT ID, CategoryID, StoreID, ProductName, [Description], Quantity, Price
--    FROM Tbl_Product
--    WHERE CategoryID = @CategoryID;
--END;

--CREATE PROCEDURE sp_GetCustomerByName
--    @CustomerName VARCHAR(100)
--AS
--BEGIN
--    SELECT CustomerID, CustomerName, Email, Phone, CityID
--    FROM Tbl_Customer
--    WHERE CustomerName LIKE '%' + @CustomerName + '%';
--END;

--CREATE PROCEDURE sp_GetOrdersByDateRange
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT OrderID, OrderDate, [Description], TotalAmount, CustomerID, EmployeeID
--    FROM Tbl_Order
--    WHERE OrderDate BETWEEN @StartDate AND @EndDate;
--END;


--CREATE PROCEDURE sp_GetProductInventoryByStore
--    @StoreID INT
--AS
--BEGIN
--    SELECT P.ID, P.CategoryID, P.ProductName, I.Quantity, I.LastUpdated
--    FROM Tbl_Product P
--    INNER JOIN Tbl_Inventory I ON P.ID = I.ProductID
--    WHERE P.StoreID = @StoreID;
--END;


--CREATE PROCEDURE sp_GetOrderItemsByOrder
--    @OrderID INT
--AS
--BEGIN
--    SELECT OrderItemID, OrderID, ProductID, Price, Quantity
--    FROM Tbl_OrderItems
--    WHERE OrderID = @OrderID;
--END;

--CREATE PROCEDURE sp_GetCityByID
--    @CityID INT
--AS
--BEGIN
--    SELECT CityID, CityName, CountryID
--    FROM Tbl_City
--    WHERE CityID = @CityID;
--END;


--CREATE PROCEDURE sp_CreateCustomer
--    @CustomerName VARCHAR(100),
--    @Email VARCHAR(100),
--    @Phone VARCHAR(20),
--    @CityID INT
--AS
--BEGIN
--    DECLARE @CustomerID INT;
--    INSERT INTO Tbl_Customer (CustomerName, Email, Phone, CityID)
--    VALUES (@CustomerName, @Email, @Phone, @CityID);
--    SET @CustomerID = SCOPE_IDENTITY();
--    SELECT @CustomerID AS CustomerID;
--END;


--CREATE PROCEDURE sp_UpdateCustomer
--    @CustomerID INT,
--    @CustomerName VARCHAR(100),
--    @Email VARCHAR(100),
--    @Phone VARCHAR(20),
--    @CityID INT
--AS
--BEGIN
--    UPDATE Tbl_Customer
--    SET CustomerName = @CustomerName, Email = @Email, Phone = @Phone, CityID = @CityID
--    WHERE CustomerID = @CustomerID;
--END;

--CREATE PROCEDURE sp_CreateProduct
--    @ProductName VARCHAR(100),
--    @Description VARCHAR(500),
--    @CategoryID INT,
--    @StoreID INT,
--    @Quantity INT,
--    @Price DECIMAL(10, 2)
--AS
--BEGIN
--    DECLARE @ProductID INT;
--    INSERT INTO Tbl_Product (ProductName, [Description], CategoryID, StoreID, Quantity, Price)
--    VALUES (@ProductName, @Description, @CategoryID, @StoreID, @Quantity, @Price);
--    SET @ProductID = SCOPE_IDENTITY();
--    SELECT @ProductID AS ProductID;
--END;

--CREATE PROCEDURE sp_UpdateProduct
--    @ProductID INT,
--    @ProductName VARCHAR(100),
--    @Description VARCHAR(500),
--    @CategoryID INT,
--    @StoreID INT,
--    @Quantity INT,
--    @Price DECIMAL(10, 2)
--AS
--BEGIN
--    UPDATE Tbl_Product
--    SET ProductName = @ProductName, [Description] = @Description, CategoryID = @CategoryID,
--        StoreID = @StoreID, Quantity = @Quantity, Price = @Price
--    WHERE ID = @ProductID;
--END;

--CREATE PROCEDURE sp_DeleteOrder
--    @OrderID INT
--AS
--BEGIN
--    DELETE FROM Tbl_OrderItems
--    WHERE OrderID = @OrderID;
--    DELETE FROM Tbl_Order
--    WHERE OrderID = @OrderID;
--END;

--CREATE PROCEDURE sp_GetTopSellingProducts
--    @TopN INT
--AS
--BEGIN
--    SELECT TOP (@TopN) P.ProductName, SUM(OI.Quantity) AS TotalQuantitySold, SUM(OI.Quantity * OI.Price) AS TotalRevenue
--    FROM Tbl_OrderItems OI
--    INNER JOIN Tbl_Product P ON OI.ProductID = P.ID
--    GROUP BY P.ProductName
--    ORDER BY TotalQuantitySold DESC;
--END;



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
