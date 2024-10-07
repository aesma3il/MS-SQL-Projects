
create database DBPointOfSale;
go
Use DBPointOfSale;
go

CREATE TABLE UserAccount (
  UserID INT IDENTITY(1,1) ,
  rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  Username VARCHAR(50) NOT NULL,
  UserPassword VARCHAR(50) NOT NULL,
  FullName VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  IsEnabled BIT default 0
);
--CREATE TABLE UserAccounts (
--  UserID INT PRIMARY KEY,
--  Username VARCHAR(50) NOT NULL,
--  Password VARCHAR(100) NOT NULL,
--  FullName VARCHAR(100) NOT NULL,
--  Email VARCHAR(100) NOT NULL,
--  AccountType VARCHAR(50),
--  Role VARCHAR(50),
--  Status VARCHAR(50),
--  CreationDate DATETIME,
--  LastLoginDate DATETIME,
--  LastActivityDate DATETIME,
--  IsEnabled BIT,
--  PasswordResetToken VARCHAR(100),
--  PasswordResetExpiration DATETIME,
--  ProfileImage VARCHAR(100),
--  Address VARCHAR(200),
--  Phone VARCHAR(20),
--  DateOfBirth DATE,
--  Gender VARCHAR(10),
--  Country VARCHAR(50),
--  City VARCHAR(50),
--  PostalCode VARCHAR(20),
--  SecurityQuestion VARCHAR(200),
--  SecurityAnswer VARCHAR(200),
--  SocialMediaProfiles VARCHAR(200),
--  Preferences VARCHAR(MAX),
--  LastModifiedBy INT,
--  LastModifiedDate DATETIME,
--  RegistrationIP VARCHAR(50),
--  LastLoginIP VARCHAR(50),
--  FailedLoginAttempts INT,
--  AccountLockedUntil DATETIME,
--  ActivationCode VARCHAR(100),
--  IsEmailVerified BIT,
--  IsPhoneVerified BIT,
--  LastPasswordChangeDate DATETIME,
--  IsTwoFactorEnabled BIT,
--  TwoFactorSecretKey VARCHAR(100),
--  TotalPoints INT,
--  AccountBalance DECIMAL(10, 2),
--  SubscriptionStatus VARCHAR(50),
--  SubscriptionStartDate DATETIME,
--  SubscriptionEndDate DATETIME,
--  PaymentMethod VARCHAR(50),
--  PaymentCardNumber VARCHAR(50),
--  PaymentCardExpiryDate VARCHAR(10),
--  PaymentCardCVV VARCHAR(10),
--  NewsletterSubscription BIT,
--  ReferralCode VARCHAR(50),
--  LastPurchaseDate DATETIME,
--  LastPurchaseAmount DECIMAL(10, 2),
--  LastPurchaseDescription VARCHAR(200),
--  PreferredLanguage VARCHAR(50),
--  TimeZone VARCHAR(50),
--  WebsiteURL VARCHAR(200),
--  Bio VARCHAR(MAX),
--  Education VARCHAR(100),
--  Occupation VARCHAR(100),
--  Interests VARCHAR(MAX),
--  Skills VARCHAR(MAX),
--  SocialSecurityNumber VARCHAR(20),
--  PassportNumber VARCHAR(20)
--);

--CREATE TABLE UserBasicInfo (
--  UserID INT PRIMARY KEY,
--  Username VARCHAR(50) NOT NULL,
--  Password VARCHAR(100) NOT NULL,
--  FullName VARCHAR(100) NOT NULL,
--  Email VARCHAR(100) NOT NULL
--);

--CREATE TABLE UserAccountInfo (
--  UserID INT PRIMARY KEY,
--  AccountType VARCHAR(50),
--  Role VARCHAR(50),
--  Status VARCHAR(50),
--  CreationDate DATETIME,
--  LastLoginDate DATETIME,
--  LastActivityDate DATETIME,
--  IsEnabled BIT
--);

--CREATE TABLE UserPasswordInfo (
--  UserID INT PRIMARY KEY,
--  PasswordResetToken VARCHAR(100),
--  PasswordResetExpiration DATETIME,
--  LastPasswordChangeDate DATETIME,
--  IsTwoFactorEnabled BIT,
--  TwoFactorSecretKey VARCHAR(100)
--);

--CREATE TABLE UserProfileInfo (
--  UserID INT PRIMARY KEY,
--  ProfileImage VARCHAR(100),
--  Address VARCHAR(200),
--  Phone VARCHAR(20),
--  DateOfBirth DATE,
--  Gender VARCHAR(10),
--  Country VARCHAR(50),
--  City VARCHAR(50),
--  PostalCode VARCHAR(20),
--  SecurityQuestion VARCHAR(200),
--  SecurityAnswer VARCHAR(200),
--  SocialMediaProfiles VARCHAR(200)
--);

--CREATE TABLE UserPreferencesInfo (
--  UserID INT PRIMARY KEY,
--  Preferences VARCHAR(MAX),
--  LastModifiedBy INT,
--  LastModifiedDate DATETIME
--);

--CREATE TABLE UserLoginInfo (
--  UserID INT PRIMARY KEY,
--  RegistrationIP VARCHAR(50),
--  LastLoginIP VARCHAR(50),
--  FailedLoginAttempts INT,
--  AccountLockedUntil DATETIME
--);

--CREATE TABLE UserVerificationInfo (
--  UserID INT PRIMARY KEY,
--  ActivationCode VARCHAR(100),
--  IsEmailVerified BIT,
--  IsPhoneVerified BIT
--);

--CREATE TABLE UserPointsInfo (
--  UserID INT PRIMARY KEY,
--  TotalPoints INT,
--  AccountBalance DECIMAL(10, 2)
--);

--CREATE TABLE UserSubscriptionInfo (
--  UserID INT PRIMARY KEY,
--  SubscriptionStatus VARCHAR(50),
--  SubscriptionStartDate DATETIME,
--  SubscriptionEndDate DATETIME
--);

--CREATE TABLE UserPaymentInfo (
--  UserID INT PRIMARY KEY,
--  PaymentMethod VARCHAR(50),
--  PaymentCardNumber VARCHAR(50),
--  PaymentCardExpiryDate VARCHAR(10),
--  PaymentCardCVV VARCHAR(10)
--);

--CREATE TABLE UserMarketingInfo (
--  UserID INT PRIMARY KEY,
--  NewsletterSubscription BIT,
--  ReferralCode VARCHAR(50)
--);

--CREATE TABLE UserPurchaseInfo (
--  UserID INT PRIMARY KEY,
--  LastPurchaseDate DATETIME,
--  LastPurchaseAmount DECIMAL(10, 2),
--  LastPurchaseDescription VARCHAR(200)
--);

--CREATE TABLE UserAdditionalInfo (
--  UserID INT PRIMARY KEY,
--  PreferredLanguage VARCHAR(50),
--  TimeZone VARCHAR(50),
--  WebsiteURL VARCHAR(200),
--  Bio VARCHAR(MAX)
--);

--CREATE TABLE UserEducationInfo (
--  UserID INT PRIMARY KEY,
--  Education VARCHAR(100)
--);

--CREATE TABLE UserOccupationInfo (
--  UserID INT PRIMARY KEY,
--  Occupation VARCHAR(100)
--);

--CREATE TABLE UserInterestsInfo (
--  UserID INT PRIMARY KEY,
--  Interests VARCHAR(MAX)
--);

--CREATE TABLE UserSkillsInfo (
--  UserID INT PRIMARY KEY,
--  Skills VARCHAR(MAX)
--);

--CREATE TABLE UserIdentificationInfo (
--  UserID INT PRIMARY KEY,
--  SocialSecurityNumber VARCHAR(20),
--  PassportNumber VARCHAR(20)
--);



CREATE TABLE Customer (
  CustomerID INT IDENTITY(1,1) ,
   rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Email VARCHAR(100)NULL,
  Phone VARCHAR(20) NOT NULL,
  ContactAddress VARCHAR(100) NOT NULL,
  CityID INT NOT NULL
);

CREATE TABLE Country (
  CountryID INT IDENTITY(1,1) ,
  CountryName VARCHAR(50) NOT NULL
);

CREATE TABLE City (
  CityID INT IDENTITY(1,1) ,
  CityName VARCHAR(50) NOT NULL,
  CountryID INT NOT NULL
);



CREATE TABLE Category (
  CategoryID INT IDENTITY(1,1)  ,
   rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  CreatedByUserID INT NOT NULL,
  CategoryName VARCHAR(50) NOT NULL,
  DescriptionText VARCHAR(200) NULL,
  CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Item (
  ItemID INT IDENTITY(1,1),
   rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  CategoryID INT NOT NULL,
  CreatedByUserID INT NOT NULL,
  ItemName VARCHAR(100) NOT NULL,
  DescriptionText VARCHAR(200) NULL,
  Cost DECIMAL(10, 2)NULL,
  Price DECIMAL(10, 2) NULL,
  MinimumStockLevel INT DEFAULT 10,
  IsContinued BIT DEFAULT 1,
  ImageItem VARCHAR(MAX) NULL,
  CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Invoice (
  InvoiceID INT IDENTITY(1,1),
   rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  CustomerID INT NOT NULL,
  UserID INT NOT NULL,
  InvoiceDate DATE DEFAULT GETDATE(),
  TotalAmount DECIMAL(10, 2) NULL,
  InvoiceNumber AS 'INV' + RIGHT('000000' + CAST(InvoiceId AS VARCHAR(6)), 5) PERSISTED
);

CREATE TABLE InvoiceDetail (
  InvoiceDetailID INT IDENTITY(1,1) ,
   rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  InvoiceID INT,
  ItemID INT,
  Quantity INT,
  Subtotal DECIMAL(10, 2)
);


CREATE TABLE Sales (
  SaleID INT IDENTITY(1,1)  ,
   rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  InvoiceID INT,
  ItemID INT,
  Quantity INT,
  SaleAmount DECIMAL(10, 2),

);

CREATE TABLE Payment (
  PaymentID INT IDENTITY(1,1) PRIMARY KEY,
   rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  InvoiceID INT,
  PaymentDate DATE,
  Amount DECIMAL(10, 2),
  UserID INT,
);


CREATE TABLE Transactions (
  TransactionID INT IDENTITY(1,1) PRIMARY KEY,
  rowguid UNIQUEIDENTIFIER DEFAULT NEWID() ,
  TransactionType VARCHAR(50),
  ItemID INT,
  Quantity INT,
  TransactionDate DATE,
  UserID INT
 
);


-- Constraint for UserAccount table
ALTER TABLE UserAccount
ADD CONSTRAINT PK_UserAccount PRIMARY KEY (UserID);

-- Constraint for Customer table
ALTER TABLE Customer
ADD CONSTRAINT PK_Customer PRIMARY KEY (CustomerID);

-- Constraint for Country table
ALTER TABLE Country
ADD CONSTRAINT PK_Country PRIMARY KEY (CountryID);

-- Constraint for City table
ALTER TABLE City
ADD CONSTRAINT PK_City PRIMARY KEY (CityID);

-- Constraint for Category table
ALTER TABLE Category
ADD CONSTRAINT PK_Category PRIMARY KEY (CategoryID);

-- Constraint for Item table
ALTER TABLE Item
ADD CONSTRAINT PK_Item PRIMARY KEY (ItemID);

-- Constraint for Invoice table
ALTER TABLE Invoice
ADD CONSTRAINT PK_Invoice PRIMARY KEY (InvoiceID);

-- Constraint for InvoiceDetail table
ALTER TABLE InvoiceDetail
ADD CONSTRAINT PK_InvoiceDetail PRIMARY KEY (InvoiceDetailID);

-- Constraint for Sales table
ALTER TABLE Sales
ADD CONSTRAINT PK_Sales PRIMARY KEY (SaleID);





-- Foreign key constraint for UserAccount table
ALTER TABLE UserAccount
ADD CONSTRAINT FK_UserAccount_Role FOREIGN KEY (RoleID)
REFERENCES UserRole (RoleID);

-- Foreign key constraint for City table
ALTER TABLE City
ADD CONSTRAINT FK_City_Country FOREIGN KEY (CountryID)
REFERENCES Country (CountryID);

-- Foreign key constraint for Category table
ALTER TABLE Category
ADD CONSTRAINT FK_Category_CreatedByUser FOREIGN KEY (CreatedByUserID)
REFERENCES UserAccount (UserID);

-- Foreign key constraint for Item table
ALTER TABLE Item
ADD CONSTRAINT FK_Item_Category FOREIGN KEY (CategoryID)
REFERENCES Category (CategoryID);

-- Foreign key constraint for Item table
ALTER TABLE Item
ADD CONSTRAINT FK_Item_CreatedByUser FOREIGN KEY (CreatedByUserID)
REFERENCES UserAccount (UserID);

-- Foreign key constraint for Invoice table
ALTER TABLE Invoice
ADD CONSTRAINT FK_Invoice_Customer FOREIGN KEY (CustomerID)
REFERENCES Customer (CustomerID);

-- Foreign key constraint for Invoice table
ALTER TABLE Invoice
ADD CONSTRAINT FK_Invoice_User FOREIGN KEY (UserID)
REFERENCES UserAccount (UserID);

-- Foreign key constraint for InvoiceDetail table
ALTER TABLE InvoiceDetail
ADD CONSTRAINT FK_InvoiceDetail_Invoice FOREIGN KEY (InvoiceID)
REFERENCES Invoice (InvoiceID);

-- Foreign key constraint for InvoiceDetail table
ALTER TABLE InvoiceDetail
ADD CONSTRAINT FK_InvoiceDetail_Item FOREIGN KEY (ItemID)
REFERENCES Item (ItemID);

-- Foreign key constraint for Sales table
ALTER TABLE Sales
ADD CONSTRAINT FK_Sales_Invoice FOREIGN KEY (InvoiceID)
REFERENCES Invoice (InvoiceID);

-- Foreign key constraint for Sales table
ALTER TABLE Sales
ADD CONSTRAINT FK_Sales_Item FOREIGN KEY (ItemID)
REFERENCES Item (ItemID);

-- Foreign key constraint for Payment table
ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_Invoice FOREIGN KEY (InvoiceID)
REFERENCES Invoice (InvoiceID);

-- Foreign key constraint for Payment table
ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_User FOREIGN KEY (UserID)
REFERENCES UserAccount (UserID);

-- Foreign key constraint for Transactions table
ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Item FOREIGN KEY (ItemID)
REFERENCES Item (ItemID);

-- Foreign key constraint for Transactions table
ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_User FOREIGN KEY (UserID)
REFERENCES UserAccount (UserID);

go


-- Create Operation: Insert a new record
CREATE PROCEDURE InsertUserAccount
  @Username VARCHAR(50),
  @UserPassword VARCHAR(50),
  @FullName VARCHAR(100),
  @Email VARCHAR(100)
AS
BEGIN
  INSERT INTO UserAccount (Username, UserPassword, FullName, Email)
  VALUES (@Username, @UserPassword, @FullName, @Email);
END

-- Read Operation: Retrieve a user account by UserID

-- Update Operation: Update a user account's username
CREATE PROCEDURE UpdateUserAccountUsername
  @UserID INT,
  @NewUsername VARCHAR(50)
AS
BEGIN
  UPDATE UserAccount
  SET Username = @NewUsername
  WHERE UserID = @UserID;
END

-- Delete Operation: Delete a user account by UserID
CREATE PROCEDURE DeleteUserAccount
  @UserID INT
AS
BEGIN
  DELETE FROM UserAccount
  WHERE UserID = @UserID;
END


CREATE PROCEDURE UpdateUserAccount
  @UserID INT,
  @Username VARCHAR(50),
  @UserPassword VARCHAR(50),
  @FullName VARCHAR(100),
  @Email VARCHAR(100)
AS
BEGIN
  UPDATE UserAccount
  SET Username = @Username,
      UserPassword = @UserPassword,
      FullName = @FullName,
      Email = @Email
  WHERE UserID = @UserID;
END



-- Update the UserPassword field
CREATE PROCEDURE UpdateUserPassword
  @UserID INT,
  @NewUserPassword VARCHAR(50)
AS
BEGIN
  UPDATE UserAccount
  SET UserPassword = @NewUserPassword
  WHERE UserID = @UserID;
END

-- Update the FullName field
CREATE PROCEDURE UpdateFullName
  @UserID INT,
  @NewFullName VARCHAR(100)
AS
BEGIN
  UPDATE UserAccount
  SET FullName = @NewFullName
  WHERE UserID = @UserID;
END

-- Update the Email field
CREATE PROCEDURE UpdateEmail
  @UserID INT,
  @NewEmail VARCHAR(100)
AS
BEGIN
  UPDATE UserAccount
  SET Email = @NewEmail
  WHERE UserID = @UserID;
END


CREATE PROCEDURE AuthenticateUser
  @Username VARCHAR(50),
  @UserPassword VARCHAR(50)
AS
BEGIN
  DECLARE @IsAuthenticated BIT;

  SET @IsAuthenticated = 0;

  IF EXISTS (
    SELECT UserID
    FROM UserAccount
    WHERE Username = @Username AND UserPassword = @UserPassword
  )
  BEGIN
    SET @IsAuthenticated = 1;
  END

  -- Return the authentication result
  RETURN @IsAuthenticated;
END


CREATE PROCEDURE ComparePreviousPassword
  @UserID INT,
  @InputPassword VARCHAR(50)
AS
BEGIN
  DECLARE @IsMatch BIT;

  SET @IsMatch = 0;

  DECLARE @PreviousPassword VARCHAR(50);

  -- Retrieve the previous password
  SELECT @PreviousPassword = UserPassword
  FROM UserAccount
  WHERE UserID = @UserID;

  -- Compare the previous password with the input
  IF @PreviousPassword = @InputPassword
  BEGIN
    SET @IsMatch = 1;
  END

  -- Return the result
  SELECT CAST(@IsMatch AS BIT) AS IsMatch;
END


CREATE PROCEDURE GetFullNameByUsername
  @Username VARCHAR(50),
  @FullName VARCHAR(100) OUTPUT
AS
BEGIN
  SELECT @FullName = FullName
  FROM UserAccount
  WHERE Username = @Username;
END


CREATE PROCEDURE ChangePassword
  @UserID INT,
  @NewUserPassword VARCHAR(50)
AS
BEGIN
  UPDATE UserAccount
  SET UserPassword = @NewUserPassword
  WHERE UserID = @UserID;
END


CREATE PROCEDURE CheckUsernameExistence
  @Username VARCHAR(50),
  @Exists BIT OUTPUT
AS
BEGIN
  SET @Exists = 0;

  IF EXISTS (
    SELECT 1
    FROM UserAccount
    WHERE Username = @Username
  )
  BEGIN
    SET @Exists = 1;
  END
END



CREATE PROCEDURE GetUserByUserID
  @UserID INT
AS
BEGIN
  SELECT UserID, Username, FullName, Email
  FROM UserAccount
  WHERE UserID = @UserID;
END


CREATE PROCEDURE GetAllUsers
AS
BEGIN
  SELECT UserID, Username, FullName, Email
  FROM UserAccount;
END



CREATE PROCEDURE GetTotalUserCount
AS
BEGIN
  SELECT COUNT(*) AS TotalUserCount
  FROM UserAccount;
END



CREATE PROCEDURE SearchUsers
  @SearchTerm VARCHAR(100)
AS
BEGIN
  SELECT UserID, rowguid, Username, UserPassword, FullName, Email
  FROM UserAccount
  WHERE Username+FullName+Email LIKE '%' + @SearchTerm + '%'
    
END




CREATE PROCEDURE GetUsersByDateRange
  @StartDate DATE,
  @EndDate DATE
AS
BEGIN
  SELECT UserID, Username, FullName, Email
  FROM UserAccount
  WHERE CAST(rowguid AS DATE) BETWEEN @StartDate AND @EndDate;
END


CREATE PROCEDURE GetUsersByUsernamePrefix
  @Prefix VARCHAR(50)
AS
BEGIN
  SELECT UserID, Username, FullName, Email
  FROM UserAccount
  WHERE Username LIKE @Prefix + '%';
END


CREATE PROCEDURE EnableUserAccountStatus
  @UserID INT,
  @IsEnabled BIT
AS
BEGIN
  UPDATE UserAccount
  SET IsEnabled = @IsEnabled
  WHERE UserID = @UserID;
END