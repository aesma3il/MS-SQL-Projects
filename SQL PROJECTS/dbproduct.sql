--CREATE TABLE Category(
--CategoryID int PRIMARY KEY IDENTITY(1,2) ,
--CategoryName NVARCHAR(20) NOT NULL
--);

--CREATE TABLE Product(
--ProductID int identity(1,1) primary key,
--ProductCategoryID int not null,
--ProductName nvarchar(20) not null,
--Quantity	int ,
--Price		nvarchar(11),
--Picture		image ,

--constraint FK_Cateogry_Product foreign key(ProductCategoryID) References Category(CategoryID)
--on delete cascade on update cascade

--);


--create table Customer(
--	CustomerID int primary key identity(1,1),
--	FirstName nvarchar(20) not null,
--	LastName  nvarchar(20) null,
--	Telephone nvarchar(20) null,
--	Email  nvarchar(20),
--	Picture Varchar(Max)
--);

--create table Orders(
--	OrderID int identity(1,2) primary key,
--	CustomerID int not null,
--	OrderDate Datetime not null,
--	constraint fk_orders_customer foreign key(CustomerID) 
--	references Customer(CustomerID)
--);


--create table OrderDetails(
--OrderID int not null,
--ProductID int not null,
--constraint fk_productdetail_product foreign key(ProductID)
--references Product(ProductID) on delete cascade on update cascade,
--constraint fk_order_orderDetail foreign key(OrderID) references Orders(OrderID)
--on delete cascade on update cascade

--);


--create table Users(
--UserID int identity(1,1) primary key,
--FullName nvarchar(30) not null,
--Email nvarchar(20) ,
--Username nvarchar(20) not null,
--Pass nvarchar(20) not null
--);




--INSERT INTO Category (CategoryName) VALUES ('Electronics');
--INSERT INTO Category (CategoryName) VALUES ('Clothing');
--INSERT INTO Category (CategoryName) VALUES ('Home and Garden');

--INSERT INTO Product (ProductCategoryID, ProductName, Quantity, Price, Picture) VALUES (1, 'iPhone X', 10, '1000', 'image1.jpg');
--INSERT INTO Product (ProductCategoryID, ProductName, Quantity, Price, Picture) VALUES (1, 'Samsung Galaxy S9', 15, '800', 'image2.jpg');
--INSERT INTO Product (ProductCategoryID, ProductName, Quantity, Price, Picture) VALUES (2, 'Levi Jeans', 20, '50', 'image3.jpg');
--INSERT INTO Product (ProductCategoryID, ProductName, Quantity, Price, Picture) VALUES (2, 'Nike Hoodie', 30, '75', 'image4.jpg');
--INSERT INTO Product (ProductCategoryID, ProductName, Quantity, Price, Picture) VALUES (3, 'KitchenAid Mixer', 5, '300', 'image5.jpg');
--INSERT INTO Product (ProductCategoryID, ProductName, Quantity, Price, Picture) VALUES (3, 'Dyson Vacuum', 8, '400', 'image6.jpg');

--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('John', 'Smith', '555-1234', 'john.smith@gmail.com', 'image7.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Jane', 'Doe', '555-5678', 'jane.doe@gmail.com', 'image8.jpg');

--INSERT INTO Orders (CustomerID, OrderDate) VALUES (1, '2021-01-01');
--INSERT INTO Orders (CustomerID, OrderDate) VALUES (2, '2021-02-02');

--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (1, 1);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (1, 2);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (2, 3);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (2, 4);

--INSERT INTO Users (FullName, Email, Username, Pass) VALUES ('Admin User', 'admin@example.com', 'admin', 'password');
--INSERT INTO Users (FullName, Email, Username, Pass) VALUES ('Regular User', 'user@example.com', 'user', 'password');

--INSERT INTO Users (FullName, Email, Username, Pass) VALUES ('Abdullah ', 'abdullah@gmail.com', 'admin', 'abood');
--INSERT INTO Users (FullName, Email, Username, Pass) VALUES ('ghadeer ', 'ghadeer@gmail.com', 'admin', 'ghadeer');
--INSERT INTO Users (FullName, Email, Username, Pass) VALUES ('ali ', 'ali@gmail.com', 'user', 'ali');
--INSERT INTO Users (FullName, Email, Username, Pass) VALUES ('saif ', 'saif@gmail.com', 'subscriber', 'saif');
--INSERT INTO Users (FullName, Email, Username, Pass) VALUES ('hacker ', 'hacker@gmail.com', 'user', 'hack');

--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('John', 'Smith', '555-1234', 'john.smith@g.com', 'image1.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Jane', 'Doe', '555-5678', 'jane.doe@g.com', 'image2.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Bob', 'Johnson', '555-9101', 'bob.g@gmail.com', 'image3.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Sara', 'Lee', '555-1212', 'sara.lee@g.com', 'image4.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Mike', 'Brown', '555-3434', 'mike.brown@gl.com', 'image5.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Emily', 'Davis', '555-8787', 'emily.davis@gmgm', 'image6.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('David', 'Jones', '555-5555', 'david.jones@gmailg', 'image7.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Sarah', 'Taylor', '555-2222', 'sarah.taylor@gmail.com', 'image8.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Tom', 'Wilson', '555-9999', 'tom.wilson@gmail.com', 'image9.jpg');
--INSERT INTO Customer (FirstName, LastName, Telephone, Email, Picture) VALUES ('Linda', 'Anderson', '555-7777', 'linda.anderson@gmail.com', 'image10.jpg');

--INSERT INTO Orders (CustomerID, OrderDate) VALUES (1, '2021-01-01');
--INSERT INTO Orders (CustomerID, OrderDate) VALUES (2, '2021-02-02');
--INSERT INTO Orders (CustomerID, OrderDate) VALUES (3, '2021-03-03');
--INSERT INTO Orders (CustomerID, OrderDate) VALUES (4, '2021-04-04');
--INSERT INTO Orders (CustomerID, OrderDate) VALUES (6, '2021-05-05');

--INSERT INTO Category (CategoryName) VALUES ('Automotive');
--INSERT INTO Category (CategoryName) VALUES ('Books');
--INSERT INTO Category (CategoryName) VALUES ('Music');
--INSERT INTO Category (CategoryName) VALUES ('Movies and TV Shows');

--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (1, 1);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (3, 2);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (3, 5);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (5, 6);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (5, 2);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (7, 5);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (11, 1);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (13, 6);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (1, 2);
--INSERT INTO OrderDetails (OrderID, ProductID) VALUES (9, 2);


--select * from Category
--select * from Orders
--select * from Customer
--select * from Product
--select * from OrderDetails


--create view showCat
--as
--select * from Category

--create Proc DeleteCategory
--@ID int
--AS
--BEGIN
--DELETE FROM Customer
--where CustomerID = @ID
--END

--Exec DeleteCategory @ID = 11
--select *
--from Product 
--inner join Category on Product.ProductCategoryID = Category.CategoryID



--create proc searchByID
--@ID int
--as
--select * from Category
--where CategoryID like ' %' + @ID + '%';




SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customer AS c
LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY OrderCount DESC;


