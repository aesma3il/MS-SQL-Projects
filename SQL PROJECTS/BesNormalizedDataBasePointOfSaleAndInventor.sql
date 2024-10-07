CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50)
);

CREATE TABLE State (
    StateID INT PRIMARY KEY,
    StateName VARCHAR(50),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE City (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(50),
    StateID INT,
    FOREIGN KEY (StateID) REFERENCES State(StateID)
);

CREATE TABLE Address(
	AddressID INT Primary key,
    AddressLine1 VARCHAR(100),
    AddressLine2 VARCHAR(100),
    PostalCode VARCHAR(20),
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES City(CityID)

);





CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
   
);



CREATE TABLE PersonAddress(
    PersonAddressID INT,
    PersonID INT,
    AddressID INT,
    CONSTRAINT PK_PersonAddress PRIMARY KEY (PersonAddressID),
    CONSTRAINT FK_PersonAddress_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    CONSTRAINT FK_PersonAddress_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);



CREATE TABLE LoginCredentials (
    PersonID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);


CREATE TABLE Phone (
    PhoneID INT PRIMARY KEY,
    PersonID INT,
    PhoneNumber VARCHAR(20),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Email (
    EmailID INT PRIMARY KEY,
    PersonID INT,
    EmailAddress VARCHAR(100),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);



CREATE TABLE Brand (
    BrandID INT PRIMARY KEY,
    Brand VARCHAR(50)
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Category VARCHAR(50)
);


CREATE TABLE ProductSubcategory (
    ProductSubID INT PRIMARY KEY,
    ProductSubName VARCHAR(100),
    
    CategoryID INT FOREIGN KEY REFERENCES ProductCategory(CategoryID)
);

CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY,
    Manufacturer VARCHAR(100)
);


CREATE TABLE BusinessEntity(
BusinessEntityID INT PRIMARY KEY,
CONSTRAINT Fk_BusinessEnttiy_Person foreign key(BusinessEntityID) references Person(PersonID)

);

CREATE TABLE ProductType (
    ProductTypeID INT PRIMARY KEY,
    ProductType VARCHAR(50),
	SubCategoryID INT FOREIGN KEY REFERENCES ProductSubcategory(ProductSubID)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    BrandID INT FOREIGN KEY REFERENCES Brand(BrandID),
    ManufacturerID INT FOREIGN KEY REFERENCES Manufacturer(ManufacturerID),
    ProductTypeID INT FOREIGN KEY REFERENCES ProductType(ProductTypeID)
);

CREATE TABLE UnitOfMeasure (
    UnitOfMeasureID INT PRIMARY KEY,
    UnitOfMeasure VARCHAR(50)
    -- Other unit of measure columns...
);

CREATE TABLE ProductUnitPrice (
    ProductID INT,
    UnitOfMeasureID INT,
    Price DECIMAL(10, 2),
    PRIMARY KEY (ProductID, UnitOfMeasureID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (UnitOfMeasureID) REFERENCES UnitOfMeasure(UnitOfMeasureID)
);


CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(100),
  
);

CREATE TABLE [Location] (
    LocationID INT PRIMARY KEY,
    WarehouseId INT FOREIGN KEY REFERENCES Warehouse(WarehouseID),
    LocationName VARCHAR(100),
    
);


CREATE TABLE ProductImages (
    ImageID INT PRIMARY KEY,
    ProductID INT,
    ImageURL VARCHAR(200),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


CREATE TABLE Attribute (
    AttributeID INT PRIMARY KEY,
    AttributeName VARCHAR(100)
);

CREATE TABLE ProductAttribute (
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    AttributeID INT FOREIGN KEY REFERENCES Attribute(AttributeID),
    AttributeValue VARCHAR(100),
    PRIMARY KEY (ProductID, AttributeID)
);


CREATE TABLE ProductInventory (
    ProductInventoryID INT PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
	 WarehouseID INT FOREIGN KEY REFERENCES Warehouse(WarehouseID),
    Qty INT
   
    
);


CREATE TABLE StockMovement (
    Id INT PRIMARY KEY,
    Quantity INT,
    MovementDate DATETIME
);

CREATE TABLE StockMovementProduct (
    StockMovementId INT PRIMARY KEY,
    ProductId INT,
    FOREIGN KEY (StockMovementId) REFERENCES StockMovement(Id),
    FOREIGN KEY (ProductId) REFERENCES Product(Id)
);

CREATE TABLE StockMovementLocation (
    StockMovementId INT PRIMARY KEY,
    LocationIdFrom INT,
    LocationIdTo INT,
    FOREIGN KEY (StockMovementId) REFERENCES StockMovement(Id),
    FOREIGN KEY (LocationIdFrom) REFERENCES [Location](LocationID),
    FOREIGN KEY (LocationIdTo) REFERENCES [Location](LocationID)
);

CREATE TABLE StockMovementType (
    StockMovementId INT PRIMARY KEY,
    MovementTypeId INT,
    FOREIGN KEY (StockMovementId) REFERENCES StockMovement(Id),
    FOREIGN KEY (MovementTypeId) REFERENCES StockMovementType(Id)
);