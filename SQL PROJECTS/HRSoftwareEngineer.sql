CREATE TABLE Company (
  CompanyID INT PRIMARY KEY,
  CompanyCode NVARCHAR(50) NOT NULL,
  ComName NVARCHAR(100) NOT NULL,
  AddressLine1 NVARCHAR(100) NOT NULL,
  AddressLine2 NVARCHAR(100),
  Phone1 NVARCHAR(20) NOT NULL,
  Phone2 NVARCHAR(20),
  Fax NVARCHAR(20),
  Email NVARCHAR(100) NOT NULL
);

CREATE TABLE Degree (
  DegreeID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  DegreeName NVARCHAR(50) NOT NULL
);

CREATE TABLE Department (
  DepartmentID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  DepartmentName NVARCHAR(50) NOT NULL
);

CREATE TABLE Job (
  JobID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  JobTitle NVARCHAR(50) NOT NULL
);

CREATE TABLE Section (
  SectionID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  SectionName NVARCHAR(50) NOT NULL
);

CREATE TABLE Course (
  CourseID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  CourseName NVARCHAR(50) NOT NULL
);

CREATE TABLE Qualification (
  QualificationID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  QualificationName NVARCHAR(50) NOT NULL
);

CREATE TABLE Speciality (
  SpecialityID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  SpecialityName NVARCHAR(50) NOT NULL
);

CREATE TABLE Nationality(
  NationalityID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  NationalityName NVARCHAR(50) NOT NULL
);

CREATE TABLE Religion (
  ReligionID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  ReligionName NVARCHAR(50) NOT NULL
);

CREATE TABLE Document (
  DocumentID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  DocumentName NVARCHAR(50) NOT NULL
);

CREATE TABLE Workplace (
  WorkplaceID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  WorkplaceName NVARCHAR(50) NOT NULL
);

CREATE TABLE Adminletter (
  AdminletterID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  AdminletterName NVARCHAR(50) NOT NULL
);

CREATE TABLE Bank (
  BankID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  BankName NVARCHAR(50) NOT NULL
);

CREATE TABLE [Dependent] (
  DependentID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  DependentName NVARCHAR(50) NOT NULL
);

CREATE TABLE VacationsLeave (
  LeaveID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  LeaveType NVARCHAR(50) NOT NULL
);

CREATE TABLE Beneficiary (
  BeneficiaryID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  BeneficiaryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Resignation (
  ResignationID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  ResignationReason NVARCHAR(100) NOT NULL
);

CREATE TABLE Exceptions (
  ExceptionID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  ExceptionName NVARCHAR(50) NOT NULL
);
CREATE TABLE MedicalAuthority (
  AuthorityID INT PRIMARY KEY,
  AuthorityCode NVARCHAR(50) NOT NULL,
  AuthorityName NVARCHAR(100) NOT NULL
);

CREATE TABLE TypeOfAllowanceOrDeduction (
  TypeID INT PRIMARY KEY,
  TypeCode NVARCHAR(50) NOT NULL,
  TypeName NVARCHAR(100) NOT NULL
);

CREATE TABLE AlloancesAndDeductions (
  ID INT PRIMARY KEY,
  Code NVARCHAR(50) NOT NULL,
  [Description] NVARCHAR(100) NOT NULL,
  TypeID INT NOT NULL,
);


CREATE TABLE OvertimePrice (
  PriceID INT PRIMARY KEY,
  Description NVARCHAR(50) NOT NULL,
  Amount DECIMAL(10, 2) NOT NULL
);
CREATE TABLE CompanyExemption (
  ExemptionID INT PRIMARY KEY,
  ExemptionCode NVARCHAR(50) NOT NULL,
  Description NVARCHAR(100) NOT NULL,
  Maxmimum decimal(10,2),
  Minimum decimal(10,2),
);

CREATE TABLE TaxSlices (
  SliceID INT PRIMARY KEY,
  LowerBound DECIMAL(10, 2) NOT NULL,
  UpperBound DECIMAL(10, 2),
  Rate DECIMAL(5, 2) NOT NULL
);


-- Table: PersonAddress
CREATE TABLE PersonAddress (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    AddressLine1 NVARCHAR(255) NOT NULL,
    AddressLine2 NVARCHAR(255),
    City NVARCHAR(100) NOT NULL,
    Neighborhood NVARCHAR(100),
    Country NVARCHAR(100) NOT NULL,
    Religion NVARCHAR(100)
);

-- Table: PersonContact
CREATE TABLE PersonContact (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(255) NOT NULL,
    WorkEmail NVARCHAR(255),
    PrimaryPhone NVARCHAR(20) NOT NULL,
    SecondaryPhone NVARCHAR(20)
);

-- Table: Person
CREATE TABLE Person (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    AddressID INT NOT NULL,
    ContactID INT NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    FatherName NVARCHAR(100),
    GrandfatherName NVARCHAR(100),
    FamilyName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    PlaceOfBirth NVARCHAR(100),
    MaritalStatus NVARCHAR(20) NOT NULL,
	BranchID INT,
    FOREIGN KEY (AddressID) REFERENCES PersonAddress(AddressID),
    FOREIGN KEY (ContactID) REFERENCES PersonContact(ContactID)
);

-- Table: Journalist
CREATE TABLE Journalist (
    JournalistID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT NOT NULL,
    PseudoName NVARCHAR(100),
    AlternativeName NVARCHAR(100),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Table: PersonDocument
CREATE TABLE PersonDocument (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT NOT NULL,
    DocType NVARCHAR(100) NOT NULL,
    DocNumber NVARCHAR(100) NOT NULL,
    IssuanceDate DATE NOT NULL,
    ExpiryDate DATE,
    PublicationPlace NVARCHAR(100),
    Serial NVARCHAR(100),
    Note NVARCHAR(MAX),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);