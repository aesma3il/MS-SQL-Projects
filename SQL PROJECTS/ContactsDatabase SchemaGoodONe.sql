----create database ContactDatabase;

--use ContactDatabase

-- Creating the ContactGroup table
CREATE TABLE ContactGroup (
    GroupID INT IDENTITY(1,1) PRIMARY KEY,
    GroupName VARCHAR(50) NOT NULL unique
);

-- Creating the EmailAddressType table
CREATE TABLE EmailAddressType (
    TypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL unique
);

-- Creating the PhoneNumberType table
CREATE TABLE PhoneNumberType (
    TypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL unique
);

-- Creating the IdentificationInfoType table
CREATE TABLE IdentificationInfoType (
    TypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL unique
);

-- Creating the AddressType table
CREATE TABLE AddressType (
    TypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);



-- Creating the Users table
CREATE TABLE Users (
    UserID INT IDENTITY(1, 1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    CreatedBy INT,
    ModifiedDate DATETIME,
    ModifiedBy INT,
    IsActive BIT,
    IsAdmin BIT
);

-- Inserting a record into the Users table
INSERT INTO Users (Username, Password, CreatedBy, IsActive, IsAdmin)
VALUES ('Abdullah', 'Abdullah', 1, 1, 1);
-- Inserting sample data into the ContactGroup table
INSERT INTO ContactGroup (GroupName)
VALUES ('Family'), ('Friends'), ('Colleagues');

-- Inserting sample data into the EmailAddressType table
INSERT INTO EmailAddressType (TypeName)
VALUES ('Personal'), ('Work'), ('Other');

-- Inserting sample data into the PhoneNumberType table
INSERT INTO PhoneNumberType (TypeName)
VALUES ('Mobile'), ('Home'), ('Work');

-- Inserting sample data into the IdentificationInfoType table
INSERT INTO IdentificationInfoType (TypeName)
VALUES ('National ID'), ('Passport'), ('Driver''s License');

-- Inserting sample data into the AddressType table
INSERT INTO AddressType (TypeName)
VALUES ('Home'), ('Office'), ('Mailing');




-- Creating the Contact table
CREATE TABLE Contacts (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,
    NamePrefix VARCHAR(10) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    NameSuffix VARCHAR(10) NOT NULL,
    NickName VARCHAR(50) NOT NULL,
    Gender VARCHAR(1) NOT NULL,
	MaritalStatus varchar(10) not null,
    DateOfBirth DATE NOT NULL,
    PlaceOfBirth VARCHAR(50) NULL,
    Company VARCHAR(50),
    Job VARCHAR(50),
	CreatedDate DATETIME DEFAULT GETDATE(),
    CreatedBy INT,
    ModifiedDate DATETIME,
    ModifiedBy INT,
    ContactGroupID INT ,
	IsActive BIT,
);

-- Creating the ContactsAddress table
CREATE TABLE ContactsAddress (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    AddressTypeID INT NOT NULL,
    ContactID INT  NOT NULL,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(20),
    Country VARCHAR(50)
);



-- Creating the ContactIdentificationInfo table
CREATE TABLE ContactIdentificationInfo (
    InfoID INT IDENTITY(1,1) PRIMARY KEY,
    ContactID INT FOREIGN KEY REFERENCES Contacts(ContactID),
    IdentificationTypeID INT FOREIGN KEY REFERENCES IdentificationInfoType(TypeID),
    IdentificationNumber VARCHAR(50) NOT NULL
);


-- Creating the ContactEmail table
CREATE TABLE ContactEmail (
    EmailID INT IDENTITY(1,1) PRIMARY KEY,
    ContactID INT FOREIGN KEY REFERENCES Contacts(ContactID),
    EmailAddress VARCHAR(100) NOT NULL,
    EmailTypeID INT FOREIGN KEY REFERENCES EmailAddressType(TypeID)
);

-- Creating the ContactPhone table
CREATE TABLE ContactPhone (
    PhoneID INT IDENTITY(1,1) PRIMARY KEY,
    ContactID INT FOREIGN KEY REFERENCES Contacts(ContactID),
    PhoneNumber VARCHAR(20) not null,
    PhoneType int
);




-- Inserting records into the Contacts table
INSERT INTO Contacts (NamePrefix, FirstName, MiddleName, LastName, NameSuffix, NickName, Gender, MaritalStatus, DateOfBirth, PlaceOfBirth, Company, Job, CreatedBy, ContactGroupID, IsActive)
VALUES ('Mr', 'John', 'A', 'Doe', 'Jr', 'Johnny', 'M', 'Single', '1990-05-15', 'New York', 'ABC Company', 'Manager', 1, 2, 1),
       ('Ms', 'Jane', 'B', 'Smith', 'Sr', 'Janie', 'F', 'Married', '1985-12-10', 'Los Angeles', 'XYZ Corporation', 'Engineer', 1, 1, 1),
       ('Dr', 'Abdullah', 'Abdo', 'Mohammed', 'Esmail', 'Ali', 'M', 'Single', '1978-09-25', 'Taiz', 'Microsoft', 'Software Engineering', 1, 3, 1);



	   -- Inserting records into the ContactsAddress table
INSERT INTO ContactsAddress (AddressTypeID, ContactID, Street, City, State, ZipCode, Country)
VALUES (1, 1, '123 Main Street', 'New York', 'NY', '10001', 'USA'),
       (2, 1, '456 Elm Street', 'Los Angeles', 'CA', '90001', 'USA');


	  -- Inserting records into the ContactIdentificationInfo table
INSERT INTO ContactIdentificationInfo (ContactID, IdentificationTypeID, IdentificationNumber)
VALUES (1, 1, '1234567890'),
       (1, 2, 'ABC123XYZ');


	   select * from 
	   AddressType








































