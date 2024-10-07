CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    AddressLine1 NVARCHAR(100) NOT NULL,
    AddressLine2 NVARCHAR(100),
    City NVARCHAR(50) NOT NULL,
    [State] NVARCHAR(50) NOT NULL,
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
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BillingAddressID) REFERENCES Addresses(AddressID),
    FOREIGN KEY (ShippingAddressID) REFERENCES Addresses(AddressID)
);


CREATE TABLE InvoiceItems (
    InvoiceID INT NOT NULL,
    ProductID INT PRIMARY KEY,
    QuantitySold INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
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


INSERT INTO Addresses (AddressID, AddressLine1, AddressLine2, City, State, ZipCode) 
VALUES 
(1, '123 Main St', '', 'Anytown', 'CA', '12345'),
(2, '456 Oak Ave', 'Suite 100', 'Sometown', 'NY', '67890'),
(3, '789 Maple Dr', '', 'Othertown', 'TX', '54321'),
(4, '555 Pine St', '', 'Cityville', 'CA', '98765'),
(5, '999 Elm St', 'Apt 101', 'Smalltown', 'TX', '12345');

INSERT INTO Customers (CustomerID, CustomerName, AddressID)
VALUES 
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Bob Johnson', 3),
(4, 'Alice Lee', 4),
(5, 'Mike Brown', 5);

INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES 
(1, 'Widget A', 'This is a widget', 9.99),
(2, 'Widget B', 'This is another widget', 19.99),
(3, 'Widget C', 'This is a third widget', 29.99),
(4, 'Gizmo X', 'This is a gizmo', 49.99);

INSERT INTO Invoices (InvoiceID, InvoiceDate, CustomerID, BillingAddressID, ShippingAddressID)
VALUES 
(1, '2023-06-01', 1, 1, 1),
(2, '2023-06-15', 2, 2, 2),
(3, '2023-06-30', 3, 3, NULL);

INSERT INTO InvoiceItems (InvoiceID, ProductID, QuantitySold, Price)
VALUES 
(1, 1, 2, 19.98),
(1, 2, 1, 19.99),
(2, 3, 3, 89.97),
(3, 4, 1, 49.99);

INSERT INTO PaymentMethods (PaymentMethodID, PaymentMethodName)
VALUES 
(1, 'Credit Card'),
(2, 'PayPal');

INSERT INTO Payments (PaymentID, PaymentAmount, PaymentDate, InvoiceID, PaymentMethodID)
VALUES 
(1, 39.97, '2023-06-01', 1, 1),
(2, 89.97, '2023-06-15', 2, 2),
(3, 49.99, '2023-07-01', 3, 1);

INSERT INTO PaymentStatus (PaymentStatusID, PaymentStatusName)
VALUES 
(1, 'Pending'),
(2, 'Complete');

INSERT INTO InvoicePayments (InvoiceID, PaymentID, PaymentStatusID)
VALUES 
(1, 1, 2),
(2, 2, 2),
(3, 3, 1);