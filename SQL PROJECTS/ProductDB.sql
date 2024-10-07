
CREATE TABLE Country(
	CountryID INT ,
	CountryName NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_COUNTRYID_COUNTRY PRIMARY KEY(CountryID)

);

CREATE TABLE City(
CityID INT IDENTITY(1,1),
CityName NVARCHAR(30) NOT NULL,
CountryID INT NOT NULL,
CONSTRAINT PK_CITYID_CITY PRIMARY KEY(CityID),
CONSTRAINT FK_COUNTRYID_CITY_COUNTRY FOREIGN KEY(CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE CUSTOMER(
CustomerID INT  IDENTITY(1,1) ,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Phone NVARCHAR(9) NOT NULL,
Email NVARCHAR(30) NOT NULL,
CityID INT NOT NULL,
CONSTRAINT PK_CUSTOMERID PRIMARY KEY(CustomerID),
CONSTRAINT FK_CITYID_CUSTOMER_CITY FOREIGN KEY(CityID) REFERENCES City(CityID) ON UPDATE CASCADE ON DELETE NO ACTION
);




CREATE TABLE Category (
CategoryID INT IDENTITY(1,1),
CategoryName NVARCHAR(50) NOT NULL,
CONSTRAINT PK_CATEGORYID_CATEGORY PRIMARY KEY(CategoryID)

);

CREATE TABLE Product(
ProductID INT IDENTITY(1,1),
CategoryID INT NOT NULL,
ProductName NVarchar(50) NOT NULL,
ProductDescripion NVARCHAR(200) NULL,
UnitPrice DECIMAL(10,2) NOT NULL,
Qty INT NOT NULL CHECK(Qty > 0),
CONSTRAINT PK_PRODUCTID_PRODUCT PRIMARY KEY(ProductID),
CONSTRAINT FK_CATEGORYID_PRODCUT_CATEGORY FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID) ON UPDATE CASCADE ON DELETE  CASCADE
);

CREATE TABLE SaleTransaction(
TransactionID INT IDENTITY(1,1),
BillNumber AS (right('000000'+CONVERT([varchar](6),TransactionID),(6))) PERSISTED,
CustomerID INT NOT NULL,
Total DECIMAL(10,2) NULL, 
[DateAndTime] DATE DEFAULT GETDATE(),
CONSTRAINT PK_TRANSACTIONID_SALETRANSACTION PRIMARY KEY(TransactionID),
CONSTRAINT FK_CustomerID_SaleTransaction_CUSTOMER FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE SaleTransactionItem(
SaleTransactionItemID INT IDENTITY(1,1) ,
SaleTransactionID INT NOT NULL,
ProductID INT NOT NULL ,
Qty INT NOT NULL,
UnitPrice DECIMAL(10,2) NOT NULL,
TotalAmount DECIMAL(10,2) NOT NULL,

CONSTRAINT PK_SaleTransactionItemID_SaleTransactionItem PRIMARY KEY(SaleTransactionItemID),
CONSTRAINT  FK_PRODUCTID_SaleTransactionItem_PRODUCT FOREIGN KEY(ProductID) REFERENCES Product(ProductID),
CONSTRAINT FK_SaleTransactionID_SaleTransactionItem_SaleTransaction FOREIGN KEY(SaleTransactionID) REFERENCES SaleTransaction(TransactionID)

);

CREATE TABLE Users(
UserID INT IDENTITY(1,1),
Username VARCHAR(50) NOT NULL UNIQUE,
[Password] VARCHAR(50) NOT NULL,

CONSTRAINT PK_USERID_USER PRIMARY KEY(UserID)
);

CREATE TABLE Payment(
PaymentID INT  IDENTITY(1,1),
SaleTransactionID INT NOT NULL,
UserID INT NOT NULL,
PaymentDate DATE DEFAULT GETDATE(),
Amount DECIMAL(10,2) ,
CONSTRAINT PK_PAYMENTID_PAYMENT PRIMARY KEY(PaymentID),
CONSTRAINT FK_SALETRANSACTIONID_PAYMENT FOREIGN KEY(SaleTransactionID) REFERENCES SaleTransaction(TransactionID),
CONSTRAINT FK_USERID_USER FOREIGN KEY(UserID) REFERENCES Users(UserID)
);

INSERT INTO Country(CountryID, CountryName) VALUES (1,'Yemen');

INSERT INTO CITY(CityName,CountryID) values('Aden', 1),
('Al Jawf', 1),
('Taiz', 1),
('Al Mahrah', 1),
('Al Mahwit', 1),
('Al Hudaydah', 1),
('Al Bayda', 1),
('Dhale', 1),
('Dhamar', 1),
('Hadramaut', 1),
('Hajjah', 1),
('Ibb', 1),
('Lahij', 1),
('Marib', 1),
('Raymah', 1),
('Sadah', 1),
('Sanaa', 1),
('Shabwah', 1),
('Amran', 1);



INSERT INTO CUSTOMER(FirstName, LastName,Phone, Email, CityID) VALUES('Abdullah','Esmail','738807541','abdism.ye@gmail.com',3 ),
('Mohammed','Esmail','738474499','mohahmed@gmail.com',3 ),
('Hamdi','Rasam','739392290','Hamdi@gmail.com', 3),
('Jalal','Alsofy','736333771','jaalsofy@gmail.com', 3),
('Hanad','Jarmoozy','739903534','han@gmail.com', 3)
,('Saif','Ghalib','734765345','salif@gmail.com',1 ),
('Mousa','Ali','735345678','mos@gmailcom',1 ),
('Morshid','Qaid','738807432','morsh@gmail.com',12 ),
('Yaseen','sadiq','745654789','yas@gmail.com',12 ),
('Ali','Shaheen','763412321','alish@gmail.com',12 );




-- Insert 5 categories
INSERT INTO Category (CategoryName) VALUES ('Electronics');
INSERT INTO Category (CategoryName) VALUES ('Home and Garden');
INSERT INTO Category (CategoryName) VALUES ('Clothing');
INSERT INTO Category (CategoryName) VALUES ('Beauty and Personal Care');
INSERT INTO Category (CategoryName) VALUES ('Books');

-- Insert 15 products, each associated with a category
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (1, 'iPhone 12', 'Apple smartphone', 799.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (1, 'Samsung Galaxy S21', 'Samsung smartphone', 699.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (1, 'MacBook Pro', 'Apple laptop', 1299.99, 50);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (1, 'Dell XPS 13', 'Dell laptop', 1199.99, 50);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (1, 'Sony Playstation 5', 'Gaming console', 499.99, 50);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (2, 'Rachael Ray Cookware Set', 'Nonstick cookware set', 199.99, 50);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (2, 'Instant Pot DUO60', 'Pressure cooker', 79.99, 50);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (2, 'Shark Navigator Lift-Away', 'Vacuum cleaner', 149.99, 50);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (3, 'Levi''s 501 Original Fit Jeans', 'Men''s jeans', 49.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (3, 'Calvin Klein Underwear 3-Pack', 'Men''s underwear', 29.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (3, 'Nike Air Max 270', 'Mens sneakers', 149.99, 50);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (4, 'Olay Regenerist Retinol 24 Night Moisturizer', 'Anti-aging moisturizer', 28.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (4, 'Crest 3D White Whitestrips', 'Teeth whitening strips', 39.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (4, 'Dove Sensitive Skin Body Wash', 'Body wash for sensitive skin', 5.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (5, 'To Kill a Mockingbird', 'Harper Lee novel', 14.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (5, '1984', 'George Orwell novel', 12.99, 100);
INSERT INTO Product (CategoryID, ProductName, ProductDescripion, UnitPrice, Qty) VALUES (5, 'The Great Gatsby', 'F. Scott Fitzgerald novel', 9.99, 100);

INSERT INTO SaleTransaction (CustomerID)
VALUES (6);
       (2 ),
       (3);

	   select * from SaleTransaction
	    select sum(TotalPrice) as Total from SaleTransactionItem
		where SaleTransactionID = 5
		




Go
CREATE TRIGGER CalculateSaleTransactionTotal
ON SaleTransactionItem
AFTER INSERT
AS
BEGIN
    DECLARE @SaleTransactionID INT;

    
        SET @SaleTransactionID = (SELECT Max(TransactionID) FROM SaleTransaction);
    select * from SaleTransaction
  
    UPDATE SaleTransaction
    SET Total = (SELECT SUM(TotalPrice) FROM SaleTransactionItem WHERE SaleTransactionID = @SaleTransactionID)
    WHERE TransactionID = @SaleTransactionID;
END

select * from SaleTransaction




	   INSERT INTO SaleTransaction (CustomerID) values(5)
	  
	   INSERT INTO SaleTransactionItem (SaleTransactionID, ProductID, Qty, UnitPrice)
VALUES (6, 1, 2, 23.00),
       (6, 5, 3, 60.00),
       (6, 3, 3, 70.00),
       (6, 8, 5, 50.00),
       (6, 9, 2, 90.00);


	   INSERT INTO Payment (SaleTransactionID, UserID, Amount)
VALUES (1, 1, 40.00),
       (2, 1, 15.00),
       (3, 1, 50.00);

	   select * from SaleTransactionItem


	   GO
drop TRIGGER CalculateSaleTransactionTotal
ON SaleTransactionItem
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @SaleTransactionID INT;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @SaleTransactionID = (SELECT SaleTransactionID FROM inserted);
    END
    ELSE
    BEGIN
        SET @SaleTransactionID = (SELECT SaleTransactionID FROM deleted);
    END

    UPDATE SaleTransaction
    SET Total = (SELECT SUM(TotalPrice) FROM SaleTransactionItem WHERE SaleTransactionID = @SaleTransactionID)
    WHERE TransactionID = @SaleTransactionID;
END
	   GO 

	   GO



--STORED PROCEDURE

GO
CREATE PROCEDURE [dbo].[CreateCustomer]
    @FirstName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @Phone NVARCHAR(9),
    @Email NVARCHAR(30),
    @CityID INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO CUSTOMER (FirstName, LastName, Phone, Email, CityID)
    VALUES (@FirstName, @LastName, @Phone, @Email, @CityID);
END;


GO

CREATE PROCEDURE [dbo].[ReadCustomerByID]
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM CUSTOMER WHERE CustomerID = @CustomerID;
END;
GO
CREATE PROCEDURE [dbo].[ReadCustomer]
 
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM CUSTOMER;
END;
GO
CREATE PROCEDURE [dbo].[UpdateCustomer]
    @CustomerID INT,
    @FirstName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @Phone NVARCHAR(9),
    @Email NVARCHAR(30),
    @CityID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE CUSTOMER SET
        FirstName = @FirstName,
        LastName = @LastName,
        Phone = @Phone,
        Email = @Email,
        CityID = @CityID
    WHERE CustomerID = @CustomerID;
END;

GO

CREATE PROCEDURE [dbo].[DeleteCustomer]
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM CUSTOMER WHERE CustomerID = @CustomerID;
END;
Go

CREATE PROCEDURE [dbo].[CreateCategory]
    @CategoryName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Category (CategoryName)
    VALUES (@CategoryName);
END;

GO
CREATE PROCEDURE [dbo].[ReadCategoryByID]
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Category WHERE CategoryID = @CategoryID;
END;

GO
CREATE PROCEDURE [dbo].[ReadCategory]
   
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Category ;
END;

GO
CREATE PROCEDURE [dbo].[UpdateCategory]
    @CategoryID INT,
    @CategoryName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Category SET
        CategoryName = @CategoryName
    WHERE CategoryID = @CategoryID;
END;
GO
CREATE PROCEDURE [dbo].[DeleteCategory]
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Category WHERE CategoryID = @CategoryID;
END;
GO

CREATE PROCEDURE [dbo].[CreateProduct]
    @CategoryID INT,
    @ProductName NVARCHAR(50),
    @ProductDescription NVARCHAR(200) = NULL,
    @UnitPrice DECIMAL(10,2),
    @Qty INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Product (CategoryID, ProductName, ProductDescription, UnitPrice, Qty)
    VALUES (@CategoryID, @ProductName, @ProductDescription, @UnitPrice, @Qty);
END;

GO
CREATE PROCEDURE [dbo].[ReadProductByID]
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Product WHERE ProductID = @ProductID;
END;
GO
CREATE PROCEDURE [dbo].[ReadProduct]
  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Product ;
END;
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
    @ProductID INT,
    @CategoryID INT,
    @ProductName NVARCHAR(50),
    @ProductDescription NVARCHAR(200) = NULL,
    @UnitPrice DECIMAL(10,2),
    @Qty INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Product SET
        CategoryID = @CategoryID,
        ProductName = @ProductName,
        ProductDescription = @ProductDescription,
        UnitPrice = @UnitPrice,
        Qty = @Qty
    WHERE ProductID = @ProductID;
END;



GO
CREATE PROCEDURE [dbo].[DeleteProduct]
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Product WHERE ProductID = @ProductID;
END;

GO

CREATE PROCEDURE [dbo].[CreateSaleTransaction]
    @CustomerID INT,
    @Total DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SaleTransaction (CustomerID, Total)
    VALUES (@CustomerID, @Total);
END;
GO
CREATE PROCEDURE [dbo].[ReadSaleTransactionByID]
    @TransactionID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM SaleTransaction WHERE TransactionID = @TransactionID;
END;


GO
CREATE PROCEDURE [dbo].[ReadSaleTransaction]
  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM SaleTransaction ;
END;
GO
CREATE PROCEDURE [dbo].[UpdateSaleTransaction]
    @TransactionID INT,
    @CustomerID INT,
    @Total DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE SaleTransaction SET
        CustomerID = @CustomerID,
        Total = @Total
    WHERE TransactionID = @TransactionID;
END;

GO
CREATE PROCEDURE [dbo].[DeleteSaleTransaction]
    @TransactionID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM SaleTransaction WHERE TransactionID = @TransactionID;
END;
Go
 
GO
CREATE PROCEDURE [dbo].[ReadSaleTransactionItemByID]
    @SaleTransactionItemID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM SaleTransactionItem WHERE SaleTransactionItemID = @SaleTransactionItemID;
END;

GO


CREATE PROCEDURE [dbo].[ReadSaleTransactionItem]
   
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM SaleTransactionItem ;
END;







GO




GO



CREATE PROCEDURE [dbo].[spDeleteSaleTransaction]
    @TransactionID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM SaleTransactionItem WHERE SaleTransactionID = @TransactionID;
    DELETE FROM Payment WHERE SaleTransactionID = @TransactionID;
    DELETE FROM SaleTransaction WHERE TransactionID = @TransactionID;
END;





GO


CREATE PROCEDURE [dbo].[CreateUser]
    @Username VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Users (Username, Password)
    VALUES (@Username, @Password);
END;









GO

CREATE PROCEDURE [dbo].[ReadUser]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Users WHERE UserID = @UserID;
END;








GO
CREATE PROCEDURE [dbo].[UpdateUser]
    @UserID INT,
    @Username VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Users SET
        Username = @Username,
        Password = @Password
    WHERE UserID = @UserID;
END;


GO

CREATE PROCEDURE [dbo].[DeleteUser]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Users WHERE UserID = @UserID;
END;


GO
CREATE PROCEDURE [dbo].[CreatePayment]
    @SaleTransactionID INT,
    @UserID INT,
    @Amount DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Payment (SaleTransactionID, UserID, Amount)
    VALUES (@SaleTransactionID, @UserID, @Amount);
END;

GO
CREATE PROCEDURE [dbo].[ReadPayment]
    @PaymentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Payment WHERE PaymentID = @PaymentID;
END;

GO
CREATE PROCEDURE [dbo].[UpdatePayment]
    @PaymentID INT,
    @SaleTransactionID INT,
    @UserID INT,
    @Amount DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Payment SET
        SaleTransactionID = @SaleTransactionID,
        UserID = @UserID,
        Amount = @Amount
    WHERE PaymentID = @PaymentID;
END;

GO
CREATE PROCEDURE [dbo].[DeletePayment]
    @PaymentID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Payment WHERE PaymentID = @PaymentID;
END;

GO
CREATE PROCEDURE [dbo].[ListProductsByCategory]
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Product WHERE CategoryID = @CategoryID;
END;

GO

CREATE PROCEDURE [dbo].[GetSaleTransactionTotal]
    @TransactionID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT SUM(TotalAmount) AS TotalAmount FROM SaleTransactionItem WHERE SaleTransactionID = @TransactionID;
END;


GO
CREATE PROCEDURE [dbo].[ListProductsToRestock]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Product WHERE Qty < 10;
END;



GO


GO



GO



GO



GO


GO



GO


GO


GO



GO


GO



GO


GO


GO


GO


GO







