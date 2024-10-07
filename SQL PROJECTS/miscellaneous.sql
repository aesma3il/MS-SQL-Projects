C

CREATE TABLE Brand (
    BrandID INT PRIMARY KEY,
    BrandName VARCHAR(100)
);




CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
   
);

CREATE TABLE Subcategory (
    SubcategoryID INT PRIMARY KEY,
    SubcategoryName VARCHAR(100),
    CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SubcategoryID INT FOREIGN KEY REFERENCES Subcategory(SubcategoryID),
    Price DECIMAL(10, 2),
   
);

CREATE TABLE ProductDescription (
    DescriptionID INT PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    DescriptionText VARCHAR(MAX)
);

CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY,
    TypeName VARCHAR(100)
);

CREATE TABLE ProductTransaction (
    TransactionID INT PRIMARY KEY,
    ProductID INT
    Quantity INT,
	TransactionDate DATE default getdate(),


);



CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    QuantityOnHand INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE PersonType (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(100)
);

CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    TypeID INT FOREIGN KEY REFERENCES PersonType(TypeID)
);

CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    PersonID INT FOREIGN KEY REFERENCES Person(PersonID),
    AddressLine1 VARCHAR(100),
    AddressLine2 VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    PostalCode VARCHAR(20)
);

CREATE TABLE TransactionType (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(100)
);

CREATE TABLE TransactionHeader (
    TransactionID INT PRIMARY KEY,
    TransactionTypeID INT FOREIGN KEY REFERENCES TransactionType(TypeID),
    PersonID INT FOREIGN KEY REFERENCES Person(PersonID),
    TransactionDate DATETIME
);

CREATE TABLE TransactionDetail (
    DetailID INT PRIMARY KEY,
    TransactionID INT FOREIGN KEY REFERENCES TransactionHeader(TransactionID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

CREATE TABLE PurchaseHeader (
    PurchaseID INT PRIMARY KEY,
    PersonID INT FOREIGN KEY REFERENCES Person(PersonID),
    PurchaseDate DATETIME
);

CREATE TABLE PurchaseDetail (
    DetailID INT PRIMARY KEY,
    PurchaseID INT FOREIGN KEY REFERENCES PurchaseHeader(PurchaseID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY,
    TableName VARCHAR(100),
    RecordID INT,
    Action VARCHAR(10),
    ActionDate DATETIME,
    OldValues VARCHAR(MAX),
    NewValues VARCHAR(MAX)
);

CREATE TABLE ErrorLog (
    LogID INT PRIMARY KEY,
    ErrorDate DATETIME,
    ErrorMessage VARCHAR(MAX)
);


CREATE TABLE [dbo].[ErrorLog](
	[ErrorLogID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorTime] [datetime] NOT NULL,
	[UserName] [sysname] NOT NULL,
	[ErrorNumber] [int] NOT NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorProcedure] [nvarchar](126) NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_ErrorLog_ErrorLogID] PRIMARY KEY CLUSTERED 
(
	[ErrorLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO