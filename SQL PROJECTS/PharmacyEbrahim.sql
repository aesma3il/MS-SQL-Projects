CREATE TABLE Country (
    CountryId INT PRIMARY KEY,
    CountryName nVARCHAR(255)
);

CREATE TABLE City (
    CityId INT PRIMARY KEY,
    CityName nVARCHAR(255),
    CountryId INT,
    FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
);

CREATE TABLE Person (
    PersonId INT PRIMARY KEY,
    PersonCode nVARCHAR(255),
    FirstName nVARCHAR(255),
    SecondName nVARCHAR(255),
    ThirdName nVARCHAR(255),
    LastName nVARCHAR(255),
	FullName nvarchar(255),
    Gender nVARCHAR(10),
    DateOfBirth DATE,
    Phone nVARCHAR(20),
    Email nVARCHAR(255),
    AddressLine nVARCHAR(255),
    NationalNo nVARCHAR(20),
    PassportNumber nVARCHAR(20),
    PicturePath nVARCHAR(255),
    CityId INT,
    FOREIGN KEY (CityId) REFERENCES City(CityId)
);

CREATE TABLE Users (
    UserId INT PRIMARY KEY,
	FullName VARCHAR(255),
    Username VARCHAR(255) UNIQUE,
    [Password] VARCHAR(255),
  
	CreatedByUser INT,
    IsActive BIT DEFAULT 1
);


-- Create PointOfSaleCategory table
CREATE TABLE PointOfSaleCategory (
    PointOfSaleCategoryID INT PRIMARY KEY,
    PointOfSaleCategoryName VARCHAR(255)
);

-- Create ProductCategory table
CREATE TABLE ProductCategory (
    ProductCategoryID INT PRIMARY KEY,
    ProductCategoryName VARCHAR(255)
);

-- Create ProductType table
CREATE TABLE ProductType (
    ProductTypeID INT PRIMARY KEY,
    ProductTypeName VARCHAR(255)
);

-- Create UnitOfMeasure table
CREATE TABLE UnitOfMeasure (
    UnitOfMeasureID INT PRIMARY KEY,
    UnitOfMeasureName VARCHAR(50)
);

-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Favorite BIT,
    Name VARCHAR(255),
    InternalReference VARCHAR(255),
    Responsible VARCHAR(255),
    Barcode VARCHAR(50),
    PointOfSaleCategoryID INT,
    ProductCategoryID INT,
    ProductTypeID INT,
    UnitOfMeasureID INT,
    FOREIGN KEY (PointOfSaleCategoryID) REFERENCES PointOfSaleCategory(PointOfSaleCategoryID),
    FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID),
    FOREIGN KEY (ProductTypeID) REFERENCES ProductType(ProductTypeID),
    FOREIGN KEY (UnitOfMeasureID) REFERENCES UnitOfMeasure(UnitOfMeasureID)
);




CREATE TABLE Transfer (
    TransferID INT PRIMARY KEY,
    Priority INT,
    Reference VARCHAR(255),
    SourceLocation VARCHAR(255),
    DestinationLocation VARCHAR(255),
    Contact VARCHAR(255),
    ScheduledDate DATE,
    SourceDocument VARCHAR(255)
);



CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    DisplayName VARCHAR(255),
    ProductCategory VARCHAR(255),
    AverageCost DECIMAL(10, 2),
    TotalValue DECIMAL(10, 2),
    QuantityOnHand INT,
    FreeToUseQuantity INT,
    Incoming INT,
    Outgoing INT,
    ForecastedQuantity INT,
    UnitOfMeasure VARCHAR(50)
);


CREATE TABLE DeliverySlip (
    SlipID INT PRIMARY KEY,
    OrderID INT,
    SlipDate DATETIME,
    RecipientName VARCHAR(255),
    RecipientAddress VARCHAR(255),
    DeliveryStatus VARCHAR(50),
    CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES OrderDetails(OrderID)
);




--الجرد 

CREATE TABLE InventoryCount (
    CountID INT PRIMARY KEY,
    Location VARCHAR(255),
    Product VARCHAR(255),
    LotOrSerialNumber VARCHAR(255),
    Quantity DECIMAL(10, 2),
    UnitOfMeasure VARCHAR(50),
    CountedQuantity DECIMAL(10, 2),
    Difference DECIMAL(10, 2),
    ScheduledDate DATE,
    AssignedTo VARCHAR(255)
);

-- الخردة
CREATE TABLE ScrapInventory (
    ScrapID INT PRIMARY KEY,
    Reference VARCHAR(255),
    [Date] DATE,
    Product VARCHAR(255),
    Quantity DECIMAL(10, 2),
    UnitOfMeasure VARCHAR(50),
    SourceLocation VARCHAR(255),
    ScrapLocation VARCHAR(255),
    [Status] VARCHAR(50)
);


--التحويل من مكان الى اخر
CREATE TABLE InventoryTransfer (
    TransferID INT PRIMARY KEY,
    [Date] DATE,
    Reference VARCHAR(255),
    Product VARCHAR(255),
    LotOrSerialNumber VARCHAR(255),
    FromLocation VARCHAR(255),
    ToLocation VARCHAR(255),
    Done BIT,
    UnitOfMeasure VARCHAR(50),
    [Status] VARCHAR(50)
);


-- العمليات ع المخازن
CREATE TABLE InventoryOperation (
    OperationID INT PRIMARY KEY,
    OperationType VARCHAR(255),
    TypeOfOperation VARCHAR(255),
    SequencePrefix VARCHAR(50),
    ReturnsType VARCHAR(255),
    DefaultReturnsLocation VARCHAR(255),
    CreateBackorder BIT,
    ShowDetailedOperations BIT,
    PreFillDetailedOperations BIT,
    LotsSerialNumbers VARCHAR(50),
    Locations VARCHAR(255),
    DefaultSourceLocation VARCHAR(255),
    DefaultDestinationLocation VARCHAR(255)
);


CREATE TABLE StorageCategory (
    CategoryID INT PRIMARY KEY,
    StorageCategory VARCHAR(255),
    Quantity INT,
    UnitOfMeasure VARCHAR(50)
);


-- عملية اختيار المنتج لملئ طلكلب

CREATE TABLE StockPicking (
    PickingID INT PRIMARY KEY,
    Priority VARCHAR(255),
    Reference VARCHAR(255),
    SourceLocation VARCHAR(255),
    DestinationLocation VARCHAR(255),
    Contact VARCHAR(255),
    ScheduledDate DATE,
    SourceDocument VARCHAR(255),
    [Status] VARCHAR(50),
    ActivityExceptionDecoration VARCHAR(MAX),
    PopoverWidgetData JSON
);




CREATE TABLE UnitConversions (
  ConversionID INT PRIMARY KEY,
  FromUnitID INT,
  ToUnitID INT,
  ConversionFactor DECIMAL(10, 4),
  FOREIGN KEY (FromUnitID) REFERENCES Units(UnitID),
  FOREIGN KEY (ToUnitID) REFERENCES Units(UnitID)
);

-- Create the MedicineCategory table
CREATE TABLE MedicineCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- Insert data into MedicineCategory table
INSERT INTO MedicineCategory (CategoryID, CategoryName)
VALUES
    (1, 'Analgesics'),
    (2, 'Antibiotics'),
    (3, 'Antidepressants'),
    (4, 'Antihistamines');

-- Create the SubCategory table
CREATE TABLE SubCategory (
    SubCategoryID INT PRIMARY KEY,
    SubCategoryName VARCHAR(100),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES MedicineCategory(CategoryID)
);

-- Insert data into SubCategory table
INSERT INTO SubCategory (SubCategoryID, SubCategoryName, CategoryID)
VALUES
    (1, 'Opioids', 1),
    (2, 'NSAIDs', 1),
    (3, 'Penicillins', 2),
    (4, 'Cephalosporins', 2),
    (5, 'SSRIs', 3),
    (6, 'Tricyclics', 3),
    (7, 'First Generation', 4),
    (8, 'Second Generation', 4);

-- Create the MedicineProduct table
CREATE TABLE MedicineProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SubCategoryID INT,
    FOREIGN KEY (SubCategoryID) REFERENCES SubCategory(SubCategoryID)
);

-- Insert data into MedicineProduct table
INSERT INTO MedicineProduct (ProductID, ProductName, SubCategoryID)
VALUES
    (1, 'Oxycodone', 1),
    (2, 'Ibuprofen', 2),
    (3, 'Amoxicillin', 3),
    (4, 'Cephalexin', 4),
    (5, 'Fluoxetine', 5),
    (6, 'Amitriptyline', 6),
    (7, 'Diphenhydramine', 7),
    (8, 'Loratadine', 8);

-- Create the MedicineUnit table
CREATE TABLE MedicineUnit (
    UnitID INT PRIMARY KEY,
    UnitName VARCHAR(50)
);

-- Insert data into MedicineUnit table
INSERT INTO MedicineUnit (UnitID, UnitName)
VALUES
    (1, 'mg'),
    (2, 'g'),
    (3, 'mL'),
    (4, 'tablet'),
    (5, 'capsule'),
    (6, 'vial');

-- Create the MedicineItem table
CREATE TABLE MedicineItem (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    ProductID INT,
    UnitID INT,
    FOREIGN KEY (ProductID) REFERENCES MedicineProduct(ProductID),
    FOREIGN KEY (UnitID) REFERENCES MedicineUnit(UnitID)
);

-- Insert data into MedicineItem table
INSERT INTO MedicineItem (ItemID, ItemName, ProductID, UnitID)
VALUES
    (1, 'Oxycodone 10mg', 1, 1),
    (2, 'Oxycodone 20mg', 1, 1),
    (3, 'Ibuprofen 200mg', 2, 1),
    (4, 'Ibuprofen 400mg', 2, 1),
    (5, 'Amoxicillin 500mg', 3, 2),
    (6, 'Amoxicillin 1000mg', 3, 2),
    (7, 'Cephalexin 250mg', 4, 1),
    (8, 'Cephalexin 500mg', 4, 1),
    (9, 'Fluoxetine 20mg', 5, 1),
    (10, 'Amitriptyline 25mg', 6, 1),
    (11, 'Diphenhydramine 25mg', 7, 1),
    (12, 'Loratadine 10mg', 8, 1);









































-- Medicines table
CREATE TABLE Medicines (
  MedicineID INT PRIMARY KEY,
  MedicineName VARCHAR(100),
  DosageStrength DECIMAL(10, 2),
  DosageUnitID INT,
  GenericName VARCHAR(100),
  RouteOfAdministration VARCHAR(50),
  Manufacturer VARCHAR(100),
  FOREIGN KEY (DosageUnitID) REFERENCES Units(UnitID)
);

-- Medicine Categories table
CREATE TABLE MedicineCategories (
  CategoryID INT PRIMARY KEY,
  CategoryName VARCHAR(50)
);

-- Medicine Inventory table
CREATE TABLE MedicineInventory (
  InventoryID INT PRIMARY KEY,
  MedicineID INT,
  BatchNumber VARCHAR(50),
  ExpiryDate DATE,
  Quantity INT,
  Location VARCHAR(100),
  FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);

-- Prescriptions table
CREATE TABLE Prescriptions (
  PrescriptionID INT PRIMARY KEY,
  PatientID INT,
  DoctorID INT,
  PrescriptionDate DATE,
  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
  FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Prescription Medicine table
CREATE TABLE PrescriptionMedicine (
  PrescriptionMedicineID INT PRIMARY KEY,
  PrescriptionID INT,
  MedicineID INT,
  DosageInstructions VARCHAR(200),
  Quantity INT,
  FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID),
  FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);

-- Medicine Prices table
CREATE TABLE MedicinePrices (
  PriceID INT PRIMARY KEY,
  MedicineID INT,
  Price DECIMAL(10, 2),
  EffectiveDate DATE,
  Currency VARCHAR(10),
  FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);