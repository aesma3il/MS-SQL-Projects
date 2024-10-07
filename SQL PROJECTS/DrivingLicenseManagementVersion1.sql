-- Create Applicants table
CREATE TABLE Person (
    PersonID INT UNIQUE ,
    NationalNumber INT NOT NULL PRIMARY KEY,
    FullName VARCHAR(100),
    DateOfBirth DATE,
    AddressLine VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    Nationality VARCHAR(50),
    PersonalImage VARBINARY(MAX)
);

CREATE TABLE UserAccount (
    UserId INT PRIMARY KEY,
    PersonId INT,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    CONSTRAINT FK_UserAccount_Person FOREIGN KEY (PersonId) REFERENCES Person(NationalNumber)
);




-- Create the AuditTrail table
CREATE TABLE AuditTrail (
    AuditTrailId INT PRIMARY KEY,
    TableName VARCHAR(100) NOT NULL,
    RecordId INT NOT NULL,
    Action VARCHAR(20) NOT NULL,
    ActionDate DATETIME NOT NULL,
    UserId INT,
    Details VARCHAR(MAX),
    -- Add other fields as needed
    CONSTRAINT FK_AuditTrail_UserAccount FOREIGN KEY (UserId) REFERENCES UserAccount(UserId)
);

CREATE TABLE Driver (
	DriverID Int unique identity(1,1),
    PersonID INT PRIMARY KEY,
   
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Create DocumentType table for example identification card, passport, cetificates
--CREATE TABLE DocumentType (
--    DocumentTypeID INT PRIMARY KEY,
--    TypeName VARCHAR(50)
--);

---- Create Document table
--CREATE TABLE Document (
--    DocumentID INT PRIMARY KEY,
--    DocumentTypeID INT,
--    ApplicantID INT,
--    DocumentNumber VARCHAR(50),
--    IssueDate DATE,
--    ExpirationDate DATE,
--    CountryOfIssue VARCHAR(50),
--    FOREIGN KEY (DocumentTypeID) REFERENCES DocumentType(DocumentTypeID),
--    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
--);


CREATE TABLE LicenseClass (
LicenseClassID INT PRIMARY KEY,
ClassName VARCHAR(100) NOT NULL,
ClassDescription VARCHAR(200),
MinimumAllowedAge INT,
ValidityLenght INT,
ClassFee DECIMAL(10,2)
   
);


-- Create Licenses table
CREATE TABLE Licenses (
    LicenseID INT PRIMARY KEY,
    LicenseNumber VARCHAR(20),
    ApplicantID INT,
    LicenseClassID INT,
    IssueDate DATE,
    ExpirationDate DATE,
    Conditions BIT,
    Fee DECIMAL(10, 2),
    FOREIGN KEY (ApplicantID) REFERENCES Person(PersonID),
    FOREIGN KEY (LicenseClassID) REFERENCES LicenseClass(LicenseClassID)
);

CREATE TABLE ServiceTypes (
    ServiceTypeID INT PRIMARY KEY,
    ServiceTypeName VARCHAR(50),
    Fee DECIMAL(10, 2)
);


CREATE TABLE Requests (
    RequestID INT PRIMARY KEY,
    UserID INT,
	ApplicantID INT,
    ServiceTypeID INT,
    RequestDate DATE,
    Status VARCHAR(50),
    Fees DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES UserAccount(UserID),
    FOREIGN KEY (ServiceTypeID) REFERENCES ServiceTypes(ServiceTypeID),
	 FOREIGN KEY (ApplicantID) REFERENCES Person(NationalNumber)

	
);

-- Create RequestStatus table
CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY,
    StatusName VARCHAR(50)
);

-- Create PaymentTypes table-- this table is for the type of different payment such as service fee, license fee, and so on.
CREATE TABLE PaymentTypes (
    PaymentTypeID INT PRIMARY KEY,
    PaymentTypeName VARCHAR(50),
	Fee DECIMAL(10,2)
);

-- Create Payments table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    PaymentTypeID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (PaymentTypeID) REFERENCES PaymentTypes(PaymentTypeID)
);


-- Create Applicant Requests table
CREATE TABLE OrderHeader (
	ID INT ,
    ApplicantID INT,
	NationalApplicantNumber INT,
	OrderDate DATE DEFAULT GETDATE(),
	OrderTypeID INT,
    LicenseTypeID INT,
	PaymentID INT,
	EmployeeID INT,
    IsFirstIssue BIT,
    HasSameLicenseType BIT,
    HasUncompleteRequest BIT,

	--enforce that each applicant has only one license of a specific class
	primary key(ApplicantID, LicenseTypeID),

    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID),
	 FOREIGN KEY (NationalApplicantNumber) REFERENCES Applicants(NationalNumber),
    FOREIGN KEY (OrderTypeID) REFERENCES OrderType(OrderTypeID),
    FOREIGN KEY (LicenseTypeID) REFERENCES LicenseClass(LicenseClassID),
	 FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
	  FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


-- Create ExamType table
-- ExamType table
CREATE TABLE ExamType (
    ExamTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50)
);


CREATE TABLE Exam (
    ExamID INT PRIMARY KEY,
    ExamTypeID INT,
    Title VARCHAR(100),
    Description TEXT,
    MaxScore INT,
    PassingScore INT,
    DurationMinutes INT,
    Status VARCHAR(50),
    FOREIGN KEY (ExamTypeID) REFERENCES ExamType(ExamTypeID),
	
);


-- Appointment table
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    ExamID INT,
    ApplicantID INT,
	PaymentID INT,
    AppointmentDate DATE,
    StartTime TIME,
    EndTime TIME,
    AppointmentStatus VARCHAR(100),
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID),
	 FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);





