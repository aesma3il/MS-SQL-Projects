--create database BestOfMyEffort;

-- Create Country table
CREATE TABLE Country (
    CountryID INT PRIMARY KEY IDENTITY,
    CountryName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Province table
CREATE TABLE Province (
    ProvinceID INT PRIMARY KEY IDENTITY,
    ProvinceName VARCHAR(100) NOT NULL,
    CountryID INT,
    
);

-- Create City table
CREATE TABLE City (
    CityID INT PRIMARY KEY IDENTITY,
    CityName VARCHAR(100) NOT NULL,
    ProvinceID INT,
    
);

-- Create Address table
CREATE TABLE Address (
    AddressID INT PRIMARY KEY,
    StreetName VARCHAR(100),
    Neighborhood VARCHAR(100),
    NearProminentPlace VARCHAR(100),
    CityID INT,
    
);

-- Create Person table
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    FatherName VARCHAR(100),
    GrandFatherName VARCHAR(100),
    FamilyName VARCHAR(100),
    Gender VARCHAR(10),
    BirthDate DATE,
    BirthPlace VARCHAR(100),
    MobileNo VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    NationalID VARCHAR(20),
    PassportID VARCHAR(20),
    AddressID INT,
 
);