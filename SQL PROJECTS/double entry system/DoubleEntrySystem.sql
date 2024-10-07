CREATE TABLE Accounts (
    AccountId  INT IDENTITY(1,1) PRIMARY KEY,
    AccountName        NVARCHAR(255) NOT NULL,
    AccountNumber      INT NOT NULL,
    Normal      INT NOT NULL
);

CREATE TABLE Transactions (
    TransactionId  INT IDENTITY(1,1) PRIMARY KEY,
    TransactionDate            DATE NOT NULL,
    Amount          DECIMAL(10, 2) NOT NULL,
    AccountId      INT REFERENCES Accounts(AccountId),
    Direction       INT NOT NULL
);


INSERT INTO Accounts (AccountName, AccountNumber, Normal)
VALUES
    ('Assets', 100, 1),
    ('Cash', 110, 1),
    ('Merchandise', 120, 1),
    ('Liabilities', 200, -1),
    ('Deferred Revenue', 210, -1),
    ('Revenues', 300, -1),
    ('Expenses', 400, 1),
    ('Cost of Goods Sold', 410, 1),
    ('Equity', 500, -1),
    ('Capital', 510, -1);


	SELECT
  STRING_AGG(AccountName, ' + ') AS expression
FROM Accounts
GROUP BY Normal;