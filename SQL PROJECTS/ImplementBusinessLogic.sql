CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    QuantityAvailable INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



CREATE PROCEDURE AddToCart
    @CustomerID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    -- Validate customer and product
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR('Invalid CustomerID.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        RAISERROR('Invalid ProductID.', 16, 1);
        RETURN;
    END

    -- Check product availability
    IF @Quantity > (SELECT QuantityAvailable FROM Products WHERE ProductID = @ProductID)
    BEGIN
        RAISERROR('Insufficient quantity available.', 16, 1);
        RETURN;
    END

    -- Add the product to the cart
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
    VALUES (@CustomerID, @ProductID, @Quantity);
END;


go

CREATE PROCEDURE PlaceOrder
    @CustomerID INT
AS
BEGIN
    -- Retrieve the cart items
    DECLARE @CartItems TABLE (
        ProductID INT,
        Quantity INT
    );

    INSERT INTO @CartItems (ProductID, Quantity)
    SELECT ProductID, Quantity
    FROM OrderDetails
    WHERE OrderID = @CustomerID;

    -- Calculate the total amount
    DECLARE @TotalAmount DECIMAL(10, 2);
    SET @TotalAmount = (
        SELECT SUM(Quantity * Price)
        FROM Products
        WHERE ProductID IN (SELECT ProductID FROM @CartItems)
    );

    -- Create an order record
    INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
    VALUES ((SELECT MAX(OrderID) + 1 FROM Orders), @CustomerID, GETDATE(), @TotalAmount);

    -- Update product quantities
    UPDATE Products
    SET QuantityAvailable = QuantityAvailable - (SELECT Quantity FROM @CartItems WHERE ProductID = Products.ProductID)
    WHERE ProductID IN (SELECT ProductID FROM @CartItems);

    -- Clear the cart
    DELETE FROM OrderDetails WHERE OrderID = @CustomerID;
END;

go

CREATE PROCEDURE ViewOrderHistory
    @CustomerID INT
AS
BEGIN
    SELECT
        o.OrderDate,
        o.TotalAmount,
        p.ProductName,
        od.Quantity
    FROM Orders o
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    INNER JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.CustomerID = @CustomerID;
END;

go
CREATE TRIGGER UpdateProductQuantities
ON Orders
AFTER INSERT
AS
BEGIN
    UPDATE Products
    SET QuantityAvailable = QuantityAvailable - (
        SELECT Quantity
        FROM inserted i
        INNER JOIN OrderDetails od ON i.OrderID = od.OrderID
        WHERE od.ProductID = Products.ProductID
    )
    WHERE ProductID IN (
        SELECT ProductID
        FROM inserted i
        INNER JOIN OrderDetails od ON i.OrderID = od.OrderID
        WHERE od.ProductID = Products.ProductID
    );
END;



go 