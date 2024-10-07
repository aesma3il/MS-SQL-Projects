-- Create the Role table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL
);

-- Create the User table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
	Password VARCHAR(50) NOT NULL,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);



-- Create the Permission table
CREATE TABLE [Permissions] (
    PermissionID INT PRIMARY KEY,
    PermissionName VARCHAR(50) NOT NULL
);

-- Create the Resource table
CREATE TABLE Resources (
    ResourceID INT PRIMARY KEY,
    ResourceName VARCHAR(100) NOT NULL
);

-- Create the Access Control List (ACL) table
CREATE TABLE ACL (
    ACLID INT PRIMARY KEY,
    ResourceID INT,
    RoleID INT,
    PermissionID INT,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES [Permissions](PermissionID)
);

-- Create the Role-Permission Assignment table
CREATE TABLE RolePermissionAssignment (
    RolePermissionID INT PRIMARY KEY,
    RoleID INT,
    PermissionID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES [Permissions](PermissionID)
);


-- Country table
CREATE TABLE Country (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL
);

-- StateOrProvince table
CREATE TABLE StateOrProvince (
    ProvinceID INT IDENTITY(1,1) PRIMARY KEY,
    ProvinceName VARCHAR(100) NOT NULL,
    CountryID INT NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- City table
CREATE TABLE City (
    CityID INT IDENTITY(1,1) PRIMARY KEY,
    CityName VARCHAR(100) NOT NULL,
    ProvinceID INT NOT NULL,
    FOREIGN KEY (ProvinceID) REFERENCES StateOrProvince(ProvinceID)
);

-- Address table
CREATE TABLE [Address] (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    Street VARCHAR(100) NOT NULL,
    Neighborhood VARCHAR(100) NOT NULL,
    AdditionalDetails VARCHAR(100),
    CityID INT NOT NULL,
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

-- Person table
CREATE TABLE Person (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    PersonGuid UNIQUEIDENTIFIER NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    FatherName VARCHAR(100),
    GrandFatherName VARCHAR(100),
    FamilyName VARCHAR(100) NOT NULL,
    Gender CHAR(1) NOT NULL,
    MaritalStatus VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    PlaceOfBirth VARCHAR(100) NOT NULL,
    BloodType VARCHAR(10),
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    MobilePhone VARCHAR(20),
    ImagePath VARCHAR(200),
    AddressID INT NOT NULL,
	CreatedAt Datetime,
	CreatedBy INT ,
    FOREIGN KEY (AddressID) REFERENCES [Address](AddressID)
);

-- ContactType table
CREATE TABLE ContactType (
    ContactTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);

-- PersonContact table
CREATE TABLE PersonContact (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,
    ContactNo VARCHAR(20) NOT NULL,
    ContactTypeID INT NOT NULL,
    PersonID INT NOT NULL,
    FOREIGN KEY (ContactTypeID) REFERENCES ContactType(ContactTypeID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- EmailAddressType table
CREATE TABLE EmailAddressType (
    AddressTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);

-- PersonEmail table
CREATE TABLE PersonEmail (
    EmailID INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(100) NOT NULL,
    EmailTypeID INT NOT NULL,
    PersonID INT NOT NULL,
    FOREIGN KEY (EmailTypeID) REFERENCES EmailAddressType(AddressTypeID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);




-- Category Table
CREATE TABLE Category (
    CategoryID INT IDENTITY(1, 1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

-- SubCategory Table
CREATE TABLE SubCategory (
    SubCategoryID INT IDENTITY(1, 1) PRIMARY KEY,
    SubCategoryName VARCHAR(50) NOT NULL,
    ParentCategoryID INT NOT NULL,
    FOREIGN KEY (ParentCategoryID) REFERENCES Category(CategoryID)
);

-- Brand Table
CREATE TABLE Brand (
    BrandID INT IDENTITY(1, 1) PRIMARY KEY,
    BrandName VARCHAR(50) NOT NULL
);

-- Model Table
CREATE TABLE Model (
    ModelID INT IDENTITY(1, 1) PRIMARY KEY,
    ModelName VARCHAR(50) NOT NULL
);

-- Sizes Table
CREATE TABLE Sizes (
    SizeID INT IDENTITY(1, 1) PRIMARY KEY,
    SizeName VARCHAR(50) NOT NULL
);

-- Colors Table
CREATE TABLE Colors (
    ColorID INT IDENTITY(1, 1) PRIMARY KEY,
    ColorName VARCHAR(50) NOT NULL
);

-- Units Table
CREATE TABLE Units (
    UnitID INT IDENTITY(1, 1) PRIMARY KEY,
    UnitName VARCHAR(50) NOT NULL
);

-- ProductType Table
CREATE TABLE ProductType (
    ProductTypeID INT IDENTITY(1, 1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);

-- Product Table
CREATE TABLE Product (
    ProductID INT IDENTITY(1, 1) PRIMARY KEY,
    ProductGuid UNIQUEIDENTIFIER NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    ProductDescription VARCHAR(MAX),
    SubCategoryID INT NOT NULL,
    ModelID INT NOT NULL,
    BrandID INT NOT NULL,
    ProductTypeID INT NOT NULL,
    IsActive BIT NOT NULL,
    FOREIGN KEY (SubCategoryID) REFERENCES SubCategory(SubCategoryID),
    FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID),
    FOREIGN KEY (ProductTypeID) REFERENCES ProductType(ProductTypeID)
);




-- ProductVariant table
CREATE TABLE ProductVariant (
    VariantID INT IDENTITY(1, 1) PRIMARY KEY,
    SalePrice DECIMAL(10, 2) NOT NULL,
    Qty INT NOT NULL
);

-- ProductVariantDetails table
CREATE TABLE ProductVariantDetails (
    VariantID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    FOREIGN KEY (VariantID) REFERENCES ProductVariant(VariantID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- VariantColor table
CREATE TABLE VariantColor (
    VariantID INT,
    ColorID INT,
    PRIMARY KEY (VariantID, ColorID),
    FOREIGN KEY (VariantID) REFERENCES ProductVariant(VariantID),
    FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);

-- VariantSize table
CREATE TABLE VariantSize (
    VariantID INT,
    SizeID INT,
    PRIMARY KEY (VariantID, SizeID),
    FOREIGN KEY (VariantID) REFERENCES ProductVariant(VariantID),
    FOREIGN KEY (SizeID) REFERENCES Sizes(SizeID)
);

-- VariantUnit table
CREATE TABLE VariantUnit (
    VariantID INT,
    UnitID INT,
    PRIMARY KEY (VariantID, UnitID),
    FOREIGN KEY (VariantID) REFERENCES ProductVariant(VariantID),
    FOREIGN KEY (UnitID) REFERENCES Units(UnitID)
);













-- Insert sample data into the Country table
INSERT INTO Country (CountryName)
VALUES
    ('United States'),
    ('Canada'),
    ('United Kingdom');

-- Insert sample data into the StateOrProvince table
INSERT INTO StateOrProvince (ProvinceName, CountryID)
VALUES
    ('California', 1),
    ('Ontario', 2),
    ('London', 3);

-- Insert sample data into the City table
INSERT INTO City (CityName, ProvinceID)
VALUES
    ('Los Angeles', 1),
    ('Toronto', 2),
    ('Manchester', 3);








	-- Insert sample data into the Address table
INSERT INTO [Address] (Street, Neighborhood, AdditionalDetails, CityID)
VALUES
    ('123 Main St', 'Downtown', NULL, 1),
    ('456 Elm St', 'Suburb', 'Apt 202', 2),
    ('789 Oak St', 'Residential', NULL, 3);

-- Insert sample data into the Person table
INSERT INTO Person (PersonGuid, FirstName, FatherName, GrandFatherName, FamilyName, Gender, MaritalStatus, DateOfBirth, PlaceOfBirth, BloodType, Email, Phone, MobilePhone, ImagePath, AddressID, CreatedAt, CreatedBy)
VALUES
    (NEWID(), 'John', 'William', 'Smith', 'Doe', 'M', 'Single', '1990-05-15', 'Los Angeles', 'A+', 'john@example.com', '1234567890', '9876543210', '/images/john.jpg', 1, GETDATE(), 1),
    (NEWID(), 'Jane', NULL, NULL, 'Doe', 'F', 'Married', '1992-08-20', 'Toronto', 'B-', 'jane@example.com', '5551112222', '9998887777', '/images/jane.jpg', 2, GETDATE(), 1),
    (NEWID(), 'Michael', 'Robert', 'Johnson', 'Smith', 'M', 'Single', '1985-12-10', 'Manchester', 'O+', 'michael@example.com', '7774441111', '3332221111', '/images/michael.jpg', 3, GETDATE(), 2);

-- Insert sample data into the ContactType table
INSERT INTO ContactType (TypeName)
VALUES
    ('Home Phone'),
    ('Work Phone'),
    ('Mobile Phone');

-- Insert sample data into the PersonContact table
INSERT INTO PersonContact (ContactNo, ContactTypeID, PersonID)
VALUES
    ('555-1234', 1, 1),
    ('555-5678', 3, 1),
    ('999-0000', 2, 2),
    ('111-2222', 3, 3);

-- Insert sample data into the EmailAddressType table
INSERT INTO EmailAddressType (TypeName)
VALUES
    ('Personal Email'),
    ('Work Email');

-- Insert sample data into the PersonEmail table
INSERT INTO PersonEmail (Email, EmailTypeID, PersonID)
VALUES
    ('john@example.com', 1, 1),
    ('jane@example.com', 1, 2),
    ('michael@example.com', 2, 3);



 -- Insert sample data into the Category table
INSERT INTO Category (CategoryName)
VALUES
    ('Medicines'),
    ('Personal Care'),
    ('Health Supplements');

-- Insert sample data into the SubCategory table
INSERT INTO SubCategory (SubCategoryName, ParentCategoryID)
VALUES
    ('Pain Relief', 1),
    ('Beauty', 2),
    ('Vitamins', 3);

-- Insert sample data into the Brand table
INSERT INTO Brand (BrandName)
VALUES
    ('Tylenol'),
    ('Dove'),
    ('Centrum');

-- Insert sample data into the Model table
INSERT INTO Model (ModelName)
VALUES
    ('Extra Strength'),
    ('Intensive Repair'),
    ('Adults');

-- Insert sample data into the Sizes table
INSERT INTO Sizes (SizeName)
VALUES
    ('Small'),
    ('Medium'),
    ('Large');

-- Insert sample data into the Colors table
INSERT INTO Colors (ColorName)
VALUES
    ('Red'),
    ('Blue'),
    ('Green');

-- Insert sample data into the Units table
INSERT INTO Units (UnitName)
VALUES
    ('Tablet'),
    ('Bottle'),
    ('Tube');

-- Insert sample data into the ProductType table
INSERT INTO ProductType (TypeName)
VALUES
    ('Over-the-counter'),
    ('Prescription'),
    ('Supplement');



	-- Insert sample data into the Product table
INSERT INTO Product (ProductGuid, ProductName, ProductDescription, SubCategoryID, ModelID, BrandID, ProductTypeID, IsActive)
VALUES
    (NEWID(), 'Tylenol Extra Strength Tablets', 'Pain reliever for adults', 1, 1, 1, 1, 1),
    (NEWID(), 'Dove Intensive Repair Shampoo', 'Restores damaged hair', 2, 2, 2, 1, 1),
    (NEWID(), 'Centrum Adults Multivitamin', 'Complete daily multivitamin for adults', 3, 3, 3, 3, 1);

-- Insert sample data into the ProductVariant table
INSERT INTO ProductVariant (SalePrice, Qty)
VALUES
    (9.99, 100),
    (5.99, 50),
    (14.99, 200);

-- Insert sample data into the ProductVariantDetails table
INSERT INTO ProductVariantDetails (VariantID, ProductID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Insert sample data into the VariantColor table
INSERT INTO VariantColor (VariantID, ColorID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Insert sample data into the VariantSize table
INSERT INTO VariantSize (VariantID, SizeID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Insert sample data into the VariantUnit table
INSERT INTO VariantUnit (VariantID, UnitID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);