CREATE TABLE Debtor (
  DebtorID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  [Address] VARCHAR(100)
);


CREATE TABLE LoanRequest (
  LoanRequestID INT PRIMARY KEY,
  DebtorID INT,
  RequestDate DATETIME,
  RequiredAmount DECIMAL(18,2),
  PaybackPeriodInMonths INT,
  Description VARCHAR(100),
  FOREIGN KEY (DebtorID) REFERENCES Debtor(DebtorID)
);
CREATE TABLE Warrantor (
  WarrantorID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50)
);

CREATE TABLE Loan (
  LoanID INT PRIMARY KEY,
  DebtorID INT,
  LoanRequestID INT,
  WarrantorID	INT,
  LoanDate DATETIME,
  TotalAmount DECIMAL(18,2),
  ProfitPercentage DECIMAL(18,2),
  Description VARCHAR(100),
  FOREIGN KEY (DebtorID) REFERENCES Debtor(DebtorID),
  FOREIGN KEY (LoanRequestID) REFERENCES LoanRequest(LoanRequestID),
  FOREIGN KEY (WarrantorID)	REFERENCES Warrantor(WarrantorID)

);



CREATE TABLE Payment (
  PaymentID INT PRIMARY KEY,
  LoanID INT,
  PaymentDate DATETIME,
  Amount DECIMAL(18,2),
  FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);