CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    AccountGUID UNIQUEIDENTIFIER,
    AccountName VARCHAR(100),
    ParentAccountID INT,
    AccountCode VARCHAR(10),
    FinalAccountID INT,
	CurrentBalance DECIMAL(10, 2),
    FOREIGN KEY (ParentAccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (FinalAccountID) REFERENCES Account(AccountID)
);


CREATE TABLE Journal (
    JournalID INT PRIMARY KEY,
    JournalGuid UNIQUEIDENTIFIER,
    JournalDate DATE,
    Note VARCHAR(255),
    JournalType VARCHAR(50)
);


CREATE TABLE JournalEntry (
    EntryID INT PRIMARY KEY,
    JournalID INT,
    EntryDate DATE,
    AccountID INT, 
    Debit DECIMAL(10, 2),
    Credit DECIMAL(10, 2),
    Description VARCHAR(255),
    FOREIGN KEY (JournalID) REFERENCES Journal(JournalID),
	 FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);


CREATE TABLE VoucherType (
    VoucherTypeID INT PRIMARY KEY,
    VoucherTypeCode VARCHAR(10),
    VoucherTypeName VARCHAR(100)
);

CREATE TABLE Voucher (
    VoucherID INT PRIMARY KEY,
    VoucherTypeID INT,
    AccountID INT,
    Description VARCHAR(255),
    VoucherNumber VARCHAR(20),
    VoucherDate DATE,
	IsPosted BIT,
    FOREIGN KEY (VoucherTypeID) REFERENCES VoucherType(VoucherTypeID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);



CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    Amount DECIMAL(10, 2),
    Description VARCHAR(255),
    DebitAccountID INT,
    CreditAccountID INT,
    FOREIGN KEY (DebitAccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (CreditAccountID) REFERENCES Account(AccountID)
);




-- Create Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255)
    -- Add any additional fields specific to categories
);

-- Create Item Table
CREATE TABLE Item (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(255),
    CategoryID INT,
    -- Add any additional fields specific to items
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Create Store Table
CREATE TABLE Store (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(255)
    -- Add any additional fields specific to stores
);

-- Create Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255)
    -- Add any additional fields specific to customers
);

-- Create InvoiceType Table
CREATE TABLE InvoiceType (
    InvoiceTypeID INT PRIMARY KEY,
    InvoiceTypeName VARCHAR(255)
    -- Add any additional fields specific to invoice types
);

-- Create InvoiceHeader Table
CREATE TABLE InvoiceHeader (
    InvoiceID INT PRIMARY KEY,
    InvoiceNumber VARCHAR(20),
    InvoiceDate DATE,
    CustomerID INT,
    StoreID INT,
    InvoiceTypeID INT,
    -- Add any additional fields specific to invoice headers
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    FOREIGN KEY (InvoiceTypeID) REFERENCES InvoiceType(InvoiceTypeID)
);

-- Create InvoiceDetails Table
CREATE TABLE InvoiceDetails (
    InvoiceDetailID INT PRIMARY KEY,
    InvoiceID INT,
    ItemID INT,
    Quantity INT,
    UnitPrice DECIMAL(18, 2),
    -- Add any additional fields specific to invoice details
    FOREIGN KEY (InvoiceID) REFERENCES InvoiceHeader(InvoiceID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);

