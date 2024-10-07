

CREATE TABLE [Products]
(
[ProductID] [int] IDENTITY(1,1) NOT NULL,
[ProductCategoryID] [int] NOT NULL,
[ProductName] [nvarchar](50) NOT NULL,
[ProductImageID] [int] NOT NULL,
[Description] [text] NOT NULL,
[Price] [smallmoney] NOT NULL,
CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED
(
[ProductID] ASC
)
);


CREATE TABLE [ProductCategory]
(
[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
[ProductCategoryName] [text] NOT NULL,
CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED
(
[ProductCategoryID] ASC
)
)



CREATE TABLE [ProductImages]
(
[ProductImageID] [int] IDENTITY(1,1) NOT NULL,
[ProductImage] [image] NOT NULL,
CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED
(
[ProductImageID] ASC
)
)


CREATE TABLE [Orders]
(
[OrderID] [int] IDENTITY(1,1) NOT NULL,
[TransactionID] [nvarchar](50) NOT NULL,
[EndUserID] [int] NOT NULL,
[OrderStatusID] [int] NOT NULL DEFAULT ((1)),
[OrderDate] [smalldatetime] NOT NULL DEFAULT (getdate()),
[ShipDate] [smalldatetime] NULL,
[TrackingNumber] [nvarchar](50) NULL,
CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED
(
[OrderID] ASC
)
)

CREATE TABLE [OrderDetails]
(
[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
[OrderID] [int] NOT NULL,
[ProductID] [int] NOT NULL,
[Quantity] [int] NOT NULL,
CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED
(
[OrderDetailID] ASC
)
)


CREATE TABLE [OrderStatus]
(
[OrderStatusID] [int] IDENTITY(1,1) NOT NULL,
[OrderStatusName] [nvarchar](50) NOT NULL,
CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED
(
[OrderStatusID] ASC
)
)

CREATE TABLE [EndUser]
(
[EndUserID] [int] IDENTITY(1,1) NOT NULL,
[EndUserTypeID] [int] NOT NULL,
[FirstName] [nvarchar](50) NOT NULL,
[LastName] [nvarchar](50) NOT NULL,
[AddressID] [int] NOT NULL,
[ContactInformationID] [int] NOT NULL,
[Password] [nvarchar](50) NOT NULL,
[IsSubscribed] [bit] NOT NULL,
CONSTRAINT [PK_EndUser] PRIMARY KEY CLUSTERED
(
[EndUserID] ASC
)
)



CREATE TABLE [EndUserType]
(
[EndUserTypeID] [int] IDENTITY(1,1) NOT NULL,
[TypeName] [nvarchar](50) NOT NULL,
CONSTRAINT [PK_EndUserType] PRIMARY KEY CLUSTERED
(
[EndUserTypeID] ASC
)
)



CREATE TABLE [Address]
(
[AddressID] [int] IDENTITY(1,1) NOT NULL,
[AddressLine] [nvarchar](50) NOT NULL,
[AddressLine2] [nvarchar](50) NULL,
[City] [nvarchar](50) NOT NULL,
[State] [nvarchar](50) NOT NULL,
[PostalCode] [nvarchar](50) NOT NULL,
CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED
(
[AddressID] ASC
)
)



CREATE TABLE [ContactInformation]
(
[ContactInformationID] [int] IDENTITY(1,1) NOT NULL,
[Phone] [nvarchar](50) NULL,
[Phone2] [nvarchar](50) NULL,
[Fax] [nvarchar](50) NULL,
[Email] [nvarchar](50) NOT NULL,
CONSTRAINT [PK_ContactInformation] PRIMARY KEY CLUSTERED
(
[ContactInformationID] ASC
)
)




CREATE TABLE [ShoppingCart]
(
[ShoppingCartID] [int] IDENTITY(1,1) NOT NULL,
[CartGUID] [nvarchar](50) NOT NULL,
[Quantity] [int] NOT NULL,
[ProductID] [int] NOT NULL,
[DateCreated] [smalldatetime] NOT NULL DEFAULT (getdate()),
CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED
(
[ShoppingCartID] ASC
)
)


--adding relationships

ALTER TABLE [OrderDetails] WITH CHECK ADD CONSTRAINT
[FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [Products] ([ProductID])


ALTER TABLE [OrderDetails] WITH CHECK ADD CONSTRAINT [FK_OrderDetails_Orders]
FOREIGN KEY([OrderID])
REFERENCES [Orders] ([OrderID])


ALTER TABLE [Orders] WITH CHECK ADD CONSTRAINT [FK_Orders_OrderStatus]
FOREIGN KEY([OrderStatusID])
REFERENCES [OrderStatus] ([OrderStatusID])

ALTER TABLE [EndUser] WITH CHECK ADD CONSTRAINT [FK_EndUser_Address]
FOREIGN KEY([AddressID])
REFERENCES [Address] ([AddressID])
GO

ALTER TABLE [EndUser] WITH CHECK ADD CONSTRAINT [FK_EndUser_ContactInformation]
FOREIGN KEY([ContactInformationID])
REFERENCES [ContactInformation] ([ContactInformationID])
GO

ALTER TABLE [EndUser] WITH CHECK ADD CONSTRAINT [FK_EndUser_EndUserType]
FOREIGN KEY([EndUserTypeID])
REFERENCES [EndUserType] ([EndUserTypeID])


ALTER TABLE [Products] WITH CHECK ADD CONSTRAINT [FK_Products_ProductCategory]
FOREIGN KEY([ProductCategoryID])
REFERENCES [ProductCategory] ([ProductCategoryID])
GO


ALTER TABLE [Products] WITH CHECK ADD CONSTRAINT [FK_Products_ProductImages]
FOREIGN KEY([ProductImageID])
REFERENCES [ProductImages] ([ProductImageID])



ALTER TABLE [ShoppingCart] WITH CHECK ADD CONSTRAINT [FK_ShoppingCart_Products]
FOREIGN KEY([ProductID])
REFERENCES [Products] ([ProductID])




--inserting data

INSERT INTO EndUserType (TypeName) VALUES ('Customer')
INSERT INTO EndUserType (TypeName) VALUES ('Administrator')


INSERT INTO OrderStatus (OrderStatusName) VALUES ('Pending')
INSERT INTO OrderStatus (OrderStatusName) VALUES ('Shipped')


INSERT INTO ProductCategory (ProductCategoryName) VALUES('Appetizer Wine')
INSERT INTO ProductCategory (ProductCategoryName) VALUES('White Wine')
INSERT INTO ProductCategory (ProductCategoryName) VALUES('Red Wine')
INSERT INTO ProductCategory (ProductCategoryName) VALUES('Desert Wine')
INSERT INTO ProductCategory (ProductCategoryName) VALUES('Glasses')
INSERT INTO ProductCategory (ProductCategoryName) VALUES('Accessories')
INSERT INTO ProductCategory (ProductCategoryName) VALUES('Membership')



