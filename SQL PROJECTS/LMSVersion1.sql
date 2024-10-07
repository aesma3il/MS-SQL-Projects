CREATE DATABASE LMSVersion1
GO
USE LMSVersion1;
GO

CREATE TABLE Staff (
   StaffId INT PRIMARY KEY,
   Username VARCHAR(50),
   [Password] VARCHAR(50),
   FirstName VARCHAR(50),
   LastName VARCHAR(50),
   Email VARCHAR(100),
   PhoneNumber VARCHAR(20)
);

CREATE TABLE [Admin] (
   AdminId INT PRIMARY KEY,
   Username VARCHAR(50),
   [Password] VARCHAR(50),
   FirstName VARCHAR(50),
   LastName VARCHAR(50),
   Email VARCHAR(100),
   PhoneNumber VARCHAR(20)
);

CREATE TABLE [Member] (
   MemberId INT PRIMARY KEY,
   Username VARCHAR(50),
   [Password] VARCHAR(50),
   FirstName VARCHAR(50),
   LastName VARCHAR(50),
   Email VARCHAR(100),
   [Address] VARCHAR(100),
   PhoneNumber VARCHAR(20)
);

CREATE TABLE Author (
   AuthorId INT PRIMARY KEY,
   FirstName VARCHAR(50),
   LastName VARCHAR(50),
   Email VARCHAR(100)
);

CREATE TABLE Publisher (
   PublisherId INT PRIMARY KEY,
   [Name] VARCHAR(100),
   [Address] VARCHAR(100),
   Email VARCHAR(100),
   PhoneNumber VARCHAR(20)
);

CREATE TABLE Genre (
   GenreId INT PRIMARY KEY,
   [Name] VARCHAR(50)
);

CREATE TABLE TransactionType (
   TypeId INT PRIMARY KEY,
   [Name] VARCHAR(50)
);

CREATE TABLE ItemStatus (
   StatusId INT PRIMARY KEY,
   [Name] VARCHAR(50)
);


CREATE TABLE Item (
   ItemId INT PRIMARY KEY,
   Title VARCHAR(100),
   AuthorId INT,
   PublisherId INT,
   PublicationDate DATE,
   GenreId INT,
   StatusId INT,
   FOREIGN KEY (AuthorId) REFERENCES Author(AuthorId),
   FOREIGN KEY (PublisherId) REFERENCES Publisher(PublisherId),
   FOREIGN KEY (GenreId) REFERENCES Genre(GenreId),
   FOREIGN KEY (StatusId) REFERENCES ItemStatus(StatusId)
);


CREATE TABLE [Transaction] (
   TransactionId INT PRIMARY KEY,
   StaffId INT,
   ItemId INT,
   MemberId INT,
   TransactionDate DATETIME DEFAULT GETDATE(),
   TransactionTypeId INT,
   ReturnedDate DateTime,
   FOREIGN KEY (StaffId) REFERENCES Staff(StaffId),
    FOREIGN KEY (MemberId) REFERENCES [Member](MemberId),
   FOREIGN KEY (ItemId) REFERENCES Item(ItemId),
   FOREIGN KEY (TransactionTypeId) REFERENCES TransactionType(TypeId)
);



CREATE TABLE Fine (
   FineId INT PRIMARY KEY,
   TransactionId INT,
   MemberId INT,
   FineDate DATETIME,
   FineAmount DECIMAL(10, 2),
   FineReason VARCHAR(100),
   FOREIGN KEY (MemberId) REFERENCES [Member](MemberId),
   FOREIGN KEY (TransactionId) REFERENCES [Transaction](TransactionId)
);

CREATE TABLE Payment (
   PaymentId INT PRIMARY KEY,
   MemberId INT,
   PaymentDate DATETIME,
   PaymentAmount DECIMAL(10, 2),
   FOREIGN KEY (MemberId) REFERENCES [Member](MemberId)
);