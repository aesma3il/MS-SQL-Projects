CREATE DATABASE DBHR;
GO
USE DBHR;
GO
CREATE TABLE Department(
	DepartmentID INT PRIMARY KEY IDENTITY(1,1),
	DepartmentName VARCHAR(100) NOT NULL,
	ManagerID INT NOT NULL ,
);

GO
	CREATE TABLE Job(
	JobID INT PRIMARY KEY IDENTITY(1,1),
	JobTitle VARCHAR(100) NOT NULL,
	MinSalary DECIMAL(10,2) NOT NULL,
	MaxSalary DECIMAL(10,2) NOT NULL
	);

	GO
CREATE TABLE Salary(
	SalaryID INT PRIMARY KEY IDENTITY(1,1),
	EmployeeID INT NOT NULL,
	PaidDay INT DEFAULT NULL ,
	PaidMonth INT DEFAULT NULL ,
	PaidYear INT DEFAULT NULL,
	Particulars		VARCHAR(500) NOT NULL,
	Amount	DECIMAL(10,2) NOT NULL,

);


GO
CREATE TABLE Employee(
	EmployeeID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NULL,
	Email VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(30) NOT NULL,
	HireDate DATETIME DEFAULT GETDATE(),
	JobID INT NOT NULL,
	DepartmentID INT NOT NULL,
	ManagerID INT ,


);


CREATE TABLE Attendance (
  EmployeeID INT,
  AttendanceDate DATE,
  StartTime TIME,
  EndTime TIME,
  CONSTRAINT PK_Attendance PRIMARY KEY (EmployeeID, AttendanceDate),
  CONSTRAINT FK_Attendance_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE LeaveType(
	LeaveTypeID INT PRIMARY KEY IDENTITY(1,1),
	LeaveTypeName VARCHAR(100) NOT NULL
);


CREATE TABLE Leave (
  LeaveID INT PRIMARY KEY,
  EmployeeID INT NOT NULL,
  LeaveTypeID INT NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  ApprovalStatus VARCHAR(50) NOT NULL,
  CONSTRAINT FK_Leave_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
   CONSTRAINT FK_Leave_LeaveType FOREIGN KEY (LeaveTypeID) REFERENCES LeaveType(LeaveTypeID)
);


ALTER TABLE Department
ADD CONSTRAINT FK_DEPT_MANAGER FOREIGN KEY(ManagerID) REFERENCES Employee(EmployeeID);
GO
ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Department FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID);
GO

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_JobTitle FOREIGN KEY(JobID) REFERENCES Job(JobID);
GO
ALTER TABLE Employee
ADD CONSTRAINT FK_MANAGERID_Employee FOREIGN KEY(ManagerID) REFERENCES Employee(EmployeeID);
GO
ALTER TABLE Salary
ADD CONSTRAINT FK_Salary_Employee FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID);


GO

CREATE PROC spBackup
	@FilePath VARCHAR(500)
AS
BEGIN
	BACKUP DATABASE DBHR TO DISK = @FilePath WITH REPLACE;
END;
GO
CREATE PROC spRestore 
	@FilePath VARCHAR(500)
AS
BEGIN
	RESTORE DATABASE DBHR FROM DISK = @FilePath WITH NORECOVERY
END;

GO
CREATE PROC spAddDepartment
    @DepartmentName VARCHAR(100),
    @ManagerID INT 
AS
BEGIN
        INSERT INTO Department (DepartmentName, ManagerID)
        VALUES (@DepartmentName, @ManagerID);
        SELECT SCOPE_IDENTITY() AS DepartmentID;
END

GO
CREATE PROC spDeleteDepartment
	@DepartmentID INT
AS
BEGIN
	DELETE FROM Department 
	WHERE DepartmentID = @DepartmentID
END;

GO
CREATE PROC spUpdateDepartment
   @DepartmentID INT ,
    @DepartmentName VARCHAR(100) ,
    @ManagerID INT 
AS
BEGIN
        UPDATE Department
        SET DepartmentName = @DepartmentName,
            ManagerID = @ManagerID
        WHERE DepartmentID = @DepartmentID;
END

GO
CREATE PROC spGetAllDepartment
AS
BEGIN
	SELECT * FROM Department
END;

GO

--------------jOB STORED PROCEDURES---------------------------------

CREATE PROCEDURE spAddJob
    @JobTitle VARCHAR(100),
    @MinSalary DECIMAL(10,2),
    @MaxSalary DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Job (JobTitle, MinSalary, MaxSalary)
    VALUES (@JobTitle, @MinSalary, @MaxSalary);
END
GO

CREATE PROCEDURE spGetAllJob
   
AS
BEGIN
    SET NOCOUNT ON;

    SELECT JobID, JobTitle, MinSalary, MaxSalary
    FROM Job
   
END
GO

CREATE PROCEDURE spUpdateJob
    @JobID INT,
    @JobTitle VARCHAR(100) = NULL,
    @MinSalary DECIMAL(10,2) = NULL,
    @MaxSalary DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Job
    SET JobTitle = COALESCE(@JobTitle, JobTitle),
        MinSalary = COALESCE(@MinSalary, MinSalary),
        MaxSalary = COALESCE(@MaxSalary, MaxSalary)
    WHERE JobID = @JobID;
END

GO
CREATE PROCEDURE spDeleteJob
    @JobID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Job
    WHERE JobID = @JobID;
END
-------END JOB STORED PROCEDURES------------------------------------------

------------------SALARY STORED PROCEDURE-----------------------------------------
GO
CREATE PROCEDURE spAddSalary
    @EmployeeID INT,
    @Particulars VARCHAR(500),
    @Amount DECIMAL(10,2),
    @PaidDay INT = NULL,
    @PaidMonth INT = NULL,
    @PaidYear INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF (@PaidDay IS NULL) SET @PaidDay = DAY(GETDATE());
    IF (@PaidMonth IS NULL) SET @PaidMonth = MONTH(GETDATE());
    IF (@PaidYear IS NULL) SET @PaidYear = YEAR(GETDATE());

    INSERT INTO Salary (EmployeeID, Particulars, Amount, PaidDay, PaidMonth, PaidYear)
    VALUES (@EmployeeID, @Particulars, @Amount, @PaidDay, @PaidMonth, @PaidYear);
END

GO
CREATE PROCEDURE spGetAllSalary
  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT SalaryID, EmployeeID, Particulars, Amount, PaidDay, PaidMonth, PaidYear
    FROM Salary;
END;


GO
CREATE PROCEDURE spUpdateSalary
    @SalaryID INT,
    @EmployeeID INT = NULL,
    @Particulars VARCHAR(500) = NULL,
    @Amount DECIMAL(10,2) = NULL,
    @PaidDay INT = NULL,
    @PaidMonth INT = NULL,
    @PaidYear INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF (@PaidDay IS NULL) SET @PaidDay = DAY(GETDATE());
    IF (@PaidMonth IS NULL) SET @PaidMonth = MONTH(GETDATE());
    IF (@PaidYear IS NULL) SET @PaidYear = YEAR(GETDATE());

    UPDATE Salary
    SET EmployeeID = COALESCE(@EmployeeID, EmployeeID),
        Particulars = COALESCE(@Particulars, Particulars),
        Amount = COALESCE(@Amount, Amount),
        PaidDay = @PaidDay,
        PaidMonth = @PaidMonth,
        PaidYear = @PaidYear
    WHERE SalaryID = @SalaryID;
END

GO

CREATE PROCEDURE spDeleteSalary
    @SalaryID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Salary
    WHERE SalaryID = @SalaryID;
END
GO
------------END SALARY STORED PROCEDURE


--------EMPLOYEE STORE PROC
CREATE PROCEDURE spAddEmployee
    @FirstName VARCHAR(30),
    @LastName VARCHAR(30),
    @Email VARCHAR(50),
    @PhoneNumber VARCHAR(30),
    @JobID INT,
    @DepartmentID INT,
    @ManagerID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Employee (FirstName, LastName, Email, PhoneNumber, HireDate, JobID, DepartmentID, ManagerID)
    VALUES (@FirstName, @LastName, @Email, @PhoneNumber, GETDATE(), @JobID, @DepartmentID, @ManagerID);
END

GO

CREATE PROCEDURE spGetAllEmployee
   
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID, FirstName, LastName, Email, PhoneNumber, HireDate, JobID, DepartmentID, ManagerID
    FROM Employee
END;
GO

CREATE PROCEDURE spUpdateEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(30) = NULL,
    @LastName VARCHAR(30) = NULL,
    @Email VARCHAR(50) = NULL,
    @PhoneNumber VARCHAR(30) = NULL,
    @JobID INT = NULL,
    @DepartmentID INT = NULL,
    @ManagerID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Employee
    SET FirstName = COALESCE(@FirstName, FirstName),
        LastName = COALESCE(@LastName, LastName),
        Email = COALESCE(@Email, Email),
        PhoneNumber = COALESCE(@PhoneNumber, PhoneNumber),
        JobID = COALESCE(@JobID, JobID),
        DepartmentID = COALESCE(@DepartmentID, DepartmentID),
        ManagerID = @ManagerID
    WHERE EmployeeID = @EmployeeID;
END

GO

CREATE PROCEDURE spDeleteEmployee
    @EmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Employee
    WHERE EmployeeID = @EmployeeID;
END

-----------------END STORED PROC EMPLOYEE

go
CREATE PROCEDURE CreateAttendance
    @EmployeeID INT,
    @AttendanceDate DATE,
    @StartTime TIME,
    @EndTime TIME
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Attendance (EmployeeID, AttendanceDate, StartTime, EndTime)
    VALUES (@EmployeeID, @AttendanceDate, @StartTime, @EndTime);
END

go
CREATE PROCEDURE ReadAttendance
    @EmployeeID INT = NULL,
    @AttendanceDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID, AttendanceDate, StartTime, EndTime
    FROM Attendance
    WHERE (@EmployeeID IS NULL OR EmployeeID = @EmployeeID)
        AND (@AttendanceDate IS NULL OR AttendanceDate = @AttendanceDate);
END
go
CREATE PROCEDURE UpdateAttendance
    @EmployeeID INT,
    @AttendanceDate DATE,
    @StartTime TIME = NULL,
    @EndTime TIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Attendance
    SET StartTime = COALESCE(@StartTime, StartTime),
        EndTime = COALESCE(@EndTime, EndTime)
    WHERE EmployeeID = @EmployeeID
        AND AttendanceDate = @AttendanceDate;
END
go
CREATE PROCEDURE DeleteAttendance
    @EmployeeID INT,
    @AttendanceDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Attendance
    WHERE EmployeeID = @EmployeeID
        AND AttendanceDate = @AttendanceDate;
END

------------------end attendance employee stored procedures


------------------leave type
go
CREATE PROCEDURE CreateLeaveType
    @LeaveTypeName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO LeaveType (LeaveTypeName)
    VALUES (@LeaveTypeName);
END
go



CREATE PROCEDURE ReadLeaveType
    @LeaveTypeID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT LeaveTypeID, LeaveTypeName
    FROM LeaveType
    WHERE (@LeaveTypeID IS NULL OR LeaveTypeID = @LeaveTypeID);
END

go


CREATE PROCEDURE UpdateLeaveType
    @LeaveTypeID INT,
    @LeaveTypeName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE LeaveType
    SET LeaveTypeName = @LeaveTypeName
    WHERE LeaveTypeID = @LeaveTypeID;
END

go

CREATE PROCEDURE DeleteLeaveType
    @LeaveTypeID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM LeaveType
    WHERE LeaveTypeID = @LeaveTypeID;
END

go

---------------leave stored procedures

CREATE PROCEDURE CreateLeave
    @LeaveID INT,
    @EmployeeID INT,
    @LeaveTypeID INT,
    @StartDate DATE,
    @EndDate DATE,
    @ApprovalStatus VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Leave (LeaveID, EmployeeID, LeaveTypeID, StartDate, EndDate, ApprovalStatus)
    VALUES (@LeaveID, @EmployeeID, @LeaveTypeID, @StartDate, @EndDate, @ApprovalStatus);
END

go
CREATE PROCEDURE ReadLeave
    @LeaveID INT = NULL,
    @EmployeeID INT = NULL,
    @LeaveTypeID INT = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @ApprovalStatus VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT LeaveID, EmployeeID, LeaveTypeID, StartDate, EndDate, ApprovalStatus
    FROM Leave
    WHERE (@LeaveID IS NULL OR LeaveID = @LeaveID)
        AND (@EmployeeID IS NULL OR EmployeeID = @EmployeeID)
        AND (@LeaveTypeID IS NULL OR LeaveTypeID = @LeaveTypeID)
        AND (@StartDate IS NULL OR StartDate = @StartDate)
        AND (@EndDate IS NULL OR EndDate = @EndDate)
        AND (@ApprovalStatus IS NULL OR ApprovalStatus = @ApprovalStatus);
END

go

CREATE PROCEDURE UpdateLeave
    @LeaveID INT,
    @EmployeeID INT = NULL,
    @LeaveTypeID INT = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @ApprovalStatus VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Leave
    SET EmployeeID = COALESCE(@EmployeeID, EmployeeID),
        LeaveTypeID = COALESCE(@LeaveTypeID, LeaveTypeID),
        StartDate = COALESCE(@StartDate, StartDate),
        EndDate = COALESCE(@EndDate, EndDate),
        ApprovalStatus = COALESCE(@ApprovalStatus, ApprovalStatus)
    WHERE LeaveID = @LeaveID;
END

go
CREATE PROCEDURE DeleteLeave
    @LeaveID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Leave
    WHERE LeaveID = @LeaveID;
END
go


-----------Attendance
go
CREATE PROCEDURE CreateAttendance
    @EmployeeID INT,
    @AttendanceDate DATE,
    @StartTime TIME,
    @EndTime TIME
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Attendance (EmployeeID, AttendanceDate, StartTime, EndTime)
    VALUES (@EmployeeID, @AttendanceDate, @StartTime, @EndTime);
END
go

CREATE PROCEDURE ReadAttendance
    @EmployeeID INT = NULL,
    @AttendanceDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID, AttendanceDate, StartTime, EndTime
    FROM Attendance
    WHERE (@EmployeeID IS NULL OR EmployeeID = @EmployeeID)
        AND (@AttendanceDate IS NULL OR AttendanceDate = @AttendanceDate);
END

go

CREATE PROCEDURE UpdateAttendance
    @EmployeeID INT,
    @AttendanceDate DATE,
    @StartTime TIME = NULL,
    @EndTime TIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Attendance
    SET StartTime = COALESCE(@StartTime, StartTime),
        EndTime = COALESCE(@EndTime, EndTime)
    WHERE EmployeeID = @EmployeeID
        AND AttendanceDate = @AttendanceDate;
END
go
CREATE PROCEDURE DeleteAttendance
    @EmployeeID INT,
    @AttendanceDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Attendance
    WHERE EmployeeID = @EmployeeID
        AND AttendanceDate = @AttendanceDate;
END
go




















































