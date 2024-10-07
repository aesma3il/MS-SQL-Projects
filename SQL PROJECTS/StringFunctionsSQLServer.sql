CREATE TABLE YourTable (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FormattedID AS RIGHT('00000' + CAST(ID AS VARCHAR(5)), 5) PERSISTED,
	firstname varchar(20) not null
);

insert into  YourTable(firstname) values('abood'),('ali'),('shadi'), ('moheeb'),
('hoda'),('abood'),('ali'),('shadi'), ('moheeb'),('hoda'),('abood'),
('ali'),('shadi'), ('moheeb'),('hoda');

select * from YourTable


-- Example table
CREATE TABLE Employees (
    EmployeeID INT identity(1,1),
	EmployeeNumber as RIGHT('000'+ CAST(EmployeeID as varchar(3)),3)  persisted,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);


-- Insert 50 records into the Employees table
INSERT INTO Employees (FirstName, LastName, Email)
VALUES
    (' mohammed', ' Doe h ', 'john.doe@example.com'),
    ('  Jane  ', ' Smith', 'jane.smith@example.com'),
    (' Michael  ', 'Johnson', 'michael.johnson@example.com'),
    -- Add more records here...
    ('Sarah', 'Williams', 'sarah.williams@example.com');


-- Example query utilizing string functions
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    LEN(FirstName) AS FirstNameLength,
	Trim(FirstName) as TrimedFirstName,
    UPPER(LastName) AS UpperCaseLastName,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    SUBSTRING(Email, 1, CHARINDEX('@', Email) - 1) AS Username
FROM 
    Employees;


	DECLARE @Password VARCHAR(100) = 'Abd122'; -- Replace with the password you want to check

IF @Password LIKE '%[a-z]%' AND
   @Password LIKE '%[A-Z]%' AND
   @Password LIKE '%[0-9]%' AND
   @Password LIKE '%[^a-zA-Z0-9]%' and
   len(@Password) = 10
BEGIN
   PRINT 'Password meets the requirements.';
END
ELSE
BEGIN
   PRINT 'Password does not meet the requirements.';
END