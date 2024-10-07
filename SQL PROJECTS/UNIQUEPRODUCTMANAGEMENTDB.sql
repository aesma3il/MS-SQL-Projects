CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(50) NOT NULL
   
);

CREATE TABLE JobTitle (
    JobTitleID INT PRIMARY KEY IDENTITY(1,1),
    JobTitleName VARCHAR(50) NOT NULL
    -- Add other columns as needed
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender CHAR(1),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    AddressLine VARCHAR(200),
    DepartmentID INT,
    JobTitleID INT,
    -- Add other columns as needed
    CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department (DepartmentID),
    CONSTRAINT FK_Employee_JobTitle FOREIGN KEY (JobTitleID)
        REFERENCES JobTitle (JobTitleID)
);



CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender CHAR(1),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    AddressLine VARCHAR(200)
  
);

CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY IDENTITY(1,1),
	FullName VARCHAR(50) NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    [Password] VARCHAR(50) NOT NULL,
   
);


CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL
    -- Add other columns as needed
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50) NOT NULL,
	 Price DECIMAL(10, 2),
    StockQuantity INT,
    CategoryID INT,
    -- Add other columns as needed
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID)
        REFERENCES Category (CategoryID)
);

CREATE TABLE ProductEntityAttributeValue (
    EntityAttributeValueID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    AttributeName VARCHAR(50) NOT NULL,
    AttributeValue VARCHAR(50),
    -- Add other columns as needed
    CONSTRAINT FK_ProductEntityAttributeValue_Product FOREIGN KEY (ProductID)
        REFERENCES Product (ProductID)
);

CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY IDENTITY(1,1),
    TransactionTypeName VARCHAR(50) NOT NULL
    -- Add other columns as needed
);

CREATE TABLE TransactionHeader (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    TransactionTypeID INT,
    TransactionDate DATE,
    CustomerID INT,
    EmployeeID INT,
    TotalAmount DECIMAL(10, 2),
    -- Add other columns as needed
    CONSTRAINT FK_Header_TransactionType FOREIGN KEY (TransactionTypeID)
        REFERENCES TransactionType (TransactionTypeID),
    CONSTRAINT FK_Header_Customer FOREIGN KEY (CustomerID)
        REFERENCES Customer (CustomerID),
    CONSTRAINT FK_Header_Employee FOREIGN KEY (EmployeeID)
        REFERENCES Employee (EmployeeID)
);

CREATE TABLE TransactionDetail (
    DetailID INT PRIMARY KEY IDENTITY(1,1) ,
    TransactionID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    -- Add other columns as needed
    CONSTRAINT FK_Detail_Transaction FOREIGN KEY (TransactionID)
        REFERENCES TransactionHeader (TransactionID),
    CONSTRAINT FK_Detail_Product FOREIGN KEY (ProductID)
        REFERENCES Product (ProductID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    TransactionID INT,
    PaymentAmount DECIMAL(10, 2),
    PaymentDate DATE,
    -- Add other columns as needed
    CONSTRAINT FK_Payment_Transaction FOREIGN KEY (TransactionID)
        REFERENCES TransactionHeader (TransactionID)
);





create view vw_TotalEmployeeInEachDepartment
as
SELECT Department.DepartmentID, Department.DepartmentName, COUNT(Employee.EmployeeID) AS TotalEmployees
FROM Department
LEFT JOIN Employee ON Department.DepartmentID = Employee.DepartmentID
GROUP BY Department.DepartmentID, Department.DepartmentName;



create view vw_ProductDetail
as
SELECT Product.ProductID, Product.ProductName, Category.CategoryName
FROM Product
INNER JOIN Category ON Product.CategoryID = Category.CategoryID;


create view vw_TopFiveCustomerMadeHighestTotalTransaction
as
SELECT TOP 5 Customer.CustomerID, Customer.FirstName, Customer.LastName, SUM(TransactionHeader.TotalAmount) AS TotalTransactionAmount
FROM Customer
INNER JOIN TransactionHeader ON Customer.CustomerID = TransactionHeader.CustomerID
GROUP BY Customer.CustomerID, Customer.FirstName, Customer.LastName
ORDER BY TotalTransactionAmount DESC;

create view vw_EmployeesWhoMadeTransactionLast30Days
as
SELECT Employee.EmployeeID, Employee.FirstName, Employee.LastName
FROM Employee
INNER JOIN TransactionHeader ON Employee.EmployeeID = TransactionHeader.EmployeeID
WHERE TransactionHeader.TransactionDate >= DATEADD(DAY, -30, GETDATE())
GROUP BY Employee.EmployeeID, Employee.FirstName, Employee.LastName;



create view vw_AveragePriceStockQtyForEachCategory
as
SELECT Category.CategoryID, Category.CategoryName, AVG(Product.Price) AS AveragePrice, AVG(Product.StockQuantity) AS AverageStockQuantity
FROM Category
LEFT JOIN Product ON Category.CategoryID = Product.CategoryID
GROUP BY Category.CategoryID, Category.CategoryName;



create proc GetProductAttributeValueWithSpecificAttribute
@AttributeName varchar(50)
as
begin
SELECT Product.ProductID, Product.ProductName, ProductEntityAttributeValue.AttributeName, ProductEntityAttributeValue.AttributeValue
FROM Product
INNER JOIN ProductEntityAttributeValue ON Product.ProductID = ProductEntityAttributeValue.ProductID
WHERE ProductEntityAttributeValue.AttributeName = @AttributeName;
end;


create proc GetTotalAmountForEachTransaction
as
SELECT TransactionHeader.TransactionID, SUM(Payment.PaymentAmount) AS TotalPaymentAmount
FROM TransactionHeader
LEFT JOIN Payment ON TransactionHeader.TransactionID = Payment.TransactionID
GROUP BY TransactionHeader.TransactionID;



create proc TopSellingProduct
as
SELECT
    Product.ProductID,
    Product.ProductName,
    Category.CategoryName,
    SUM(TransactionDetail.Quantity) AS TotalQuantitySold
FROM
    Product
INNER JOIN
    Category ON Product.CategoryID = Category.CategoryID
INNER JOIN
    TransactionDetail ON Product.ProductID = TransactionDetail.ProductID
GROUP BY
    Product.ProductID,
    Product.ProductName,
    Category.CategoryName
ORDER BY
    TotalQuantitySold DESC;




	create proc GetEmployeeNotMadeTransaction
	as
	SELECT
    Employee.EmployeeID,
    Employee.FirstName,
    Employee.LastName
FROM
    Employee
LEFT JOIN
    TransactionHeader ON Employee.EmployeeID = TransactionHeader.EmployeeID
WHERE
    TransactionHeader.TransactionID IS NULL;



create proc GetCustomerMadeTransactionInAllTransType
as
	SELECT
    Customer.CustomerID,
    Customer.FirstName,
    Customer.LastName
FROM
    Customer
INNER JOIN
    TransactionHeader ON Customer.CustomerID = TransactionHeader.CustomerID
GROUP BY
    Customer.CustomerID,
    Customer.FirstName,
    Customer.LastName
HAVING
    COUNT(DISTINCT TransactionHeader.TransactionTypeID) = (SELECT COUNT(*) FROM TransactionType);




	create proc TotalNumberProductForEachCategory
	as
	SELECT
    Category.CategoryName,
    COUNT(Product.ProductID) AS TotalProducts
FROM
    Category
LEFT JOIN
    Product ON Category.CategoryID = Product.CategoryID
GROUP BY
    Category.CategoryName;


	create proc GetEmployeeWhoHaveSameJobtTitle
	as
	SELECT
    E1.EmployeeID,
    E1.FirstName,
    E1.LastName,
    E1.JobTitleID
FROM
    Employee E1
INNER JOIN
    Employee E2 ON E1.JobTitleID = E2.JobTitleID
WHERE
    E1.EmployeeID <> E2.EmployeeID;




	create proc OutOfStock
	as
	SELECT
    P.ProductID,
    P.ProductName,
    P.StockQuantity
FROM
    Product P
WHERE
    P.StockQuantity = 0;









	create proc GetCustomerWhoMadeInAllCategories
	as
	SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName
FROM
    Customer C
INNER JOIN
    TransactionHeader TH ON C.CustomerID = TH.CustomerID
INNER JOIN
    TransactionDetail TD ON TH.TransactionID = TD.TransactionID
INNER JOIN
    Product P ON TD.ProductID = P.ProductID
GROUP BY
    C.CustomerID,
    C.FirstName,
    C.LastName
HAVING
    COUNT(DISTINCT P.CategoryID) = (SELECT COUNT(*) FROM Category);






	create proc Top5CategoryHighestRevenue
	as
	SELECT
    C.CategoryID,
    C.CategoryName,
    SUM(TD.Quantity * TD.UnitPrice) AS TotalRevenue
FROM
    Category C
INNER JOIN
    Product P ON C.CategoryID = P.CategoryID
INNER JOIN
    TransactionDetail TD ON P.ProductID = TD.ProductID
GROUP BY
    C.CategoryID,
    C.CategoryName
ORDER BY
    TotalRevenue DESC




CREATE PROCEDURE CreateProductEntityAttributeValue
    @ProductID INT,
    @AttributeName VARCHAR(50),
    @AttributeValue VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO ProductEntityAttributeValue (ProductID, AttributeName, AttributeValue)
    VALUES (@ProductID, @AttributeName, @AttributeValue);
END;


CREATE PROCEDURE GetProductEntityAttributeValueByID
    @EntityAttributeValueID INT
AS
BEGIN
    SELECT *
    FROM ProductEntityAttributeValue
    WHERE EntityAttributeValueID = @EntityAttributeValueID;
END;


CREATE PROCEDURE UpdateProductEntityAttributeValue
    @EntityAttributeValueID INT,
    @ProductID INT,
    @AttributeName VARCHAR(50),
    @AttributeValue VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    UPDATE ProductEntityAttributeValue
    SET ProductID = @ProductID,
        AttributeName = @AttributeName,
        AttributeValue = @AttributeValue
    WHERE EntityAttributeValueID = @EntityAttributeValueID;
END;

CREATE PROCEDURE DeleteProductEntityAttributeValue
    @EntityAttributeValueID INT
AS
BEGIN
    DELETE FROM ProductEntityAttributeValue
    WHERE EntityAttributeValueID = @EntityAttributeValueID;
END;








CREATE PROCEDURE CreateCategory
    @CategoryName VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO Category (CategoryName)
    VALUES (@CategoryName);
END;

CREATE PROCEDURE GetAllCategories
AS
BEGIN
    SELECT CategoryID, CategoryName
    FROM Category;
END;

CREATE PROCEDURE GetCategoryByID
    @CategoryID INT
AS
BEGIN
    SELECT CategoryID, CategoryName
    FROM Category
    WHERE CategoryID = @CategoryID;
END;

CREATE PROCEDURE UpdateCategory
    @CategoryID INT,
    @CategoryName VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    UPDATE Category
    SET CategoryName = @CategoryName
    WHERE CategoryID = @CategoryID;
END;


CREATE PROCEDURE DeleteCategory
    @CategoryID INT
AS
BEGIN
    DELETE FROM Category
    WHERE CategoryID = @CategoryID;
END;







CREATE PROCEDURE CreateProduct
    @ProductName VARCHAR(50),
    @Price DECIMAL(10, 2),
    @StockQuantity INT,
    @CategoryID INT
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO Product (ProductName, Price, StockQuantity, CategoryID)
    VALUES (@ProductName, @Price, @StockQuantity, @CategoryID);
END;


CREATE PROCEDURE GetAllProducts
AS
BEGIN
    SELECT P.ProductID, P.ProductName, P.Price, P.StockQuantity, P.CategoryID
    FROM Product P;
END;

CREATE PROCEDURE GetProductByID
    @ProductID INT
AS
BEGIN
    SELECT P.ProductID, P.ProductName, P.Price, P.StockQuantity, P.CategoryID
    FROM Product P
    WHERE P.ProductID = @ProductID;
END;









CREATE PROCEDURE UpdateProduct
    @ProductID INT,
    @ProductName VARCHAR(50),
    @Price DECIMAL(10, 2),
    @StockQuantity INT,
    @CategoryID INT
    -- Add other parameters as needed
AS
BEGIN
    UPDATE Product
    SET ProductName = @ProductName,
        Price = @Price,
        StockQuantity = @StockQuantity,
        CategoryID = @CategoryID
    WHERE ProductID = @ProductID;
END;


CREATE PROCEDURE DeleteProduct
    @ProductID INT
AS
BEGIN
    DELETE FROM Product
    WHERE ProductID = @ProductID;
END;





CREATE PROCEDURE CreateTransactionType
    @TransactionTypeName VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO TransactionType (TransactionTypeName)
    VALUES (@TransactionTypeName);
END;


CREATE PROCEDURE GetAllTransactionTypes
AS
BEGIN
    SELECT TransactionTypeID, TransactionTypeName
    FROM TransactionType;
END;




CREATE PROCEDURE GetTransactionTypeByID
    @TransactionTypeID INT
AS
BEGIN
    SELECT TransactionTypeID, TransactionTypeName
    FROM TransactionType
    WHERE TransactionTypeID = @TransactionTypeID;
END;

CREATE PROCEDURE UpdateTransactionType
    @TransactionTypeID INT,
    @TransactionTypeName VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    UPDATE TransactionType
    SET TransactionTypeName = @TransactionTypeName
    WHERE TransactionTypeID = @TransactionTypeID;
END;


CREATE PROCEDURE DeleteTransactionType
    @TransactionTypeID INT
AS
BEGIN
    DELETE FROM TransactionType
    WHERE TransactionTypeID = @TransactionTypeID;
END;



CREATE PROCEDURE PlaceOrder
    @TransactionTypeID INT,
    @TransactionDate DATE,
    @CustomerID INT,
    @EmployeeID INT,
    @TotalAmount DECIMAL(10, 2),
    @ProductIDs VARCHAR(MAX),
    @Quantities VARCHAR(MAX)
    -- Add other parameters as needed
AS
BEGIN
    -- Insert into TransactionHeader
    INSERT INTO TransactionHeader (TransactionTypeID, TransactionDate, CustomerID, EmployeeID, TotalAmount)
    VALUES (@TransactionTypeID, @TransactionDate, @CustomerID, @EmployeeID, @TotalAmount);

    -- Retrieve the generated TransactionID
    DECLARE @TransactionID INT;
    SET @TransactionID = SCOPE_IDENTITY();

    -- Insert into TransactionDetail
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;
    DECLARE @UnitPrice DECIMAL(10, 2);

    -- Split the comma-separated product IDs and quantities
    DECLARE @ProductIDList TABLE (ID INT);
    DECLARE @QuantityList TABLE (Qty INT);

    INSERT INTO @ProductIDList (ID)
    SELECT CAST(value AS INT)
    FROM STRING_SPLIT(@ProductIDs, ',');

    INSERT INTO @QuantityList (Qty)
    SELECT CAST(value AS INT)
    FROM STRING_SPLIT(@Quantities, ',');

    -- Iterate through the product IDs and quantities lists
    DECLARE ProductCursor CURSOR FOR
        SELECT ID FROM @ProductIDList;

    DECLARE QuantityCursor CURSOR FOR
        SELECT Qty FROM @QuantityList;

    OPEN ProductCursor;
    OPEN QuantityCursor;

    FETCH NEXT FROM ProductCursor INTO @ProductID;
    FETCH NEXT FROM QuantityCursor INTO @Quantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Retrieve the unit price of the product
        SET @UnitPrice = (SELECT Price FROM Product WHERE ProductID = @ProductID);

        -- Insert into TransactionDetail
        INSERT INTO TransactionDetail (TransactionID, ProductID, Quantity, UnitPrice)
        VALUES (@TransactionID, @ProductID, @Quantity, @UnitPrice);

        FETCH NEXT FROM ProductCursor INTO @ProductID;
        FETCH NEXT FROM QuantityCursor INTO @Quantity;
    END

    CLOSE ProductCursor;
    CLOSE QuantityCursor;

    DEALLOCATE ProductCursor;
    DEALLOCATE QuantityCursor;
END;



CREATE PROCEDURE GetOrderByID
    @TransactionID INT
AS
BEGIN
    SELECT TH.TransactionID, TH.TransactionTypeID, TH.TransactionDate, TH.CustomerID, TH.EmployeeID, TH.TotalAmount,
           TD.DetailID, TD.ProductID, TD.Quantity, TD.UnitPrice
    FROM TransactionHeader TH
    INNER JOIN TransactionDetail TD ON TH.TransactionID = TD.TransactionID
    WHERE TH.TransactionID = @TransactionID;
END;



CREATE PROCEDURE GetAllOrders
AS
BEGIN
    SELECT TH.TransactionID, TH.TransactionTypeID, TH.TransactionDate, TH.CustomerID, TH.EmployeeID, TH.TotalAmount,
           TD.DetailID, TD.ProductID, TD.Quantity, TD.UnitPrice
    FROM TransactionHeader TH
    INNER JOIN TransactionDetail TD ON TH.TransactionID = TD.TransactionID;
END;


CREATE PROCEDURE DeleteOrder
    @TransactionID INT
AS
BEGIN
    -- Delete from TransactionDetail
    DELETE FROM TransactionDetail
    WHERE TransactionID = @TransactionID;

    -- Delete from TransactionHeader
    DELETE FROM TransactionHeader
    WHERE TransactionID = @TransactionID;
END;



CREATE PROCEDURE UpdateOrder
    @TransactionID INT,
    @TransactionTypeID INT,
    @TransactionDate DATE,
    @CustomerID INT,
    @EmployeeID INT,
    @TotalAmount DECIMAL(10, 2),
    @ProductIDs VARCHAR(MAX),
    @Quantities VARCHAR(MAX)
    -- Add other parameters as needed
AS
BEGIN
    -- Update TransactionHeader
    UPDATE TransactionHeader
    SET TransactionTypeID = @TransactionTypeID,
        TransactionDate = @TransactionDate,
        CustomerID = @CustomerID,
        EmployeeID = @EmployeeID,
        TotalAmount = @TotalAmount
    WHERE TransactionID = @TransactionID;

    -- Delete existing TransactionDetail records
    DELETE FROM TransactionDetail
    WHERE TransactionID = @TransactionID;

    -- Insert updated TransactionDetail records
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;
    DECLARE @UnitPrice DECIMAL(10, 2);

    -- Split the comma-separated product IDs and quantities
    DECLARE @ProductIDList TABLE (ID INT);
    DECLARE @QuantityList TABLE (Qty INT);

    INSERT INTO @ProductIDList (ID)
    SELECT CAST(value AS INT)
    FROM STRING_SPLIT(@ProductIDs, ',');

    INSERT INTO @QuantityList (Qty)
    SELECT CAST(value AS INT)
    FROM STRING_SPLIT(@Quantities, ',');

    -- Iterate through the product IDs and quantities lists
    DECLARE ProductCursor CURSOR FOR
        SELECT ID FROM @ProductIDList;

    DECLARE QuantityCursor CURSOR FOR
        SELECT Qty FROM @QuantityList;

    OPEN ProductCursor;
    OPEN QuantityCursor;

    FETCH NEXT FROM ProductCursor INTO @ProductID;
    FETCH NEXT FROM QuantityCursor INTO @Quantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Retrieve the unit price of the product
        SET @UnitPrice = (SELECT Price FROM Product WHERE ProductID = @ProductID);

        -- Insert into TransactionDetail
        INSERT INTO TransactionDetail (TransactionID, ProductID, Quantity, UnitPrice)
        VALUES (@TransactionID, @ProductID, @Quantity, @UnitPrice);

        FETCH NEXT FROM ProductCursor INTO @ProductID;
        FETCH NEXT FROM QuantityCursor INTO @Quantity;
    END;

    CLOSE ProductCursor;
    CLOSE QuantityCursor;

    DEALLOCATE ProductCursor;
    DEALLOCATE QuantityCursor;
END;


CREATE PROCEDURE CreatePayment
    @TransactionID INT,
    @PaymentAmount DECIMAL(10, 2),
    @PaymentDate DATE
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO Payment (TransactionID, PaymentAmount, PaymentDate)
    VALUES (@TransactionID, @PaymentAmount, @PaymentDate);
END;


CREATE PROCEDURE GetPaymentById
    @PaymentID INT
AS
BEGIN
    SELECT *
    FROM Payment
    WHERE PaymentID = @PaymentID;
END;

CREATE PROCEDURE UpdatePayment
    @PaymentID INT,
    @TransactionID INT,
    @PaymentAmount DECIMAL(10, 2),
    @PaymentDate DATE
    -- Add other parameters as needed
AS
BEGIN
    UPDATE Payment
    SET TransactionID = @TransactionID,
        PaymentAmount = @PaymentAmount,
        PaymentDate = @PaymentDate
    WHERE PaymentID = @PaymentID;
END;


CREATE PROCEDURE DeletePayment
    @PaymentID INT
AS
BEGIN
    DELETE FROM Payment
    WHERE PaymentID = @PaymentID;
END;






-- Create
CREATE PROCEDURE CreateDepartment
    @DepartmentName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Department (DepartmentName)
    VALUES (@DepartmentName);
    
    SELECT SCOPE_IDENTITY() AS DepartmentID;
END;

-- Read
CREATE PROCEDURE GetDepartment
    @DepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT *
    FROM Department
    WHERE DepartmentID = @DepartmentID;
END;

-- Update
CREATE PROCEDURE UpdateDepartment
    @DepartmentID INT,
    @DepartmentName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Department
    SET DepartmentName = @DepartmentName
    WHERE DepartmentID = @DepartmentID;
END;

-- Delete
CREATE PROCEDURE DeleteDepartment
    @DepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DELETE FROM Department
    WHERE DepartmentID = @DepartmentID;
END;



CREATE TABLE Logging (
    LogID INT IDENTITY(1, 1) PRIMARY KEY,
    TableName VARCHAR(100) NOT NULL,
    [Action] VARCHAR(20) NOT NULL,
    LogDate DATETIME NOT NULL,
    OldData NVARCHAR(MAX),
    NewData NVARCHAR(MAX)
);


CREATE TRIGGER trg_PersonLogging
ON Employee
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Action VARCHAR(20)

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
            SET @Action = 'UPDATE'
        ELSE
            SET @Action = 'INSERT'

        INSERT INTO Logging (TableName, Action, LogDate, OldData, NewData)
        SELECT 'Employee', @Action, GETDATE(), CAST(OldValues AS NVARCHAR(MAX)), CAST(NewValues AS NVARCHAR(MAX))
        FROM (
            SELECT (SELECT * FROM deleted FOR XML RAW, ELEMENTS, TYPE).query('/row') AS OldValues,
                   (SELECT * FROM inserted FOR XML RAW, ELEMENTS, TYPE).query('/row') AS NewValues
        ) AS LoggingData
    END
    ELSE
    BEGIN
        SET @Action = 'DELETE'
        
        INSERT INTO Logging (TableName, Action, LogDate, OldData)
        SELECT 'Employee', @Action, GETDATE(), CAST(OldData AS NVARCHAR(MAX))
        FROM (
            SELECT (SELECT * FROM deleted FOR XML RAW, ELEMENTS, TYPE).query('/row') AS OldData
        ) AS LoggingData
    END
END;



CREATE PROCEDURE GetAllDepartments
AS
BEGIN
    SELECT DepartmentID, DepartmentName
    FROM Department;
END;



CREATE PROCEDURE CreateJobTitle
    @JobTitleName VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO JobTitle (JobTitleName)
    VALUES (@JobTitleName);
END;

CREATE PROCEDURE GetAllJobTitles
AS
BEGIN
    SELECT JobTitleID, JobTitleName
    FROM JobTitle;
END;

CREATE PROCEDURE GetJobTitleByID
    @JobTitleID INT
AS
BEGIN
    SELECT JobTitleID, JobTitleName
    FROM JobTitle
    WHERE JobTitleID = @JobTitleID;
END;


CREATE PROCEDURE UpdateJobTitle
    @JobTitleID INT,
    @JobTitleName VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    UPDATE JobTitle
    SET JobTitleName = @JobTitleName
    WHERE JobTitleID = @JobTitleID;
END;


CREATE PROCEDURE DeleteJobTitle
    @JobTitleID INT
AS
BEGIN
    DELETE FROM JobTitle
    WHERE JobTitleID = @JobTitleID;
END;


CREATE PROCEDURE CreateEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @AddressLine VARCHAR(200),
    @DepartmentID INT,
    @JobTitleID INT
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO Employee (FirstName, LastName, DateOfBirth, Gender, Email, Phone, AddressLine, DepartmentID, JobTitleID)
    VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @Email, @Phone, @AddressLine, @DepartmentID, @JobTitleID);
END;


CREATE PROCEDURE GetAllEmployees
AS
BEGIN
    SELECT E.EmployeeID, E.FirstName, E.LastName, E.DateOfBirth, E.Gender, E.Email, E.Phone, E.AddressLine, E.DepartmentID, E.JobTitleID
    FROM Employee E;
END;

CREATE PROCEDURE GetEmployeeByID
    @EmployeeID INT
AS
BEGIN
    SELECT E.EmployeeID, E.FirstName, E.LastName, E.DateOfBirth, E.Gender, E.Email, E.Phone, E.AddressLine, E.DepartmentID, E.JobTitleID
    FROM Employee E
    WHERE E.EmployeeID = @EmployeeID;
END;


CREATE PROCEDURE UpdateEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @AddressLine VARCHAR(200),
    @DepartmentID INT,
    @JobTitleID INT
    -- Add other parameters as needed
AS
BEGIN
    UPDATE Employee
    SET FirstName = @FirstName,
        LastName = @LastName,
        DateOfBirth = @DateOfBirth,
        Gender = @Gender,
        Email = @Email,
        Phone = @Phone,
        AddressLine = @AddressLine,
        DepartmentID = @DepartmentID,
        JobTitleID = @JobTitleID
    WHERE EmployeeID = @EmployeeID;
END;


CREATE PROCEDURE DeleteEmployee
    @EmployeeID INT
AS
BEGIN
    DELETE FROM Employee
    WHERE EmployeeID = @EmployeeID;
END;


CREATE PROCEDURE CreateCustomer
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @AddressLine VARCHAR(200)
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO Customer (FirstName, LastName, DateOfBirth, Gender, Email, Phone, AddressLine)
    VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @Email, @Phone, @AddressLine);
END;

CREATE PROCEDURE GetAllCustomers
AS
BEGIN
    SELECT CustomerID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, AddressLine
    FROM Customer;
END;

CREATE PROCEDURE GetCustomerByID
    @CustomerID INT
AS
BEGIN
    SELECT CustomerID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, AddressLine
    FROM Customer
    WHERE CustomerID = @CustomerID;
END;

CREATE PROCEDURE UpdateCustomer
    @CustomerID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @AddressLine VARCHAR(200)
    -- Add other parameters as needed
AS
BEGIN
    UPDATE Customer
    SET FirstName = @FirstName,
        LastName = @LastName,
        DateOfBirth = @DateOfBirth,
        Gender = @Gender,
        Email = @Email,
        Phone = @Phone,
        AddressLine = @AddressLine
    WHERE CustomerID = @CustomerID;
END;


CREATE PROCEDURE DeleteCustomer
    @CustomerID INT
AS
BEGIN
    DELETE FROM Customer
    WHERE CustomerID = @CustomerID;
END;


CREATE PROCEDURE CreateUser
    @FullName VARCHAR(50),
    @UserName VARCHAR(50),
    @Password VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    INSERT INTO UserAccount (FullName, UserName, [Password])
    VALUES (@FullName, @UserName, @Password);
END;


CREATE PROCEDURE GetAllUsers
AS
BEGIN
    SELECT UserID, FullName, UserName, [Password]
    FROM UserAccount;
END;


CREATE PROCEDURE GetUserByID
    @UserID INT
AS
BEGIN
    SELECT UserID, FullName, UserName, [Password]
    FROM UserAccount
    WHERE UserID = @UserID;
END;


CREATE PROCEDURE UpdateUser
    @UserID INT,
    @FullName VARCHAR(50),
    @UserName VARCHAR(50),
    @Password VARCHAR(50)
    -- Add other parameters as needed
AS
BEGIN
    UPDATE UserAccount
    SET FullName = @FullName,
        UserName = @UserName,
        [Password] = @Password
    WHERE UserID = @UserID;
END;


CREATE PROCEDURE DeleteUser
    @UserID INT
AS
BEGIN
    DELETE FROM UserAccount
    WHERE UserID = @UserID;
END;




--Certainly! Here are 100 unique and useful queries for the given schema:

--1. Retrieve all departments.
--1. Retrieve all job titles.
--1. Retrieve all employees.
--1. Retrieve all customers.
--1. Retrieve all user accounts.
--1. Retrieve all categories.
--1. Retrieve all products.
--1. Retrieve all product entity attribute values.
--1. Retrieve all transaction types.
--1. Retrieve all transaction headers.
--1. Retrieve all transaction details.
--1. Retrieve all payments.
--1. Retrieve the department with a specific ID.
--1. Retrieve the job title with a specific ID.
--1. Retrieve the employee with a specific ID.
--1. Retrieve the customer with a specific ID.
--1. Retrieve the user account with a specific ID.
--1. Retrieve the category with a specific ID.
--1. Retrieve the product with a specific ID.
--1. Retrieve the product entity attribute value with a specific ID.
--1. Retrieve the transaction type with a specific ID.
--1. Retrieve the transaction header with a specific ID.
--1. Retrieve the transaction detail with a specific ID.
--1. Retrieve the payment with a specific ID.
--1. Retrieve the departments with a specific department name.
--1. Retrieve the job titles with a specific job title name.
--1. Retrieve the employees with a specific first name.
--1. Retrieve the employees with a specific last name.
--1. Retrieve the employees with a specific date of birth.
--1. Retrieve the employees with a specific gender.
--1. Retrieve the employees with a specific email.
--1. Retrieve the employees with a specific phone number.
--1. Retrieve the employees with a specific address line.
--1. Retrieve the employees in a specific department.
--1. Retrieve the employees with a specific job title.
--1. Retrieve the customers with a specific first name.
--1. Retrieve the customers with a specific last name.
--1. Retrieve the customers with a specific date of birth.
--1. Retrieve the customers with a specific gender.
--1. Retrieve the customers with a specific email.
--1. Retrieve the customers with a specific phone number.
--1. Retrieve the customers with a specific address line.
--1. Retrieve the user accounts with a specific full name.
--1. Retrieve the user accounts with a specific username.
--1. Retrieve the user accounts with a specific password.
--1. Retrieve the categories with a specific category name.
--1. Retrieve the products with a specific product name.
--1. Retrieve the products with a specific price.
--1. Retrieve the products with a specific stock quantity.
--1. Retrieve the products in a specific category.
--1. Retrieve the product entity attribute values with a specific attribute name.
--1. Retrieve the product entity attribute values with a specific attribute value.
--1. Retrieve the transaction types with a specific transaction type name.
--1. Retrieve the transaction headers with a specific transaction type.
--1. Retrieve the transaction headers with a specific transaction date.
--1. Retrieve the transaction headers for a specific customer.
--1. Retrieve the transaction headers for a specific employee.
--1. Retrieve the transaction headers with a specific total amount.
--1. Retrieve the transaction details with a specific transaction.
--1. Retrieve the transaction details with a specific product.
--1. Retrieve the transaction details with a specific quantity.
--1. Retrieve the transaction details with a specific unit price.
--1. Retrieve the payments with a specific transaction.
--1. Retrieve the payments with a specific payment amount.
--1. Retrieve the payments with a specific payment date.
--1. Retrieve the average price of all products.
--1. Retrieve the total stock quantity of all products.
--1. Retrieve the total number of employees.
--1. Retrieve the total number of customers.
--1. Retrieve the total number of transactions.
--1. Retrieve the total number of payments.
--1. Retrieve the highest price among all products.
--1. Retrieve the lowest price among all products.
--1. Retrieve the employee with the highest total amount of transactions.
--1. Retrieve the employee with the lowest total amount of transactions.
--1. Retrieve the customer with the highest total amount of transactions.
--1. Retrieve the customer with the lowest total amount of transactions.
--1. Retrieve the product with the highest quantity sold.
--1. Retrieve the product with the lowest quantity sold.
--1. Retrieve the department with the most employees.
--1. Retrieve the department with the fewest employees.
--1. Retrieve the job title with the most employees.
--1. Retrieve the job title with the fewest employees.
--1. Retrieve the average total amount of transactions.
--1. Retrieve the average payment amount.
--1. Retrieve the oldest employee.
--1. Retrieve the youngest employee.
--1. Retrieve the oldest customer.
--1. Retrieve the youngest customer.
--1. Retrieve the products with a price greater than a specific value.
--1. Retrieve the products with a price less than a specific value.
--1. Retrieve the employees with a specific job title and department.
--1. Retrieve the customers with a specific gender and age range.
--1. Retrieve the employees who have not made any transactions.
--1. Retrieve the customers who have not made any transactions.
--1. Retrieve the customers who have made transactions in a specific category.
--1. Retrieve the products that have beenpart of transactions with a specific customer.
--1. Retrieve the transactions made by a specific employee.
--1. Retrieve the transactions made on a specific date.
--1. Retrieve the payments made on a specific date.

--These queries cover a wide range of scenarios and can provide valuable information from the given schema. Feel free to modify them or ask for more specific queries if needed.



--Certainly! Here are 100 more unique and useful queries for the given schema:

--1. Retrieve the employees who have made transactions with a specific customer.

--1. Retrieve the transactions made by a specific customer.

--1. Retrieve the transactions made by a specific customer on a specific date.

--1. Retrieve the transactions made by a specific employee on a specific date.

--1. Retrieve the transactions made by a specific customer in a specific category.

--1. Retrieve the transactions made by a specific employee in a specific category.

--1. Retrieve the total amount spent by a specific customer.

--1. Retrieve the total amount earned by a specific employee.

--1. Retrieve the total amount spent in a specific category.

--1. Retrieve the total amount earned in a specific category.

--1. Retrieve the total amount spent on a specific date.

--1. Retrieve the total amount earned on a specific date.

--1. Retrieve the total number of transactions made by a specific customer.

--1. Retrieve the total number of transactions made by a specific employee.

--1. Retrieve the total number of transactions made in a specific category.

--1. Retrieve the total number of transactions made on a specific date.

--1. Retrieve the average amount spent per transaction by a specific customer.

--1. Retrieve the average amount earned per transaction by a specific employee.

--1. Retrieve the average amount spent per transaction in a specific category.

--1. Retrieve the average amount earned per transaction in a specific category.

--1. Retrieve the average amount spent per transaction on a specific date.

--1. Retrieve the average amount earned per transaction on a specific date.

--1. Retrieve the oldest transaction.

--1. Retrieve the newest transaction.

--1. Retrieve the earliest transaction made by a specific customer.

--1. Retrieve the latest transaction made by a specific customer.

--1. Retrieve the earliest transaction made by a specific employee.

--1. Retrieve the latest transaction made by a specific employee.

--1. Retrieve the products that have been sold in the highest quantity.

--1. Retrieve the products that have been sold in the lowest quantity.

--1. Retrieve the products that have been sold for the highest total amount.

--1. Retrieve the products that have been sold for the lowest total amount.

--1. Retrieve the products that have never been sold.

--1. Retrieve the customers who have made the highest number of transactions.

--1. Retrieve the customers who have made the lowest number of transactions.

--1. Retrieve the employees who have made the highest number of transactions.

--1. Retrieve the employees who have made the lowest number of transactions.

--1. Retrieve the customers who have spent the highest total amount.

--1. Retrieve the customers who have spent the lowest total amount.

--1. Retrieve the employees who have earned the highest total amount.

--1. Retrieve the employees who have earned the lowest total amount.

--1. Retrieve the customers who have made transactions in a specific price range.

--1. Retrieve the employees who have made transactions in a specific price range.

--1. Retrieve the customers who have made transactions in a specific date range.

--1. Retrieve the employees who have made transactions in a specific date range.

--1. Retrieve the customers who have made transactions in a specific category and price range.

--1. Retrieve the employees who have made transactions in a specific category and price range.

--1. Retrieve the customers who have made transactions in a specific category and date range.

--1. Retrieve the employees who have made transactions in a specific category and date range.

--1. Retrieve the customers who have made transactions in a specific price range and date range.

--1. Retrieve the employees who have made transactions in a specific price range and date range.

--1. Retrieve the customers who have made transactions in a specific category, price range, and date range.

--1. Retrieve the employees who have made transactions in a specific category, price range, and date range.

--1. Retrieve the customers who have not made any transactions in a specific category.

--1. Retrieve the employees who have not made any transactions in a specific category.

--1. Retrieve the customers who have made transactions with a specific product.

--1. Retrieve the employees who have made transactions with a specific product.

--1. Retrieve the customers who have made transactions with a specific product in a specific category.

--1. Retrieve the employees who have made transactions with a specific product in a specific category.

--1. Retrieve the customers who have made transactions with a specific product in a specific price range.

--1. Retrieve the employees who have made transactions with a specific product in a specific price range.

--1. Retrieve the customers who have made transactions with a specific product in a specific date range.

--1. Retrieve the employees who have made transactions with a specific product in a specific date range.

--1. Retrieve the customers who have made transactions with a specific product in a specific category and price range.

--1. Retrieve the employees who have made transactions with a specific product in a specific category and price range.

--1. Retrieve the customers who have made transactions with a specific product in a specific category and date range.

--1. Retrieve the employees who have made transactions with a specific product in a specific category and date range.

--1. Retrieve the customers who have made transactions withApologies for the incomplete response. Here are the remaining queries:

--1. Retrieve the customers who have made transactions with a specific product in a specific price range and date range.

--1. Retrieve the employees who have made transactions with a specific product in a specific price range and date range.

--1. Retrieve the customers who have made transactions with multiple products.

--1. Retrieve the employees who have made transactions with multiple products.

--1. Retrieve the customers who have made transactions with a specific payment method.

--1. Retrieve the employees who have made transactions with a specific payment method.

--1. Retrieve the customers who have made transactions with a specific payment method and date range.

--1. Retrieve the employees who have made transactions with a specific payment method and date range.

--1. Retrieve the customers who have made transactions with a specific payment method and amount range.

--1. Retrieve the employees who have made transactions with a specific payment method and amount range.

--1. Retrieve the customers who have made transactions with a specific payment method and in a specific category.

--1. Retrieve the employees who have made transactions with a specific payment method and in a specific category.

--1. Retrieve the customers who have made transactions with a specific payment method and in a specific category and date range.

--1. Retrieve the employees who have made transactions with a specific payment method and in a specific category and date range.

--1. Retrieve the customers who have made transactions with a specific payment method and in a specific category and amount range.

--1. Retrieve the employees who have made transactions with a specific payment method and in a specific category and amount range.

--1. Retrieve the customers who have made transactions with a specific payment method and in a specific category, price range, and date range.

--1. Retrieve the employees who have made transactions with a specific payment method and in a specific category, price range, and date range.

--1. Retrieve the products that have been sold on a specific date.

--1. Retrieve the products that have been sold to a specific customer.

--1. Retrieve the products that have been sold by a specific employee.

--1. Retrieve the products that have been sold in a specific category and price range.

--1. Retrieve the products that have been sold in a specific category and date range.

--1. Retrieve the products that have been sold in a specific category, price range, and date range.

--1. Retrieve the products that have not been sold in a specific category.

--1. Retrieve the products that have not been sold on a specific date.

--1. Retrieve the products that have not been sold to a specific customer.

--1. Retrieve the products that have not been sold by a specific employee.

--1. Retrieve the products that have not been sold in a specific category and price range.

--1. Retrieve the products that have not been sold in a specific category and date range.

--1. Retrieve the products that have not been sold in a specific category, price range, and date range.

--1. Retrieve the customers who have made the highest total number of payments.

--1. Retrieve the customers who have made the lowest total number of payments.

--1. Retrieve the employees who have received the highest total number of payments.

--1. Retrieve the employees who have received the lowest total number of payments.

--1. Retrieve the customers who have made payments in a specific payment method.

--1. Retrieve the employees who have received payments in a specific payment method.

--1. Retrieve the customers who have made payments in a specific payment method and date range.

--1. Retrieve the employees who have received payments in a specific payment method and date range.

--1. Retrieve the customers who have made payments in a specific payment method and amount range.

--1. Retrieve the employees who have received payments in a specific payment method and amount range.

--1. Retrieve the customers who have made payments in a specific payment method and in a specific category.

--1. Retrieve the employees who have received payments in a specific payment method and in a specific category.

--1. Retrieve the customers who have made payments in a specific payment method and in a specific category and date range.

--1. Retrieve the employees who have received payments in a specific payment method and in a specific category and date range.

--1. Retrieve the customers who have made payments in a specific payment method and in a specific category and amount range.

--1. Retrieve the employees who have received payments in a specific payment method and in a specific category and amount range.

--1. Retrieve the customers who have made payments in a specific payment method and in a specific category, price range, and date range.

--1. Retrieve the employees who have received payments in a specific payment method and in a specific category, price range, and date range.

--These additional queries further explore various aspects of the given schema and can provide more specific information based on your requirements.












