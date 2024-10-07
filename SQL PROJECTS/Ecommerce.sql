CREATE DATABASE Ecommerce;

USE Ecommerce;

-- Create the table for categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    CategoryDescription VARCHAR(200) NOT NULL
);

-- Create the table for subcategories
CREATE TABLE Subcategories (
    SubcategoryID INT PRIMARY KEY,
    SubcategoryName VARCHAR(50) NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create the table for products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    ProductDescription VARCHAR(200) NOT NULL,
    ProductImage VARCHAR(100) NOT NULL,
    SubcategoryID INT NOT NULL,
    FOREIGN KEY (SubcategoryID) REFERENCES Subcategories(SubcategoryID)
);

-- Create the table for sizes
CREATE TABLE Sizes (
    SizeID INT PRIMARY KEY,
    SizeValue VARCHAR(20) NOT NULL
);

-- Create the table for colors
CREATE TABLE Colors (
    ColorID INT PRIMARY KEY,
    ColorValue VARCHAR(20) NOT NULL
);

-- Create the table for items
CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(50) NOT NULL,
    ItemDescription VARCHAR(200) NOT NULL,
    ItemPrice DECIMAL(10, 2) NOT NULL,
    ItemImage VARCHAR(100) NOT NULL,
    ProductID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the table for item sizes
CREATE TABLE ItemSizes (
    ItemID INT NOT NULL,
    SizeID INT NOT NULL,
    PRIMARY KEY (ItemID, SizeID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (SizeID) REFERENCES Sizes(SizeID)
);

-- Create the table for item colors
CREATE TABLE ItemColors (
    ItemID INT NOT NULL,
    ColorID INT NOT NULL,
    PRIMARY KEY (ItemID, ColorID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);



-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    [Address] VARCHAR(200) NOT NULL
);

-- Create the PaymentMethod table
CREATE TABLE PaymentMethod (
    PaymentMethodID INT PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL,
    Descrip VARCHAR(200) NOT NULL
);

-- Create the Order table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID)
);

-- Create the OrderItem table
CREATE TABLE OrderItem (
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    SizeID INT NOT NULL,
    ColorID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, ItemID, SizeID, ColorID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (SizeID) REFERENCES Sizes(SizeID),
    FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);

-- Create the ShoppingCart table
CREATE TABLE ShoppingCart (
    ShoppingCartID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CreationDate DATETIME NOT NULL,
    IsCheckedOut BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create the ShoppingCartItem table
CREATE TABLE ShoppingCartItem (
    ShoppingCartID INT NOT NULL,
    ItemID INT NOT NULL,
    SizeID INT NOT NULL,
    ColorID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (ShoppingCartID, ItemID, SizeID, ColorID),
    FOREIGN KEY (ShoppingCartID) REFERENCES ShoppingCart(ShoppingCartID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (SizeID) REFERENCES Sizes(SizeID),
    FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);

-- Create the ShippingMethod table
CREATE TABLE ShippingMethod (
    ShippingMethodID INT PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL,
    [Description] VARCHAR(200) NOT NULL
);

-- Create the Shipping table
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ShippingMethodID INT NOT NULL,
    [Address] VARCHAR(200) NOT NULL,
    ShippingDate DATETIME NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethod(ShippingMethodID)
);

-- Create the ShippingItem table
CREATE TABLE ShippingItem (
    ShippingID INT NOT NULL,
    ItemID INT NOT NULL,
    SizeID INT NOT NULL,
    ColorID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (ShippingID, ItemID, SizeID, ColorID),
    FOREIGN KEY (ShippingID) REFERENCES Shipping(ShippingID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (SizeID) REFERENCES Sizes(SizeID),
    FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);

-- Create the Review table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    ItemID INT NOT NULL,
    Rating INT NOT NULL,
    Comment VARCHAR(200),
    ReviewDate DATETIME NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);


CREATE TABLE Brands (
BrandID INT PRIMARY KEY,
[Name] VARCHAR(100) NOT NULL,
[Description] VARCHAR(500),
IsActive BIT NOT NULL DEFAULT 1
);


ALTER TABLE Products
add constraint fk_supplier_product foreign key(SupplierID) references Suppliers(SupplierID)

alter table products
add SupplierID int 

CREATE TABLE Suppliers (
SupplierID INT PRIMARY KEY,
[Name] VARCHAR(100) NOT NULL,
ContactName VARCHAR(100),
ContactEmail VARCHAR(100),
ContactPhone VARCHAR(20),
IsActive BIT NOT NULL DEFAULT 1
);



CREATE TABLE Inventory (
    InventoryID	int,
	ProductItemID INT,
    Quantity INT NOT NULL DEFAULT 0,
    MinQuantity INT NOT NULL DEFAULT 0,
    MaxQuantity INT NOT NULL DEFAULT 0,
    ReorderQuantity INT NOT NULL DEFAULT 0,
    LastUpdated DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Inventory PRIMARY KEY (InventoryID),
    CONSTRAINT FK_Inventory_ProductVariationID FOREIGN KEY (ProductItemID) REFERENCES Items(ItemID)
);







CREATE TABLE Countries (
    CountryId INT PRIMARY KEY,
    CountryCode VARCHAR(2) NOT NULL,
    CountryName VARCHAR(100) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE States (
    StateId INT PRIMARY KEY,
    StateCode VARCHAR(2) NOT NULL,
    StateName VARCHAR(100) NOT NULL,
    CountryId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CountryId) REFERENCES Countries(CountryId)
);

CREATE TABLE Cities (
    CityId INT PRIMARY KEY,
    CityName VARCHAR(100) NOT NULL,
    StateId INT NOT NULL,
    Latitude DECIMAL(9,6) NOT NULL,
    Longitude DECIMAL(9,6) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (StateId) REFERENCES States(StateId)
);

CREATE TABLE PostalCodes (
    PostalCodeId INT PRIMARY KEY,
    PostalCode VARCHAR(50) NOT NULL,
    CityId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CityId) REFERENCES Cities(CityId)
);

CREATE TABLE Addresses (
    AddressId INT PRIMARY KEY,
    StreetAddress VARCHAR(200) NOT NULL,
    PostalCodeId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
AddressLine varchar(100),
    FOREIGN KEY (PostalCodeId) REFERENCES PostalCodes(PostalCodeId)
);


CREATE TABLE [dbo].[Users](
    [UserId] [int] IDENTITY(1,1) NOT NULL,
    [Username] [nvarchar](50) NOT NULL,
    [Password] [nvarchar](50) NOT NULL,
    [RoleId] [int] NOT NULL
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
    (
        [UserId] ASC
    )
)



CREATE TABLE [dbo].[Roles](
    [RoleId] [int] IDENTITY(1,1) NOT NULL,
    [RoleName] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
    (
        [RoleId] ASC
    )
)


CREATE TABLE [dbo].[Permissions](
    [PermissionId] [int] IDENTITY(1,1) NOT NULL,
    [PermissionName] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
    (
        [PermissionId] ASC
    )
)

CREATE TABLE [dbo].[RolePermissions](
    [RoleId] [int] NOT NULL,
    [PermissionId] [int] NOT NULL,
    CONSTRAINT [PK_RolePermissions] PRIMARY KEY CLUSTERED 
    (
        [RoleId] ASC,
        [PermissionId] ASC
    )
)













-- Insert sample data into Categories table
INSERT INTO Categories (CategoryID, CategoryName, CategoryDescription)
VALUES (1, 'Electronics', 'Electronic gadgets and devices'),
       (2, 'Clothing', 'Fashionable clothing and accessories'),
       (3, 'Home and Garden', 'Furniture, appliances, and decor');

-- Insert sample data into Subcategories table
INSERT INTO Subcategories (SubcategoryID, SubcategoryName, CategoryID)
VALUES (1, 'Smartphones', 1),
       (2, 'T-Shirts', 2),
       (3, 'Sofas', 3);

-- Insert sample data into Products table
INSERT INTO Products (ProductID, ProductName, ProductDescription, ProductImage, SubcategoryID)
VALUES (1, 'Samsung Galaxy S21 Ultra', 'A high-performance smartphone with advanced features', 's21ultra.jpg', 1),
       (2, 'Slim-Fit T-Shirt', 'A comfortable and stylish t-shirt for everyday wear', 'slimfitshirt.jpg', 2),
       (3, '3-Seater Fabric Sofa', 'A comfortable and stylish sofa for your living room', 'sofa.jpg', 3);

-- Insert sample data into Sizes table
INSERT INTO Sizes (SizeID, SizeValue)
VALUES (1, 'Small'),
       (2, 'Medium'),
       (3, 'Large');

-- Insert sample data into Colors table
INSERT INTO Colors (ColorID, ColorValue)
VALUES (1, 'Red'),
       (2, 'Blue'),
       (3, 'Green');

-- Insert sample data into Items table
INSERT INTO Items (ItemID, ItemName, ItemDescription, ItemPrice, ItemImage, ProductID)
VALUES (1, 'Samsung Galaxy S21 Ultra', '12GB RAM, 256GB storage, 6.8-inch screen', 1299.99, 's21ultra.jpg', 1),
       (2, 'Men''s Slim-Fit T-Shirt', 'Cotton blend, crew neck, short sleeves', 19.99, 'slimfitshirt.jpg', 2),
       (3, '3-Seater Fabric Sofa', 'Gray linen fabric, hardwood frame, 86 inches long', 699.99, 'sofa.jpg', 3);

-- Insert sample data into ItemSizes table
INSERT INTO ItemSizes (ItemID, SizeID)
VALUES (2, 1),
       (2, 2),
       (2, 3),
       (3, 1),
       (3, 2),
       (3, 3);

-- Insert sample data into ItemColors table
INSERT INTO ItemColors (ItemID, ColorID)
VALUES (2, 1),
       (2, 2),
       (3, 3);