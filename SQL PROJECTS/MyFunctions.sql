

CREATE FUNCTION IsPasswordStrong (@Password VARCHAR(100))
RETURNS BIT
AS
BEGIN
    DECLARE @IsStrong BIT = 0;

    IF LEN(@Password) >= 8
        AND @Password <> UPPER(@Password)
        AND @Password <> LOWER(@Password)
        AND @Password LIKE '%[0-9]%'
        AND @Password LIKE '%[^a-zA-Z0-9]%'
    BEGIN
        SET @IsStrong = 1;
    END

    RETURN @IsStrong;
END;
go

--SELECT dbo.IsPasswordStrong('Abcd1234') AS IsStrong;

CREATE FUNCTION GenerateRandomNumber
(
    @Min INT,
    @Max INT
)
RETURNS INT
AS
BEGIN
    RETURN FLOOR((RAND() * (@Max - @Min + 1)) + @Min);
END;

go
CREATE FUNCTION RemoveNonNumericCharacters
(
    @InputString VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @OutputString VARCHAR(100);
    SET @OutputString = '';
    
    SELECT @OutputString = @OutputString + SUBSTRING(@InputString, Numbers.Number, 1)
    FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Numbers(Number)
    WHERE ISNUMERIC(SUBSTRING(@InputString, Numbers.Number, 1)) = 1;
    
    RETURN @OutputString;
END;

go
CREATE FUNCTION RemoveNonNumericCharacters
(
    @InputString VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @OutputString VARCHAR(100);
    SET @OutputString = '';
    
    SELECT @OutputString = @OutputString + SUBSTRING(@InputString, Numbers.Number, 1)
    FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Numbers(Number)
    WHERE ISNUMERIC(SUBSTRING(@InputString, Numbers.Number, 1)) = 1;
    
    RETURN @OutputString;
END;
go

CREATE FUNCTION CalculateAge
(
    @DateOfBirth DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @Age INT = YEAR(@CurrentDate) - YEAR(@DateOfBirth);
    
    IF (MONTH(@CurrentDate) < MONTH(@DateOfBirth) OR (MONTH(@CurrentDate) = MONTH(@DateOfBirth) AND DAY(@CurrentDate) < DAY(@DateOfBirth)))
    BEGIN
        SET @Age = @Age - 1;
    END
    
    RETURN @Age;
END;
go

CREATE FUNCTION FormatNumberWithCommas
(
    @Number DECIMAL(18,2)
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @FormattedNumber VARCHAR(50);
    
    SET @FormattedNumber = CONVERT(VARCHAR, @Number, 1);
    SET @FormattedNumber = REPLACE(@FormattedNumber, '.', ',');
    
    RETURN @FormattedNumber;
END;

go

CREATE FUNCTION CalculateDateDifferenceInDays
(
    @StartDate DATE,
    @EndDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @DaysDiff INT;
    
    SET @DaysDiff = DATEDIFF(DAY, @StartDate, @EndDate);
    
    RETURN @DaysDiff;
END;
go

CREATE FUNCTION GenerateRandomString
(
    @Length INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Chars VARCHAR(62) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    DECLARE @RandomString VARCHAR(100) = '';
    DECLARE @Index INT = 1;
    
    WHILE @Index <= @Length
    BEGIN
        SET @RandomString = @RandomString + SUBSTRING(@Chars, CAST((RAND() * 62) + 1 AS INT), 1);
        SET @Index = @Index + 1;
    END;
    
    RETURN @RandomString;
END;

go

CREATE FUNCTION CalculateAgeDetailed
(
    @DateOfBirth DATE
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @Years INT, @Months INT, @Days INT;
    
    SELECT @Years = DATEDIFF(YEAR, @DateOfBirth, @CurrentDate) - CASE WHEN (MONTH(@CurrentDate) < MONTH(@DateOfBirth) OR (MONTH(@CurrentDate) = MONTH(@DateOfBirth) AND DAY(@CurrentDate) < DAY(@DateOfBirth))) THEN 1 ELSE 0 END;
    SELECT @Months = MONTH(@CurrentDate) - MONTH(@DateOfBirth) - CASE WHEN DAY(@CurrentDate) < DAY(@DateOfBirth) THEN 1 ELSE 0 END;
    SELECT @Days = DAY(@CurrentDate) - DAY(@DateOfBirth) + CASE WHEN @Months < 0 THEN 30 ELSE 0 END;
    
    RETURN CONCAT(@Years, ' years, ', @Months, ' months, ', @Days, ' days');
END;
go

CREATE FUNCTION SplitStringIntoRows
(
    @InputString VARCHAR(MAX),
    @Delimiter CHAR(1)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Value
    FROM STRING_SPLIT(@InputString, @Delimiter)
);
go




