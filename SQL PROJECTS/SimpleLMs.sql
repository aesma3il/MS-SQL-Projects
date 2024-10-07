create table Category(
	CategoryID int identity(1,1),
	CategoryName varchar(50) not null,
	Constraint PK_Category primary key(CategoryID)
);

create table Author(
	AuthorID int identity(1,1),
	FullName varchar(100) not null,
	Biography varchar(200) null,
	constraint PK_Author primary key(AuthorID)
);


Create table Borrower(
BorrowerID int identity(1,1),
FirstName varchar(30) not null,
LastName varchar(20) null,
constraint PK_borrower primary key(BorrowerID)
);


create table Book(
	BookID int identity(1,1),
	Title varchar(50) not null,
	ISBN varchar(50) not null,
	PublicationYear date not null default getDate(),
	AvailabilityStatus varchar(50) null,
	CategoryID int,
	AuthorID int,
	Constraint PK_BOOK primary key(BookID),
	Constraint FK_Book_Author foreign key(AuthorID) references Author(AuthorID),
	constraint FK_Book_Category foreign key(CategoryID) references Category(CategoryID)

);

create table BorrowingTransaction(
	TransID int identity(1,1),
	BookID int,
	BorrowerID int,
	TransDate date not null default getDate(),
	ReturnDate date null,
	

	Constraint PK_BorrowingTransacton primary key(TransID),
	Constraint FK_Transc_BOOk foreign key(BookID) references Book(BookID),
	constraint FK_Trans_Borrower foreign key(BorrowerID) references Borrower(BorrowerID)

);



-- Inserting sample records into the Category table
INSERT INTO Category (CategoryName)
VALUES ('Fiction'), ('Non-Fiction'), ('Science Fiction'), ('Romance');

-- Inserting sample records into the Author table
INSERT INTO Author (FullName, Biography)
VALUES ('Jane Austen', 'Jane Austen was an English novelist known for her six major novels...'),
       ('George Orwell', 'George Orwell was an English writer and journalist...'),
       ('Stephen King', 'Stephen King is an American author of horror, supernatural fiction...');

-- Inserting sample records into the Borrower table
INSERT INTO Borrower (FirstName, LastName)
VALUES ('John', 'Doe'), ('Alice', 'Smith'), ('Robert', 'Johnson');

-- Inserting sample records into the Book table
INSERT INTO Book (Title, ISBN, PublicationYear, AvailabilityStatus, CategoryID, AuthorID)
VALUES ('Pride and Prejudice', '9780141439518', '1813-01-28', 'Available', 1, 1),
       ('1984', '9780451524935', '1949-06-08', 'Available', 2, 2),
       ('The Shining', '9780307743657', '1977-01-28', 'Available', 1, 3);

-- Inserting sample records into the BorrowingTransaction table
INSERT INTO BorrowingTransaction (BookID, BorrowerID, TransDate, ReturnDate)
VALUES (1, 1, '2023-07-01', '2023-07-15'),
       (2, 1, '2023-07-05', GETDATE()),
       (3, 1, '2023-07-10', NULL),
	    (1, 2, '2023-07-10', NULL), 
		(2, 2, '2023-07-10', NULL),
		 (3, 2, '2023-07-10', NULL),
		  (1, 3, '2023-07-10', NULL), 
		  (2, 3, '2023-07-10', NULL),
		   (3, 3, '2023-07-10', NULL);




		   select name from sys.tables
		   select * from Category,Author,Borrower,Book,BorrowingTransaction

		   select * from BorrowingTransaction


		    select B.Title, Br.FirstName, t.TransDate
		   from BorrowingTransaction t
		   inner join Book B on B.BookID = t.BookID
		   inner join Borrower Br on t.BorrowerID = Br.BorrowerID


		   select B.Title, Br.FirstName, t.TransDate
		   from BorrowingTransaction t
		   inner join Book B on B.BookID = t.BookID
		   inner join Borrower Br on t.BorrowerID = Br.BorrowerID
		   where Br.BorrowerID = 1


		   go
		  create proc NumberOfBorrowedBooks
		  as
		  begin
			 select Br.BorrowerID, Br.FirstName, Br.LastName, Count(*) as TotalNUmberOfBorrowedBooks
		   from BorrowingTransaction t
		   inner join Book B on B.BookID = t.BookID
		   inner join Borrower Br on t.BorrowerID = Br.BorrowerID
		   group by  Br.BorrowerID, Br.FirstName, Br.LastName
		  end;
		  go

		create proc BookDetails
		as
		begin
			   select b.Title,b.PublicationYear,b.AvailabilityStatus, c.CategoryName, a.FullName
		   from Book b
		   inner join Category c on  c.CategoryID =b.CategoryID  
		   inner join Author a on  a.AuthorID = b.AuthorID 

		end;
		   select b.Title, c.CategoryName, a.FullName
		   from Book b
		   inner join Category c on   b.CategoryID   =c.CategoryID
		   inner join Author a on    b.AuthorID =a.AuthorID