CREATE DATABASE DrivinLicenseManagement
GO
use DrivinLicenseManagement;
GO
CREATE TABLE Manufacturer(
MfgId INT  ,
MfgName Nvarchar(100) not null,
CONSTRAINT PK_Manufacturer_MfgId PRIMARY KEY(MfgId)
);

CREATE TABLE MfgModel(
MfgModelId INT  ,
MfgModelName Nvarchar(100) not null,
MfgId INT,
CONSTRAINT PK_MfgId_MfgModel PRIMARY KEY(MfgModelId),
CONSTRAINT FK_MfgId_MfgModel_Manufacturer FOREIGN KEY(MfgId) REFERENCES Manufacturer(MfgId)
);

CREATE TABLE SubModel(
SubModelId INT  ,
SubModelName Nvarchar(100) not null,
ModelId INT,
CONSTRAINT PK_SubModelId_SubModel PRIMARY KEY(SubModelId),
CONSTRAINT FK_ModelId_SubModel_MfgModel FOREIGN KEY(ModelId) REFERENCES MfgModel(MfgModelId)
);

CREATE TABLE DriveType(
DriveTypeId INT,
DriveTypeName NVarchar(100) not null,
CONSTRAINT PK_DriveTypeId_DriveType PRIMARY KEY(DriveTypeId)

);

CREATE TABLE FuelType(
FuelTypeId INT,
FuelTypeName NVARCHAR(100) NOT NULL,
CONSTRAINT PK_FuelTypeId PRIMARY KEY(FuelTypeId)
);

CREATE TABLE Body(
BodyId INT,
BodyName NVARCHAR(100) NOT NULL,
CONSTRAINT PK_BodyId_Body PRIMARY KEY(BodyId)
);


CREATE TABLE Vehicle(
VehicleId INT,
MfgId INT NOT NULL,
SubModelId INT NOT NULL,
BodyId INT NOT NULL,
VehicleDisplayName NVarchar(100) NOT NULL,
[Year] INT NOT NULL,
DriveTypeId INT NOT NULL,
Engine Nvarchar(100) NOT NULL ,
EngineCC nvarchar(100) NOT NULL,
EngineCylinders nvarchar(100),
EngineLiterDisplay Nvarchar(100),
FuelTypeId INT NOT NULL,
NumOfDoors INT NOT NULL,

CONSTRAINT PK_VehicleId PRIMARY KEY(VehicleId),

CONSTRAINT FK_MfgId_Vehicle_Manufacturer FOREIGN KEY(MfgId) REFERENCES Manufacturer(MfgId),
CONSTRAINT FK_SubModelId_Vehicle_SubModel FOREIGN KEY(SubModelId) REFERENCES SubModel(SubModelId),
CONSTRAINT FK_BodyId_Vehicle_Body FOREIGN KEY(BodyId) REFERENCES Body(BodyId),
CONSTRAINT FK_DriveTypeId_Vehicle_DriveType FOREIGN KEY(DriveTypeId) REFERENCES DriveType(DriveTypeId),
CONSTRAINT FK_FuelTypeId_Vehicle_FuelType FOREIGN KEY(FuelTypeId) REFERENCES FuelType(FuelTypeId)

);








CREATE TABLE Country (
  CountryId INT ,
  CountryName nVARCHAR(100) NOT NULL,
  CONSTRAINT PK_CountryId_Country PRIMARY KEY(CountryId)
);


CREATE TABLE City (
  CityId INT ,
  CityName nVARCHAR(100) NOT NULL,
 CountryId INT NOT NULL,
 CONSTRAINT PK_CityId_City PRIMARY KEY(CityId),
 CONSTRAINT FK_CountryId_City_Country FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
);




CREATE TABLE Addresses (
  AddressId INT PRIMARY KEY,
  AddressLine1 VARCHAR(100) NOT NULL,
  AddressLine2 VARCHAR(100) NOT NULL,
  CityId INT NOT NULL,

CONSTRAINT FK_CityId_Addresses_City  FOREIGN KEY (CityId) REFERENCES City(CityId)
);


CREATE TABLE Gender (
  GenderId INT PRIMARY KEY,
  GenderName nVARCHAR(50) NOT NULL
);


CREATE TABLE ContactInformation (
  ContactId INT ,
  PhoneNumber nVARCHAR(20),
  Email nVARCHAR(100),

  CONSTRAINT PK_ContactId_ContactInformation PRIMARY KEY(ContactId)
);

CREATE TABLE IdentificationInformation (
  IdentificationId INT ,
  SocialSecurityNumber VARCHAR(20),
  NationalIDNumber VARCHAR(50),
  DriverLicenseNumber VARCHAR(50),
  CONSTRAINT PK_IdentificationID_IdentificationInformation PRIMARY KEY(IdentificationID)
);


CREATE TABLE Person (
  PersonId INT,
  FirstName VARCHAR(50) NOT NULL,
  MiddleName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  DateOfBirth DATE,
  PersonImage NVARCHAR(MAX) NULL,
  AddressId INT,
   GenderId INT,
  ContactId INT,
  IdentificationId INT,
  CONSTRAINT PK_PersonId_Person PRIMARY KEY(PersonId),
  FOREIGN KEY (AddressId) REFERENCES Addresses(AddressId),
  FOREIGN KEY (GenderId) REFERENCES Gender(GenderId),
   FOREIGN KEY (ContactId) REFERENCES ContactInformation(ContactId),
    FOREIGN KEY (IdentificationId) REFERENCES IdentificationInformation(IdentificationId)
);


CREATE TABLE Employee(
EmployeeId INT ,
PersonId INT  not null unique, 

CONSTRAINT PK_EmployeeId_Employee PRIMARY KEY(EmployeeId),
CONSTRAINT FK_PersonId_Employee_Person FOREIGN KEY(PersonId) REFERENCES Person(PersonId)
);

CREATE TABLE Applicant (
    ApplicantID INT PRIMARY KEY,
    IdentificationNo VARCHAR(50),
    FullName VARCHAR(100),
    BirthDate DATE,
    AddressLine VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Nationality VARCHAR(50),
    PersonalImage VARBINARY(MAX)
);

CREATE TABLE Services
(
ServiceId INT,
ServiceName NVARCHAR(100) NOT NULL,
CONSTRAINT PK_ServiceId_Services PRIMARY KEY(ServiceId)
);

-- DocumentType table
CREATE TABLE DocumentType (
    DocumentTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50)
);

-- Document table
CREATE TABLE Document (
    DocumentID INT PRIMARY KEY,
    DocumentNumber VARCHAR(50),
    DocumentTypeID INT,
	ApplicantID INT,
    IssuedDate DATE,
    ExpiryDate DATE,
    AdditionalFields VARCHAR(255),
    FOREIGN KEY (DocumentTypeID) REFERENCES DocumentType(DocumentTypeID),
	FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);

CREATE TABLE RequestStatus(
RequestStatusId INT,
StatusName nvarchar(50) not null,
CONSTRAINT PK_RequestStatusId_RequestStatus PRIMARY KEY(RequestStatusId)
);

CREATE TABLE Request(
RequestId INT,
RequestDate Date DEFAULT GETDATE(),
ApplicantID INT,
ServiceTypeId INT,
RequestStatusId INT,
EmployeeId INT,

CONSTRAINT PK_RequestId PRIMARY KEY(RequestId),
CONSTRAINT FK_ApplicantID_Request_Driver FOREIGN KEY(ApplicantID) REFERENCES Applicant(ApplicantID),
CONSTRAINT FK_ServiceTypeId_Request_Services FOREIGN KEY(ServiceTypeId) REFERENCES Services(ServiceId),
CONSTRAINT FK_RequestStatusId_Request_RequstStatus FOREIGN KEY(RequestStatusId) REFERENCES RequestStatus(RequestStatusId),
CONSTRAINT FK_EmployeeId_Request_Employee FOREIGN KEY(EmployeeId) REFERENCES Employee(EmployeeId)
);


CREATE TABLE LicenseCategoryConditions(
ID INT,
Particular varchar(50) not null
);

-- Create LicenseType table
CREATE TABLE LicenseCategory (
    LicenseTypeId INT PRIMARY KEY,
    [Name] VARCHAR(50),
    [Description] VARCHAR(100),
	Cost Decimal(10,2)
);






-- Create License table
CREATE TABLE License (
    LicenseId INT PRIMARY KEY,
    LicenseNumber VARCHAR(20),
    LicenseTypeId INT,
    IssueDate DATE,
    ExpiryDate DATE,
    ِِApplicantID INT,
    FOREIGN KEY (LicenseTypeId) REFERENCES LicenseCategory(LicenseTypeId),
    FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);


CREATE TABLE Payment(
PaymentId INT,
RequestId INT,
PaymentDate Date default getDate(),
Amount Decimal(10,2) not null,
ApplicantId INT,

CONSTRAINT PK_RequestPaymentId PRIMARY KEY(PaymentId),
CONSTRAINT FK_RequestId_Payment_Request FOREIGN KEY(RequestId) REFERENCES Request(RequestId),
CONSTRAINT FK_ApplicantId_Payment_Applicant FOREIGN KEY(ApplicantId) REFERENCES Applicant(ApplicantId)
);





















--CREATE TABLE Driver(
--DriverId INT ,
--PersonId INT  not null unique, 

--CONSTRAINT PK_DriverId PRIMARY KEY(DriverId),
--CONSTRAINT FK_PersonId_Applicant_Person FOREIGN KEY(PersonId) REFERENCES Person(PersonId)
--);










