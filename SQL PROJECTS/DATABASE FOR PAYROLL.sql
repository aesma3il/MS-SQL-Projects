CREATE DATABASE DBPAYROLL;

CREATE TABLE Country(
   Code        INT IDENTITY(1,1),
   CountryName NVARCHAR(50) NOT NULL
);

CREATE TABLE City(
	 Code INT IDENTITY(1,1),
	CityName NVARCHAR(50),
	CountryID INT NOT NULL
);

CREATE TABLE Department(
	DeptID  INT IDENTITY(1,1),
	DeptName NVARCHAR(50) NOT NULL,
);

CREATE TABLE Gender(
	ID  INT IDENTITY(1,1),
	GenderName NVARCHAR(20)
);


CREATE TABLE JobTitle(
	ID INT IDENTITY(1,1),
	JobTitle NVARCHAR(50) NOT NULL
);

CREATE TABLE Employee(
	ID INT IDENTITY(1,1),
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50) NOT NULL,
	Email NVARCHAR(25) NOT NULL,
	MobileNumber NVARCHAR(9) NULL,
	DateOfBirth DATETIME,
	EmploymetStart DATETIME,
	DeptID INT,
	JobTitleID INT,
	GenderID INT,
	CityID INT
);


CREATE TABLE EmploymentTerms(
	ID  INT IDENTITY(1,1)
	EmployeeID INT,
	AgreedSalary FLOAT,
	Note TEXT,
	SalaryStartDate DATETIME,
	SalaryEndDate DATETIME

);

CREATE TABLE JobTitleHistory(
	ID  INT IDENTITY(1,1)
	JobTitleID INT
	EmployeeID INT
	StartDate  DATE
	EndDate DATE
);

CREATE TABLE DepartmentHistory(
	ID  INT IDENTITY(1,1),
	DeptID INT,
	EmployeeID INT,
	StartDate  DATE,
	EndDate DATE
);



-- ADDING PRIMARY CONSTRAINTS

ALTER TABLE Country
ADD CONSTRAINT PK_Country PRIMARY KEY(Code)

ALTER TABLE City
ADD CONSTRAINT PK_City PRIMARY KEY(Code)


ALTER TABLE Department
ADD CONSTRAINT PK_Department PRIMARY KEY(DeptID)

ALTER TABLE JobTitle
ADD CONSTRAINT PK_JobTitle PRIMARY KEY(ID)

ALTER TABLE Gender
ADD CONSTRAINT PK_Gender PRIMARY KEY(ID)

ALTER TABLE Employee
ADD CONSTRAINT PK_Employee PRIMARY KEY(ID)

ALTER TABLE EmploymentTerms
ADD CONSTRAINT PK_EmploymentTerms PRIMARY KEY(ID)

ALTER TABLE JobTitleHistory
ADD CONSTRAINT PK_JobHistory PRIMARY KEY(ID)

ALTER TABLE DepartmentHistory
ADD CONSTRAINT PK_DeptHistory PRIMARY KEY(ID)



--ADDING FOREIGN KEY CONSTRAINT

ALTER TABLE City
ADD CONSTRAINT FK_City_Country FOREIGN KEY(CountryID)
REFERENCES Country(Code)



ALTER TABLE EmploymentTerms
ADD CONSTRAINT FK_EmpTerms FOREIGN KEY(EmployeeID)
REFERENCES Employee(ID)

ALTER TABLE Employee
ADD CONSTRAINT FK_DeptID FOREIGN KEY(DeptID)
REFERENCES Department(DeptID)

ALTER TABLE Employee
ADD CONSTRAINT FK_City FOREIGN KEY(CityID)
REFERENCES City(Code)

ALTER TABLE Employee
ADD CONSTRAINT FK_JobTitle FOREIGN KEY(JobTitleID)
REFERENCES JobTitle(ID)

ALTER TABLE Employee
ADD CONSTRAINT FK_Emp_Gender FOREIGN KEY(GenderID)
REFERENCES Gender(ID)

ALTER TABLE JobTitleHistroy
ADD CONSTRAINT FK_Emp_Job FOREIGN KEY(EmployeeID)
REFERENCES Employee(ID)

ALTER TABLE JobTitleHistroy
ADD CONSTRAINT FK_EmpJobTitle FOREIGN KEY(JobTitleID)
REFERENCES JobTitle(ID)

ALTER TABLE DepartmentHistory
ADD CONSTRAINT FK_EmpDeptHistory FOREIGN KEY(EmployeeID)
REFERENCES Employee(ID)

ALTER TABLE DepartmentHistory
ADD CONSTRAINT FK_DeptHistory FOREIGN KEY(DeptID)
REFERENCES Department(DeptID)



--ADDING DEFAULT CONSTRAINT







--ADDING CHECK CONSTRAINT 





--ADDING UNIQUE CONSTRAINT 



--stored procedure

--BACKUP PROCEDURE
CREATE PROC BackupDbPayroll
AS
BEGIN 
BACKUP DATABASE DBPAYROLL 
TO DISK = 'd:\BACKUP\DBPAYROLL.BAK'
WITH DIFFERENTIAL 
END

--RESTORE DATABASE 
CREATE PROC RESTOREDBPAYROLL
AS
BEGIN
RESTORE DATABASE DBPAYROLL
FROM DISK = 'd:\BACKUP\DBPAYROLL.BAK'
END