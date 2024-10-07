--create database DBPersonalInformation;
--use DBPersonalInformation


create table Tbl_Country(
CountryID int primary key identity(1,1),
CountryName varchar(50) not null,


);

create table Tbl_City(
CityID int primary key identity(1,1),
CityName varchar(50) not null,
CountryID int not null ,
foreign key(CountryID) references Tbl_Country(CountryID)
);

create Table Tbl_Directorate(
ID int primary key identity(1,1),
DirectorateName varchar(50) not null,
CityID int,
foreign key(CityID) references Tbl_City(CityID)
);

create table Tbl_Person(
ID int,
FirstName,
LastName,
DateOfBirth,
Gender,



);

create table Tbl_ContactInfo(
ContactID int primary key identity(1,1),
Email varchar(50) not null,
Phone varchar(50),
FaxNumber varchar(50),
Website varchar(100)

);

create table Tbl_Address(
AddressID int primary key identity(1,1),
StreetName varchar(20),
StreetNumber varchar(50),
DepartmentNumber varchar(20),
CityID int,
foreign key(CityID) references Tbl_City(CityID)

);


create table Tbl_SocialMedia(
ID int primary key identity(1,1),
PlatformType varchar(50)
);

create table Tbl_SocialMediaDetails(
ID int primary key identity(1,1),
Username varchar(50),
Pass varchar(50),
PlatformTypeID int,
Link varchar(100)
foreign key(PlatformTypeID) references Tbl_SocialMedia(ID)
);


create table Tbl_CreditCard(
ID int primary key identity(1,1),
CreditCardNumber varchar(50),
CardholderName varchar(50),
ExpDate Date,
CVV varchar(10)
);