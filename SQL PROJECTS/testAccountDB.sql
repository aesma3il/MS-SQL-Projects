create database TestAccount;
use TestAccount;


CREATE TABLE ChartOfAccounts (
    AccountID INT PRIMARY KEY IDENTITY,
    AccountCode VARCHAR(10),
    AccountName VARCHAR(255),
    AccountTypeID INT NOT NULL,
    AccountHolderID INT,
    CONSTRAINT fk_account_accounttype FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID),
    CONSTRAINT fk_accountholder_person FOREIGN KEY (AccountHolderID) REFERENCES Person(PersonID)
);

CREATE TABLE GeneralLedger (
    EntryID INT PRIMARY KEY identity,
    TransactionDate DATE,
    Description TEXT
);

CREATE TABLE GeneralLedgerLine (
    LineID INT PRIMARY KEY IDENTITY,
    EntryID INT,
    AccountID INT,
    Amount DECIMAL(10, 2),
    TransactionType VARCHAR(50),
    Reference VARCHAR(255),
    FOREIGN KEY (EntryID) REFERENCES GeneralLedger(EntryID),
    FOREIGN KEY (AccountID) REFERENCES ChartOfAccounts(AccountID)
);



-- Insert sample data into ChartOfAccounts table
INSERT INTO ChartOfAccounts (AccountCode, AccountName, AccountTypeID, AccountHolderID)
VALUES
    ('1001', 'Cash', 1, NULL),
    ('2001', 'Accounts Receivable', 1, NULL),
    ('3001', 'Accounts Payable', 2, NULL),
    ('4001', 'Sales Revenue', 3, NULL);

-- Insert sample data into GeneralLedger table
INSERT INTO GeneralLedger (TransactionDate, Description)
VALUES
    ('2023-09-01', 'Sale transaction'),
    ('2023-09-02', 'Purchase transaction');

-- Insert sample data into GeneralLedgerLine table
INSERT INTO GeneralLedgerLine (EntryID, AccountID, Amount, TransactionType, Reference)
VALUES
    (1, 1, 1000.00, 'Debit', 'Customer A'),
    (1, 4, 1000.00, 'Credit', 'Sales Revenue'),
    (2, 3, 500.00, 'Debit', 'Vendor B'),
    (2, 1, 500.00, 'Credit', 'Cash');


-- Insert a transaction into the GeneralLedger table
INSERT INTO GeneralLedger (EntryID, TransactionDate, Description)
VALUES (1, '2023-09-12', 'Sale transaction');

-- Insert debit entry for an account in the GeneralLedgerLine table
INSERT INTO GeneralLedgerLine (EntryID, AccountID, Amount, TransactionType, Reference)
VALUES (1, 1, 1000.00, 'Debit', 'Customer A');

-- Insert credit entry for another account in the GeneralLedgerLine table
INSERT INTO GeneralLedgerLine (EntryID, AccountID, Amount, TransactionType, Reference)



VALUES (1, 2, 1000.00, 'Credit', 'Sales Revenue');


SELECT
    COA.AccountCode,
    COA.AccountName,
    CONVERT(nvarchar(max), GL.Description) AS Description,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE 0 END) AS DebitAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Credit' THEN GLL.Amount ELSE 0 END) AS CreditAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE -GLL.Amount END) AS Balance
FROM
    ChartOfAccounts COA
    INNER JOIN GeneralLedgerLine GLL ON COA.AccountID = GLL.AccountID
    INNER JOIN GeneralLedger GL ON GLL.EntryID = GL.EntryID
GROUP BY
    COA.AccountCode,
    COA.AccountName,
    CONVERT(nvarchar(max), GL.Description);




	SELECT
    COA.AccountCode,
    COA.AccountName,
    CONVERT(nvarchar(max), GL.Description) AS Description,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE 0 END) AS DebitAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Credit' THEN GLL.Amount ELSE 0 END) AS CreditAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE -GLL.Amount END) AS Balance
FROM
    ChartOfAccounts COA
    INNER JOIN GeneralLedgerLine GLL ON COA.AccountID = GLL.AccountID
    INNER JOIN GeneralLedger GL ON GLL.EntryID = GL.EntryID
WHERE
    COA.AccountID = 1
GROUP BY
    COA.AccountCode,
    COA.AccountName,
    CONVERT(nvarchar(max), GL.Description);







	SELECT
    COA.AccountCode,
    COA.AccountName,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE 0 END) AS DebitAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Credit' THEN GLL.Amount ELSE 0 END) AS CreditAmount,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE -GLL.Amount END) AS Balance
FROM
    ChartOfAccounts COA
    INNER JOIN GeneralLedgerLine GLL ON COA.AccountID = GLL.AccountID
GROUP BY
    COA.AccountCode,
    COA.AccountName;



	go
SELECT
    GL.EntryID,
    GL.TransactionDate,
    GL.Description,
    CASE WHEN GLL.TransactionType = 'Debit' THEN 'Debit' ELSE 'Credit' END AS TransactionType,
    GLL.Amount,
    SUM(CASE WHEN GLL.TransactionType = 'Debit' THEN GLL.Amount ELSE -GLL.Amount END) OVER (ORDER BY GL.TransactionDate, GL.EntryID) AS Balance
FROM
    GeneralLedger GL
    INNER JOIN GeneralLedgerLine GLL ON GL.EntryID = GLL.EntryID
WHERE
    GLL.AccountID = 1
ORDER BY
    GL.TransactionDate, GL.EntryID;