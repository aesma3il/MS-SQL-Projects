CREATE TABLE Gender(
GenderID INT,
GenderName nvarchar(20) not null
);


create table Journalist(
JournalistID INT,
RealFullName NVARCHAR(100) NOT NULL,
PseudoName NVARCHAR(100) NULL,
GenderID  iNT,
IdentificationCard nvarchar(30) not null,
PhoneNumber1 nvarchar(9),
PhoneNumber2 nvarchar(9),
AccommodationCityID INT,
PassportImage nvarchar(200)



);


Create table Projects(
ProjectID INT,
ProjectName nvarchar(100) not null

);

create table Organization(
OrganizationID INT,
OrganizationName nvarchar(100) not null

);

Create table Country(
CountryID INT ,
CountryName nvarchar(50) not null
);

Create table City(
CityID INT
CityName nvarchar(50) not null,
CountryID iNT NOT NULL

);


Create table Category(
CategoryID iNT ,
CategoryName NVarchar(50)
);


Create table Topics(
TopicID 
TopicName
CategoryID

);

Create Table Material(
MaterialID
MaterialTitle
MaterialText
CategoryID
TopicID
CityID
ProjectID
MaterialWebsiteLink
NumberOfWords
EditorID



);



Create table JournalistMaterial(
ID
MaterialID
JournalistID
);

Create table LocationWithinCity(
LocationID
LocationName
CityID
);