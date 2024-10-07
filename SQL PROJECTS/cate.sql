-- Creating the Manufacturer table

 use SmartAccountSaleVendordb


 -- Creating the Country table
CREATE TABLE Country (
  CountryId INT PRIMARY KEY IDENTITY,
  CountryName VARCHAR(255) NOT NULL
);

-- Creating the Province table
CREATE TABLE Province (
  ProvinceId INT PRIMARY KEY IDENTITY,
  ProvinceName VARCHAR(255) NOT NULL,
  CountryId INT NOT NULL,
  FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
);

-- Creating the City table
CREATE TABLE City (
  CityId INT PRIMARY KEY IDENTITY,
  CityName VARCHAR(255) NOT NULL,
  ProvinceId INT NOT NULL,
  FOREIGN KEY (ProvinceId) REFERENCES Province(ProvinceId)
);










CREATE TABLE Manufacturer (
  ManufacturerId INT PRIMARY KEY IDENTITY,
  ManufacturerName VARCHAR(255) not null,
 
);

-- Creating the Brand table
CREATE TABLE Brand (
  BrandId INT PRIMARY KEY IDENTITY,
  BrandName VARCHAR(25) not null
);



-- Creating the Color table
CREATE TABLE Color (
  ColorId INT PRIMARY KEY IDENTITY,
  ColorName VARCHAR(25) not null
);

-- Creating the Size table
CREATE TABLE Size (
  SizeId INT PRIMARY KEY IDENTITY,
  SizeName VARCHAR(25) not null
);

-- Creating the Unit table
CREATE TABLE Unit (
  UnitId INT PRIMARY KEY IDENTITY,
  UnitName VARCHAR(25) not null
);


-- Creating the Category table
CREATE TABLE Category (
  CategoryId INT PRIMARY KEY IDENTITY,
  CategoryName VARCHAR(255) NOT NULL
);

-- Creating the Subcategory table
CREATE TABLE Subcategory (
  SubcategoryId INT PRIMARY KEY IDENTITY,
  SubcategoryName VARCHAR(255) NOT NULL,
  CategoryId INT not null,
  FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

-- Creating the Product table
CREATE TABLE Product (
  ProductId INT PRIMARY KEY IDENTITY,
  ProductNumber NVARCHAR(50) NOT NULL,
  ProductName VARCHAR(255) NOT NULL,
  StandardCost MONEY,
  ReorderPoint INT,
  SubcategoryId INT not null,
  ManufacturerId INT not null,
  BrandId INT not null,
  FOREIGN KEY (SubcategoryId) REFERENCES Subcategory(SubcategoryId),
  FOREIGN KEY (ManufacturerId) REFERENCES Manufacturer(ManufacturerId),
  FOREIGN KEY (BrandId) REFERENCES Brand(BrandId)
);

-- Creating the ProductVariant table
CREATE TABLE ProductVariant (
  VariantId INT PRIMARY KEY IDENTITY,
  VariantName VARCHAR(255) NOT NULL,
  ProductId INT,
  ColorId INT,
  SizeId INT,
  UnitId INT,
  FOREIGN KEY (ProductId) REFERENCES Product(ProductId),
  FOREIGN KEY (ColorId) REFERENCES Color(ColorId),
  FOREIGN KEY (SizeId) REFERENCES Size(SizeId),
  FOREIGN KEY (UnitId) REFERENCES Unit(UnitId)
);

-- Creating the ProductVariantPrice table
CREATE TABLE ProductVariantPrice (
  PriceId INT PRIMARY KEY IDENTITY,
  VariantId INT not null,
  Price MONEY not null,
  StartDate date not null,
  EndDate date not null,
  FOREIGN KEY (VariantId) REFERENCES ProductVariant(VariantId)
);

 

-- Creating the Inventory table
CREATE TABLE Inventory (
  InventoryId INT PRIMARY KEY,
  VariantId INT,
  Quantity INT,
  FOREIGN KEY (VariantId) REFERENCES ProductVariant(VariantId)
);

-- Creating the PersonType table
CREATE TABLE PersonType (
  PersonTypeId INT PRIMARY KEY identity,
  PersonTypeName VARCHAR(255) NOT NULL
);

-- Creating the PhoneNumberType table
CREATE TABLE PhoneNumberType (
  PhoneNumberTypeId INT PRIMARY KEY identity,
  PhoneNumberTypeName VARCHAR(255) NOT NULL
);

-- Creating the PhoneNumber table
CREATE TABLE PhoneNumber (
  PhoneNumberId INT PRIMARY KEY identity,
  PhoneNumber VARCHAR(20) NOT NULL,
  PhoneNumberTypeId INT not null,
  FOREIGN KEY (PhoneNumberTypeId) REFERENCES PhoneNumberType(PhoneNumberTypeId)
);

-- Creating the AddressType table
CREATE TABLE AddressType (
  AddressTypeId INT PRIMARY KEY,
  AddressTypeName VARCHAR(255) NOT NULL
);

-- Creating the Address table
CREATE TABLE PersonAddress (
  AddressId INT PRIMARY KEY identity,
  AddressLine1 VARCHAR(255) NOT NULL,
  AddressLine2 VARCHAR(255),
  AddressTypeId INT not null,
  CityId INT not null,
  FOREIGN KEY (AddressTypeId) REFERENCES AddressType(AddressTypeId),
  FOREIGN KEY (CityId) REFERENCES City(CityId)
);

-- Creating the IdentificationType table
CREATE TABLE IdentificationType (
  IdentificationTypeId INT PRIMARY KEY identity,
  IdentificationTypeName VARCHAR(255) NOT NULL
);

-- Creating the Identification table
CREATE TABLE Identification (
  IdentificationId INT PRIMARY KEY identity,
  IdentificationTypeId INT not null,
  IdentificationNumber VARCHAR(50) not null,
  FOREIGN KEY (IdentificationTypeId) REFERENCES IdentificationType(IdentificationTypeId)
);

-- Creating the DocumentType table
CREATE TABLE DocumentType (
  DocumentTypeId INT PRIMARY KEY identity,
  DocumentTypeName VARCHAR(255) NOT NULL
);

-- Creating the Document table
CREATE TABLE Document (
  DocumentId INT PRIMARY KEY identity,
  DocumentTypeId INT not null,
  DocumentName VARCHAR(255) not null,
  DocPath varchar(max) ,
  FOREIGN KEY (DocumentTypeId) REFERENCES DocumentType(DocumentTypeId)
);
-- Creating the Person table
CREATE TABLE Person (
  PersonId INT PRIMARY KEY IDENTITY,
  PersonTypeID Int not null,
  FirstName VARCHAR(50) NOT NULL,
  MiddleName varchar(50) not null,
  LastName VARCHAR(50) NOT NULL,
  Gender tinyint,
  DateOfBirth DATE,
  MaritalStatus VARCHAR(50),
  Email VARCHAR(50) unique,
  AddressId INT,
  DocumentId  INT,
  IdentificationId INT,
  PhoneNumberId INT,
  FOREIGN KEY (PersonTypeID) REFERENCES PersonType(PersonTypeId),
  FOREIGN KEY (AddressId) REFERENCES PersonAddress(AddressId),
  FOREIGN KEY (DocumentId) REFERENCES Document(DocumentId),
  FOREIGN KEY (IdentificationId) REFERENCES Identification(IdentificationId),
  FOREIGN KEY (PhoneNumberId) REFERENCES PhoneNumber(PhoneNumberId),
  
);



CREATE TABLE [dbo].[Currency]
(
    [CurrencyCode] VARCHAR(3) PRIMARY KEY,
    [Name] VARCHAR(50),
    [ModifiedDate] DATETIME
);

CREATE TABLE [dbo].[CurrencyRate]
(
    [CurrencyRateID] INT IDENTITY(1,1) PRIMARY KEY,
    [CurrencyRateDate] DATE,
    [FromCurrencyCode] VARCHAR(3),
    [ToCurrencyCode] VARCHAR(3),
    [AverageRate] DECIMAL(18, 4),
    [EndOfDayRate] DECIMAL(18, 4),
    [ModifiedDate] DATETIME,
    FOREIGN KEY ([FromCurrencyCode]) REFERENCES [dbo].[Currency] ([CurrencyCode]),
    FOREIGN KEY ([ToCurrencyCode]) REFERENCES [dbo].[Currency] ([CurrencyCode])
);



-- Inserting data into the Color table
INSERT INTO Color (ColorName)
VALUES ('Red'), ('Blue'), ('Green'), ('Yellow'), ('Orange'), ('Purple'), ('Pink'), ('Black'), ('White'), ('Gray');

-- Inserting data into the Size table
INSERT INTO Size (SizeName)
VALUES ('Small'), ('Medium'), ('Large'), ('Extra Small'), ('Extra Large'), ('XS'), ('S'), ('M'), ('L'), ('XL');

-- Inserting data into the Unit table
INSERT INTO Unit (UnitName)
VALUES ('Piece'), ('Pack'), ('Kilogram'), ('Meter'), ('Liter'), ('Box'), ('Set'), ('Pair'), ('Roll'), ('Bundle');

INSERT INTO Manufacturer (ManufacturerName)
VALUES ('Nike'), ('Adidas'), ('Puma'), ('Reebok'), ('Under Armour'), ('New Balance'), ('Vans'), ('Converse'), ('Fila'), ('Skechers');

-- Inserting data into the Brand table
INSERT INTO Brand (BrandName)
VALUES ('Levis'), ('H&M'), ('Zara'), ('GAP'), ('Forever 21'), ('Tommy Hilfiger'), ('Calvin Klein'), ('Ralph Lauren'), ('Guess'), ('American Eagle');

-- Inserting data into the Category table
INSERT INTO Category (CategoryName)
VALUES ('Men''s Clothing'), ('Women''s Clothing'), ('Kids'' Clothing'), ('Shoes'), ('Accessories');

-- Inserting data into the Subcategory table
INSERT INTO Subcategory (SubcategoryName, CategoryId)
VALUES ('T-shirts', 1), ('Jeans', 1), ('Dresses', 2), ('Tops', 2), ('Shirts', 1), ('Shorts', 1), ('Sneakers', 4), ('Sandals', 4), ('Hats', 5), ('Bags', 5);



-- Inserting data into the Product table
INSERT INTO Product (ProductNumber, ProductName, StandardCost, ReorderPoint, SubcategoryId, ManufacturerId, BrandId)
VALUES ('P001', 'Men s T-shirt', 25.99, 10, 1, 1, 1),
       ('P002', 'Women s Jeans', 39.99, 15, 2, 2, 2),
       ('P003', 'Kids'' Dress', 19.99, 8, 3, 3, 3),
       ('P004', 'Men s Shirt', 29.99, 12, 1, 1, 1),
       ('P005', 'Women s Top', 15.99, 10, 2, 2, 2),
       ('P006', 'Kids  Shorts', 12.99, 6, 3, 3, 3),
       ('P007', 'Men s Jeans', 49.99, 18, 1, 1, 1),
       ('P008', 'Women s Dress', 34.99, 12, 2, 2, 2),
       ('P009', 'Kids  T-shirt', 9.99, 5, 3, 3, 3),
       ('P010', 'Women s Shirt', 22.99, 10, 2, 2, 2);

-- Inserting data into the ProductVariant table
INSERT INTO ProductVariant (VariantName, ProductId, ColorId, SizeId, UnitId)
VALUES ('Red, Small', 1, 1, 1, 1),
       ('Blue, Medium', 1, 2, 2, 1),
       ('Black, Large', 1, 8, 3, 1),
       ('Blue, Small', 2, 2, 1, 1),
       ('Black, Medium', 2, 8, 2, 1),
       ('Red, Large', 2, 1, 3, 1),
       ('Pink, Small', 3, 7, 1, 1),
       ('Green, Medium', 3, 3, 2, 1),
       ('Yellow, Large', 3, 4, 3, 1),
       ('White, Small', 4, 5, 1, 1),
       ('Blue, Medium', 4, 2, 2, 1),
       ('Black, Large', 4, 8, 3, 1),
       ('Green, Small', 5, 3, 1, 1),
       ('Red, Medium', 5, 1, 2, 1),
       ('Blue, Large', 5, 2, 3, 1),
       ('Yellow, Small', 6, 4, 1, 1),
       ('Black, Medium', 6, 8, 2, 1),
       ('Pink, Large', 6, 7, 3, 1),
       ('Blue, Small', 7, 2, 1, 1),
       ('Red, Medium', 7, 1, 2, 1),
       ('Black, Large', 7, 8, 3, 1),
       ('White, Small', 8, 5, 1, 1),
       ('Green, Medium', 8, 3, 2, 1),
       ('Blue, Large', 8, 2, 3, 1),
       ('Pink, Small', 9, 7, 1, 1),
       ('Blue, Medium', 9, 2, 2, 1),
       ('Black, Large', 9, 8, 3, 1),
       ('Green, Small', 10, 3, 1, 1),
       ('Red, Medium', 10, 1, 2, 1),
       ('Blue, Large', 10, 2, 3, 1);


-- Inserting data into the Inventory table
INSERT INTO Inventory (InventoryId, VariantId, Quantity)
VALUES (1, 1, 50),
       (2, 2, 100),
       (3, 3, 75),
       (4, 4, 80),
       (5, 5, 60),
       (6, 6, 90),
       (7, 7, 70),
       (8, 8, 85),
       (9, 9, 55),
       (10, 10, 95),
       (11, 11, 65),
       (12, 12, 60),
       (13, 13, 70),
       (14, 14, 75),
       (15, 15, 80),
       (16, 16, 90),
       (17, 17, 50),
       (18, 18, 85),
       (19, 19, 95),
       (20, 20, 80),
       (21, 21, 70),
       (22, 22, 75),
       (23, 23, 60),
       (24, 24, 90),
       (25, 25, 55),
       (26, 26, 85),
       (27, 27, 80),
       (28, 28, 90),
       (29, 29, 50),
       (30, 30, 75);

-- Inserting data into the ProductVariantPrice table
INSERT INTO ProductVariantPrice (VariantId, Price, StartDate, EndDate)
VALUES (1, 29.99, '2023-09-01', '2023-09-30'),
       (2, 34.99, '2023-09-02', '2023-09-29'),
       (3, 19.99, '2023-09-03', '2023-09-28'),
       (4, 39.99, '2023-09-04', '2023-09-27'),
       (5, 14.99, '2023-09-05', '2023-09-26'),
       (6, 9.99, '2023-09-06', '2023-09-25'),
       (7, 44.99, '2023-09-07', '2023-09-24'),
       (8, 29.99, '2023-09-08', '2023-09-23'),
       (9, 12.99, '2023-09-09', '2023-09-22'),
       (10, 24.99, '2023-09-10', '2023-09-21'),
       (11, 17.99, '2023-09-11', '2023-09-20'),
       (12, 39.99, '2023-09-12', '2023-09-19'),
       (13, 24.99, '2023-09-13', '2023-09-18'),
       (14, 19.99, '2023-09-14', '2023-09-17'),
       (15, 39.99, '2023-09-15', '2023-09-16'),
       (16, 14.99, '2023-09-16', '2023-09-15'),
       (17, 29.99, '2023-09-17', '2023-09-14'),
       (18, 22.99, '2023-09-18', '2023-09-13'),
       (19, 16.99, '2023-09-19', '2023-09-12'),
       (20, 39.99, '2023-09-20', '2023-09-11'),
       (21, 19.99, '2023-09-21', '2023-09-10'),
       (22, 12.99, '2023-09-22', '2023-09-09'),
       (23, 29.99, '2023-09-23', '2023-09-08'),
       (24, 14.99, '2023-09-24', '2023-09-07'),
       (25, 34.99, '2023-09-25', '2023-09-06'),
       (26, 24.99, '2023-09-26', '2023-09-05'),
       (27, 14.99, '2023-09-27', '2023-09-04'),
       (28, 39.99, '2023-09-28', '2023-09-03'),
       (29, 19.99, '2023-09-29', '2023-09-02'),
       (30, 9.99, '2023-09-30', '2023-09-01');




-- Inserting data into the Country table
INSERT INTO Country (CountryName)
VALUES ('Yemen');

-- Inserting data into the Province table for Yemen
INSERT INTO Province (ProvinceName, CountryId)
VALUES ('Taiz', (SELECT CountryId FROM Country WHERE CountryName = 'Yemen'));

-- Inserting data into the City table for Yemen
INSERT INTO City (CityName, ProvinceId)
VALUES ('Taiz City', (SELECT ProvinceId FROM Province WHERE ProvinceName = 'Taiz'));



-- Inserting data into the PersonType table
INSERT INTO PersonType (PersonTypeName)
VALUES ('Employee'), ('Customer'), ('Supplier'), ('Vendor');


-- Inserting data into the PhoneNumberType table
INSERT INTO PhoneNumberType (PhoneNumberTypeName)
VALUES ('Home'), ('Work'), ('Mobile'), ('Fax');

-- Inserting data into the AddressType table
INSERT INTO AddressType (AddressTypeId,AddressTypeName)
VALUES (1,'Home Address'), (2,'Work Address');




CREATE or alter VIEW MasterView AS
SELECT
    P.ProductId,
    P.ProductNumber,
    P.ProductName,
    P.StandardCost,
    P.ReorderPoint,
    C.CategoryName,
    S.SubcategoryName,
    M.ManufacturerName,

    B.BrandName,

    PV.VariantName,

    CO.ColorName,
  
    SI.SizeName,
 
    U.UnitName,
  
    PVP.Price,
  

    I.Quantity
FROM
    Product P
    JOIN Subcategory S ON P.SubcategoryId = S.SubcategoryId
    JOIN Category C ON S.CategoryId = C.CategoryId
    JOIN Manufacturer M ON P.ManufacturerId = M.ManufacturerId
    JOIN Brand B ON P.BrandId = B.BrandId
    JOIN ProductVariant PV ON P.ProductId = PV.ProductId
    JOIN Color CO ON PV.ColorId = CO.ColorId
    JOIN Size SI ON PV.SizeId = SI.SizeId
    JOIN Unit U ON PV.UnitId = U.UnitId
    JOIN ProductVariantPrice PVP ON PV.VariantId = PVP.VariantId
    JOIN Inventory I ON PV.VariantId = I.VariantId;





	select * from MasterView





	-- Creating the master view for Person
CREATE VIEW vw_PersonMaster AS
SELECT
  p.PersonId,
  pt.PersonTypeName,
  p.FirstName,
  p.MiddleName,
  p.LastName,
  p.Gender,
  p.DateOfBirth,
  p.MaritalStatus,
  p.Email,
  ph.PhoneNumber,
  phn.PhoneNumberTypeName,
  pa.AddressLine1,
  pa.AddressLine2,
  at.AddressTypeName,
  c.CityName,
  pr.ProvinceName,
  cn.CountryName,
  it.IdentificationTypeName,
  i.IdentificationNumber,
  dt.DocumentTypeName,
  d.DocumentName,
  d.DocPath
FROM Person p
LEFT JOIN PersonType pt ON p.PersonTypeID = pt.PersonTypeId
LEFT JOIN PhoneNumber ph ON p.PhoneNumberId = ph.PhoneNumberId
LEFT JOIN PhoneNumberType phn ON ph.PhoneNumberTypeId = phn.PhoneNumberTypeId
LEFT JOIN PersonAddress pa ON p.AddressId = pa.AddressId
LEFT JOIN AddressType at ON pa.AddressTypeId = at.AddressTypeId
LEFT JOIN City c ON pa.CityId = c.CityId
LEFT JOIN Province pr ON c.ProvinceId = pr.ProvinceId
LEFT JOIN Country cn ON pr.CountryId = cn.CountryId
LEFT JOIN Identification i ON p.IdentificationId = i.IdentificationId
LEFT JOIN IdentificationType it ON i.IdentificationTypeId = it.IdentificationTypeId
LEFT JOIN Document d ON p.DocumentId = d.DocumentId
LEFT JOIN DocumentType dt ON d.DocumentTypeId = dt.DocumentTypeId;

