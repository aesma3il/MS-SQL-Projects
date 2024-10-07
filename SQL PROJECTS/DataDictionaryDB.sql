--CREATE DATABASE DataDictionaryDB
--go
--use DataDictionaryDB
--go 
CREATE TABLE Tables (
    TableID INT PRIMARY KEY,
    TableName VARCHAR(255) NOT NULL
);

CREATE TABLE Attributes (
    AttributeID INT PRIMARY KEY,
    TableID INT,
    AttributeName VARCHAR(255) NOT NULL,
    DataType VARCHAR(50) NOT NULL,
    Size INT,
    FOREIGN KEY (TableID) REFERENCES Tables (TableID)
);

CREATE TABLE ConstraintTypes (
    ConstraintTypeID INT PRIMARY KEY,
    ConstraintTypeName VARCHAR(255) NOT NULL
);

CREATE TABLE Constraints (
    ConstraintID INT PRIMARY KEY,
    AttributeID INT,
    ConstraintTypeID INT,
    ConstraintName VARCHAR(255) NOT NULL,
    ReferenceTable VARCHAR(255),
    FOREIGN KEY (AttributeID) REFERENCES Attributes (AttributeID),
    FOREIGN KEY (ConstraintTypeID) REFERENCES ConstraintTypes (ConstraintTypeID)
);