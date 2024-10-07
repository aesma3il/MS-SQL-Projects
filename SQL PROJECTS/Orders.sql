--create database Orders;
--use Orders
-- Country table
CREATE TABLE Country (
  CountryID INT PRIMARY KEY identity,
  CountryName VARCHAR(100) not  null
);


CREATE TABLE PersonType (
    TypeID INT PRIMARY KEY identity,
    TypeName VARCHAR(50) not null,
);


-- Person table
CREATE TABLE Person (
  PersonID INT PRIMARY KEY identity,
  FirstName VARCHAR(50) not null,
  LastName VARCHAR(50) not null,
  DateOfBirth DATE not null,
  Email VARCHAR(100) not null,
  Phone VARCHAR(20) not null,
  ImagePath VARCHAR(100) null,
  CountryID INT not null,
  PersonTypeID INT not null,
  FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
   FOREIGN KEY (PersonTypeID) REFERENCES PersonType(TypeID)
);
CREATE TABLE EmailMessages (
  EmailID INT PRIMARY KEY identity,
  SenderID INT not null,
  Title VARCHAR(100) not   null,
  Body VARCHAR(MAX) not null,
  SentAt DATETIME default getdate(),
  FOREIGN KEY (SenderID) REFERENCES Person(PersonID)
);

CREATE TABLE EmailParticipants (
  EmailID INT,
  ParticipantID INT,
  PRIMARY KEY (EmailID, ParticipantID),
  FOREIGN KEY (EmailID) REFERENCES EmailMessages(EmailID),
  FOREIGN KEY (ParticipantID) REFERENCES Person(PersonID)
);
-- UserAccount table
CREATE TABLE UserAccount (
  UserID INT PRIMARY KEY identity,
  PersonID INT not null unique,
  Username VARCHAR(50) not null,
  Password VARCHAR(100) not null,
  IsActive BIT default 1,
  RoleID INT,
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);


CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) NOT NULL
);

-- Permissions table
CREATE TABLE Permission (
    PermissionId INT PRIMARY KEY IDENTITY,
    PermissionName NVARCHAR(50) NOT NULL
);

-- RolePermissions table
CREATE TABLE RolePermissions (
    RoleId INT,
    PermissionId INT,
    PRIMARY KEY (RoleId, PermissionId),
    FOREIGN KEY (RoleId) REFERENCES Roles (RoleId),
    FOREIGN KEY (PermissionId) REFERENCES Permission (PermissionId)
);

alter table UserAccount
add constraint Fk_RoleID_Roles  FOREIGN KEY (RoleId) REFERENCES Roles (RoleId)

-- AccountType table
CREATE TABLE AccountType (
  AccountTypeID INT PRIMARY KEY IDENTITY,
  AccountTypeName VARCHAR(50) NOT NULL
);

-- Account table
CREATE TABLE Account (
  AccountID INT PRIMARY KEY IDENTITY,
  AccountNumber VARCHAR(20) NOT NULL,
  AccountName VARCHAR(100) NOT NULL,
  AccountTypeID INT NOT NULL,
  FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID)
);

-- Journal table
CREATE TABLE Journal (
  JournalID INT PRIMARY KEY IDENTITY,
  JournalDate DATE NOT NULL,
  Description VARCHAR(500) NULL
);

-- JournalEntry table
CREATE TABLE JournalEntry (
  JournalEntryID INT PRIMARY KEY IDENTITY,
  JournalID INT NOT NULL,
  AccountID INT NOT NULL,
  Debit DECIMAL(10, 2) NOT NULL,
  Credit DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (JournalID) REFERENCES Journal(JournalID),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);


-- Product table
CREATE TABLE Product (
  ProductID INT PRIMARY KEY identity,
  ProductCode VARCHAR(50) not null,
  ProductName VARCHAR(100) not null,
  ProductDescription VARCHAR(500) null,
  UnitPrice DECIMAL(10, 2) not null,
  Quantity INT not null
);

-- OrderStatus table
CREATE TABLE OrderStatus (
  StatusID INT PRIMARY KEY identity,
  StatusCode VARCHAR(50) not null,
  StatusName VARCHAR(100) not null
);

-- Orders table
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY identity,
  CustomerID INT not null,
  SalePerson INT not null,
  Note VARCHAR(500) null,
  OrderDate DATE default getdate(),
  TotalAmount DECIMAL(10, 2) null,
  OrderStatusID INT null,
  FOREIGN KEY (CustomerID) REFERENCES Person(PersonID),
  FOREIGN KEY (SalePerson) REFERENCES UserAccount(UserID),
  FOREIGN KEY (OrderStatusID) REFERENCES OrderStatus(StatusID)
);


-- Payment table
CREATE TABLE Payment (
  PaymentID INT PRIMARY KEY identity,
  OrderID INT not null,
  Amount DECIMAL(10, 2) not null,
  Note VARCHAR(500),
  PaymentDate DATE default getdate(),
  SalePerson INT not null,
  JournalID INT,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (SalePerson) REFERENCES UserAccount(UserID)
);

-- LineItem table
CREATE TABLE LineItem (
  LineItemID INT PRIMARY KEY identity,
  OrderID INT not null,
  ProductID INT not null,
  Quantity INT not null,
  UnitPrice DECIMAL(10, 2) not null,
  TotalAmount Decimal(10,2)
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);



select * from ErrorLog



INSERT INTO PersonType (TypeName)
VALUES ('User'),
       ('Employee'),
       ('Customer');


go
CREATE PROCEDURE spCountry_FindCountryByID
    @CountryID INT
AS
BEGIN
    SELECT *
    FROM Country
    WHERE CountryID = @CountryID;
END
go
CREATE PROCEDURE spCountry_RetrieveAllCountries
AS
BEGIN
    SELECT *
    FROM Country;
END


go

CREATE or alter  PROCEDURE sp_PersonCreatePerson
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @ImagePath VARCHAR(100),
    @CountryID INT,
    @PersonTypeID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Person (FirstName, LastName, DateOfBirth, Email, Phone, ImagePath, CountryID, PersonTypeID)
        VALUES (@FirstName, @LastName, @DateOfBirth, @Email, @Phone, @ImagePath, @CountryID, @PersonTypeID);

        -- Optionally, you can return the newly created PersonID if needed
        SELECT SCOPE_IDENTITY() AS NewPersonID;
    END TRY
    BEGIN CATCH
        -- Log the error to the ErrorLog table
        INSERT INTO ErrorLog (ErrorTime, Username, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
        VALUES (GETDATE(), SUSER_SNAME(), ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE());

        -- Rethrow the error
        THROW;
    END CATCH
END



go
CREATE PROCEDURE sp_PersonDeletePerson
    @PersonID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Person
        WHERE PersonID = @PersonID;
    END TRY
    BEGIN CATCH
        -- Log the error to the ErrorLog table
        INSERT INTO ErrorLog (ErrorTime, Username, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
        VALUES (GETDATE(), SUSER_SNAME(), ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE());

        -- Rethrow the error
        THROW;
    END CATCH
END

go

CREATE PROCEDURE sp_PersonUpdatePerson
    @PersonID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @ImagePath VARCHAR(100),
    @CountryID INT,
    @PersonTypeID INT
AS
BEGIN
    BEGIN TRY
        UPDATE Person
        SET FirstName = @FirstName,
            LastName = @LastName,
            DateOfBirth = @DateOfBirth,
            Email = @Email,
            Phone = @Phone,
            ImagePath = @ImagePath,
            CountryID = @CountryID,
            PersonTypeID = @PersonTypeID
        WHERE PersonID = @PersonID;
    END TRY
    BEGIN CATCH
        -- Log the error to the ErrorLog table
        INSERT INTO ErrorLog (ErrorTime, Username, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
        VALUES (GETDATE(), SUSER_SNAME(), ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE());

        -- Rethrow the error
        THROW;
    END CATCH
END


go


CREATE PROCEDURE ReadPersonByID
    @PersonID INT
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM Person
        WHERE PersonID = @PersonID;
    END TRY
    BEGIN CATCH
        -- Log the error to the ErrorLog table
        INSERT INTO ErrorLog (ErrorTime, Username, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
        VALUES (GETDATE(), SUSER_SNAME(), ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE());

        -- Rethrow the error
        THROW;
    END CATCH
END



CREATE PROCEDURE sp_PersonFindPersonByID
    @PersonID INT
AS
BEGIN
    BEGIN TRY
        SELECT
            p.PersonID,
            p.FirstName,
            p.LastName,
            p.DateOfBirth,
            p.Email,
            p.Phone,
            ISNULL(p.ImagePath, '') AS ImagePath,
            p.CountryID,
            p.PersonTypeID
        FROM Person p
        WHERE p.PersonID = @PersonID;
    END TRY
    BEGIN CATCH
        -- Log the error to the ErrorLog table
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        DECLARE @Username VARCHAR(100);

        -- Get the username with null handling
        SET @Username = COALESCE(SUSER_SNAME(), 'Unknown');

        -- Get the error details
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();

        -- Log the error to the ErrorLog table
        INSERT INTO ErrorLog (ErrorTime, Username, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
        VALUES (GETDATE(), @Username, ERROR_NUMBER(), @ErrorSeverity, @ErrorState, ERROR_PROCEDURE(), ERROR_LINE(), @ErrorMessage);

        -- Rethrow the error
        THROW;
    END CATCH
END