-- Create the AccountTypes table
CREATE TABLE AccountTypes (
  AccountTypeID INT IDENTITY(1,1) PRIMARY KEY,
  TypeName VARCHAR(50)
);

-- Create the Accounts table
CREATE TABLE Accounts (
  AccountID INT IDENTITY(1,1) PRIMARY KEY,
  AccountName VARCHAR(50),
  AccountTypeID INT,
  ParentAccountID INT,
  FOREIGN KEY (AccountTypeID) REFERENCES AccountTypes(AccountTypeID),
  FOREIGN KEY (ParentAccountID) REFERENCES Accounts(AccountID)
);

-- Create the JournalTypes table
CREATE TABLE JournalTypes (
  TypeID INT IDENTITY(1,1) PRIMARY KEY,
  TypeName VARCHAR(50),
  Description VARCHAR(255)
);

-- Create the JournalEntries table
CREATE TABLE JournalEntries (
  EntryID INT IDENTITY(1,1) PRIMARY KEY,
  Date DATE,
  Description VARCHAR(255),
  TypeID INT,
  FOREIGN KEY (TypeID) REFERENCES JournalTypes(TypeID)
);

-- Create the EntryLines table
CREATE TABLE EntryLines (
  EntryLineID INT IDENTITY(1,1) PRIMARY KEY,
  EntryID INT,
  AccountID INT,
  Amount DECIMAL(18, 2),
  DebitCredit VARCHAR(10),
  FOREIGN KEY (EntryID) REFERENCES JournalEntries(EntryID),
  FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);