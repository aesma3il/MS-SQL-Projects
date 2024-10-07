----CREATE DATABASE  InventoryManagementSystem
------DROP DATABASE InventoryManagementSystem
--use InventoryManagementSystem

CREATE TABLE Countries (
  CountryID INT PRIMARY KEY,
  CountryName VARCHAR(100) NOT NULL
);

CREATE TABLE States (
  StateID INT PRIMARY KEY,
  StateName VARCHAR(100) NOT NULL,
  CountryID INT NOT NULL,
  FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Cities (
  CityID INT PRIMARY KEY,
  CityName VARCHAR(100) NOT NULL,
  StateID INT NOT NULL,
  FOREIGN KEY (StateID) REFERENCES States(StateID)
);


CREATE TABLE PostalCodes (
  PostalCodeID INT PRIMARY KEY,
  PostalCode VARCHAR(20) NOT NULL,
  CityID INT NOT NULL,
  FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

CREATE TABLE Addresses (
  AddressID INT PRIMARY KEY,
  Street VARCHAR(100) NOT NULL,
  PostalCodeID INT NOT NULL,
  FOREIGN KEY (PostalCodeID) REFERENCES PostalCodes(PostalCodeID)
);


CREATE TABLE Gender (
  GenderID INT PRIMARY KEY,
  GenderName VARCHAR(50) NOT NULL
);


CREATE TABLE ContactInformation (
  ContactID INT PRIMARY KEY,
  PhoneNumber VARCHAR(20),
  Email VARCHAR(100),
);

CREATE TABLE IdentificationInformation (
  IdentificationID INT PRIMARY KEY,
  SocialSecurityNumber VARCHAR(20),
  NationalIDNumber VARCHAR(50),
  DriverLicenseNumber VARCHAR(50),
);


CREATE TABLE Person (
  PersonID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  MiddleName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  DateOfBirth DATE,
  AddressID INT,
   GenderID INT,
  ContactID INT,
  IdentificationID INT,
  FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
  FOREIGN KEY (GenderID) REFERENCES Gender(GenderID),
   FOREIGN KEY (ContactID) REFERENCES ContactInformation(ContactID),
    FOREIGN KEY (IdentificationID) REFERENCES IdentificationInformation(IdentificationID)
);


create table Adminsrator(
AdminID int Primary key identity(1,1),
PersonID int not null ,
FOREIGN KEY(PersonID) references Person(PersonID)
);

create table AdminLogin(
AccountID int primary key identity(1,1),
AdminID int foreign key references Adminsrator(AdminID),
Username varchar(50) not null,
[Password] varchar(50) not null
)




CREATE TABLE Brand(
	BrandID INT IDENTITY(1,1),
	BrandName VARCHAR(50) NOT NULL

);
GO

CREATE TABLE Category(
	CategoryID INT IDENTITY(1,1),
	CategoryName VARCHAR(50) NOT NULL,
	CategoryImage VARCHAR(200) NOT NULL

);


CREATE TABLE Product(
	ProductID INT IDENTITY(1,1),
	ProductNumber AS RIGHT('000000' + CAST(ProductID AS VARCHAR(6)), 6) PERSISTED,
	ProductName VARCHAR(100) NOT NULL,
	ProductDescription VARCHAR(200) NOT NULL,
	CategoryID INT NOT NULL,
	BrandID INT NULL
);


CREATE TABLE Variant(
	VariantID INT IDENTITY(1,1),
	Variant AS RIGHT('000000' + CAST(VariantID AS VARCHAR(6)), 6) PERSISTED,
	ProductID INT NOT NULL,
	VariantName VARCHAR(100) NOT NULL,
	Sku VARCHAR(10) NOT NULL,
	UnitPrice DECIMAL(10,2) NOT NULL
);


CREATE TABLE InventoryItems(
	InventoryItemsID INT IDENTITY(1,1),
	VariantID INT  NOT NULL,
	WarehouseID INT NOT NULL,
	Quantity INT NOT NULL CHECK(Quantity > 0)
);



CREATE TABLE Warehouse(
	WarehouseID INT IDENTITY(1,1),
	WarehouseName VARCHAR(50) NOT NULL,
	WarehouseAddress VARCHAR(50) NOT NULL

);

CREATE TABLE OrderStatus(
	OrderStatusID INT IDENTITY(1,1),
	OrderStatusName VARCHAR(20) NOT NULL
)

CREATE TABLE Orders(
	OrderID INT IDENTITY(1,1),
	OrderNumber AS RIGHT('000000' + CAST(OrderID AS VARCHAR(6)), 6) PERSISTED,
	CustomerID INT NOT NULL,
	StatusID INT DEFAULT NULL,
	Total DECIMAL(10,2) NOT NULL,
	PaymentID	 INT DEFAULT NULL,
	OrderDate datetime default getdate()

);





CREATE TABLE OrderItem(
	OrderItemID  INT IDENTITY(1,1),
	VariantID  INT NOT NULL, 
	OrderID		INT,
	Quantity  INT NOT NULL,
	Price  DECIMAL(10,2) NOT NULL ,
	TotalAmount DECIMAL(10,2) NOT NULL 
);




CREATE TABLE PaymentMethod(
	PaymentMethodID 	INT IDENTITY(1,1),
	PaymentMethodName VARCHAR(50) NOT NULL
);

CREATE TABLE PaymentStatus(
	PaymentStatusID INT IDENTITY(1,1),
	StatusName	VARCHAR(30) NOT NULL
);




CREATE TABLE Payment(
	PaymentID INT IDENTITY(1,1),
	PaymentDate DATETIME  DEFAULT GETDATE(),
	PaymentStatusID INT NULL,
	PaymentMethodID INT NOT NULL,
	Amount decimal(10,2) NOT NULL,
);

ALTER TABLE Brand
ADD CONSTRAINT PK_BRAND PRIMARY KEY(BrandID)

ALTER TABLE Category
ADD CONSTRAINT PK_CATEGORY PRIMARY KEY(CategoryID)

ALTER TABLE Product
ADD CONSTRAINT PK_PRODUCT PRIMARY KEY(ProductID)

ALTER TABLE Variant
ADD CONSTRAINT PK_VARIANT PRIMARY KEY(VariantID)

ALTER TABLE InventoryItems
ADD CONSTRAINT PK_INVENTORYITEMS PRIMARY KEY(InventoryItemsID)

ALTER TABLE  OrderStatus
ADD CONSTRAINT PK_OrderStatus PRIMARY KEY(OrderStatusID)

ALTER TABLE  Orders
ADD CONSTRAINT PK_ORDERS PRIMARY KEY(OrderID)

ALTER TABLE Customer
ADD CONSTRAINT PK_CUSTOMER PRIMARY KEY(CustomerID)

ALTER TABLE OrderItem
ADD CONSTRAINT PK_ORDERITEM PRIMARY KEY(OrderItemID)

ALTER TABLE PaymentMethod
ADD CONSTRAINT PK_PAYMENTMETHOD PRIMARY KEY(PaymentMethodID)

ALTER TABLE  Payment
ADD CONSTRAINT PK_PAYMENT PRIMARY KEY(PaymentID)

ALTER TABLE Warehouse
ADD CONSTRAINT PK_WAREHOUSE PRIMARY KEY(WarehouseID)


ALTER TABLE PaymentStatus
ADD CONSTRAINT PK_PAYMENTSTATUS PRIMARY KEY(PaymentStatusID)

ALTER TABLE  Variant
ADD CONSTRAINT FK_Variant_Product FOREIGN KEY(ProductID)  REFERENCES Product(ProductID);


ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_PaymentStatus FOREIGN KEY(PaymentStatusID) REFERENCES PaymentStatus(PaymentStatusID);

ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_PaymentMethod FOREIGN KEY(PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID);

ALTER TABLE OrderItem
ADD CONSTRAINT FK_OrderItem_Variant FOREIGN KEY(VariantID)  REFERENCES Variant(VariantID)

ALTER TABLE OrderItem
ADD CONSTRAINT FK_OrderItem_Orders FOREIGN KEY(OrderID)  REFERENCES Orders(OrderID)

ALTER TABLE Orders
ADD CONSTRAINT FK_Order_Customer FOREIGN KEY(CustomerID)  REFERENCES Customer(CustomerID)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Payment FOREIGN KEY(PaymentID)  REFERENCES Payment(PaymentID)

ALTER TABLE Orders
ADD CONSTRAINT FK_Order_PaymentStatus FOREIGN KEY(StatusID)  REFERENCES OrderStatus(OrderStatusID)

ALTER TABLE InventoryItems
ADD CONSTRAINT FK_InventoryItem_Variant FOREIGN KEY(VariantID)  REFERENCES Variant(VariantID)

ALTER TABLE InventoryItems
ADD CONSTRAINT FK_InventoryItems_Warehouse FOREIGN KEY(WarehouseID)  REFERENCES Warehouse(WarehouseID)


ALTER TABLE Product
ADD CONSTRAINT FK_Product_Category FOREIGN KEY(CategoryID)  REFERENCES Category(CategoryID)
ALTER TABLE Product
ADD CONSTRAINT FK_Product_Brand FOREIGN KEY(BrandID)  REFERENCES Brand(BrandID)




--INSERTING DATA
INSERT INTO Gender (GenderID, GenderName)
VALUES
  (1, 'Male'),
  (2, 'Female'),
  (3, 'Non-binary'),
  (4, 'Genderqueer'),
  (5, 'Genderfluid'),
  (6, 'Agender'),
  (7, 'Other');

