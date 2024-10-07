

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




CREATE TABLE Publisher (
    PublisherID int IDENTITY(1,1) PRIMARY KEY,
    PublisherName varchar(100) NOT NULL
);

-- Table: Book
CREATE TABLE Book (
    BookID int IDENTITY(1,1) PRIMARY KEY,
    Title varchar(50) NOT NULL,
    ISBN varchar(50) NOT NULL,
    PublicationYear date NOT NULL DEFAULT GETDATE(),
    AvailabilityStatus varchar(50) NULL,
    CategoryID int,
    AuthorID int,
    PublisherID int,
    CONSTRAINT FK_Book_Author FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
    CONSTRAINT FK_Book_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    CONSTRAINT FK_Book_Publisher FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

-- Table: Review
CREATE TABLE Review (
    ReviewID int IDENTITY(1,1) PRIMARY KEY,
    BookID int,
    BorrowerID int,
    Rating int NOT NULL,
    Comment varchar(500) NULL,
    CONSTRAINT FK_Review_Book FOREIGN KEY (BookID) REFERENCES Book(BookID),
    CONSTRAINT FK_Review_Borrower FOREIGN KEY (BorrowerID) REFERENCES Borrower(BorrowerID)
);



CREATE NONCLUSTERED INDEX idx_BorrowingTransaction_BorrowerID
ON BorrowingTransaction (BorrowerID);

create table BorrowingTransaction(
	TransID int identity(1,1),
	BookID int,
	BorrowerID int,
	TransDate date not null default getDate(),
	DueDate date  null,
	ReturnDate date null,
	

	Constraint PK_BorrowingTransacton primary key(TransID),
	Constraint FK_Transc_BOOk foreign key(BookID) references Book(BookID),
	constraint FK_Trans_Borrower foreign key(BorrowerID) references Borrower(BorrowerID)

);


INSERT INTO Category (CategoryName)
VALUES
    ('Fiction'),
    ('Non-Fiction'),
    ('Mystery'),
    ('Romance'),
    ('Science Fiction'),
    ('Fantasy'),
    ('Biography'),
    ('History'),
    ('Thriller'),
    ('Horror'),
    ('Self-Help'),
    ('Business'),
    ('Travel'),
    ('Cooking'),
    ('Art'),
    ('Poetry'),
    ('Philosophy'),
    ('Religion'),
    ('Science'),
    ('Psychology'),
    ('Health'),
    ('Sports'),
    ('Education'),
    ('Technology'),
    ('Music'),
    ('Drama'),
    ('Comedy'),
    ('Action'),
    ('Adventure'),
    ('Crime'),
    ('Western'),
    ('Young Adult'),
    ('Children'),
    ('Graphic Novel'),
    ('Comic'),
    ('Historical Fiction'),
    ('Literary Fiction'),
    ('Memoir'),
    ('Autobiography'),
    ('Reference'),
    ('Parenting'),
    ('Nature'),
    ('Gardening'),
    ('Fashion'),
    ('Architecture'),
    ('Design'),
    ('Photography'),
    ('Economics'),
    ('Sociology'),
    ('Politics'),
    ('Anthropology');

-- Insert more records as needed


INSERT INTO Publisher (PublisherName)
VALUES
    ('Penguin Random House'),
    ('HarperCollins Publishers'),
    ('Simon & Schuster'),
    ('Hachette Book Group'),
    ('Macmillan Publishers'),
    ('Scholastic Corporation'),
    ('Pearson PLC'),
    ('Bloomsbury Publishing'),
    ('Oxford University Press'),
    ('Cambridge University Press'),
    ('Wiley'),
    ('Elsevier'),
    ('Springer'),
    ('McGraw-Hill Education'),
    ('Cengage'),
    ('Perseus Books Group'),
    ('Houghton Mifflin Harcourt'),
    ('Random House'),
    ('Little, Brown and Company'),
    ('Knopf Doubleday Publishing Group'),
    ('Vintage Books'),
    ('Scribner'),
    ('Grove Atlantic'),
    ('Farrar, Straus and Giroux'),
    ('W. W. Norton & Company'),
    ('Penguin Books'),
    ('Harper Perennial'),
    ('Gallery Books'),
    ('Pocket Books'),
    ('Grand Central Publishing'),
    ('St. Martin''s Press'),
    ('Tor Books'),
    ('Ace Books'),
    ('Ballantine Books'),
    ('Del Rey Books'),
    ('Scholastic Press'),
    ('Viking Press'),
    ('Oxford Press'),
    ('Cambridge Press'),
    ('Wiley-Blackwell'),
    ('Elsevier Science'),
    ('Springer Nature'),
    ('McGraw-Hill'),
    ('Cengage Learning'),
    ('Pearson Education'),
    ('Hachette Livre'),
    ('Wolters Kluwer'),
    ('Taylor & Francis'),
    ('John Wiley & Sons'),
    ('Elsevier BV'),
    ('Thieme Medical Publishers');

-- Insert more records as needed
truncate table Author

INSERT INTO Author (FullName, Biography)
VALUES
	 ('Agatha Christie', 'Prominent English detective fiction writer.'),
    ('Ernest Hemingway', 'Celebrated American novelist and short story writer.'),
    ('Leo Tolstoy', 'Renowned Russian author of "War and Peace."'),
    ('Harper Lee', 'Author of the Pulitzer Prize-winning novel "To Kill a Mockingbird."'),
    ('Mark Twain', 'Iconic American author and humorist.'),
    ('Emily Dickinson', 'Prominent American poet of the 19th century.'),
    ('Oscar Wilde', 'Famous Irish playwright and wit.'),
    ('H.G. Wells', 'Notable British author of science fiction.'),
    ('Ralph Waldo Emerson', 'Influential American essayist and philosopher.'),
    ('Edgar Allan Poe', 'Renowned American writer of macabre and mystery.'),
    ('Charles Dickens', 'Prolific English author and social critic.'),
    ('William Shakespeare', 'Legendary playwright and poet of the Elizabethan era.'),
    ('Gabriel García Márquez', 'Prominent Colombian author and Nobel laureate.'),
    ('Maya Angelou', 'Renowned American poet and civil rights activist.'),
    ('J.K. Rowling', 'Author of the "Harry Potter" series.'),
    ('John Steinbeck', 'Acclaimed American author of "The Grapes of Wrath."'),
    ('Rudyard Kipling', 'British writer known for "The Jungle Book."'),
    ('Samuel Beckett', 'Irish playwright and novelist, known for "Waiting for Godot."'),
    ('Arthur Conan Doyle', 'Creator of the detective Sherlock Holmes.'),
    ('Albert Camus', 'French philosopher and author of "The Stranger."'),
    ('Walt Whitman', 'Celebrated American poet of the 19th century.'),
    ('John Keats', 'Renowned English Romantic poet.'),
    ('Fyodor Dostoevsky', 'Russian author of "Crime and Punishment."'),
    ('George Eliot', 'Pseudonym of English novelist Mary Ann Evans.'),
    ('Jane Austen', 'Renowned English novelist.'),
    ('George Orwell', 'Famous British author and journalist.'),
    ('F. Scott Fitzgerald', 'Noted American writer of the Jazz Age.'),
    ('Virginia Woolf', 'Influential English modernist writer.'),
    ('Aldous Huxley', 'Author of "Brave New World."'),
    ('Herman Melville', 'Notable American novelist and poet.'),
    ('J.D. Salinger', 'Famed author of "The Catcher in the Rye."'),
    ('Charlotte Brontë', 'Writer of the classic novel "Jane Eyre."'),
    ('Toni Morrison', 'Nobel Prize-winning American author.'),
    ('J.R.R. Tolkien', 'Renowned creator of Middle-earth.');
  
    

	select * from Author



INSERT INTO Book (Title, ISBN, PublicationYear, AvailabilityStatus, CategoryID, AuthorID, PublisherID)
VALUES
    ('To Kill a Mockingbird', '9780061120084', '1960-07-11', 'Available', 1, 1, 1),
    ('1984', '9780451524935', '1949-06-08', 'Available', 2, 2, 2),
    ('Pride and Prejudice', '9780141439518', '1813-01-28', 'Available', 1, 3, 3),
    ('The Great Gatsby', '9780743273565', '1925-04-10', 'Available', 1, 4, 4),
    ('To the Lighthouse', '9780156030471', '1927-05-05', 'Available', 1, 5, 5),
    ('Brave New World', '9780060850524', '1932-01-01', 'Available', 2, 6, 6),
    ('Moby-Dick', '9781853260087', '1851-10-18', 'Available', 1, 7, 7),
    ('The Catcher in the Rye', '9780316769488', '1951-07-16', 'Available', 1, 8, 8),
    ('Jane Eyre', '9780141441146', '1847-10-16', 'Available', 1, 9, 9),
    ('Beloved', '9781400033416', '1987-09-02', 'Available', 1, 10, 10),
    ('The Lord of the Rings', '9780618640157', '1954-07-29', 'Available', 3, 11, 11),
    ('The Hobbit', '9780261102217', '1937-09-21', 'Available', 3, 11, 11),
    ('Harry Potter and the Philosopher''s Stone', '9780747532743', '1997-06-26', 'Available', 3, 12, 12),
    ('The Da Vinci Code', '9780307277671', '2003-03-18', 'Available', 4, 13, 13),
    ('A Game of Thrones', '9780553386790', '1996-08-01', 'Available', 3, 14, 14),
    ('The Hunger Games', '9780439023481', '2008-09-14', 'Available', 3, 15, 15),
    ('The Alchemist', '9780062315007', '1988-01-01', 'Available', 5, 16, 16),
    ('The Chronicles of Narnia', '9780066238500', '1950-10-16', 'Available', 3, 17, 17),
    ('The Odyssey', '9780140268867', '800-01-01', 'Available', 1, 18, 18),
    ('Crime and Punishment', '9780143107637', '1866-01-01', 'Available', 1, 19, 19),
    ('The Picture of Dorian Gray', '9780141439570', '1890-07-01', 'Available', 1, 20, 20),
    ('The Divine Comedy', '9780140449327', '1320-01-01', 'Available', 1, 21, 21),
    ('The Adventures of Tom Sawyer', '9780486400778', '1876-01-01', 'Available', 1, 22, 22),
    ('Frankenstein', '9780486282114', '1818-01-01', 'Available', 1, 23, 23),
    ('The Little Prince', '9780156012194', '1943-04-06', 'Available', 6, 24, 24),
    ('Alice''s Adventures in Wonderland', '9780141439761', '1865-11-26', 'Available', 6, 25, 25),
    ('Wuthering Heights', '9780141439556', '1847-12-29', 'Available', 1, 9, 26),
    ('The Sun Also Rises', '9780743297332', '1926-10-22', 'Available', 1, 26, 27);

insert into Borrower(FirstName,LastName) values('Abdullah','Esmail'),('Mohammed ','Esmail'),
('Ali','Saif'),('Atef','Mohammed'),('Ibrahim','Abdo'),('Yaseen','Abdo'),('Waheeb','Esmail'),
('Hail','Saeed'),('Hamdi','Rasam'),('Esmail','Ahmed'),('Ayoub','Ahmed'),
('Khalid','Qaid'),('Khalil','Kamel'),('Abas','Nasr')
,('Ameen','Mohammed');

select * from  Borrower
