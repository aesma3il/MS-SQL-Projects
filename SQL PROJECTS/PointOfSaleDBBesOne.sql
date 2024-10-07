


CREATE TABLE Addresss (
    AddressID int PRIMARY KEY,
    AddressText nvarchar(50),
    City nvarchar(50),
    Country nvarchar(50),
    Street nvarchar(200),
    PostalCode nvarchar(20)
);


CREATE TABLE PaymentMethod (
    PaymentMethodID INT PRIMARY KEY,
    PaymentMethodName VARCHAR(50)
);


create table CompanyInfo(
CompanyID int primary key,
CompanyName nvarchar(100) not null,
PhoneNumber nvarchar(50),
AddressID int unique foreign key references Addresss(AddressID),
ComanyLogo varchar(max)
);


create table Person(
PersonID int primary key,
FirstName nvarchar(50) not null,
LastName nvarchar(50),
Email nvarchar(100),
PhoneNumber nvarchar(100),
);


create table Employee(
EmployeeID int primary key,
PersonID int unique,
AddressID int unique foreign key references Addresss(AddressID),
constraint fk_Employee_Person foreign key(PersonID) references Person(PersonID)

);


CREATE TABLE EmployeePayment (
    PaymentID int PRIMARY KEY,
    EmployeeID int NOT NULL foreign key references Employee(EmployeeID),
	PaymentMethodID INT FOREIGN KEY REFERENCES PaymentMethod(PaymentMethodID),
    PaymentDate datetime  NOT NULL default getdate(),
    PaymentAmount decimal(10,2) NOT NULL,
    PaymentNotes varchar(500)
);



create table Store(
	StoreID int primary key,
	StoreName nvarchar(100) not null
);


CREATE TABLE Category(
CategoryID int Primary key,
CategoryName nvarchar(100) not null,
CategoryDescription nvarchar(500) null

);


create table SubCategory(
SubCategoryID int primary key,
SubCategoryName nvarchar(100) not null,
AddionalNotes nvarchar(500),
CategoryID int foreign key references Category(CategoryID)

);


CREATE TABLE Brand (
  BrandID INT PRIMARY KEY,
  BrandName VARCHAR(50)
);

CREATE TABLE Manufacturer (
  MFRID INT PRIMARY KEY,
  MFRName VARCHAR(50)
);

create table Product(
ProductID int Primary key,
ProductName nvarchar(100) not null,
ProductDescription nvarchar(500),
cost DECIMAL(10,2),
Price DECIMAL(10,2),
Quantity INT,
SubCategoryID int foreign key references SubCategory(SubCategoryID),
BrandID int foreign key references Brand(BrandID),
MFRID int foreign key references Manufacturer(MFRID),
StoreID int foreign key references Store(StoreID)
);


CREATE TABLE Size (
  SizeID INT PRIMARY KEY,
  SizeName VARCHAR(255)
);

CREATE TABLE Color (
  ColorID INT PRIMARY KEY,
  ColorName VARCHAR(255)
);

create table Item(
ItemID int primary key,
ProductID int foreign key references Product(ProductID),
SizeID int foreign key references Size(SizeID),
ColorID int foreign key references Color(ColorID),
SKU varchar(300),
ItemName nvarchar(100),
ItemDescription nvarchar(500),
Price decimal(10,2) not null,
Quantity int,



);

create table Customer(
CustomerID int primary key,
FirstName nvarchar(50) not null,
LastName nvarchar(50),
PhoneNumber int,
Email nvarchar(100),
AddressID int unique foreign key references Addresss(AddressID),

);

create table Sale(
SaleID int primary key,
CustomerID int,
EmployeeID int,
SaleDateTime DateTime default GetDate(),
Discount DECIMAL(10, 2),
Tax DECIMAL(10, 2),
TotalAmount decimal(10, 2),

constraint fk_Sale_Customer foreign key(CustomerID) references Customer(CustomerID),
constraint fk_Sale_Employee foreign key(EmployeeID) references Employee(EmployeeID)
);


create table SaleDetail(
SaleDetailID int primary key,
ItemID int foreign key references Item(ItemID),
SaleID int foreign key references Sale(SaleID),
UnitPrice decimal(10, 2),
SaleQty int,
Subtotal decimal(10, 2),
);





create table SalePayment(
SalePaymentID int primary key,
SaleID int FOREIGN KEY REFERENCES Sale(SaleID),
CustomerID int FOREIGN KEY REFERENCES Customer(CustomerID),
PaymentMethodID INT FOREIGN KEY REFERENCES PaymentMethod(PaymentMethodID),
PaidDate datetime default getDate(),
TotalAmount decimal(10, 2),
PaidAmount decimal(10, 2),
RemainingAmount decimal(10, 2),
Note nvarchar(500)
);



create table Supplier(
SupplierID int primary key,
PersonID int unique foreign key references Person(PersonID) ,
AddressID int unique foreign key references Addresss(AddressID),
);


create table PurchaseOrder(
PurchaseOrderID int primary key,
EmployeeID int foreign key references Employee(EmployeeID),
SupplierID int foreign key references Supplier(SupplierID),
PurchaseDate datetime default getdate(),
TotalAmount decimal(10, 2),
Note nvarchar(500)
);


create table PurchaseDetail(
PurchaseDetailID int primary key,
PurchaseOrderID int foreign key references PurchaseOrder(PurchaseOrderID),
ItemID int foreign key references Item(ItemID),
PurchaseQty int,
PurchaseUnitPrice decimal(10, 2),
Subtotal decimal(10, 2),

);

CREATE TABLE PurchasePayment (
    PurchasePaymentID int primary key,
    SupplierID int foreign key references Supplier(SupplierID),
    PaymentMethodID int foreign key references PaymentMethod(PaymentMethodID),
    PaidDate datetime default getDate(),
    TotalAmount decimal(10, 2),
    PaidAmount decimal(10, 2),
    RemainingAmount decimal(10, 2),
    Note nvarchar(500)
);




create table UserAdmin(
UserID int primary key,
PersonID int unique foreign key references Person(PersonID),
AddressID int unique foreign key references Addresss(AddressID),
Username nvarchar(100) not null,
Pass nvarchar(100) not null

);



CREATE TABLE Returning (
    ReturnID int PRIMARY KEY,
    SaleID int FOREIGN KEY REFERENCES Sale(SaleID),
    ItemID int foreign key references Item(ItemID),
    ReturnDate datetime,
    ReturnReason nvarchar(500),
    ReturnQuantity int,
    RefundAmount decimal(10,2)
   
);


CREATE TABLE Refunds (
    RefundID int PRIMARY KEY,
    ReturnID int FOREIGN KEY REFERENCES Returning(ReturnID),
    CustomerID int FOREIGN KEY REFERENCES Customer(CustomerID),
    RefundAmount decimal(10, 2),
    RefundDate datetime default getdate(),
    
);