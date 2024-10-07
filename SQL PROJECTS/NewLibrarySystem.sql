-- Create Authors table
CREATE TABLE Authors (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName VARCHAR(50),
    BirthDate DATE,
    Nationality VARCHAR(50),
    Biography TEXT
);

-- Create Genres table
CREATE TABLE Genres (
    GenreID INT IDENTITY(1,1) PRIMARY KEY,
    GenreName VARCHAR(50)
);

-- Create Books table
CREATE TABLE Books (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(100),
    PublicationYear INT,
    ISBN VARCHAR(20),
    Quantity INT,
    AuthorID INT,
    GenreID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- Create Members table
CREATE TABLE Members (
    MemberID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Create Loans table
CREATE TABLE Loans (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);



-- Stored Procedures for the Authors table
CREATE PROCEDURE CreateAuthor
    @AuthorName VARCHAR(50),
    @BirthDate DATE,
    @Nationality VARCHAR(50),
    @Biography TEXT
AS
BEGIN
    INSERT INTO Authors (AuthorName, BirthDate, Nationality, Biography)
    VALUES (@AuthorName, @BirthDate, @Nationality, @Biography);
END;

CREATE PROCEDURE GetAuthors
AS
BEGIN
    SELECT * FROM Authors;
END;

CREATE PROCEDURE GetAuthorByID
    @AuthorID INT
AS
BEGIN
    SELECT * FROM Authors WHERE AuthorID = @AuthorID;
END;

CREATE PROCEDURE UpdateAuthor
    @AuthorID INT,
    @AuthorName VARCHAR(50),
    @BirthDate DATE,
    @Nationality VARCHAR(50),
    @Biography TEXT
AS
BEGIN
    UPDATE Authors SET
        AuthorName = @AuthorName,
        BirthDate = @BirthDate,
        Nationality = @Nationality,
        Biography = @Biography
    WHERE AuthorID = @AuthorID;
END;

CREATE PROCEDURE DeleteAuthor
    @AuthorID INT
AS
BEGIN
    DELETE FROM Authors WHERE AuthorID = @AuthorID;
END;

-- Stored Procedures for the Genres table
CREATE PROCEDURE CreateGenre
    @GenreName VARCHAR(50)
AS
BEGIN
    INSERT INTO Genres (GenreName)
    VALUES (@GenreName);
END;

CREATE PROCEDURE GetGenres
AS
BEGIN
    SELECT * FROM Genres;
END;

CREATE PROCEDURE GetGenreByID
    @GenreID INT
AS
BEGIN
    SELECT * FROM Genres WHERE GenreID = @GenreID;
END;

CREATE PROCEDURE UpdateGenre
    @GenreID INT,
    @GenreName VARCHAR(50)
AS
BEGIN
    UPDATE Genres SET
        GenreName = @GenreName
    WHERE GenreID = @GenreID;
END;

CREATE PROCEDURE DeleteGenre
    @GenreID INT
AS
BEGIN
    DELETE FROM Genres WHERE GenreID = @GenreID;
END;

-- Stored Procedures for the Books table
CREATE PROCEDURE CreateBook
    @Title VARCHAR(100),
    @PublicationYear INT,
    @ISBN VARCHAR(20),
    @Quantity INT,
    @AuthorID INT,
    @GenreID INT
AS
BEGIN
    INSERT INTO Books (Title, PublicationYear, ISBN, Quantity, AuthorID, GenreID)
    VALUES (@Title, @PublicationYear, @ISBN, @Quantity, @AuthorID, @GenreID);
END;

CREATE PROCEDURE GetBooks
AS
BEGIN
    SELECT * FROM Books;
END;

CREATE PROCEDURE GetBookByID
    @BookID INT
AS
BEGIN
    SELECT * FROM Books WHERE BookID = @BookID;
END;

CREATE PROCEDURE UpdateBook
    @BookID INT,
    @Title VARCHAR(100),
    @PublicationYear INT,
    @ISBN VARCHAR(20),
    @Quantity INT,
    @AuthorID INT,
    @GenreID INT
AS
BEGIN
    UPDATE Books SET
        Title = @Title,
        PublicationYear = @PublicationYear,
        ISBN = @ISBN,
        Quantity = @Quantity,
        AuthorID = @AuthorID,
        GenreID = @GenreID
    WHERE BookID = @BookID;
END;

CREATE PROCEDURE DeleteBook
    @BookID INT
AS
BEGIN
    DELETE FROM Books WHERE BookID = @BookID;
END;


-- Stored Procedures for the Members table
CREATE PROCEDURE CreateMember
    @Name VARCHAR(50),
  
    @Address VARCHAR(100),
    @Email VARCHAR(50)
AS
BEGIN
    INSERT INTO Members (Name, Address, Email)
    VALUES (@Name, @Address, @Email);
END;

CREATE PROCEDURE GetMembers
AS
BEGIN
    SELECT * FROM Members;
END;

CREATE PROCEDURE GetMemberByID
    @MemberID INT
AS
BEGIN
    SELECT * FROM Members WHERE MemberID = @MemberID;
END;

CREATE PROCEDURE UpdateMember
    @MemberID INT,
    @MemberName VARCHAR(50),
    @MembershipDate DATE,
    @Address VARCHAR(100),
    @Email VARCHAR(50)
AS
BEGIN
    UPDATE Members SET
       Name = @MemberName,
        Address = @Address,
        Email = @Email
    WHERE MemberID = @MemberID;
END;

CREATE PROCEDURE DeleteMember
    @MemberID INT
AS
BEGIN
    DELETE FROM Members WHERE MemberID = @MemberID;
END;

-- Stored Procedures for the Loans table
CREATE PROCEDURE CreateLoan
    @BookID INT,
    @MemberID INT,
    @LoanDate DATE,
    @ReturnDate DATE
AS
BEGIN
    INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate)
    VALUES (@BookID, @MemberID, @LoanDate, @ReturnDate);
END;

CREATE PROCEDURE GetLoans
AS
BEGIN
    SELECT * FROM Loans;
END;

CREATE PROCEDURE GetLoanByID
    @LoanID INT
AS
BEGIN
    SELECT * FROM Loans WHERE LoanID = @LoanID;
END;

CREATE PROCEDURE UpdateLoan
    @LoanID INT,
    @BookID INT,
    @MemberID INT,
    @LoanDate DATE,
    @ReturnDate DATE
AS
BEGIN
    UPDATE Loans SET
        BookID = @BookID,
        MemberID = @MemberID,
        LoanDate = @LoanDate,
        ReturnDate = @ReturnDate
    WHERE LoanID = @LoanID;
END;

CREATE PROCEDURE DeleteLoan
    @LoanID INT
AS
BEGIN
    DELETE FROM Loans WHERE LoanID = @LoanID;
END;


-- Stored Procedure for retrieving a report of all books with their authors and genres
CREATE PROCEDURE GetBookReport
AS
BEGIN
    SELECT
        B.BookID,
        B.Title,
        B.PublicationYear,
        B.ISBN,
        B.Quantity,
        A.AuthorID,
        A.AuthorName,
        G.GenreID,
        G.GenreName
    FROM
        Books B
        INNER JOIN Authors A ON B.AuthorID = A.AuthorID
        INNER JOIN Genres G ON B.GenreID = G.GenreID;
END;

-- Stored Procedure for retrieving a report of all loans with book, member, and due date information
CREATE PROCEDURE GetLoanReport
AS
BEGIN
    SELECT
        L.LoanID,
        B.BookID,
        B.Title AS BookTitle,
        M.MemberID,
        M.Name,
        L.LoanDate,
        L.ReturnDate
    FROM
        Loans L
        INNER JOIN Books B ON L.BookID = B.BookID
        INNER JOIN Members M ON L.MemberID = M.MemberID;
END;

-- Stored Procedure for retrieving information about a book by its ID
CREATE PROCEDURE GetBookInfoByID
    @BookID INT
AS
BEGIN
    SELECT
        B.BookID,
        B.Title,
        B.PublicationYear,
        B.ISBN,
        B.Quantity,
        A.AuthorID,
        A.AuthorName,
        G.GenreID,
        G.GenreName
    FROM
        Books B
        INNER JOIN Authors A ON B.AuthorID = A.AuthorID
        INNER JOIN Genres G ON B.GenreID = G.GenreID
    WHERE
        B.BookID = @BookID;
END;

-- Stored Procedure for retrieving information about a member by their ID
CREATE PROCEDURE GetMemberInfoByID
    @MemberID INT
AS
BEGIN
    SELECT
        MemberID,
        Name,
        Address,
        Email
    FROM
        Members
    WHERE
        MemberID = @MemberID;
END;


-- Stored Procedure for retrieving a report of books with low stock levels
CREATE PROCEDURE GetLowStockBooks
    @Threshold INT
AS
BEGIN
    SELECT
        B.BookID,
        B.Title,
        B.PublicationYear,
        B.ISBN,
        B.Quantity,
        A.AuthorName,
        G.GenreName
    FROM
        Books B
        INNER JOIN Authors A ON B.AuthorID = A.AuthorID
        INNER JOIN Genres G ON B.GenreID = G.GenreID
    WHERE
        B.Quantity < @Threshold;
END;

-- Stored Procedure for retrieving a report of overdue loans
CREATE PROCEDURE GetOverdueLoans
AS
BEGIN
    SELECT
        L.LoanID,
        B.Title AS BookTitle,
        M.Name,
        L.LoanDate,
        L.ReturnDate
    FROM
        Loans L
        INNER JOIN Books B ON L.BookID = B.BookID
        INNER JOIN Members M ON L.MemberID = M.MemberID
    WHERE
        L.ReturnDate < GETDATE();
END;

-- Stored Procedure for retrieving a report of books borrowed by a specific member
CREATE PROCEDURE GetBooksBorrowedByMember
    @MemberID INT
AS
BEGIN
    SELECT
        B.BookID,
        B.Title,
        B.PublicationYear,
        B.ISBN,
        A.AuthorName,
        G.GenreName,
        L.LoanDate,
        L.ReturnDate
    FROM
        Loans L
        INNER JOIN Books B ON L.BookID = B.BookID
        INNER JOIN Authors A ON B.AuthorID = A.AuthorID
        INNER JOIN Genres G ON B.GenreID = G.GenreID
    WHERE
        L.MemberID = @MemberID;
END;