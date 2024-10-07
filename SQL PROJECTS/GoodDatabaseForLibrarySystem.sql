CREATE TABLE Users
(
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    pass VARCHAR(255) NOT NULL
);



CREATE TABLE Patron
(
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    library_card_number VARCHAR(255) NOT NULL
);


CREATE TABLE Notification (
  notification_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT NOT NULL,
  msg NVARCHAR(MAX) NOT NULL,
  msg_status	 NVARCHAR(50) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE(),
  foreign key(user_id) references Patron(id)
);


CREATE TABLE Publisher
(
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
);

CREATE TABLE Author
(
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
);

CREATE TABLE Category
(
    id INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE Book
(
    id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    category_id INT NOT NULL,
    publication_date DATE NOT NULL,
    isbn VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES Publisher (id),
    FOREIGN KEY (category_id) REFERENCES Category (id)
);

CREATE TABLE BookAuthor
(
    id INT PRIMARY KEY IDENTITY(1,1),
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Book (id),
    FOREIGN KEY (author_id) REFERENCES Author (id)
);
CREATE TABLE LoanStatus(
 
	id int Primary key IDENTITY(1,1),
	Lable Varchar(20)
);

CREATE TABLE Loan
(
    id INT PRIMARY KEY IDENTITY(1,1),
    book_id INT NOT NULL,
    patron_id INT NOT NULL,
    checkout_date DATE NOT NULL,
    due_date DATE NOT NULL,
    status_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Book (id),
    FOREIGN KEY (patron_id) REFERENCES Patron (id),
	FOREIGN KEY (status_id) REFERENCES LoanStatus(id)
);




CREATE TABLE LoanReturn
(
    id INT PRIMARY KEY IDENTITY(1,1),
    loan_id INT NOT NULL,
    return_date DATE NOT NULL,
    condition VARCHAR(255),
    notes TEXT,
    FOREIGN KEY (loan_id) REFERENCES Loan (id)
);

CREATE TABLE BookReservation
(
    id INT PRIMARY KEY IDENTITY(1,1),
    book_id INT NOT NULL,
    patron_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    status VARCHAR(255) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Book (id),
    FOREIGN KEY (patron_id) REFERENCES Patron (id)
);



CREATE TABLE Vendor
(
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
);

CREATE TABLE PurchaseOrder
(
    id INT PRIMARY KEY IDENTITY(1,1),
    vendor_id INT NOT NULL,
    date_ordered DATE NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    status VARCHAR(255) NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES Vendor (id)
);

CREATE TABLE PurchaseOrderItem
(
    id INT PRIMARY KEY IDENTITY(1,1),
    purchase_order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity_ordered INT NOT NULL,
    unit_cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (purchase_order_id) REFERENCES PurchaseOrder (id),
    FOREIGN KEY (book_id) REFERENCES Book (id)
);

CREATE TABLE Invoice
(
    id INT PRIMARY KEY IDENTITY(1,1),
    purchase_order_id INT NOT NULL,
    date_received DATE NOT NULL,
    total_due DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (purchase_order_id) REFERENCES PurchaseOrder (id)
);

CREATE TABLE InvoiceItem
(
    id INT PRIMARY KEY IDENTITY(1,1),
    invoice_id INT NOT NULL,
    purchase_order_item_id INT NOT NULL,
    quantity_received INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES Invoice (id),
    FOREIGN KEY (purchase_order_item_id) REFERENCES PurchaseOrderItem (id)
);

CREATE TABLE Payment
(
    id INT PRIMARY KEY IDENTITY(1,1),
    invoice_id INT NOT NULL,
    date_paid DATE NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_type VARCHAR(255) NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES Invoice (id)
);