CREATE TABLE Countries (
  CountryID INT PRIMARY KEY,
  CountryName VARCHAR(100) NOT NULL
);

CREATE TABLE Cities (
  CityID INT PRIMARY KEY,
  CityName VARCHAR(100) NOT NULL,
  CountryID INT NOT NULL,
  FOREIGN KEY ( CountryID ) REFERENCES Countries(CountryID )
);



CREATE TABLE Gender (
  GenderID INT PRIMARY KEY,
  GenderName VARCHAR(50) NOT NULL
);


CREATE TABLE ContactInformation (
  ContactID INT PRIMARY KEY,
  PhoneNumber VARCHAR(20),
  Email VARCHAR(100),
);

CREATE TABLE IdentificationInformation (
  IdentificationID INT PRIMARY KEY,
  SocialSecurityNumber VARCHAR(20),
  NationalIDNumber VARCHAR(50),
  DriverLicenseNumber VARCHAR(50),
);


CREATE TABLE Person (
  PersonID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  MiddleName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  DateOfBirth DATE,
  AddressID INT,
   GenderID INT,
  ContactID INT,
  IdentificationID INT,
  FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
  FOREIGN KEY (GenderID) REFERENCES Gender(GenderID),
   FOREIGN KEY (ContactID) REFERENCES ContactInformation(ContactID),
    FOREIGN KEY (IdentificationID) REFERENCES IdentificationInformation(IdentificationID)
);



create table UserLogin(
UserLoginID int primary key identity(1,1),
PersonID int ,
Username varchar(50) not null,
HashPassword varchar(50) not null,
RecoveryEmail Varchar(50) null,
constraint fk_userlogin_Person foreign key references Person(PersonID)
)
