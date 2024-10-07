
-- AccountClassifications table
CREATE TABLE AccountClassifications (
    AccountClassificationID INT IDENTITY(1,1) PRIMARY KEY,
    AccountClassificationName VARCHAR(20)
);

CREATE TABLE FinancialStatements (
    FinancialStatementID INT IDENTITY(1,1) PRIMARY KEY,
    FinancialStatementName VARCHAR(50)
);
-- Categories table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50)
);
-- AccountTypes table
CREATE TABLE AccountTypes (
    AccountTypeID INT IDENTITY(1,1) PRIMARY KEY,
    AccountTypeName VARCHAR(50)
);

-- FinancialStatements table


-- NormalBalances table
CREATE TABLE NormalBalances (
    NormalBalanceID INT IDENTITY(1,1) PRIMARY KEY,
    NormalBalanceName VARCHAR(50)
);

-- Currencies table
CREATE TABLE Currencies (
    CurrencyID INT IDENTITY(1,1) PRIMARY KEY,
    CurrencyCode VARCHAR(3),
    CurrencyName VARCHAR(50)
);

-- Accounts table
CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    AccountNumber VARCHAR(10),
    AccountName VARCHAR(100),
    AccountTypeID INT,
    ParentAccountID INT,
    OpeningBalance DECIMAL(18, 2),
    CurrencyID INT,
    IsInactive BIT,
    CreatedDate DATETIME,
    UpdatedDate DATETIME,
    CategoryID INT,
    AccountClassificationID INT, -- New column for account classification
	NormalBalanceID INT,
    FOREIGN KEY (AccountTypeID) REFERENCES AccountTypes(AccountTypeID),
    FOREIGN KEY (ParentAccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (CurrencyID) REFERENCES Currencies(CurrencyID),
    FOREIGN KEY (AccountClassificationID) REFERENCES AccountClassifications(AccountClassificationID),
	 FOREIGN KEY (NormalBalanceID) REFERENCES NormalBalances(NormalBalanceID)
);


select * from NormalBalances
   




-- Insert sample data into NormalBalances
INSERT INTO NormalBalances (NormalBalanceName)
VALUES ('Debit'), ('Credit');

-- Insert sample data into Currencies
INSERT INTO Currencies (CurrencyCode, CurrencyName)
VALUES ('USD', 'United States Dollar'), ('EUR', 'Euro'), ('GBP', 'British Pound'), ('JPY', 'Japanese Yen');

-- Insert sample data into AccountTypes
INSERT INTO AccountTypes (AccountTypeName)
VALUES ('Asset'), ('Liability'), ('Equity'), ('Revenue'), ('Expense');


-- Insert sample data into FinancialStatements
INSERT INTO FinancialStatements (FinancialStatementName)
VALUES ('Income Statement'), ('Balance Sheet');

INSERT INTO Accounts (
    AccountNumber, AccountName, AccountTypeID, ParentAccountID,
    OpeningBalance, CurrencyID, IsInactive, CreatedDate, UpdatedDate
)
VALUES
    ('1000', 'Assets', 1, NULL, 0.00, 1, 0, GETDATE(), GETDATE()),
    ('1100', 'Cash', 1, 1, 5000.00, 2, 0, GETDATE(), GETDATE()),
    ('1200', 'Accounts Receivable', 1, 1, 0.00, 2, 0, GETDATE(), GETDATE()),
    ('1210', 'Trade Receivables', 1, 3, 0.00, 1, 0, GETDATE(), GETDATE());



	go

	CREATE VIEW MasterView AS
SELECT
    A.AccountID,
    A.AccountNumber,
    A.AccountName,
    A.OpeningBalance,
    A.IsInactive,
    A.CreatedDate,
    A.UpdatedDate,
    AT.AccountTypeName,
    C.CategoryName,
    AC.AccountClassificationName,
    N.NormalBalanceName,
    Cur.CurrencyCode,
    Cur.CurrencyName
FROM
    Accounts A
    INNER JOIN AccountTypes AT ON A.AccountTypeID = AT.AccountTypeID
    LEFT JOIN Categories C ON A.CategoryID = C.CategoryID
    LEFT JOIN AccountClassifications AC ON A.AccountClassificationID = AC.AccountClassificationID
    INNER JOIN NormalBalances N ON AT.AccountTypeID = N.NormalBalanceID
    INNER JOIN Currencies Cur ON A.CurrencyID = Cur.CurrencyID;


	select * from Categories




	-- Inserting data into AccountClassifications table
INSERT INTO AccountClassifications (AccountClassificationName)
VALUES ('Asset'), ('Liability'), ('Equity'), ('Revenue'), ('Expense');

-- Inserting data into FinancialStatements table
INSERT INTO FinancialStatements (FinancialStatementName)
VALUES ('Income Statement'), ('Balance Sheet'), ('Statement of Cash Flows');

-- Inserting data into Categories table
INSERT INTO Categories (CategoryName)
VALUES ('Cash and Cash Equivalents'), ('Accounts Receivable'), ('Inventory'), ('Accounts Payable'), ('Sales'), ('Expenses'), ('Long-term Assets'), ('Long-term Liabilities');

-- Inserting data into AccountTypes table
INSERT INTO AccountTypes (AccountTypeName)
VALUES ('Bank Account'), ('Receivable Account'), ('Inventory Account'), ('Payable Account'), ('Sales Account'), ('Expense Account'), ('Fixed Asset Account'), ('Long-term Debt Account'), ('Equity Account');

-- Inserting data into NormalBalances table
INSERT INTO NormalBalances (NormalBalanceName)
VALUES ('Debit'), ('Credit');

-- Inserting data into Currencies table
INSERT INTO Currencies (CurrencyCode, CurrencyName)
VALUES ('USD', 'United States Dollar'), ('EUR', 'Euro'), ('JPY', 'Japanese Yen');

-- Inserting sample data into Accounts table
INSERT INTO Accounts (AccountNumber, AccountName, AccountTypeID, ParentAccountID, OpeningBalance, CurrencyID, IsInactive, CreatedDate, UpdatedDate, CategoryID, AccountClassificationID, NormalBalanceID)
VALUES
    ('1001', 'Cash Account', 1, NULL, 10000.00, 1, 0, GETDATE(), GETDATE(), 1, 1, 1),
    ('2001', 'Accounts Receivable', 2, NULL, 0.00, 1, 0, GETDATE(), GETDATE(), 2, 2, 1),
    ('3001', 'Inventory', 3, NULL, 50000.00, 1, 0, GETDATE(), GETDATE(), 3, 1, 1),
    ('4001', 'Accounts Payable', 4, NULL, 0.00, 1, 0, GETDATE(), GETDATE(), 4, 2, 2),
    ('5001', 'Sales Revenue', 5, NULL, 0.00, 1, 0, GETDATE(), GETDATE(), 5, 4, 2),
    ('6001', 'Salaries Expense', 6, NULL, 0.00, 1, 0, GETDATE(), GETDATE(), 6, 5, 2),
    ('7001', 'Property, Plant, and Equipment', 7, NULL, 100000.00, 1, 0, GETDATE(), GETDATE(), 7, 1, 1),
    ('8001', 'Long-term Debt', 8, NULL, 50000.00, 1, 0, GETDATE(), GETDATE(), 8, 2, 2),
    ('9001', 'Equity', 9, NULL, 100000.00, 1, 0, GETDATE(), GETDATE(), 9, 3, 1);




	CREATE VIEW MasterView AS
SELECT 
    A.AccountID,
    A.AccountNumber,
    A.AccountName,
    AT.AccountTypeName,
    CASE
        WHEN A.ParentAccountID IS NULL THEN ''
        ELSE P.AccountName
    END AS ParentAccountName,
    A.OpeningBalance,
    C.CurrencyCode,
    C.CurrencyName,
    A.IsInactive,
    A.CreatedDate,
    A.UpdatedDate,
    CT.CategoryName,
    AC.AccountClassificationName,
    NB.NormalBalanceName
FROM
    Accounts A
    JOIN AccountTypes AT ON A.AccountTypeID = AT.AccountTypeID
    LEFT JOIN Accounts P ON A.ParentAccountID = P.AccountID
    JOIN Currencies C ON A.CurrencyID = C.CurrencyID
    JOIN Categories CT ON A.CategoryID = CT.CategoryID
    JOIN AccountClassifications AC ON A.AccountClassificationID = AC.AccountClassificationID
    JOIN NormalBalances NB ON A.NormalBalanceID = NB.NormalBalanceID;