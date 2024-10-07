CREATE DATABASE DBCarRental;

CREATE TABLE  VCATEGORY(
	CategoryID INT IDENTITY(1,1) PRIMARY KEY,
	CategoryName NVARCHAR(50) NOT NULL
);


CREATE TABLE VEHICLERETURN(
	ReturnID INT IDENTITY(1,1) PRIMARY KEY,
	ActualReturnDate DATETIME,
	ActualRentalDays tinyint,
	Mileage smallint,
	ConsumedMileage smallint,
	FinalCheckNotes nvarchar(50),
	AdditionalCharge smallmoney,
	ActualTotalDueAmount smallmoney

);

CREATE TABLE CUSTOMER(
	CustomerID int identity(1,1) primary key,
	FirstName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	PhoneNumber nvarchar(12) null,
	DriverLicenseNumber nvarchar(50) not null

);

