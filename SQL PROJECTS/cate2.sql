-- AccountCategories table
-- AccountCategories table
CREATE TABLE AccountCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50)
);

-- AccountTypes table
CREATE TABLE AccountTypes (
    AccountTypeID INT IDENTITY(1,1) PRIMARY KEY,
    AccountTypeName VARCHAR(50),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES AccountCategories(CategoryID)
);

-- NormalBalances table
CREATE TABLE NormalBalances (
    NormalBalanceID INT IDENTITY(1,1) PRIMARY KEY,
    NormalBalance VARCHAR(10) NOT NULL
);
CREATE TABLE Currencies (
    CurrencyID INT IDENTITY(1,1) PRIMARY KEY,
    CurrencyCode VARCHAR(10),
    Symbol VARCHAR(10),
    -- Add other relevant attributes for currencies
);


CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountName VARCHAR(100),
    ParentAccountID INT,
    FOREIGN KEY (ParentAccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE AccountHierarchy (
    AccountID INT,
    ParentAccountID INT,
    PRIMARY KEY (AccountID, ParentAccountID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (ParentAccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE AccountCurrency (
    AccountID INT,
    CurrencyID INT,
    PRIMARY KEY (AccountID, CurrencyID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CurrencyID) REFERENCES Currencies(CurrencyID)
);

CREATE TABLE AccountDetails (
    AccountID INT,
    CategoryID INT,
    AccountTypeID INT,
    NormalBalanceID INT,
    PRIMARY KEY (AccountID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CategoryID) REFERENCES AccountCategories(CategoryID),
    FOREIGN KEY (AccountTypeID) REFERENCES AccountTypes(AccountTypeID),
    FOREIGN KEY (NormalBalanceID) REFERENCES NormalBalances(NormalBalanceID)
);


-- TransactionTypes table
CREATE TABLE TransactionTypes (
    TransactionTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionTypeName VARCHAR(50)
);

-- Transactions table
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionTypeID INT,
    TransactionDate DATE,
    Description VARCHAR(100),
    -- Add other relevant attributes for transactions
    FOREIGN KEY (TransactionTypeID) REFERENCES TransactionTypes(TransactionTypeID)
);

-- TransactionAccounts table
CREATE TABLE TransactionAccounts (
    TransactionAccountID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionID INT,
    AccountID INT,
    Amount DECIMAL(18, 2),
    -- Add other relevant attributes for the transaction-account relationship
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);



-- Users table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName VARCHAR(50),
    -- Add other relevant attributes for users
);




-- Transactions table
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionTypeID INT,
    CurrencyID INT, -- Added foreign key column
    TransactionDate DATE,
    Description VARCHAR(100),
    -- Add other relevant attributes for transactions
    FOREIGN KEY (TransactionTypeID) REFERENCES TransactionTypes(TransactionTypeID),
    FOREIGN KEY (CurrencyID) REFERENCES Currencies(CurrencyID) -- Foreign key constraint
);



-- Inserting data into AccountCategories table
INSERT INTO AccountCategories (CategoryName)
VALUES ('Assets'),
       ('Liabilities'),
       ('Equity'),
       ('Income'),
       ('Expenses'),
       ('Gains'),
       ('Losses');
	   
-- Inserting data into AccountTypes table
INSERT INTO AccountTypes (AccountTypeName, CategoryID)
VALUES ('Cash and Cash Equivalents', 1),
       ('Accounts Receivable', 1),
       ('Inventory', 1),
       ('Property, Plant, and Equipment', 1),
       ('Investments', 1),
       ('Intangible Assets', 1),
       ('Accounts Payable', 2),
       ('Loans and Borrowings', 2),
       ('Accrued Expenses', 2),
       ('Deferred Revenues', 2),
       ('Provisions', 2),
       ('Share Capital', 3),
       ('Retained Earnings', 3),
       ('Reserves', 3),
       ('Sales Revenue', 4),
       ('Service Revenue', 4),
       ('Interest Income', 4),
       ('Rental Income', 4),
       ('Other Operating Income', 4),
       ('Cost of Goods Sold', 5),
       ('Employee Salaries and Benefits', 5),
       ('Rent Expense', 5),
       ('Utilities Expense', 5),
       ('Advertising and Marketing Expense', 5),
       ('Depreciation and Amortization', 5),
       ('Interest Expense', 5),
       ('Taxes and Duties', 5),
       ('Gain on Sale of Assets', 6),
       ('Gain on Investments', 6),
       ('Loss on Impairment of Assets', 7),
       ('Loss on Investments', 7);

-- Inserting data into NormalBalances table
INSERT INTO NormalBalances (NormalBalance)
VALUES ('Debit'),
       ('Credit');

-- Inserting data into Currencies table
INSERT INTO Currencies (CurrencyCode, Symbol)
VALUES ('USD', '$'),
       ('EUR', '€'),
       ('JPY', '¥');

-- Note: The above data is just an example and may not reflect the complete ISCA structure or real-world values.





INSERT INTO Accounts (AccountName, CategoryID, AccountTypeID, NormalBalanceID, ParentAccountID, CurrencyID)
VALUES ('Cash on Hand', 1, 1, 1, NULL, 1),
       ('Checking Account', 1, 1, 1, NULL, 1),
       ('Savings Account', 1, 1, 1, NULL, 1),
       ('Accounts Receivable', 1, 2, 2, NULL, 1),
       ('Raw Materials Inventory', 1, 3, 2, NULL, 1),
       ('Work-in-Progress Inventory', 1, 3, 2, NULL, 1),
       ('Finished Goods Inventory', 1, 3, 2, NULL, 1),
       ('Land', 1, 4, 2, NULL, 1),
       ('Buildings', 1, 4, 2, NULL, 1),
       ('Machinery', 1, 4, 2, NULL, 1),
       ('Stocks', 1, 5, 2, NULL, 1),
       ('Bonds', 1, 5, 2, NULL, 1),
       ('Patents', 1, 6, 2, NULL, 1),
       ('Trademarks', 1, 6, 2, NULL, 1),
       ('Goodwill', 1, 6, 2, NULL, 1);

-- Liabilities
INSERT INTO Accounts (AccountName, CategoryID, AccountTypeID, NormalBalanceID, ParentAccountID, CurrencyID)
VALUES ('Accounts Payable', 2, 7, 1, NULL, 1),
       ('Loans Payable', 2, 8, 1, NULL, 1),
       ('Accrued Salaries', 2, 9, 1, NULL, 1),
       ('Unearned Revenue', 2, 10, 1, NULL, 1),
       ('Provision for Bad Debts', 2, 11, 1, NULL, 1);

-- Equity
INSERT INTO Accounts (AccountName, CategoryID, AccountTypeID, NormalBalanceID, ParentAccountID, CurrencyID)
VALUES ('Share Capital', 3, 12, 1, NULL, 1),
       ('Retained Earnings', 3, 13, 1, NULL, 1),
       ('General Reserve', 3, 14, 1, NULL, 1);

-- Income
INSERT INTO Accounts (AccountName, CategoryID, AccountTypeID, NormalBalanceID, ParentAccountID, CurrencyID)
VALUES ('Sales Revenue', 4, 15, 1, NULL, 1),
       ('Service Revenue', 4, 16, 1, NULL, 1),
       ('Interest Income', 4, 17, 1, NULL, 1),
       ('Rental Income', 4, 18, 1, NULL, 1),
       ('Other Operating Income', 4, 19, 1, NULL, 1);

-- Expenses
INSERT INTO Accounts (AccountName, CategoryID, AccountTypeID, NormalBalanceID, ParentAccountID, CurrencyID)
VALUES ('Cost of Goods Sold', 5, 20, 2, NULL, 1),
       ('Employee Salaries and Benefits', 5, 21, 2, NULL, 1),
       ('Rent Expense', 5, 22, 2, NULL, 1),
       ('Utilities Expense', 5, 23, 2, NULL, 1),
       ('Advertising and Marketing Expense', 5, 24, 2, NULL, 1),
       ('Depreciation and Amortization', 5, 25, 2, NULL, 1),
       ('Interest Expense', 5, 26, 2, NULL, 1),
       ('Taxes and Duties', 5, 27, 2, NULL, 1);

-- Gains
INSERT INTO Accounts (AccountName, CategoryID, AccountTypeID, NormalBalanceID, ParentAccountID, CurrencyID)
VALUES ('Gain on Sale of Assets', 6, 28, 1, NULL, 1),
       ('Gain on Investments', 6, 29, 1, NULL, 1);

-- Losses
INSERT INTO Accounts (AccountName, CategoryID, AccountTypeID, NormalBalanceID, ParentAccountID, CurrencyID)
VALUES ('Loss on Impairment of Assets', 7, 30, 2, NULL, 1);

select * from AccountTypes

-- Create the master view
CREATE VIEW MasterView AS
SELECT
    A.AccountID,
    A.AccountName,
    AC.CategoryName,
    AT.AccountTypeName,
    NB.NormalBalance,
    A.ParentAccountID,
    C.CurrencyCode,
    C.Symbol
FROM
    Accounts A
    INNER JOIN AccountCategories AC ON A.CategoryID = AC.CategoryID
    INNER JOIN AccountTypes AT ON A.AccountTypeID = AT.AccountTypeID
    INNER JOIN NormalBalances NB ON A.NormalBalanceID = NB.NormalBalanceID
    LEFT JOIN Currencies C ON A.CurrencyID = C.CurrencyID;