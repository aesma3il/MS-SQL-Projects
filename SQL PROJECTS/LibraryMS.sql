-- Create the Category table
CREATE TABLE Category (
    ID INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Create the Item table
CREATE TABLE Item (
    ID INT PRIMARY KEY,
    ItemName VARCHAR(255),
    Author VARCHAR(255),
    PublicationDate DATE,
    CategoryName VARCHAR(255),
    IsAvailable BIT,
    FOREIGN KEY (CategoryName) REFERENCES Category(Name)
);

-- Create the AccountRole table
CREATE TABLE AccountRole (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(255)
);

-- Create the Permissions table
CREATE TABLE Permissions (
    PermissionID INT PRIMARY KEY,
    PermissionName VARCHAR(255)
);

-- Create the AccountPermission table
CREATE TABLE AccountPermission (
    RoleID INT,
    PermissionID INT,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES AccountRole(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);

-- Create the UserAccount table
CREATE TABLE UserAccount (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Gender VARCHAR(50),
    DateOfBirth DATE,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES AccountRole(RoleID)
);

-- Create the EmailValidationStatus table
CREATE TABLE EmailValidationStatus (
    EmailValidationStatusID INT PRIMARY KEY,
    StatusName VARCHAR(255)
);

-- Create the AccountLoginData table
CREATE TABLE AccountLoginData (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    PasswordHash VARCHAR(255),
    PasswordSalt VARCHAR(255),
    EmailAddress VARCHAR(255),
    ConfirmationToken VARCHAR(255),
    TokenGenerationTime DATETIME,
    EmailValidationStatusID INT,
    PasswordRecoveryToken VARCHAR(255),
    RecoveryTokenTime DATETIME,
    IsActive BIT,
    FOREIGN KEY (EmailValidationStatusID) REFERENCES EmailValidationStatus(EmailValidationStatusID)
);

-- Create the UserNotifications table
CREATE TABLE UserNotifications (
    ID INT PRIMARY KEY,
    NotifyType VARCHAR(255),
    MessageText VARCHAR(255),
    Date DATETIME,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES UserAccount(ID)
);

-- Create the TransactionType table
CREATE TABLE TransactionType (
    ID INT PRIMARY KEY,
    TypeName VARCHAR(255)
);

-- Create the TransactionStatus table
CREATE TABLE TransactionStatus (
    ID INT PRIMARY KEY,
    StatusName VARCHAR(255)
);

-- Create the Transaction table
CREATE TABLE Transactions (
    ID INT PRIMARY KEY,
    UserID INT,
    ItemID INT,
    TransactionTypeID INT,
    DueDate DATETIME,
    Status INT,
    FOREIGN KEY (UserID) REFERENCES UserAccount(ID),
    FOREIGN KEY (ItemID) REFERENCES Item(ID),
    FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(ID),
    FOREIGN KEY (Status) REFERENCES TransactionStatus(ID)
);

-- Create the Fine table
CREATE TABLE Fine (
    ID INT PRIMARY KEY,
    TransactionID INT,
    Amount DECIMAL(10, 2),
    Reason VARCHAR(255),
    Date DATETIME,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(ID)
);

-- Create the Payment table
CREATE TABLE Payment (
    ID INT PRIMARY KEY,
    FineID INT,
    UserID INT,
    PaymentDate DATETIME,
    Amount DECIMAL(10, 2),
    Description VARCHAR(255),
    FOREIGN KEY (FineID) REFERENCES Fine(ID),
    FOREIGN KEY (UserID) REFERENCES UserAccount(ID)
);

-- Create the BorrowingHistory table
CREATE TABLE BorrowingHistory (
    ID INT PRIMARY KEY,
    TransactionID INT,
    UserID INT,
    ItemID INT,
    DueDate DATETIME,
    Status INT,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(ID),
    FOREIGN KEY (UserID) REFERENCES UserAccount(ID),
    FOREIGN KEY (ItemID) REFERENCES Item(ID),
    FOREIGN KEY (Status) REFERENCES TransactionStatus(ID)
);





--Category(ID,Name)
--Item(ID, ItemName,Author, PublicationDate, CategoryName, IsAvailable)
--AccountRole(RoleID, RoleName)
--Permissions(PermissionID, PermissionName)
--AccountPermission(RoleID, PermissionID)
--UserAccount(ID, Firstname, LastName, Gender, DateOfBirth, RoleID)
--EmailValidationStatus(EmailValidationStatusID, StatusName)
--AccountLoginData(UserID, Username, PasswordHash, PasswordSalt,EmailAddress,ConfirmationToken,TokenGenerationTime, EmailValidationStatusID, PasswordRevoveryToken,RecoveryTokenTime, IsActive)

--UserNotifications(ID, Type, Description, Date, UserID)
--TransactionType(ID, TypeName)
--TransactionStatus(ID, StatusName)
--Transaction(ID, UserID, ItemID, TransactionTypeID, DueDate, Status)
--Fine(ID, TransactionID, Amount, Reason, Date)
--Payment(ID, FineID,UserID, PaymentDate, Amount, Description) 
--BorrowingHistory(ID,TransactionID,UserID, ItemID, DueDate, Status)


--CreateUser
--CheckBookAvailable

--Borrowing Process:

--When a user wants to borrow a library item, the software checks the availability of the item in the catalog and determines if the user is eligible to borrow based on their membership status and any loan policies.
--If the item is available and the user is eligible, a borrowing transaction record is created. This record includes information such as the user's identification, the borrowed item's details, the due date, and any other relevant data.
--The software updates the catalog to reflect that the item is checked out, and it may also update the user's account to reflect the borrowed item and the due date.
--The user may receive a physical or digital receipt indicating the borrowed item and the due date.
--Returning Process:

--When a user returns a borrowed item, the software receives the returned item and identifies it using barcode or RFID technology.
--The software locates the corresponding borrowing transaction record and marks it as returned.
--The catalog is updated to reflect that the item is available for borrowing again.
--If the user returned the item on time, no further action is required. If the item is overdue, the software may calculate and apply fines or penalties based on predefined rules.
--The user's account is updated to remove the returned item from their borrowed materials list.
