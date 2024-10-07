CREATE TABLE Countries (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100)
);

CREATE TABLE States (
    StateID INT PRIMARY KEY,
    StateName VARCHAR(100),
    CountryID INT NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(100),
    StateID INT NOT NULL,
    FOREIGN KEY (StateID) REFERENCES States(StateID)
);


CREATE TABLE Subareas (
    SubareaID INT PRIMARY KEY,
    SubareaName VARCHAR(100),
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);


CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    AddressLine1 VARCHAR(100),
    AddressLine2 VARCHAR(100),
    CityID INT,
	CountryID INT,
	StateID INT,
    PostalCode VARCHAR(20),
    PhoneNumber VARCHAR(20),
    IsDefault BIT,
	IsBillingAddress BIT,
    IsShippingAddress BIT,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID),
	 FOREIGN KEY (CountryID) REFERENCES Countries(CountryID),
	  FOREIGN KEY (StateID) REFERENCES States(StateID)
);