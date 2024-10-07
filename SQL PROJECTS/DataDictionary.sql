-- Create the database
CREATE DATABASE DataDictionary;
GO

-- Use the database
USE DataDictionary;
GO

-- Create the table for storing tables information
CREATE TABLE Tables (
    TableID INT PRIMARY KEY,
    TableName VARCHAR(100),
    Description VARCHAR(500)
);
GO

-- Create the table for storing column information
CREATE TABLE Columns (
    ColumnID INT PRIMARY KEY,
    TableID INT,
    ColumnName VARCHAR(100),
    DataType VARCHAR(50),
    Description VARCHAR(500),
    IsNullable BIT,
    IsPrimaryKey BIT,
    CONSTRAINT FK_Columns_Tables FOREIGN KEY (TableID)
        REFERENCES Tables (TableID)
);
GO

-- Create the table for storing constraints information
CREATE TABLE Constraints (
    ConstraintID INT PRIMARY KEY,
    TableID INT,
    ConstraintName VARCHAR(100),
    Type VARCHAR(50),
    Description VARCHAR(500),
    CONSTRAINT FK_Constraints_Tables FOREIGN KEY (TableID)
        REFERENCES Tables (TableID)
);
GO

-- Create the table for storing indexes information
CREATE TABLE Indexes (
    IndexID INT PRIMARY KEY,
    TableID INT,
    IndexName VARCHAR(100),
    ColumnName VARCHAR(100),
    IsUnique BIT,
    IsClustered BIT,
    CONSTRAINT FK_Indexes_Tables FOREIGN KEY (TableID)
        REFERENCES Tables (TableID)
);
GO

-- Create the table for storing triggers information
CREATE TABLE Triggers (
    TriggerID INT PRIMARY KEY,
    TableID INT,
    TriggerName VARCHAR(100),
    EventType VARCHAR(50),
    Description VARCHAR(500),
    CONSTRAINT FK_Triggers_Tables FOREIGN KEY (TableID)
        REFERENCES Tables (TableID)
);
GO

-- Create the table for storing views information
CREATE TABLE Views (
    ViewID INT PRIMARY KEY,
    ViewName VARCHAR(100),
    Definition VARCHAR(MAX),
    Description VARCHAR(500)
);
GO

-- Create the table for storing stored procedures information
CREATE TABLE StoredProcedures (
    ProcedureID INT PRIMARY KEY,
    ProcedureName VARCHAR(100),
    Definition VARCHAR(MAX),
    Description VARCHAR(500)
);
GO

-- Create the table for storing functions information
CREATE TABLE Functions (
    FunctionID INT PRIMARY KEY,
    FunctionName VARCHAR(100),
    ReturnType VARCHAR(50),
    Definition VARCHAR(MAX),
    Description VARCHAR(500)
);
GO

-- Create the table for storing user-defined types information
CREATE TABLE UserDefinedTypes (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(100),
    BaseType VARCHAR(100),
    Description VARCHAR(500)
);
GO

-- Create the table for storing synonyms information
CREATE TABLE Synonyms (
    SynonymID INT PRIMARY KEY,
    SynonymName VARCHAR(100),
    BaseObjectSchema VARCHAR(100),
    BaseObjectName VARCHAR(100),
    Description VARCHAR(500)
);
GO