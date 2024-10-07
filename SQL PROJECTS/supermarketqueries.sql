INSERT INTO tbl_Customers (CustomerID, FirstName, LastName, Email, Phone, Address1, City, ZipCode, Country)
VALUES 
  (111, 'John', 'Doe', 'john.Fdoe@example.com', '1232-456-7890', '123 Main St', 'Anytown', '12345', 'USA'),
  (112, 'Jane', 'Doe', 'jane.doDe@example.com', '9872-654-3210', '456 Maple Ave', 'Otherville', '54321', 'USA'),
  (113, 'Alice', 'Smith', 'asmiFth@example.com', '5552-1231-4567', '789 Oak St', 'Smalltown', '67890', 'USA'),
  (114, 'Bob', 'Johnson', 'bjohnSson@example.com', '5515-987-6543', '321 Elm St', 'Bigcity', '45678', 'YEMEN'),
  (15, 'Samantha', 'Jones', 'sjoFnes@example.com', '5515-1555-5555', '555 Pine St', 'Midtown', '23456', 'UAE'),
  (116, 'David', 'Lee', 'dlee@exSample.com', '555-111-22242', '111 Oak St', 'Downtown', '34567', 'USA'),
  (117, 'Rachel', 'Garcia', 'rgaFSrcia@example.com', '565-333-4444', '777 Elm St', 'Uptown', '56789', 'USA'),
  (118, 'Michael', 'Lee', 'mlee@FSexample.com', '555-4484-5555', '555 Maple Ave', 'Suburbia', '67890', 'USA'),
  (119, 'Emily', 'Chen', 'echen@FSexample.com', '555-777-89888', '999 Pine St', 'Outskirts', '78901', 'USA'),
  (210, 'William', 'Wang', 'wwangFS@example.com', '555-2022-3333', '222 Oak St', 'Faraway', '89012', 'US');


  INSERT INTO Categories (CategoryID, CategoryName)
VALUES 
  (11, 'Electronics'),
  (12, 'Books'),
  (13, 'Clothing'),
  (14, 'Home goods'),
  (15, 'Toys'),
  (16, 'Sports equipment'),
  (17, 'Beauty and personal care'),
  (18, 'Food and beverage'),
  (19, 'Automotive'),
  (110, 'Office supplies');


  SELECT * FROM Categories
  SELECT * FROM Products
  SELECT * FROM tbl_Customers
  SELECT* FROM tbl_Orders
  SELECT* FROM OrderDetails

  INSERT INTO OrderDetails VALUES(1,22,3,100),
  (2,22,3,1090),
  (2,1,3,1070),
  (2,111,7,1400),
  (2,116,8,1200),
  (2,202,9,100),
  (2,222,2,1000)

  ALTER TABLE orderDetails
  drop constraint PK_OrderDetails

  SELECT c.CategoryName, SUM(od.Quantity * od.PricePerUnit) AS TotalRevenue
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName;

  INSERT INTO Products (ProductID, ProductName, Price, CategoryID, QuantityInStock)
VALUES 
  (1191, 'Smartphone', 599.99, 11, 100),
  (211, 'Laptop', 999.99, 11, 50),
  (3811, 'Tablet', 399.99, 11, 75),
  (4181, 'Book ROMANCE', 19.99, 12, 250),
  (1615, 'E-reader', 149.99, 2, 100),
  (116, 'T-shirt', 24.99, 13, 500),
  (11537, 'Jeans', 49.99, 13, 250),
  (118, 'Sweater', 59.99, 13, 200),
  (119, 'Pillow', 29.99, 4, 1000),
  (1110, 'Candle', 9.99, 4, 500),
  (111, 'Action figure', 14.99, 5, 100),
  (15352, 'Puzzle', 19.99, 5, 200),
  (1334, 'Basketball', 29.99, 14, 50),
  (1144, 'Soccer ball', 24.99, 17, 75),
  (13533, 'Exercise bike', 499.99, 16, 10),
  (144336, 'Shampoo', 9.99, 16, 500),
  (1647, 'Toothpaste', 4.99, 18, 750),
  (1758, 'Chocolate', 3.99, 18, 1000),
  (17579, 'Coffee', 12.99, 18, 500),
  (2460, 'Car wax', 19.99, 19, 100);

  SELECT
   c.FirstName,
   c.LastName,
   SUM(od.Quantity) AS TotalQuantity,
   SUM(od.Quantity * od.PricePerUnit) AS TotalRevenue
FROM
   tbl_Customers c
   JOIN tbl_Orders o ON c.CustomerID = o.CustomerID
   JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY
   c.FirstName,
   c.LastName
HAVING
   SUM(od.Quantity * od.PricePerUnit) > 1


   SELECT
   c.CategoryName,
   SUM(od.Quantity * od.PricePerUnit) AS TotalRevenue
FROM
   Categories c
   JOIN Products p ON c.CategoryID = p.CategoryID
   JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY
   c.CategoryName
ORDER BY
   TotalRevenue DESC;


   SELECT
   c.FirstName,
   c.LastName,
   MAX(o.OrderDate) AS LastOrderDate
FROM
   tbl_Customers c
   LEFT JOIN tbl_Orders o ON c.CustomerID = o.CustomerID
GROUP BY
   c.FirstName,
   c.LastName
HAVING
   MAX(o.OrderDate) >1;


   SELECT COUNT(DISTINCT CustomerID)
FROM tbl_Orders;

SELECT SUM(Quantity * PricePerUnit)
FROM OrderDetails
WHERE ProductID = 1;


SELECT *
FROM tbl_Orders o
WHERE OrderDate = (
   SELECT MAX(OrderDate)
   FROM tbl_Orders
   WHERE CustomerID = o.CustomerID
);


SELECT c.CustomerID, c.FirstName, c.LastName, SUM(od.Quantity * od.PricePerUnit) AS TotalSpent
FROM tbl_Customers c
JOIN tbl_Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID,c.FirstName, c.LastName
ORDER BY TotalSpent DESC





SELECT   CategoryID, COUNT(CategoryID) as Numberofproduct
FROM Products
group by CategoryID


SELECT   CategoryID
FROM Categories
intersect
SELECT   CategoryID
FROM products



SELECT   CategoryID
FROM Categories


SELECT   CategoryID
FROM products



