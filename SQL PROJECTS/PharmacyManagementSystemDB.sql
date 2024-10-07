CREATE DATABASE Pharmacy
CREATE TABLE Supplier (
    ID int,
    Name varchar(30),
    Phone int,
    Address varchar(30),
    Email varchar(30),
    CompanyID int
);

CREATE TABLE Company (
    ID int,
    Name varchar(50),
    Address varchar(50),
    Phone int,
    Email varchar(50)
);

CREATE TABLE Category (
    ID int,
    Name varchar(50),
    DateCreated datetime
);

CREATE TABLE Subcategory (
    ID int,
    Name varchar(45),
    DateCreated datetime,
    CategoryID int
);

CREATE TABLE [Order] (
    ID int,
    OrderDate datetime,
    CompanyID int,
    SupplierID int
);

CREATE TABLE OrderProduct (
    ProductID int,
    OrderID int,
    ManufactureDate date,
    ExpirationDate date,
    Quantity int,
    BuyPrice real,
    Rate real,
    QuantityInHand int,
    LocationID int
);

CREATE TABLE Product (
    ID int,
    Name varchar(40),
    Description varchar(100),
    Manufacturer varchar(30),
    SubcategoryID int,
    SupercategoryID int
);

CREATE TABLE BillHasProduct (
    BillID int,
    ProductID int,
    Quantity int,
    Amount real
);

CREATE TABLE Bill (
    ID int,
    BillDate date,
    PatientName varchar(40),
    UserID int
);

CREATE TABLE Report (
    ID int,
    Description varchar(50),
    ReportDate date,
    UserID int
);

CREATE TABLE [User] (
    ID int,
    Username varchar(45),
    Password varchar(40),
    EmployeeID int,
    TypeID int,
    Profile int
);

CREATE TABLE Employee (
    ID int,
    Name varchar(30),
    Phone int,
    Address varchar(30),
    Email varchar(30),
    Gender binary
);

CREATE TABLE Role (
    ID int,
    Name varchar(40),
    DateCreated date,
    ProfileID int
);

CREATE TABLE Profile (
    ID int,
    Name varchar(40),
    DateCreated date,
    ColumnName varchar(40)
);

CREATE TABLE Attendance (
    ID int,
    TimeIn datetime,
    TimeOut datetime,
    AttendanceDate date,
    UserID int
);

CREATE TABLE Inventory (
    ID int,
    ProductID int,
    Quantity int,
    AdjustmentType varchar(20),
    AdjustmentDate datetime,
    Reason varchar(100)
);

CREATE TABLE Prescription (
    ID int,
    PatientName varchar(50),
    MedicationName varchar(50),
    Dosage varchar(20),
    Quantity int,
    PrescribingPhysician varchar(50),
    DateFilled datetime
);

CREATE TABLE Patient (
    ID int,
    FirstName varchar(30),
    LastName varchar(30),
    Address varchar(50),
    City varchar(30),
    State varchar(30),
    ZipCode varchar(10),
    Phone varchar(20),
    Email varchar(50),
    MedicalHistory text
);

CREATE TABLE Payment (
    ID int,
    BillID int,
    Amount real,
    PaymentDate datetime,
    PaymentType varchar(50)
);

CREATE TABLE Refund (
    ID int,
    CustomerName varchar(50),
    ProductID int,
    Quantity int,
    RefundDate datetime
);

CREATE TABLE Discount (
    ID int,
    BillID int,
    DiscountAmount real,
    DiscountReason varchar(100)
);

CREATE TABLE Tax (
    ID int,
    BillID int,
    TaxAmount real,
    ExemptionReason varchar(100)
);

CREATE TABLE SupplierProduct (
    ID int,
    SupplierID int,
    ProductID int,
    Price decimal(10,2),
    Availability bit
);


--constraints

ALTER TABLE Supplier ADD CONSTRAINT PK_Supplier PRIMARY KEY (ID);
ALTER TABLE Company ADD CONSTRAINT PK_Company PRIMARY KEY (ID);
ALTER TABLE Category ADD CONSTRAINT PK_Category PRIMARY KEY (ID);
ALTER TABLE Subcategory ADD CONSTRAINT PK_Subcategory PRIMARY KEY (ID);
ALTER TABLE [Order] ADD CONSTRAINT PK_Order PRIMARY KEY (ID);
ALTER TABLE OrderProduct ADD CONSTRAINT PK_OrderProduct PRIMARY KEY (ProductID, OrderID);
ALTER TABLE Product ADD CONSTRAINT PK_Product PRIMARY KEY (ID);
ALTER TABLE BillHasProduct ADD CONSTRAINT PK_BillHasProduct PRIMARY KEY (BillID, ProductID);
ALTER TABLE Bill ADD CONSTRAINT PK_Bill PRIMARY KEY (ID);
ALTER TABLE Report ADD CONSTRAINT PK_Report PRIMARY KEY (ID);
ALTER TABLE [User] ADD CONSTRAINT PK_User PRIMARY KEY (ID);
ALTER TABLE Employee ADD CONSTRAINT PK_Employee PRIMARY KEY (ID);
ALTER TABLE Role ADD CONSTRAINT PK_Role PRIMARY KEY (ID);
ALTER TABLE Profile ADD CONSTRAINT PK_Profile PRIMARY KEY (ID);
ALTER TABLE Attendance ADD CONSTRAINT PK_Attendance PRIMARY KEY (ID);
ALTER TABLE Inventory ADD CONSTRAINT PK_Inventory PRIMARY KEY (ID);
ALTER TABLE Prescription ADD CONSTRAINT PK_Prescription PRIMARY KEY (ID);
ALTER TABLE Patient ADD CONSTRAINT PK_Patient PRIMARY KEY (ID);
ALTER TABLE Payment ADD CONSTRAINT PK_Payment PRIMARY KEY (ID);
ALTER TABLE Refund ADD CONSTRAINT PK_Refund PRIMARY KEY (ID);
ALTER TABLE Discount ADD CONSTRAINT PK_Discount PRIMARY KEY (ID);
ALTER TABLE Tax ADD CONSTRAINT PK_Tax PRIMARY KEY (ID);
ALTER TABLE SupplierProduct ADD CONSTRAINT PK_SupplierProduct PRIMARY KEY (ID);

ALTER TABLE Supplier ADD CONSTRAINT FK_Supplier_Company FOREIGN KEY (CompanyID) REFERENCES Company(ID);
ALTER TABLE Subcategory ADD CONSTRAINT FK_Subcategory_Category FOREIGN KEY (CategoryID) REFERENCES Category(ID);
ALTER TABLE [Order] ADD CONSTRAINT FK_Order_Company FOREIGN KEY (CompanyID) REFERENCES Company(ID);
ALTER TABLE [Order] ADD CONSTRAINT FK_Order_Supplier FOREIGN KEY (SupplierID) REFERENCES Supplier(ID);
ALTER TABLE OrderProduct ADD CONSTRAINT FK_OrderProduct_Product FOREIGN KEY (ProductID) REFERENCES Product(ID);
ALTER TABLE OrderProduct ADD CONSTRAINT FK_OrderProduct_Order FOREIGN KEY (OrderID) REFERENCES [Order](ID);
ALTER TABLE Product ADD CONSTRAINT FK_Product_Subcategory FOREIGN KEY (SubcategoryID) REFERENCES Subcategory(ID);
ALTER TABLE BillHasProduct ADD CONSTRAINT FK_BillHasProduct_Bill FOREIGN KEY (BillID) REFERENCES Bill(ID);
ALTER TABLE BillHasProduct ADD CONSTRAINT FK_BillHasProduct_Product FOREIGN KEY (ProductID) REFERENCES Product(ID);
ALTER TABLE Bill ADD CONSTRAINT FK_Bill_User FOREIGN KEY (UserID) REFERENCES [User](ID);
ALTER TABLE Report ADD CONSTRAINT FK_Report_User FOREIGN KEY (UserID) REFERENCES [User](ID);
ALTER TABLE [User] ADD CONSTRAINT FK_User_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(ID);
ALTER TABLE [User] ADD CONSTRAINT FK_User_Profile FOREIGN KEY (Profile) REFERENCES Profile(ID);
ALTER TABLE Role ADD CONSTRAINT FK_Role_Profile FOREIGN KEY (ProfileID) REFERENCES Profile(ID);
ALTER TABLE Attendance ADD CONSTRAINT FK_Attendance_User FOREIGN KEY (UserID) REFERENCES [User](ID);
ALTER TABLE Inventory ADD CONSTRAINT FK_Inventory_Product FOREIGN KEY (ProductID) REFERENCES Product(ID);
ALTER TABLE Prescription ADD CONSTRAINT FK_Prescription_User FOREIGN KEY (PrescribingPhysician) REFERENCES Employee(Name);
ALTER TABLE Prescription ADD CONSTRAINT FK_Prescription_Patient FOREIGN KEY (PatientName) REFERENCES Patient(FirstName);
ALTER TABLE Payment ADD CONSTRAINT FK_Payment_Bill FOREIGN KEY (BillID) REFERENCES Bill(ID);
ALTER TABLE Refund ADD CONSTRAINT FK_Refund_Product FOREIGN KEY (ProductID) REFERENCES Product(ID);
ALTER TABLE Discount ADD CONSTRAINT FK_Discount_Bill FOREIGN KEY (BillID) REFERENCES Bill(ID);
ALTER TABLE Tax ADD CONSTRAINT FK_Tax_Bill FOREIGN KEY (BillID) REFERENCES Bill(ID);
ALTER TABLE SupplierProduct ADD CONSTRAINT FK_SupplierProduct_Product FOREIGN KEY (ProductID) REFERENCES Product(ID);
ALTER TABLE SupplierProduct ADD CONSTRAINT FK_SupplierProduct_Supplier FOREIGN KEY (SupplierID) REFERENCES Supplier(ID);

ALTER TABLE Inventory ADD CONSTRAINT CHK_Inventory_AdjustmentType CHECK (AdjustmentType IN ('Increase', 'Decrease'));
ALTER TABLE Payment ADD CONSTRAINT CHK_Payment_PaymentType CHECK (PaymentType IN ('Cash', 'Credit Card', 'Debit Card', 'Cheque'));
ALTER TABLE Discount ADD CONSTRAINT CHK_Discount_DiscountAmount CHECK (DiscountAmount >= 0.0);
ALTER TABLE Tax ADD CONSTRAINT CHK_Tax_TaxAmount CHECK (TaxAmount >= 0.0);
ALTER TABLE SupplierProduct ADD CONSTRAINT CHK_SupplierProduct_Availability CHECK (Availability IN (0,1));
