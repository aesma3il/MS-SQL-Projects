-- Country Table

-- UserAccount Table




-- Role Table
CREATE TABLE [Role] (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL
);

-- Permission Table
CREATE TABLE Permission (
    PermissionID INT PRIMARY KEY,
    PermissionName VARCHAR(50) NOT NULL
);

-- RolePermission Table
CREATE TABLE RolePermission (
    RoleID INT,
    PermissionID INT,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permission(PermissionID)
);



CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
	RoleID INT,
	CONSTRAINT FK_RoleID_UserAccount_Role FOREIGN KEY(RoleID) REFERENCES [Role](RoleID)
  
);



CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL
    -- Additional columns for country information
);

-- City Table
CREATE TABLE City (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(100) NOT NULL,
    CountryID INT,
    -- Additional columns for city information
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- Address Table
CREATE TABLE Address (
    AddressID INT PRIMARY KEY,
    Street VARCHAR(100) NOT NULL,
    CityID INT,
    CountryID INT,
    PostalCode VARCHAR(20),
    -- Additional columns for address information
    FOREIGN KEY (CityID) REFERENCES City(CityID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);



CREATE TABLE UserAccounts (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    PasswordHash VARCHAR(100) NOT NULL, -- Hashed and salted password
  
);
CREATE TABLE UserProfiles (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ContactNumber VARCHAR(20),
    ProfilePicture VARCHAR(100),
    -- Additional columns for user profile attributes
);

CREATE TABLE ContactInformation (
    ContactID INT PRIMARY KEY,
    Email VARCHAR(100),
    Phone VARCHAR(20),
  
);

CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL,
    -- Additional columns for role attributes
);

-- ContactInformation Table
CREATE TABLE ContactInformation (
    ContactID INT PRIMARY KEY,
    Email VARCHAR(100),
    Phone VARCHAR(20),
  
);

-- Person Table
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ContactID INT,
    -- Additional columns for person information
    FOREIGN KEY (ContactID) REFERENCES ContactInformation(ContactID)
);