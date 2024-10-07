CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(50)
);

CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    WarehouseName NVARCHAR(50)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(50)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50)
);

CREATE TABLE Shipment (
    SupplierID INT,
    WarehouseID INT,
    CustomerID INT,
    ProductID INT,
    ShipmentDate DATE,
    ShipmentQuantity INT,
    CONSTRAINT PK_Shipment PRIMARY KEY (SupplierID, WarehouseID, CustomerID, ProductID),
    CONSTRAINT FK_Shipment_Supplier FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID),
    CONSTRAINT FK_Shipment_Warehouse FOREIGN KEY (WarehouseID) REFERENCES Warehouse (WarehouseID),
    CONSTRAINT FK_Shipment_Customer FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
    CONSTRAINT FK_Shipment_Product FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);


INSERT INTO Supplier (SupplierID, SupplierName) VALUES
(1, 'Supplier A'),
(2, 'Supplier B'),
(3, 'Supplier C');

INSERT INTO Warehouse (WarehouseID, WarehouseName) VALUES
(1, 'Warehouse X'),
(2, 'Warehouse Y'),
(3, 'Warehouse Z');

INSERT INTO Customer (CustomerID, CustomerName) VALUES
(1, 'Customer 1'),
(2, 'Customer 2'),
(3, 'Customer 3');

INSERT INTO Product (ProductID, ProductName) VALUES
(1, 'Product A'),
(2, 'Product B'),
(3, 'Product C');

INSERT INTO Shipment (SupplierID, WarehouseID, CustomerID, ProductID, ShipmentDate, ShipmentQuantity) VALUES
(1, 1, 1, 1, '2022-01-01', 100),
(1, 1, 1, 2, '2022-01-01', 50),
(1, 2, 2, 3, '2022-01-05', 200),
(2, 2, 3, 1, '2022-01-10', 75),
(2, 3, 1, 2, '2022-01-15', 150),
(3, 3, 2, 3, '2022-01-20', 100),
(3, 1, 3, 1, '2022-01-25', 50);