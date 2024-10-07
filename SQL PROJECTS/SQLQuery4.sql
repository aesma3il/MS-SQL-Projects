-- Create the Year table
CREATE TABLE Years (
    YearID INT PRIMARY KEY,
    YearNumber INT
);

-- Create the Month table
CREATE TABLE Months (
    MonthID INT PRIMARY KEY,
    MonthNumber INT,
    MonthName VARCHAR(20)
);

-- Create the YearMonth table to link Year and Month
CREATE TABLE YearMonth (
    YearID INT,
    MonthID INT,
    FOREIGN KEY (YearID) REFERENCES Years(YearID),
    FOREIGN KEY (MonthID) REFERENCES Months(MonthID)
);

-- Create the table
CREATE TABLE CalendarData (
   ID INT primary key identity(1,1),
    MonthNumber INT ,
    DayNumber INT,
    Saturday VARCHAR(50),
    Sunday VARCHAR(50),
    Monday VARCHAR(50),
    Tuesday VARCHAR(50),
    Wednesday VARCHAR(50),
    Thursday VARCHAR(50),
    Friday VARCHAR(50),
	foreign key(MonthNumber) references Months(MonthID)
);

DECLARE @StartYear INT = 2020;  -- Replace with your desired start year
DECLARE @EndYear INT = 2025;    -- Replace with your desired end year

WHILE @StartYear <= @EndYear
BEGIN
    INSERT INTO Years (YearID, YearNumber)
    VALUES (@StartYear - @StartYear + 1, @StartYear);
    
    SET @StartYear = @StartYear + 1;
END