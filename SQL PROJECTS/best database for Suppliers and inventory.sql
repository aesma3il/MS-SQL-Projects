
create table PersonType(
PersonTypeID INT PRIMARY KEY IDENTITY(1,1)
TypeName nvarchar(50) not null
);




CREATE TABLE Person (
    PersonID INT IDENTITY(1, 1) ,
    FirstName NVARCHAR(30) NOT NULL,
    LastName NVARCHAR(30) NOT NULL,
    Email NVARCHAR(30) NOT NULL,
    Phone NVARCHAR(30) NULL,
   

	CONSTRAINT PK_Person PRIMARY KEY(PersonID)
);




-- Create Categories table
CREATE TABLE Category (
    CategoryID INT  identity(1,1),
    CategoryName VARCHAR(255),

	CONSTRAINT PK_Category PRIMARY KEY(CategoryID)
);



-- Create Brands table
CREATE TABLE Brand (
    BrandID INT identity(1,1),
    BrandName VARCHAR(255) NOT NULL,

	CONSTRAINT PK_Brand PRIMARY KEY(BrandID)
);

-- Create Products table
CREATE TABLE Product (
    ProductID INT  identity(1,1),
    ProductName VARCHAR(255) not null,
    ProductDescription VARCHAR(MAX),
    BrandID INT not null,
    CategoryID INT not null,
  
    
   
 CONSTRAINT FK_Product_Brand   FOREIGN KEY (BrandID) REFERENCES Brand(BrandID),
 CONSTRAINT FK_Product_Category   FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),

CONSTRAINT PK_Product PRIMARY KEY(ProductID)
);

-- TransactionType table
CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY  identity(1,1),
    TransactionTypeName VARCHAR(100)
);

-- TransactionHeader table
CREATE TABLE TransactionHeader (
    TransactionID INT PRIMARY KEY,
    TransactionTypeID INT,
    TransactionDate DATETIME,
	TotalAmount DECIMAL(10,2) NOT NULL,
	PersonID INT,
	EmployeeID INT,

	 CONSTRAINT FK_TransactionType_TransactionHeader FOREIGN KEY (TransactionTypeID)
    REFERENCES TransactionType (TransactionTypeID),
	 CONSTRAINT FK_Person_TransactionHeader FOREIGN KEY (PersonID)
    REFERENCES Person (PersonID),

    CONSTRAINT FK_Employee_TransactionHeader FOREIGN KEY (EmployeeID)
    REFERENCES Person (PersonID)
);

-- TransactionDetail table
CREATE TABLE TransactionDetail (
    TransactionDetailID INT PRIMARY KEY  identity(1,1),
    TransactionID INT,
    ProductID INT,
	UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT,
	SubTotal as(Quantity* UnitPrice),

    CONSTRAINT FK_TransactionHeader_TransactionDetail FOREIGN KEY (TransactionID)
    REFERENCES TransactionHeader (TransactionID),
    CONSTRAINT FK_Product_TransactionDetail FOREIGN KEY (ProductID)
    REFERENCES Product (ProductID)
);



-- Create PaymentMethods table
CREATE TABLE PaymentMethod (
    PaymentMethodID INT  IDENTITY(1,1),
    [Name] VARCHAR(255) not null,
	CONSTRAINT PK_PaymentMethod PRIMARY KEY(PaymentMethodID)
);



CREATE TABLE Payment (
    PaymentID INT  identity(1,1),
    TransactionID INT,
    PaymentDate DATETIME default getdate(),
    Amount DECIMAL(10, 2),
    PaymentMethodID INT,
	AdditionalNote nvarchar(100),
   CONSTRAINT FK_Paymentt_TransactionHeader FOREIGN KEY (TransactionID)
    REFERENCES TransactionHeader (TransactionID),
CONSTRAINT FK_PuPayment_PaymentMethod FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID),

   CONSTRAINT PK_Payment PRIMARY KEY(PaymentID)
);

gO
CREATE  PROC spSearchByID
@ID INT
AS

BEGIN
SELECT P.PersonID, P.FirstName, P.LastName, P.Email, P.Phone, P.City, P.Country, P.StreetAddress, P.DateOfBirth, P.Gender, P.Nationality, P.SocialSecurityNumber, P.MaritalStatus, P.Occupation,
       U.Username, U.[Password], U.FullName
FROM Person P
INNER JOIN Users U ON P.PersonID = U.PersonID
WHERE P.PersonID = @ID AND U.PersonID = @ID

END;

gO

CREATE PROC spListAllUserInfo
as
begin
SELECT P.PersonID, P.FirstName, P.LastName, P.Email, P.Phone, P.City, P.Country, P.StreetAddress, P.DateOfBirth, P.Gender, P.Nationality, P.SocialSecurityNumber, P.MaritalStatus, P.Occupation,
       U.Username, U.[Password], U.FullName
FROM Person P
INNER JOIN Users U ON P.PersonID = U.PersonID
end;
gO

CREATE PROC spListAllCategories

AS
BEGIN
SELECT * FROM Category
END;

GO
CREATE PROC spInsertNewCategory
@CategoryName VARCHAR(255)
AS
BEGIN
INSERT INTO Category (CategoryName) VALUES(@CategoryName)
END;
GO
CREATE PROC spUpdateCategory
@CategoryID INT,
@CategoryName varchar(255)
AS
BEGIN
UPDATE Category SET CategoryName = @CategoryName
WHERE CategoryID = @CategoryID
END;
GO

CREATE PROC spSearchCategoryByID
@ID INT
AS
BEGIN
SELECT * FROM Category
WHERE CategoryID = @ID
END;
GO


CREATE PROCEDURE UpdatePersonAndUser
    @PersonID INT,
    @FirstName NVARCHAR(30),
    @LastName NVARCHAR(30),
    @Email NVARCHAR(30),
    @Phone NVARCHAR(30),
    @City NVARCHAR(30),
    @Country NVARCHAR(30),
    @StreetAddress NVARCHAR(50),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @Nationality NVARCHAR(30),
    @SocialSecurityNumber NVARCHAR(30),
    @MaritalStatus NVARCHAR(20),
    @Occupation NVARCHAR(50),
    @Username NVARCHAR(30),
    @Password NVARCHAR(30),
    @FullName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the Person table
    UPDATE Person
    SET FirstName = @FirstName,
        LastName = @LastName,
        Email = @Email,
        Phone = @Phone,
        City = @City,
        Country = @Country,
        StreetAddress = @StreetAddress,
        DateOfBirth = @DateOfBirth,
        Gender = @Gender,
        Nationality = @Nationality,
        SocialSecurityNumber = @SocialSecurityNumber,
        MaritalStatus = @MaritalStatus,
        Occupation = @Occupation
    WHERE PersonID = @PersonID;

    -- Update the Users table
    UPDATE Users
    SET Username = @Username,
        [Password] = @Password,
        FullName = @FullName
    WHERE PersonID = @PersonID;
END;

go
CREATE PROCEDURE InsertPersonAndUser
    @FirstName NVARCHAR(30),
    @LastName NVARCHAR(30),
    @Email NVARCHAR(30),
    @Phone NVARCHAR(30),
    @City NVARCHAR(30),
    @Country NVARCHAR(30),
    @StreetAddress NVARCHAR(50),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @Nationality NVARCHAR(30),
    @SocialSecurityNumber NVARCHAR(30),
    @MaritalStatus NVARCHAR(20),
    @Occupation NVARCHAR(50),
    @Username NVARCHAR(30),
    @Password NVARCHAR(30),
    @FullName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert into the Person table
    INSERT INTO Person (FirstName, LastName, Email, Phone, City, Country, StreetAddress, DateOfBirth, Gender, Nationality, SocialSecurityNumber, MaritalStatus, Occupation)
    VALUES (@FirstName, @LastName, @Email, @Phone, @City, @Country, @StreetAddress, @DateOfBirth, @Gender, @Nationality, @SocialSecurityNumber, @MaritalStatus, @Occupation);

    -- Get the generated PersonID
    DECLARE @PersonID INT;
    SET @PersonID = SCOPE_IDENTITY();

    -- Insert into the Users table
    INSERT INTO Users (PersonID, Username, [Password], FullName)
    VALUES (@PersonID, @Username, @Password, @FullName);
END;



-- Insert data into the Category table
INSERT INTO Category (CategoryName)
VALUES ('Produce'),
       ('Dairy'),
       ('Bakery'),
       ('Meat'),
       ('Canned Goods');

-- Insert data into the Brand table
INSERT INTO Brand (BrandName)
VALUES ('Kellogg''s'),
       ('Nestle'),
       ('Coca-Cola'),
       ('Kraft'),
       ('Campbell''s');

-- Insert data into the Product table
INSERT INTO Product (ProductName, ProductDescription, BrandID, CategoryID, Qty, Price)
VALUES ('Apples', 'Fresh apples', 1, 1, 50, 1.99),
       ('Milk', '1% low-fat milk', 2, 2, 20, 2.49),
       ('Bread', 'Whole wheat bread', 3, 3, 30, 3.99),
       ('Ground Beef', 'Lean ground beef', 4, 4, 25, 5.99),
       ('Tomato Soup', 'Condensed tomato soup', 5, 5, 40, 1.29);



	   -- Create TransactionType table
CREATE TABLE TransactionType (
    TransactionTypeID INT IDENTITY(1, 1) PRIMARY KEY,
    TransactionTypeName VARCHAR(50) NOT NULL
);

-- Insert transaction types
INSERT INTO TransactionType (TransactionTypeName)
VALUES ('Purchase'),
       ('Sale'),
       ('Return');

-- Create ProductTransaction table
CREATE TABLE ProductTransaction (
    TransactionID INT IDENTITY(1, 1) PRIMARY KEY,
    ProductID INT NOT NULL,
    TransactionTypeID INT NOT NULL,
    QuantityChange INT NOT NULL,
    TransactionDate DATETIME NOT NULL,
   UserID INT NOT NULL,

    CONSTRAINT FK_ProductTransaction_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FK_ProductTransaction_TransactionType FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(TransactionTypeID),
	CONSTRAINT FK_ProductTransaction_User FOREIGN KEY (UserID) REFERENCES Users(UserID)
);