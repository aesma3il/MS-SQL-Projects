---- Create the database
--CREATE DATABASE AccountingDB;
--GO


---- Use the newly created database
--USE AccountingDB;
--GO

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    contact_details VARCHAR(100),
    address VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Create Transaction_Types table
CREATE TABLE Transaction_Types (
    transaction_type_id INT PRIMARY KEY,
    transaction_type VARCHAR(50)
);

-- Create Accounts table
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    opened_date DATE,
    closed_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Account_Details table
CREATE TABLE Account_Details (
account_details_id INT not null unique,
    account_id INT PRIMARY KEY,
    credit DECIMAL(18, 2),
    debit DECIMAL(18, 2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Create Transactions table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    date DATE,
    transaction_type_id INT,
    FOREIGN KEY (transaction_type_id) REFERENCES Transaction_Types(transaction_type_id)
);

-- Create Transaction_Details table
CREATE TABLE Transaction_Details (
    transaction_id INT,
    account_details_id INT,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id),
    FOREIGN KEY (account_details_id) REFERENCES Account_Details(account_details_id),
    PRIMARY KEY (transaction_id, account_details_id)
);

-- Create Source_Documents table
CREATE TABLE Source_Documents (
    document_id INT PRIMARY KEY,
    transaction_id INT,
    document_type VARCHAR(50),
    document_data VARCHAR(100),
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

-- Create Journal_Entries table
CREATE TABLE Journal_Entries (
    entry_id INT PRIMARY KEY,
    transaction_id INT,
    account_details_id INT,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id),
    FOREIGN KEY (account_details_id) REFERENCES Account_Details(account_details_id)
);

-- Create Balances table
CREATE TABLE Balances (
    balance_id INT PRIMARY KEY,
    account_id INT,
    transaction_id INT,
    balance DECIMAL(18, 2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

-- Create Financial_Statements table
CREATE TABLE Financial_Statements (
    statement_id INT PRIMARY KEY,
    statement_type VARCHAR(50),
    statement_data VARCHAR(100)
);

-- Create Security_Users table
CREATE TABLE Security_Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(50),
    access_level VARCHAR(50)
);

-- Create Relationships between tables
ALTER TABLE Accounts ADD CONSTRAINT FK_Accounts_Account_Details FOREIGN KEY (account_id) REFERENCES Account_Details(account_id);
ALTER TABLE Transaction_Details ADD CONSTRAINT FK_Transaction_Details_Account_Details FOREIGN KEY (account_details_id) REFERENCES Account_Details(account_details_id);
ALTER TABLE Transaction_Details ADD CONSTRAINT FK_Transaction_Details_Transactions FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id);
ALTER TABLE Source_Documents ADD CONSTRAINT FK_Source_Documents_Transactions FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id);
ALTER TABLE Journal_Entries ADD CONSTRAINT FK_Journal_Entries_Transactions FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id);
ALTER TABLE Journal_Entries ADD CONSTRAINT FK_Journal_Entries_Account_Details FOREIGN KEY (account_details_id) REFERENCES Account_Details(account_details_id);
ALTER TABLE Balances ADD CONSTRAINT FK_Balances_Accounts FOREIGN KEY (account_id) REFERENCES Accounts(account_id);
ALTER TABLE Balances ADD CONSTRAINT FK_Balances_Transactions FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id);
ALTER TABLE Financial_Statements ADD CONSTRAINT FK_Financial_Statements_Transactions FOREIGN KEY (statement_id) REFERENCES Transactions(transaction_id);
ALTER TABLE Security_Users ADD CONSTRAINT FK_Security_Users_Transactions FOREIGN KEY (user_id) REFERENCES Transactions(user_id);