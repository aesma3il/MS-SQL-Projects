--Create database DVLMs;
--go
--use DVLMs;
--go



CREATE TABLE Nationality (
    NationalityID INT PRIMARY KEY identity,
    [Name] VARCHAR(50) NOT NULL
);

CREATE PROCEDURE usp_Nationality_LoadAll
AS
BEGIN
    SELECT NationalityID, Name
    FROM Nationality;
END;


GO

CREATE PROCEDURE usp_Nationality_GetNameByID
    @NationalityID INT
AS
BEGIN
    SELECT [Name]
    FROM Nationality
    WHERE NationalityID = @NationalityID;
END;
go
INSERT INTO Nationality ([Name])
VALUES
    ('United States'),
    ('Canada'),
    ('United Kingdom'),
    ('Germany'),
    ('France'),
    ('Australia'),
    ('Japan'),
    ('Brazil'),
    ('India'),
    ('China');

GO


CREATE TABLE Person (
    PersonID INT PRIMARY KEY IDENTITY,
    NationalNo VARCHAR(20) NOT NULL UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    SecondName VARCHAR(50) NOT NULL,
    ThirdName VARCHAR(50) NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender BIT NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL,
    NationalityID INT,
	ImagePath varchar(max) null
    CONSTRAINT FK_NationalityID_Nationality FOREIGN KEY (NationalityID) REFERENCES Nationality (NationalityID)
);
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    PersonID INT NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(50) NOT NULL,
    IsActive BIT NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE UserActivityLog (
    LogID INT PRIMARY KEY IDENTITY,
    ComputerName VARCHAR(100) NOT NULL,
    IPAddress VARCHAR(20) NOT NULL,
    LogDateTime DATETIME NOT NULL,
    UserID INT NOT NULL,
    ActivityType VARCHAR(15) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);



CREATE PROCEDURE usp_Users_GetUsersCount
AS
BEGIN
    SELECT COUNT(*) AS RecordCount FROM Users;
END;











alter table Person 
Add ImagePath varchar(max) null
go
create VIEW vw_Person_PersonDetails
AS
SELECT
    PersonID,
	NationalNo,
    FirstName,
    SecondName,
    ThirdName,
    LastName,
    CASE
        WHEN Gender = 1 THEN 'Male'
        WHEN Gender = 0 THEN 'Female'
    END AS Gender,
    DateOfBirth,
    Email,
    Phone,
    n.Name,
	p.ImagePath
FROM
    Person p
	inner join Nationality n on p.NationalityID = n.NationalityID;
go


create proc usp_Person_GetPersonInfoByID 
@PersonID INT
as
begin
SELECT
    PersonID,
	NationalNo,
    FirstName,
    SecondName,
    ThirdName,
    LastName,
    CASE
        WHEN Gender = 1 THEN 'Male'
        WHEN Gender = 0 THEN 'Female'
    END AS Gender,
    DateOfBirth,
    Email,
    Phone,
    n.Name,
	p.ImagePath
FROM
    Person p
	inner join Nationality n on p.NationalityID = n.NationalityID
	where p.PersonID = @PersonID
end

CREATE PROCEDURE usp_Person_Add
    @NationalNo VARCHAR(20),
    @FirstName VARCHAR(50),
    @SecondName VARCHAR(50),
    @ThirdName VARCHAR(50),
    @LastName VARCHAR(50),
    @Gender BIT,
    @DateOfBirth DATE,
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @NationalityID INT,
    @ImagePath VARCHAR(MAX)
AS
BEGIN
    INSERT INTO Person (NationalNo, FirstName, SecondName, ThirdName, LastName, Gender, DateOfBirth, Email, Phone, NationalityID, ImagePath)
    VALUES (@NationalNo, @FirstName, @SecondName, @ThirdName, @LastName, @Gender, @DateOfBirth, @Email, @Phone, @NationalityID, @ImagePath);
END;



create  proc usp_Person_LoadAll
as
begin
select * from vw_Person_PersonDetails
end



CREATE PROCEDURE usp_Person_Edit
    @PersonID INT,
    @NationalNo VARCHAR(20),
    @FirstName VARCHAR(50),
    @SecondName VARCHAR(50),
    @ThirdName VARCHAR(50),
    @LastName VARCHAR(50),
    @Gender BIT,
    @DateOfBirth DATE,
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @NationalityID INT,
    @ImagePath VARCHAR(MAX)
AS
BEGIN
    UPDATE Person
    SET NationalNo = @NationalNo,
        FirstName = @FirstName,
        SecondName = @SecondName,
        ThirdName = @ThirdName,
        LastName = @LastName,
        Gender = @Gender,
        DateOfBirth = @DateOfBirth,
        Email = @Email,
        Phone = @Phone,
        NationalityID = @NationalityID,
        ImagePath = @ImagePath
    WHERE PersonID = @PersonID;
END;


CREATE PROCEDURE usp_Person_Delete
    @PersonID INT
AS
BEGIN
    DELETE FROM Person
    WHERE PersonID = @PersonID;
END;



CREATE PROCEDURE usp_Person_GetFullNameByID
    @PersonID INT
AS
BEGIN
    SELECT CONCAT(FirstName, ' ', ISNULL(SecondName + ' ', ''), ISNULL(ThirdName + ' ', ''), LastName) AS FullName
    FROM Person
    WHERE PersonID = @PersonID;
END;








-- Create indexes
CREATE INDEX idx_Person_PersonID ON Person (PersonID);
CREATE INDEX idx_Person_NationalNo ON Person (NationalNo);
CREATE INDEX idx_Person_FirstName ON Person (FirstName);
CREATE INDEX idx_Person_SecondName ON Person (SecondName);
CREATE INDEX idx_Person_ThirdName ON Person (ThirdName);
CREATE INDEX idx_Person_LastName ON Person (LastName);
CREATE INDEX idx_Person_Gender ON Person (Gender);
CREATE INDEX idx_Person_DateOfBirth ON Person (DateOfBirth);
CREATE INDEX idx_Person_Email ON Person (Email);
CREATE INDEX idx_Person_Phone ON Person (Phone);
CREATE INDEX idx_Person_NationalityID ON Person (NationalityID);



CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    PersonID INT NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(50) NOT NULL,
    IsActive BIT NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);


CREATE PROCEDURE usp_Users_Add
    @PersonID INT,
    @FullName VARCHAR(100),
    @Username VARCHAR(50),
    @Password VARCHAR(50),
    @IsActive BIT
AS
BEGIN
    INSERT INTO Users (PersonID, FullName, Username, Password, IsActive)
    VALUES (@PersonID, @FullName, @Username, @Password, @IsActive);
END;



CREATE PROCEDURE usp_Users_GetUserInfoByID
    @UserID INT
AS
BEGIN
    SELECT UserID, PersonID, FullName, Username, IsActive
    FROM Users
    WHERE UserID = @UserID;
END;



CREATE PROCEDURE usp_Users_Edit
    @UserID INT,
    @PersonID INT,
    @FullName VARCHAR(100),
    @Username VARCHAR(50),
    @IsActive BIT
AS
BEGIN
    UPDATE Users
    SET PersonID = @PersonID,
        FullName = @FullName,
        Username = @Username,
        IsActive = @IsActive
    WHERE UserID = @UserID;
END;


CREATE PROCEDURE usp_Users_Delete
    @UserID INT
AS
BEGIN
    DELETE FROM Users
    WHERE UserID = @UserID;
END;


CREATE PROCEDURE usp_Users_Authenticate
    @Username VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Users
        WHERE Username = @Username AND Password = @Password AND IsActive = 1
    )
    BEGIN
        SELECT 1;
    END
    ELSE
    BEGIN
        SELECT 0;
    END;
END;

go
CREATE PROCEDURE usp_Users_GetCurrentPasswordByUserID
    @UserID int
  
AS
BEGIN
    SELECT Password
    FROM Users
    WHERE UserID = @UserID;
END;



create proc usp_Users_ChangePassword
@UserID Int,
@NewPassword nvarchar(50)
as
begin
update Users
set Password= @NewPassword
where UserID = @UserID

end



CREATE PROCEDURE usp_UserActivity_History
AS
BEGIN
    SELECT  L.LogID,U.UserID, U.FullName, U.Username,
           L.ComputerName, L.IPAddress, L.LogDateTime, L.ActivityType
    FROM Users U
    LEFT JOIN UserActivityLog L ON U.UserID = L.UserID;
END;


CREATE PROCEDURE usp_UserActivityLog_Login 
    @ComputerName VARCHAR(100),
    @IPAddress VARCHAR(20),
    @UserID INT
AS
BEGIN
    INSERT INTO UserActivityLog (ComputerName, IPAddress, LogDateTime, UserID, ActivityType)
    VALUES (@ComputerName, @IPAddress, GETDATE(), @UserID, 'Login');
END;

CREATE PROCEDURE usp_UserActivityLog_Logout
    @ComputerName VARCHAR(100),
    @IPAddress VARCHAR(20),
    @UserID INT
AS
BEGIN
    INSERT INTO UserActivityLog (ComputerName, IPAddress, LogDateTime, UserID, ActivityType)
    VALUES (@ComputerName, @IPAddress, GETDATE(), @UserID, 'Logout');
END;