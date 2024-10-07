-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Create Supplier table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Create User table
CREATE TABLE [User] (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    Role VARCHAR(50)
);

-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description VARCHAR(255),
    Price DECIMAL(10, 2)
);


CREATE TABLE TransactionType (
    TransactionTypeID INT PRIMARY KEY,
    TransactionTypeName VARCHAR(50)
);

CREATE TABLE TransactionHeader (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    TransactionTypeID INT FOREIGN KEY REFERENCES TransactionType(TransactionTypeID)
);



-- Create TransactionDetail table
CREATE TABLE TransactionDetail (
    DetailID INT PRIMARY KEY,
    TransactionID INT FOREIGN KEY REFERENCES TransactionHeader(TransactionID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);


CREATE TABLE PurchaseTransaction (
    TransactionID INT PRIMARY KEY,
    SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID),
    PurchaseAmount DECIMAL(10, 2)
);

-- Create PurchaseTransactionDetail table
CREATE TABLE PurchaseTransactionDetail (
    DetailID INT PRIMARY KEY,
    TransactionID INT FOREIGN KEY REFERENCES PurchaseTransaction(TransactionID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);



-- Create SaleTransaction table
CREATE TABLE SaleTransaction (
    TransactionID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    SaleAmount DECIMAL(10, 2)
);

-- Create SaleTransactionDetail table
CREATE TABLE SaleTransactionDetail (
    DetailID INT PRIMARY KEY,
    TransactionID INT FOREIGN KEY REFERENCES SaleTransaction(TransactionID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

-- Create Payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    TransactionID INT FOREIGN KEY REFERENCES TransactionHeader(TransactionID),
    Amount DECIMAL(10, 2),
    PaymentDate DATE
);




-- Create ReturnReason table
CREATE TABLE ReturnReason (
    ReasonID INT PRIMARY KEY,
    ReasonDescription VARCHAR(255)
);

-- Create ReturnTransaction table
CREATE TABLE ReturnTransaction (
    ReturnID INT PRIMARY KEY,
    TransactionID INT FOREIGN KEY REFERENCES TransactionHeader(TransactionID),
    ReturnDate DATE,
    ReasonID INT FOREIGN KEY REFERENCES ReturnReason(ReasonID)
);

-- Create ReturnTransactionDetail table
CREATE TABLE ReturnTransactionDetail (
    DetailID INT PRIMARY KEY,
    ReturnID INT FOREIGN KEY REFERENCES ReturnTransaction(ReturnID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT
);





-- Create Review table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    Rating INT,
    Comment VARCHAR(255)
);

-- Create Wishlist table
CREATE TABLE Wishlist (
    WishlistID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID)
);

-- Create Promotion table
CREATE TABLE Promotion (
    PromotionID INT PRIMARY KEY,
    PromotionName VARCHAR(100),
    Discount DECIMAL(5, 2)
);

-- Create PromotionProduct table
CREATE TABLE PromotionProduct (
    PromotionID INT FOREIGN KEY REFERENCES Promotion(PromotionID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    PRIMARY KEY (PromotionID, ProductID)
);


-- Create ChartOfAccounts table
CREATE TABLE ChartOfAccounts (
    AccountID INT PRIMARY KEY,
    AccountName VARCHAR(100),
    AccountType VARCHAR(50)
);

-- Create Account table
CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    AccountNumber VARCHAR(20),
    Description VARCHAR(255)
);

-- Create AccountTransaction table
CREATE TABLE AccountTransaction (
    TransactionID INT PRIMARY KEY REFERENCES TransactionHeader(TransactionID),
    AccountID INT REFERENCES Account(AccountID),
    Amount DECIMAL(10, 2),
    DebitCredit VARCHAR(1)
);

-- Create JournalEntry table
CREATE TABLE JournalEntry (
    EntryID INT PRIMARY KEY,
    TransactionID INT REFERENCES TransactionHeader(TransactionID),
    EntryDate DATE,
    Description VARCHAR(255)
);

-- Create Ledger table
CREATE TABLE Ledger (
    LedgerID INT PRIMARY KEY,
    AccountID INT REFERENCES Account(AccountID),
    EntryID INT REFERENCES JournalEntry(EntryID),
    Amount DECIMAL(10, 2),
    DebitCredit VARCHAR(1)
);

-- Create TrialBalance table
CREATE TABLE TrialBalance (
    AccountID INT PRIMARY KEY REFERENCES Account(AccountID),
    DebitAmount DECIMAL(10, 2),
    CreditAmount DECIMAL(10, 2)
);


-- Create User table
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    AccountID INT REFERENCES Account(AccountID)
);

-- Add AccountID column to Account table
ALTER TABLE Account
ADD AccountID INT;



-- Add foreign key constraint to AccountID column in Account table
ALTER TABLE Account
ADD FOREIGN KEY (AccountID) REFERENCES User(AccountID);

