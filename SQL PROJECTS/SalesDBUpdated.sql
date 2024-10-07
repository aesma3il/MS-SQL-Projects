
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    AddressLine1 NVARCHAR(100) NOT NULL,
    AddressLine2 NVARCHAR(100),
    City NVARCHAR(50) NOT NULL,
   [ State] NVARCHAR(50) NOT NULL,
    ZipCode NVARCHAR(10) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(50) NOT NULL,
    AddressID INT NOT NULL,
    FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    InvoiceDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    BillingAddressID INT NOT NULL,
    ShippingAddressID INT,
    InvoiceStatus NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BillingAddressID) REFERENCES Addresses(AddressID),
    FOREIGN KEY (ShippingAddressID) REFERENCES Addresses(AddressID)
);

CREATE TABLE InvoiceItems (
    InvoiceID INT NOT NULL,
    ProductID INT NOT NULL,
    QuantitySold INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (InvoiceID, ProductID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY,
    PaymentMethodName NVARCHAR(50) NOT NULL
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    PaymentAmount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    InvoiceID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
);

CREATE TABLE PaymentStatus (
    PaymentStatusID INT PRIMARY KEY,
    PaymentStatusName NVARCHAR(50) NOT NULL
);

CREATE TABLE InvoicePayments (
    InvoiceID INT NOT NULL,
    PaymentID INT NOT NULL,
    PaymentStatusID INT NOT NULL,
    CONSTRAINT PK_InvoicePayments PRIMARY KEY (InvoiceID, PaymentID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),
    FOREIGN KEY (PaymentStatusID) REFERENCES PaymentStatus(PaymentStatusID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    OrderStatus NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE ShippingMethods (
    ShippingMethodID INT PRIMARY KEY,
    ShippingMethodName NVARCHAR(50) NOT NULL
);

CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY,
    ShipmentDate DATE NOT NULL,
    ShippingMethodID INT NOT NULL,
    TrackingNumber NVARCHAR(50) NOT NULL,
    InvoiceID INT,
    OrderID INT,
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethods(ShippingMethodID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE ShipmentItems (
    ShipmentID INT NOT NULL,
    ProductID INT NOT NULL,
    QuantityShipped INT NOT NULL,
    PRIMARY KEY (ShipmentID, ProductID),
    FOREIGN KEY (ShipmentID) REFERENCES Shipments(ShipmentID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE TaxRates (
    TaxRateID INT PRIMARY KEY,
    TaxRateName NVARCHAR(50) NOT NULL,
    [State] NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Rate DECIMAL(10,2) NOT NULL
);

CREATE TABLE TaxCodes (
    TaxCodeID INT PRIMARY KEY,
    TaxCodeName NVARCHAR(50) NOT NULL,
    TaxRateID INT NOT NULL,
    FOREIGN KEY (TaxRateID) REFERENCES TaxRates(TaxRateID)
);


-- Insert sample data into the Addresses table
INSERT INTO Addresses (AddressID, AddressLine1, AddressLine2, City, State, ZipCode)
VALUES 
    (1, '123 Main St', NULL, 'Anytown', 'CA', '12345'),
    (2, '456 1st Ave', NULL, 'Otherville', 'NY', '67890'),
    (3, '789 Elm St', NULL, 'Smallville', 'TX', '54321');

-- Insert sample data into the Customers table
INSERT INTO Customers (CustomerID, CustomerName, AddressID)
VALUES 
    (1, 'John Doe', 1),
    (2, 'Jane Smith', 2),
    (3, 'Bob Johnson', 3);

-- Insert sample data into the Products table
INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES 
    (1, 'Product A', 'This is product A', 10.00),
    (2, 'Product B', 'This is product B', 20.00),
    (3, 'Product C', 'This is product C', 30.00);

-- Insert sample data into the Invoices table
INSERT INTO Invoices (InvoiceID, InvoiceDate, CustomerID, BillingAddressID, ShippingAddressID, InvoiceStatus)
VALUES 
    (1, '2022-01-01', 1, 1, 1, 'Paid'),
    (2, '2022-02-01', 2, 2, 2, 'Pending'),
    (3, '2022-03-01', 3, 3, NULL, 'Pending');

-- Insert sample data into the InvoiceItems table
INSERT INTO InvoiceItems (InvoiceID, ProductID, QuantitySold, Price)
VALUES 
    (1, 1, 2, 10.00),
    (1, 2, 3, 20.00),
    (2, 3, 4, 30.00),
    (3, 1, 1, 10.00),
    (3, 3, 2, 30.00);

-- Insert sample data into the PaymentMethods table
INSERT INTO PaymentMethods (PaymentMethodID, PaymentMethodName)
VALUES 
    (1, 'Credit Card'),
    (2, 'PayPal'),
    (3, 'Wire Transfer');

-- Insert sample data into the Payments table
INSERT INTO Payments (PaymentID, PaymentAmount, PaymentDate, InvoiceID, PaymentMethodID)
VALUES 
    (1, 20.00, '2022-01-01', 1, 1),
    (2, 40.00, '2022-02-01', 2, 2),
    (3, 10.00, '2022-03-01', 3, 3);

-- Insert sample data into the PaymentStatus table
INSERT INTO PaymentStatus (PaymentStatusID, PaymentStatusName)
VALUES 
    (1, 'Pending'),
    (2, 'Processed'),
    (3, 'Cancelled');

-- Insert sample data into the InvoicePayments table
INSERT INTO InvoicePayments (InvoiceID, PaymentID, PaymentStatusID)
VALUES 
    (1, 1, 2),
    (2, 2, 1),
    (3, 3, 3);

-- Insert sample data into the Orders table
INSERT INTO Orders (OrderID, OrderDate, CustomerID, OrderStatus)
VALUES 
    (1, '2022-01-01', 1, 'Shipped'),
    (2, '2022-02-01', 2, 'Pending'),
    (3, '2022-03-01', 3, 'Pending');

-- Insert sample data into the ShippingMethods table
INSERT INTO ShippingMethods (ShippingMethodID, ShippingMethodName)
VALUES 
    (1, 'Standard'),
    (2, 'Express'),
    (3, 'Overnight');

-- Insert sample data into the Shipments table
INSERT INTO Shipments (ShipmentID, ShipmentDate, ShippingMethodID, TrackingNumber, InvoiceID, OrderID)
VALUES 
    (1, '2022-01-02', 1, '123456789', 1, 1),
    (2, '2022-01-03', 2, '234567890', NULL, 1),
    (3, '2022-02-02', 1, '345678901', 2, 2),
    (4, '2022-03-02', 3, '456789012', NULL, 3);

-- Insert sample data into the ShipmentItems table
INSERT INTO ShipmentItems (ShipmentID, ProductID, QuantityShipped)
VALUES 
    (1,1, 2),
    (1, 2, 3),
    (2, 2, 1),
    (2, 3, 2),
    (3, 3, 4),
    (4, 1, 1),
    (4, 3, 2);

-- Insert sample data into the TaxRates table
INSERT INTO TaxRates (TaxRateID, TaxRateName, State, Country, Rate)
VALUES 
    (1, 'State Sales Tax', 'CA', 'USA', 0.075),
    (2, 'State Sales Tax', 'NY', 'USA', 0.04),
    (3, 'State Sales Tax', 'TX', 'USA', 0.0625);

-- Insert sample data into the TaxCodes table
INSERT INTO TaxCodes (TaxCodeID, TaxCodeName, TaxRateID)
VALUES 
    (1, 'Taxable', 1),
    (2, 'Taxable', 2),
    (3, 'Taxable', 3);