--use  ManagementOfPeopleUsers


-- Creating the Countries table
CREATE TABLE Countries (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL
);

-- Creating the Cities table
CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

go
CREATE  TABLE People (
    PersonID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    NationalNO NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(20) NOT NULL,
    SecondName NVARCHAR(20) NOT NULL,
    ThirdName NVARCHAR(20) NULL,
    LastName NVARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender TINYINT NOT NULL,
    Address NVARCHAR(500) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(50) NULL,
    CityID INT,
    ImagePath NVARCHAR(max) NULL,
    FOREIGN KEY (CityID ) REFERENCES Cities(CityID )
  
);


alter table People
alter column Gender Bit

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    PersonID INT not null unique,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);



-- Repository pattern for CRUD operations on the Countries table
CREATE PROCEDURE Countries_Create
    @CountryID INT,
    @CountryName VARCHAR(100)
AS
BEGIN
    INSERT INTO Countries (CountryID, CountryName)
    VALUES (@CountryID, @CountryName);
END;

CREATE PROCEDURE Countries_GetAll
AS
BEGIN
    SELECT * FROM Countries;
END;

CREATE PROCEDURE Countries_GetById
    @CountryID INT
AS
BEGIN
    SELECT * FROM Countries WHERE CountryID = @CountryID;
END;

CREATE PROCEDURE Countries_Update
    @CountryID INT,
    @CountryName VARCHAR(100)
AS
BEGIN
    UPDATE Countries SET CountryName = @CountryName WHERE CountryID = @CountryID;
END;

CREATE PROCEDURE Countries_Delete
    @CountryID INT
AS
BEGIN
    DELETE FROM Countries WHERE CountryID = @CountryID;
END;


-- Repository pattern for CRUD operations on the Cities table
CREATE PROCEDURE Cities_Create
    @CityID INT,
    @CityName VARCHAR(100),
    @CountryID INT
AS
BEGIN
    INSERT INTO Cities (CityID, CityName, CountryID)
    VALUES (@CityID, @CityName, @CountryID);
END;

CREATE PROCEDURE Cities_GetAll
AS
BEGIN
    SELECT * FROM Cities;
END;

CREATE PROCEDURE Cities_GetById
    @CityID INT
AS
BEGIN
    SELECT * FROM Cities WHERE CityID = @CityID;
END;

CREATE PROCEDURE Cities_Update
    @CityID INT,
    @CityName VARCHAR(100),
    @CountryID INT
AS
BEGIN
    UPDATE Cities SET CityName = @CityName, CountryID = @CountryID WHERE CityID = @CityID;
END;

CREATE PROCEDURE Cities_Delete
    @CityID INT
AS
BEGIN
    DELETE FROM Cities WHERE CityID = @CityID;
END;


-- Repository pattern for CRUD operations on the People table
CREATE PROCEDURE People_Create
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
    @CityID INT,
    @ImagePath NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO People (NationalNO, FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gender, Address, Phone, Email, CityID, ImagePath)
    VALUES (@NationalNO, @FirstName, @SecondName, @ThirdName, @LastName, @DateOfBirth, @Gender, @Address, @Phone, @Email, @CityID, @ImagePath);
END;

CREATE PROCEDURE People_GetAll
AS
BEGIN
    SELECT * FROM People;
END;

CREATE PROCEDURE People_GetById
    @PersonID INT
AS
BEGIN
    SELECT * FROM People WHERE PersonID = @PersonID;
END;

CREATE PROCEDURE People_Update
    @PersonID INT,
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
    @CityID INT,
    @ImagePath NVARCHAR(MAX)
AS
BEGIN
    UPDATE People SET
        NationalNO = @NationalNO,
        FirstName = @FirstName,
        SecondName = @SecondName,
        ThirdName = @ThirdName,
        LastName = @LastName,
        DateOfBirth = @DateOfBirth,
        Gender = @Gender,
        Address = @Address,
        Phone = @Phone,
        Email = @Email,
        CityID = @CityID,
        ImagePath = @ImagePath
    WHERE PersonID = @PersonID;
END;

CREATE PROCEDURE People_Delete
    @PersonID INT
AS
BEGIN
    DELETE FROM People WHERE PersonID = @PersonID;
END;
