

CREATE TABLE Countries (
    CountryID INT PRIMARY KEY IDENTITY,
    CountryName NVARCHAR(100) NOT NULL
);

CREATE TABLE Gender (
    GenderID TINYINT PRIMARY KEY identity,
    GenderName NVARCHAR(20) NOT NULL
);

CREATE TABLE People (
    PersonID INT PRIMARY KEY IDENTITY,
	NationalNO NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(20) NOT NULL,
    SecondName NVARCHAR(20) NOT NULL,
    ThirdName NVARCHAR(20),
    LastName NVARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    GenderID TINYINT NOT NULL,
    Address NVARCHAR(500) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(50),
    NationalityCountryID INT NOT NULL,
    ImagePath NVARCHAR(200),
    FOREIGN KEY (NationalityCountryID) REFERENCES Countries (CountryID),
    FOREIGN KEY (GenderID) REFERENCES Gender (GenderID)
);


CREATE TABLE ApplicationTypes (
    AppTypeID INT PRIMARY KEY identity,
    AppTypeName NVARCHAR(100) NOT NULL,
    Fee DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY identity,
    PersonID INT NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY IDENTITY,
    ApplicantPersonID INT NOT NULL,
	ApplicationDate DATE,
    AppTypeID INT NOT NULL,
    ApplicationStatus NVARCHAR(50) NOT NULL,
	LastStatusDate datetime not null,
    PaidFee DECIMAL(10, 2) NOT NULL,
	CreatedByUserID INT not null,
	
    FOREIGN KEY (ApplicantPersonID) REFERENCES People(PersonID),
    FOREIGN KEY (AppTypeID) REFERENCES ApplicationTypes(AppTypeID),
	FOREIGN KEY (CreatedByUserID) REFERENCES Users(UserID)
);




CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY identity,
    PersonID INT NOT NULL,
    Department NVARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    HireDate DATE NOT NULL,
    CONSTRAINT fk_Employee_Person FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);



CREATE TABLE LicenseClasses (
    LicenseClassID INT PRIMARY KEY,
    ClassName NVARCHAR(50) NOT NULL,
    ClassDescription NVARCHAR(200) NOT NULL,
    MinimumAllowedAge INT NOT NULL,
    ValidityLength INT NOT NULL,
    ClassFees DECIMAL(10, 2) NOT NULL
);



CREATE TABLE DrivingLicenseApplications (
    LicenseAppID INT PRIMARY KEY IDENTITY,
	ApplicationID INT ,
    LicenseClassID INT NOT NULL,
    Fee DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID),
    FOREIGN KEY (LicenseClassID) REFERENCES LicenseClasses(LicenseClassID)
);


CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY IDENTITY,
    PersonID INT NOT NULL,
  
    CONSTRAINT fk_Driver_Person FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);

CREATE TABLE Licenses (
    LicenseID INT PRIMARY KEY IDENTITY,
	LicenseNumber INT,
	LicenseClassID INT NOT NULL,
    DriverID INT NOT NULL,
    IssueDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
	DESCRIPTION NVARCHAR(300),
	Status nvarchar(30),
    CONSTRAINT fk_License_Driver FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    CONSTRAINT fk_License_LicenseClass FOREIGN KEY (LicenseClassID) REFERENCES LicenseClasses(LicenseClassID)
);

CREATE TABLE TestType (
    TestTypeID INT PRIMARY KEY IDENTITY,
    TestTypeName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200) NOT NULL
);

CREATE TABLE Tests (
    TestID INT PRIMARY KEY IDENTITY,
    TestTypeID INT NOT NULL,
    TestDate DATE NOT NULL,
    TestResult NVARCHAR(50),
    CONSTRAINT fk_Tests_TestType FOREIGN KEY (TestTypeID) REFERENCES TestType(TestTypeID)
);

CREATE TABLE TestAppointment (
    AppointmentID INT PRIMARY KEY IDENTITY ,
    PersonID INT NOT NULL,
    TestID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    CONSTRAINT fk_TestAppointment_Person FOREIGN KEY (PersonID) REFERENCES People(PersonID),
    CONSTRAINT fk_TestAppointment_Tests FOREIGN KEY (TestID) REFERENCES Tests(TestID)
);




--Poplate Data


INSERT INTO Countries (CountryName)
VALUES ('United States'), ('United Kingdom'), ('Yemen'), ('Australia');

INSERT INTO Gender (GenderName)
VALUES ('Male'), ('Female');


INSERT INTO People (NationalNO, FirstName, SecondName, ThirdName, LastName, DateOfBirth, GenderID, Address, Phone, Email, NationalityCountryID, ImagePath)
VALUES ('1234567890', 'Abdullah', 'Abdo', 'Mohammed', 'Esmail', '1998-01-01', 1, 'Gamal Street', '+967738807541', 'abdism.ye@gmail.com', 3, NULL)

GO
CREATE PROCEDURE CreatePerson
    @NationalNO NVARCHAR(20),
    @FirstName NVARCHAR(20),
    @SecondName NVARCHAR(20),
    @ThirdName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @DateOfBirth DATE,
    @Gender TINYINT,
    @Address NVARCHAR(500),
    @Phone NVARCHAR(20),
    @Email NVARCHAR(50),
    @NationalityCountryID INT,
    @ImagePath NVARCHAR(200)
AS
BEGIN
    INSERT INTO People (NationalNO, FirstName, SecondName, ThirdName, LastName, DateOfBirth, GenderID, Address, Phone, Email, NationalityCountryID, ImagePath)
    VALUES (@NationalNO, @FirstName, @SecondName, @ThirdName, @LastName, @DateOfBirth, @Gender, @Address, @Phone, @Email, @NationalityCountryID, @ImagePath)
END
GO

CREATE PROCEDURE uspCreatePerson
    @NationalNO NVARCHAR(20),
    @FirstName NVARCHAR(20),
    @SecondName NVARCHAR(20),
    @ThirdName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @DateOfBirth DATE,
    @Gender TINYINT,
    @Address NVARCHAR(500),
    @Phone NVARCHAR(20),
    @Email NVARCHAR(50),
    @NationalityCountryID INT,
    @ImagePath NVARCHAR(200),
    @InsertedID INT OUTPUT
AS
BEGIN
    INSERT INTO People (NationalNO, FirstName, SecondName, ThirdName, LastName, DateOfBirth, GenderID, Address, Phone, Email, NationalityCountryID, ImagePath)
    VALUES (@NationalNO, @FirstName, @SecondName, @ThirdName, @LastName, @DateOfBirth, @Gender, @Address, @Phone, @Email, @NationalityCountryID, @ImagePath)

    SET @InsertedID = SCOPE_IDENTITY()
END

Go

CREATE PROCEDURE UpdatePerson
    @PersonID INT,
    @NationalNO NVARCHAR(20),
    @FirstName NVARCHAR(20),
    @SecondName NVARCHAR(20),
    @ThirdName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @DateOfBirth DATE,
    @GenderID TINYINT,
    @Address NVARCHAR(500),
    @Phone NVARCHAR(20),
    @Email NVARCHAR(50),
    @NationalityCountryID INT,
    @ImagePath NVARCHAR(200)
AS
BEGIN
    UPDATE People
    SET NationalNO = @NationalNO,
        FirstName = @FirstName,
        SecondName = @SecondName,
        ThirdName = @ThirdName,
        LastName = @LastName,
        DateOfBirth = @DateOfBirth,
        GenderID = @GenderID,
        Address = @Address,
        Phone = @Phone,
        Email = @Email,
        NationalityCountryID = @NationalityCountryID,
        ImagePath = @ImagePath
    WHERE PersonID = @PersonID
END
Go

CREATE VIEW PeopleView AS
SELECT p.PersonID, p.NationalNO, p.FirstName, p.SecondName, p.ThirdName, p.LastName, p.DateOfBirth,
       g.GenderName, p.Address, p.Phone, p.Email, c.CountryName, p.ImagePath
FROM People p
INNER JOIN Gender g ON p.GenderID = g.GenderID
INNER JOIN Countries c ON p.NationalityCountryID = c.CountryID;

Go

CREATE PROCEDURE DeletePerson
    @PersonID INT
AS
BEGIN
    DELETE FROM People
    WHERE PersonID = @PersonID
END
Go
CREATE PROCEDURE GetAllPeople
AS
BEGIN
   SELECT
    PersonID,
    NationalNO,
    ISNULL(FirstName, '') AS FirstName,
    ISNULL(SecondName, '') AS SecondName,
    ISNULL(ThirdName, '') AS ThirdName,
    LastName,
    DateOfBirth,
    ISNULL(GenderName, '') AS GenderName,
    Address,
    Phone,
    ISNULL(Email, '') AS Email,
    CountryName,
    ISNULL(CountryName, '') AS CountryName,
    ISNULL(ImagePath, '') AS ImagePath
FROM
    PeopleView;
END
Go
CREATE PROCEDURE GetPersonByID
    @PersonID INT
AS
BEGIN
    SELECT *
    FROM PeopleView
    WHERE PersonID = @PersonID
END
Go




--CREATE TABLE Drivers (
--    DriverID INT IDENTITY(1,1) PRIMARY KEY,
--	PersonID INt not null
--);





--CREATE TABLE ApplicationType (
--    ApplicationTypeID INT IDENTITY(1,1) PRIMARY KEY,
--    Name NVARCHAR(100) NOT NULL,
--    Description NVARCHAR(MAX),
--    Fee DECIMAL(10, 2) NOT NULL
--)


--CREATE TABLE Applications (
--    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
--    ApplicationTypeID INT,
--    ApplicationDate DATE,
--    PersonID INT,
--    ApplicationStatus NVARCHAR(50),
--    PaidAmount DECIMAL(10, 2),
--    FOREIGN KEY (ApplicationTypeID) REFERENCES ApplicationType(ApplicationTypeID),
--    FOREIGN KEY (PersonID) REFERENCES People(PersonID)
--);




--CREATE TABLE LicenseClass (
--    LicenseClassId INT IDENTITY(1,1) PRIMARY KEY,
--    ClassName NVARCHAR(100) NOT NULL,
--    ClassDescription NVARCHAR(MAX),
--    MinimumAllowedAge INT not null,
--    ValidityLength INT not null,
--    ClassFees DECIMAL(10, 2) not null
--)


--CREATE TABLE DrivingLicenseApplications (
--    ID INT IDENTITY(1,1) PRIMARY KEY,
--    LicenseClassID INT, 
--);

--CREATE TABLE ExamType (
--    ExamTypeId INT IDENTITY(1,1) PRIMARY KEY,
--    TypeName NVARCHAR(100) NOT NULL,
--    ExamFee DECIMAL(10, 2) NOT NULL
--)

--CREATE TABLE Exam (
--    ExamId INT IDENTITY(1,1) PRIMARY KEY,
--    ApplicantId INT not null,
--    ExamDate DATE,
--    ExamTypeId INT FOREIGN KEY REFERENCES ExamType(ExamTypeId),
--    Result NVARCHAR(50)
--)

--CREATE TABLE ExamAppointment (
--    AppointmentId INT IDENTITY(1,1) PRIMARY KEY,
--    ExamId INT FOREIGN KEY REFERENCES Exam(ExamId),
--    AppointmentDate DATETIME,
--    Location NVARCHAR(100),
--    ExaminerID INT,
--    Remarks NVARCHAR(MAX)
--)

--CREATE TABLE Payment (
--    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
--    AppointmentId INT FOREIGN KEY REFERENCES ExamAppointment(AppointmentId),
--    Amount DECIMAL(10, 2),
--    PaymentDate DATE,
--    Remarks NVARCHAR(MAX)
--)


--CREATE TABLE Licenses (
--    LicenseId INT IDENTITY(1,1) PRIMARY KEY,
--    DriverId INT not null,
--    LicenseNumber NVARCHAR(50) NOT NULL,
--    LicenseClassID INT not null,
--    DateOfIssue DATE not null,
--    ExpirationDate DATE not null,
--    Remarks NVARCHAR(MAX) not null,
--	LicenseStatus nvarchar(50) default 'New'
--);




--CREATE TABLE Settings (
--    SettingId INT IDENTITY(1,1) PRIMARY KEY,
--    SettingName NVARCHAR(50) NOT NULL,
--    SettingValue NVARCHAR(MAX)
--);