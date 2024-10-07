--CREATE DATABASE OnlineBookstoreDB;
--Go
--Use OnlineBookstoreDB
--GO
CREATE TABLE PersonType (
    PersonTypeID INT IDENTITY(1,1) PRIMARY KEY,
    PersonTypeName NVARCHAR(50) NOT NULL
);

CREATE TABLE Person (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    PersonTypeID INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NULL,
    Email NVARCHAR(50),
    AddressLine NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    BirthDate DATE NOT NULL,
    Nationality NVARCHAR(20) NOT NULL,
    Gender CHAR NOT NULL,
    CONSTRAINT FK_PersonTypeID_Person_PersonType FOREIGN KEY (PersonTypeID) REFERENCES PersonType(PersonTypeID)
);

CREATE TABLE Book (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorID INT,
    Title NVARCHAR(50) NOT NULL,
    ISBN INT NOT NULL,
    PublicationDate DATE NOT NULL,
    Qty INT NOT NULL CHECK (Qty > 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    CONSTRAINT FK_PersonID_Book_Author FOREIGN KEY (AuthorID) REFERENCES Person(PersonID)
);

CREATE TABLE Genre (
    GenreID INT IDENTITY(1,1) PRIMARY KEY,
    GenreName NVARCHAR(50) NOT NULL,
    GenreDescription TEXT NULL
);

CREATE TABLE BookGenre (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    GenreID INT,
    CONSTRAINT FK_BookID_BookGenre_Book FOREIGN KEY (BookID) REFERENCES Book(BookID),
    CONSTRAINT FK_GenreID_Genre FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)
);

CREATE TABLE TransactionHeader (
    TID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    UserID INT,
    TDate DATE DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_TransactionHeader_PersonID FOREIGN KEY (CustomerID) REFERENCES Person(PersonID),
    CONSTRAINT FK_TransactionHeader_UserID FOREIGN KEY (UserID) REFERENCES Person(PersonID)
);

CREATE TABLE TransactionDetail (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    TID INT,
    Qty INT CHECK (Qty > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    SubTotal DECIMAL(10,2) NULL,
    CONSTRAINT FK_TransactionDetail_TID FOREIGN KEY (TID) REFERENCES TransactionHeader(TID),
    CONSTRAINT FK_TransactionDetail_BookID FOREIGN KEY (BookID) REFERENCES Book(BookID)
);



-- Event table to store events for Person entity
CREATE TABLE PersonEvent (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT,
    EventType NVARCHAR(50) NOT NULL,
    EventData NVARCHAR(MAX) NOT NULL,
    EventTimestamp DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_PersonEvent_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Event table to store events for Book entity
CREATE TABLE BookEvent (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    EventType NVARCHAR(50) NOT NULL,
    EventData NVARCHAR(MAX) NOT NULL,
    EventTimestamp DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_BookEvent_Book FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- Event table to store events for TransactionHeader entity
CREATE TABLE TransactionHeaderEvent (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    TID INT,
    EventType NVARCHAR(50) NOT NULL,
    EventData NVARCHAR(MAX) NOT NULL,
    EventTimestamp DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_TransactionHeaderEvent_TransactionHeader FOREIGN KEY (TID) REFERENCES TransactionHeader(TID)
);

-- Event table to store events for TransactionDetail entity
CREATE TABLE TransactionDetailEvent (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    ID INT,
    EventType NVARCHAR(50) NOT NULL,
    EventData NVARCHAR(MAX) NOT NULL,
    EventTimestamp DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_TransactionDetailEvent_TransactionDetail FOREIGN KEY (ID) REFERENCES TransactionDetail(ID)
);




CREATE TABLE ArchivedEvent (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventType NVARCHAR(50) NOT NULL,
    EventData NVARCHAR(MAX) NOT NULL,
    EventTimestamp DATETIME2 NOT NULL,
    CONSTRAINT CK_ArchivedEvent_EventTimestamp CHECK (EventTimestamp < DATEADD(year, -1, GETDATE())) -- Example retention period of 1 year
);



-- Scheduled job to archive and purge events
-- This job can be scheduled to run periodically (e.g., once a day)
-- It moves events older than a certain threshold to the ArchivedEvent table and purges them from the event tables
-- Adjust the retention period and other criteria based on your requirements
-- Note: The following is a simplified example and may require customization for your specific environment and scheduling mechanism
CREATE PROCEDURE dbo.ArchiveAndPurgeEvents
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RetentionDate DATETIME2;
    SET @RetentionDate = DATEADD(year, -1, GETDATE()); -- Example retention period of 1 year

    -- Archive PersonEvents
    INSERT INTO ArchivedEvent (EventType, EventData, EventTimestamp)
    SELECT EventType, EventData, EventTimestamp
    FROM PersonEvent
    WHERE EventTimestamp < @RetentionDate;

    DELETE FROM PersonEvent
    WHERE EventTimestamp < @RetentionDate;

    -- Archive BookEvents
    INSERT INTO ArchivedEvent (EventType, EventData, EventTimestamp)
    SELECT EventType, EventData, EventTimestamp
    FROM BookEvent
    WHERE EventTimestamp < @RetentionDate;

    DELETE FROM BookEvent
    WHERE EventTimestamp < @RetentionDate;

    -- Archive TransactionHeaderEvents
    INSERT INTO ArchivedEvent (EventType, EventData, EventTimestamp)
    SELECT EventType, EventData, EventTimestamp
    FROM TransactionHeaderEvent
    WHERE EventTimestamp < @RetentionDate;

    DELETE FROM TransactionHeaderEvent
    WHERE EventTimestamp < @RetentionDate;

    -- Archive TransactionDetailEvents
    INSERT INTO ArchivedEvent (EventType, EventData, EventTimestamp)
    SELECT EventType, EventData, EventTimestamp
    FROM TransactionDetailEvent
    WHERE EventTimestamp < @RetentionDate;

    DELETE FROM TransactionDetailEvent
    WHERE EventTimestamp < @RetentionDate;
END;



GO
--how can i make this accept milion users
-- Indexes for the Person table
CREATE INDEX IX_Person_PersonTypeID ON Person (PersonTypeID);
CREATE INDEX IX_Person_Email ON Person (Email);

-- Indexes for the Book table
CREATE INDEX IX_Book_AuthorID ON Book (AuthorID);
CREATE INDEX IX_Book_ISBN ON Book (ISBN);

-- Indexes for the TransactionHeader table
CREATE INDEX IX_TransactionHeader_CustomerID ON TransactionHeader (CustomerID);
CREATE INDEX IX_TransactionHeader_UserID ON TransactionHeader (UserID);

-- Index for the TransactionDetail table
CREATE INDEX IX_TransactionDetail_TID ON TransactionDetail (TID);


-- Create a partition function
CREATE PARTITION FUNCTION PF_Person (INT)
AS RANGE LEFT FOR VALUES (100000, 200000, 300000); -- Adjust the partition values based on the data distribution

-- Create a partition scheme
CREATE PARTITION SCHEME PS_Person
AS PARTITION PF_Person
TO ([PRIMARY], [Partition1], [Partition2], [Partition3]);

-- Create the partitioned Person table
CREATE TABLE Person (
    PersonID INT NOT NULL,
    PersonTypeID INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NULL,
    Email NVARCHAR(50),
    AddressLine NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    BirthDate DATE NOT NULL,
    Nationality NVARCHAR(20) NOT NULL,
    Gender CHAR NOT NULL,
    CONSTRAINT PK_Person PRIMARY KEY (PersonID)
) ON PS_Person(PersonID);



--Data compression techniques
-- Enable PAGE compression for the Person table
ALTER TABLE Person REBUILD WITH (DATA_COMPRESSION = PAGE);




CREATE TABLE AuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(100) NOT NULL,
    RecordID INT NOT NULL,
    Operation CHAR(1) NOT NULL,
    OperationDate DATETIME NOT NULL,
    UserID INT,
    OldValue NVARCHAR(MAX),
    NewValue NVARCHAR(MAX)
);


--
-- Trigger for insert operation
CREATE TRIGGER Person_InsertTrigger
ON Person
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'Person', PersonID, 'I', GETDATE(), NULL, NULL, NULL
    FROM inserted;
END;

-- Trigger for update operation
CREATE TRIGGER Person_UpdateTrigger
ON Person
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'Person', PersonID, 'U', GETDATE(), NULL, CAST(d.FirstName AS NVARCHAR(MAX)), CAST(i.FirstName AS NVARCHAR(MAX))
    FROM deleted d
    INNER JOIN inserted i ON d.PersonID = i.PersonID;
END;

-- Trigger for delete operation
CREATE TRIGGER Person_DeleteTrigger
ON Person
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'Person', PersonID, 'D', GETDATE(), NULL, CAST(FirstName AS NVARCHAR(MAX)), NULL
    FROM deleted;
END;

go
-- Trigger for insert operation
CREATE TRIGGER Book_InsertTrigger
ON Book
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'Book', BookID, 'I', GETDATE(), NULL, NULL, NULL
    FROM inserted;
END;

-- Trigger for update operation
CREATE TRIGGER Book_UpdateTrigger
ON Book
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'Book', BookID, 'U', GETDATE(), NULL, CAST(d.Title AS NVARCHAR(MAX)), CAST(i.Title AS NVARCHAR(MAX))
    FROM deleted d
    INNER JOIN inserted i ON d.BookID = i.BookID;
END;

-- Trigger for delete operation
CREATE TRIGGER Book_DeleteTrigger
ON Book
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'Book', BookID, 'D', GETDATE(), NULL, CAST(Title AS NVARCHAR(MAX)), NULL
    FROM deleted;
END;
go

-- Trigger for insert operation
CREATE TRIGGER TransactionHeader_InsertTrigger
ON TransactionHeader
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'TransactionHeader', TransactionID, 'I', GETDATE(), NULL, NULL, NULL
    FROM inserted;
END;

-- Trigger for update operation
CREATE TRIGGER TransactionHeader_UpdateTrigger
ON TransactionHeader
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'TransactionHeader', TransactionID, 'U', GETDATE(), NULL, CAST(d.Status AS NVARCHAR(MAX)), CAST(i.Status AS NVARCHAR(MAX))
    FROM deleted d
    INNER JOIN inserted i ON d.TransactionID = i.TransactionID;
END;

-- Trigger for delete operation
CREATE TRIGGER TransactionHeader_DeleteTrigger
ON TransactionHeader
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Operation, OperationDate, UserID, OldValue, NewValue)
    SELECT 'TransactionHeader', TransactionID, 'D', GETDATE(), NULL, CAST(Status AS NVARCHAR(MAX)), NULL
    FROM deleted;
END;
go





--1. Hardware Optimization: Collaborate with system administrators and infrastructure teams to ensure that the hardware resources, such as CPU, memory, storage, and network, are adequately provisioned and optimized for database performance.

--1. Performance Monitoring: Implement monitoring tools and techniques to continuously monitor the performance of the database system. This includes tracking key performance indicators, identifying performance bottlenecks, and proactively addressing any issues that arise.

--1. Load Testing and Benchmarking: Conduct load testing and benchmarking exercises to simulate real-world scenarios and assess the performance of the database under different workload conditions. This helps identify potential performance issues and fine-tune the system accordingly.

--Its important to note that the specific performance tuning techniques may vary depending on the database management system (e.g., Oracle, SQL Server, MySQL) and the unique characteristics of the database and its workload. Database developers often use a combination of these techniques and employ iterative testing and optimization to achieve the desired performance improvements.

























