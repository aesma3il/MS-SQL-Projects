CREATE TABLE Brand(
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName VARCHAR(50) NOT NULL
);

CREATE TABLE Category(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    CategoryImage VARCHAR(200) NOT NULL
);

CREATE TABLE Product(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    ProductDescription VARCHAR(200) NOT NULL,
    CategoryID INT NOT NULL,
    BrandID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);

CREATE TABLE Variant(
    VariantID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    VariantName VARCHAR(100) NOT NULL,
    Sku VARCHAR(10) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Warehouse(
    WarehouseID INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseName VARCHAR(50) NOT NULL,
    WarehouseAddress VARCHAR(50) NOT NULL
);

CREATE TABLE InventoryItems(
    InventoryItemsID INT IDENTITY(1,1) PRIMARY KEY,
    VariantID INT NOT NULL,
    WarehouseID INT NOT NULL,
    Quantity INT NOT NULL CHECK(Quantity > 0),
    FOREIGN KEY (VariantID) REFERENCES Variant(VariantID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);




CREATE TABLE Customer(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    EmailAddress VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);



CREATE TABLE PaymentMethod(
    PaymentMethodID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethodName VARCHAR(50) NOT NULL
);

CREATE TABLE PaymentStatus(
    PaymentStatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName VARCHAR(30) NOT NULL
);

CREATE TABLE Payment(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentStatusID INT,
    PaymentMethodID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PaymentStatusID) REFERENCES PaymentStatus(PaymentStatusID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID)
);


CREATE TABLE OrderStatus(
    OrderStatusID INT IDENTITY(1,1) PRIMARY KEY,
    OrderStatusName VARCHAR(20) NOT NULL
);

CREATE TABLE Orders(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    StatusID INT,
    TotalPrice DECIMAL(10,2) NOT NULL,
    PaymentID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StatusID) REFERENCES OrderStatus(OrderStatusID),
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);

CREATE TABLE OrderItem(
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    VariantID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (VariantID) REFERENCES Variant(VariantID)
);






 
CREATE TABLE ShippingMethod(
    ShippingMethodID INT IDENTITY(1,1) PRIMARY KEY,
    ShippingMethodName VARCHAR(50) NOT NULL,
    ShippingCost DECIMAL(10,2) NOT NULL
);

CREATE TABLE ShippingStatus(
    ShippingStatusID INT IDENTITY(1,1) PRIMARY KEY,
    ShippingStatusName VARCHAR(30) NOT NULL,
    Description VARCHAR(200) NOT NULL
);

CREATE TABLE ShippingDetails(
    ShippingDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ShippingMethodID INT,
    TrackingNumber VARCHAR(50) NOT NULL,
    ShippingAddress VARCHAR(100) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethod(ShippingMethodID)
);



CREATE TABLE ReturnStatus(
    ReturnStatusID INT IDENTITY(1,1) PRIMARY KEY,
    ReturnStatusName VARCHAR(30) NOT NULL,
    Description VARCHAR(200) NOT NULL
);

