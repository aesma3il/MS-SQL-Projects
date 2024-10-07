CREATE TABLE JournalEntry (
    EntryID INT PRIMARY KEY,
    [Date] DATE,
    Number VARCHAR(255),
    Account VARCHAR(255),
    Partner VARCHAR(255),
    Label VARCHAR(255),
    Debit DECIMAL(10, 2),
    Credit DECIMAL(10, 2),
    MatchingNumber VARCHAR(255)
);


CREATE TABLE JournalEntry (
    EntryID INT PRIMARY KEY,
    [Date] DATE,
    Number VARCHAR(255),
    Partner VARCHAR(255),
    Reference VARCHAR(255),
    Journal VARCHAR(255),
    TotalSigned DECIMAL(10, 2),
    [Status] VARCHAR(50)
);



CREATE TABLE JournalItem (
    ItemID INT PRIMARY KEY,
    EntryID INT,
    [Date] DATE,
    Number VARCHAR(255),
    Account VARCHAR(255),
    Partner VARCHAR(255),
    Label VARCHAR(255),
    Debit DECIMAL(10, 2),
    Credit DECIMAL(10, 2),
    MatchingNumber VARCHAR(255),
    FOREIGN KEY (EntryID) REFERENCES JournalEntry(EntryID)
);


--customer invoice
CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY,
    Number VARCHAR(255),
    PartnerDisplayName VARCHAR(255),
    InvoiceDate DATE,
    DueDate DATE,
    Activities VARCHAR(255),
    UntaxedAmountSigned DECIMAL(10, 2),
    TotalSigned DECIMAL(10, 2),
    PaymentStatus VARCHAR(50),
    [Status] VARCHAR(50)
);



CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    [Date] DATE,
    Number VARCHAR(255),
    Journal VARCHAR(255),
    PaymentMethod VARCHAR(255),
    CustomerVendor VARCHAR(255),
    AmountCompanyCurrency DECIMAL(10, 2),
    Signed BIT,
    [Status] VARCHAR(50)
);






CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    IsCompany BIT,
    CompanyName VARCHAR(255),
    CountryID INT,
    StateID INT,
    Zip VARCHAR(255),
    City VARCHAR(255),
    Street VARCHAR(255),
    Street2 VARCHAR(255),
    Phone VARCHAR(255),
    Mobile VARCHAR(255),
    Email VARCHAR(255),
    VAT VARCHAR(255),
    BankIDs JSON
);



CREATE TABLE CreditNote (
    CreditNoteID INT PRIMARY KEY,
    Number VARCHAR(255),
    PartnerDisplayName VARCHAR(255),
    CreditNoteDate DATE,
    DueDate DATE,
    Activities VARCHAR(255),
    UntaxedAmountSigned DECIMAL(10, 2),
    TotalSigned DECIMAL(10, 2),
    PaymentStatus VARCHAR(50),
    [Status] VARCHAR(50)
);


CREATE TABLE FollowUpReport (
    TaskID INT PRIMARY KEY,
    Name VARCHAR(255),
    Responsible VARCHAR(255),
    Reminders VARCHAR(255),
    FollowUpStatus VARCHAR(50),
    NextReminder DATE,
    FollowUpLevel INT,
    TotalDue DECIMAL(10, 2),
    TotalOverdue DECIMAL(10, 2),
    Activities VARCHAR(255)
);


CREATE TABLE ChartOfAccounts (
    Code VARCHAR(10) PRIMARY KEY,
    AccountName VARCHAR(255),
    AccountType VARCHAR(50),
    AllowReconciliation BIT
);

CREATE TABLE Currency (
    CurrencyID INT PRIMARY KEY,
    CurrencyName VARCHAR(255),
    Symbol VARCHAR(10),
    Date DATE,
    CurrentRate DECIMAL(10, 4),
    Active BIT
);

CREATE TABLE JournalGroup (
    GroupID INT PRIMARY KEY,
    Sequence INT,
    JournalGroup VARCHAR(255),
    ExcludedJournals VARCHAR(MAX)
);


CREATE TABLE Journals (
    JournalID INT PRIMARY KEY,
    Sequence INT,
    JournalName VARCHAR(255),
    Type VARCHAR(50),
    JournalGroups VARCHAR(255),
    ShortCode VARCHAR(50),
    DefaultAccount VARCHAR(255)
);

CREATE TABLE Tax (
    TaxID INT PRIMARY KEY,
    Sequence INT,
    TaxName VARCHAR(255),
    Description VARCHAR(255),
    TaxType VARCHAR(50),
    TaxScope VARCHAR(50),
    LabelOnInvoices VARCHAR(255),
    Active BIT
);

CREATE TABLE FollowUpLevel (
    LevelID INT PRIMARY KEY,
    Description VARCHAR(255),
    DueDays INT,
    SendEmail BIT,
    SendSMSMessage BIT,
    SendLetter BIT,
    Automatic BIT,
    ActivityType VARCHAR(50)
);

CREATE TABLE FixedAsset (
    AssetID INT PRIMARY KEY,
    AssetName VARCHAR(255),
    FixedAssetAccount VARCHAR(255),
    DepreciationAccount VARCHAR(255),
    Method VARCHAR(50),
    Duration INT,
    MonthsInPeriod INT
);


CREATE TABLE UnpostedJournalEntry (
    EntryID INT PRIMARY KEY,
    Journal VARCHAR(255),
    Account VARCHAR(255),
    Ref VARCHAR(255),
    DueDate DATE,
    MatchingNumber VARCHAR(255),
    Debit DECIMAL(10, 2),
    Credit DECIMAL(10, 2),
    AmountCurrency VARCHAR(50),
    Balance DECIMAL(10, 2)
);





