

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

-- Create Author table
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

-- Create Publisher table
CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

-- Create Book table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    BookTitle VARCHAR(200) NOT NULL,
    AuthorID INT NOT NULL,
    PublisherID INT NOT NULL,
    CategoryID INT,
    PublishedYear INT,
    ISBN VARCHAR(20),
	BookStatus VARCHAR(20) NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


-- Create Members table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    MemberName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20),
    Email VARCHAR(100)
);

-- Create Loans table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FineAmount DECIMAL(10, 2),
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Create Reservations table
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    ReservationDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Create Fines table
CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    LoanID INT,
    FineAmount DECIMAL(10, 2),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

-- Create Notifications table
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY,
    MemberID INT,
    NotificationType VARCHAR(50) NOT NULL,
    NotificationDate DATE,
	TextMessage TExT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    AccessLevel VARCHAR(20) NOT NULL
);



---- Create Members table
--CREATE TABLE Members (
--    MemberID INT PRIMARY KEY,
--    MemberName VARCHAR(100) NOT NULL,
--    ContactNumber VARCHAR(20),
--    Email VARCHAR(100)
--);



---- Create Requests table
--CREATE TABLE Requests (
--    RequestID INT PRIMARY KEY,
--    MemberID INT,
--    TransactionType VARCHAR(20),
--    RequestDate DATE,
--    RequestStatus VARCHAR(20),
--    -- Additional columns as per your requirements
--    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
--);


---- Create Issuance table
--CREATE TABLE Issuance (
--    IssuanceID INT PRIMARY KEY,
--    RequestID INT,
--    BookID INT,
--    MemberID INT,
--    IssuanceDate DATE,
--    DueDate DATE,
--    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID),
--    FOREIGN KEY (BookID) REFERENCES Book(BookID),
--    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
--);

---- Create Renewal table
--CREATE TABLE Renewal (
--    RenewalID INT PRIMARY KEY,
--    RequestID INT,
--    IssuanceID INT,
--    RenewalDate DATE,
--    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID),
--    FOREIGN KEY (IssuanceID) REFERENCES Issuance(IssuanceID)
--);


---- Create Return table
--CREATE TABLE Returning (
--    ReturnID INT PRIMARY KEY,
--    RequestID INT,
--    IssuanceID INT,
--    ReturnDate DATE,
--    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID),
--    FOREIGN KEY (IssuanceID) REFERENCES Issuance(IssuanceID)
--);



--another way to manage
-- Create Requests table
--CREATE TABLE Requests (
--    RequestID INT PRIMARY KEY,
--    MemberID INT,
--    TransactionType VARCHAR(20),
--    RequestDate DATE,
--    Status VARCHAR(20),
--    -- Additional columns as per your requirements
--    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
--);

-- Create IssuanceRequests table
CREATE TABLE IssuanceRequests (
    RequestID INT PRIMARY KEY,
    BookID INT,
    IssuanceDate DATE,
    DueDate DATE,
    -- Additional columns specific to issuance requests
    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Create RenewalRequests table
CREATE TABLE RenewalRequests (
    RequestID INT PRIMARY KEY,
    IssuanceID INT,
    RenewalDate DATE,
    -- Additional columns specific to renewal requests
    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID),
    FOREIGN KEY (IssuanceID) REFERENCES Issuance(IssuanceID)
);

-- Create ReturnRequests table
CREATE TABLE ReturnRequests (
    RequestID INT PRIMARY KEY,
    IssuanceID INT,
    ReturnDate DATE,
    FineAmount DECIMAL(10,2),
    -- Additional columns specific to return requests
    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID),
    FOREIGN KEY (IssuanceID) REFERENCES Issuance(IssuanceID)
);