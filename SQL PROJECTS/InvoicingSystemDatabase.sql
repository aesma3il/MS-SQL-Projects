


CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY IDENTITY(1,1) ,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    BillingAddress VARCHAR(100),
	RowGuid uniqueidentifier DEFAULT NEWID()
);






CREATE TABLE Invoice (
    InvoiceId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL,
    InvoiceDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
	RowGuid uniqueidentifier DEFAULT NEWID()
);

CREATE TABLE ProductOrService (
    ProductOrServiceId INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    [Description] VARCHAR(500),
    Price DECIMAL(10, 2) NOT NULL,
	RowGuid uniqueidentifier DEFAULT NEWID()
	
);


CREATE TABLE InvoiceLine (
    InvoiceLineId INT PRIMARY KEY IDENTITY(1,1),
    InvoiceId INT NOT NULL,
    ProductOrServiceId INT NOT NULL,
    Quantity INT NOT NULL,
    LineItemTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId),
    FOREIGN KEY (ProductOrServiceId) REFERENCES ProductOrService(ProductOrServiceId),
	RowGuid uniqueidentifier DEFAULT NEWID()
);



CREATE TABLE Payment (
    PaymentId INT PRIMARY KEY IDENTITY(1,1),
    InvoiceId INT NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId),
	RowGuid uniqueidentifier DEFAULT NEWID()
);



INSERT INTO ProductOrService (ProductName, [Description], Price)
VALUES ('iPhone 12', 'Apple smartphone with OLED display and A14 Bionic chip', 799.00),
       ('Samsung Galaxy S21', 'Android smartphone with 5G connectivity and triple camera', 699.99),
       ('Sony WH-1000XM4', 'Wireless noise-canceling headphones with 30-hour battery life', 349.99),
       ('Nintendo Switch', 'Portable gaming console with detachable Joy-Con controllers', 299.99),
       ('Bose QuietComfort Earbuds', 'True wireless earbuds with noise cancellation and IPX4 rating', 279.00)
	   
	   
	   
	   
	   
	   
	   INSERT INTO ProductOrService (ProductName, [Description], Price)
VALUES 
('iPhone 12', 'Apple smartphone with OLED display and A14 Bionic chip', 799.00),
('Samsung Galaxy S21', 'Android smartphone with 5G connectivity and triple camera', 699.99),
('Sony WH-1000XM4', 'Wireless noise-canceling headphones with 30-hour battery life', 349.99),
('Nintendo Switch', 'Portable gaming console with detachable Joy-Con controllers', 299.99),
('Bose QuietComfort Earbuds', 'True wireless earbuds with noise cancellation and IPX4 rating', 279.00),
('Apple Watch Series 6', 'Smartwatch with always-on Retina display and blood oxygen sensor', 399.00),
('Fitbit Charge 4', 'Fitness tracker with built-in GPS and heart rate monitor', 129.95),
('Sony PlayStation 5', 'Next-generation gaming console with 4K graphics and ultra-fast SSD', 499.99),
('Xbox Series X', 'Powerful gaming console with 4K graphics and 1TB SSD', 499.99),
('Dyson V11 Absolute', 'Cordless vacuum cleaner with up to 60 minutes of run time', 699.99),
('Keurig K-Elite', 'Single-serve coffee maker with strong brew and iced coffee settings', 169.99),
('Instant Pot Duo Nova', 'Multi-cooker with 7-in-1 functions and easy-seal lid', 99.99),
('Ninja Foodi Grill', 'Indoor grill with smokeless technology and 4-quart air fryer', 249.99),
('Samsung QLED 4K TV', 'Smart TV with Quantum Dot technology and Alexa compatibility', 999.99),
('LG OLED 4K TV', 'Smart TV with self-lit pixels and Dolby Vision IQ', 1899.99),
('HP Spectre x360', '2-in-1 laptop with 4K OLED display and 11th Gen Intel Core processor', 1499.99),
('Dell XPS 13', 'Ultra-portable laptop with InfinityEdge display and 11th Gen Intel Core processor', 949.99),
('Logitech MX Master 3', 'Wireless mouse with MagSpeed scrolling and customizable buttons', 99.99),
('Apple Magic Keyboard', 'Wireless keyboard with scissor mechanism and numeric keypad', 129.00),
('Bose SoundLink Revolve+', 'Portable Bluetooth speaker with 360-degree sound and water-resistant design', 299.00),
('Sonos One', 'Smart speaker with voice control and multi-room audio', 199.00),
('Google Nest Hub Max', 'Smart display with built-in Google Assistant and video calling', 229.00),
('Ring Video Doorbell Pro', 'Smart doorbell with HD video and motion-activated alerts', 249.00),
('Arlo Pro 4', 'Wireless security camera with 2K HDR video and color night vision', 199.99),
('Nest Learning Thermostat', 'Smart thermostat with auto-schedule and remote control', 249.00),
('iRobot Roomba i7+', 'Robot vacuum cleaner with automatic dirt disposal and smart mapping', 799.99),
('Fujifilm X-T4', 'Mirrorless camera with 26.1MP sensor and in-body image stabilization', 1699.99),
('Canon EOS R5', 'Full-frame mirrorless camera with 45MP sensor and 8K video', 3899.00),
('GoPro HERO9 Black', 'Action camera with 5K video and HyperSmooth 3.0 stabilization', 449.99),
('Sony Alpha A7 III', 'Mirrorless camera with 24.2MP sensor and 4K video', 1998.00),
('Razer Blade 15', 'Gaming laptop with 144Hz display and NVIDIA GeForce RTX 3070 graphics', 1999.99),
('ASUS ROG Zephyrus G14', 'Ultra-slim gaming laptop with AMD Ryzen 9 processor and NVIDIA GeForce RTX 3060 graphics', 1499.99);
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   INSERT INTO Customer (FirstName, LastName, Email, Phone, BillingAddress)
		VALUES ('John', 'Doe', 'johndoe@gmail.com', '555-123-4567', '123 Main St, Anytown, USA'),
       ('Jane', 'Smith', 'janesmith@yahoo.com', '555-987-6543', '456 Elm St, Anytown, USA'),
       ('Bob', 'Johnson', 'bjohnson@hotmail.com', '555-555-5555', '789 Oak St, Anytown, USA'),
       ('Samantha', 'Lee', 'samanthalee@gmail.com', NULL, '321 Maple St, Anytown, USA'),
       ('David', 'Chang', 'davidchang@gmail.com', '555-111-2222', '555 Pine St, Anytown, USA'),
	    ('Abdullah', 'Esmail', 'abdism.ye@gmail.com', '738-807-541', 'Gamael  St, Taiz, Yemen')
		, ('Ghadeer', 'Mohammed', 'ghadeer.ye@gmail.com', '738-807-541', 'Gamael  St, Taiz, Yemen'),
		 ('Mohammed', 'Esmail', 'mohahmd.ye@gmail.com', '738-807-541', 'Gamael  St, Taiz, Yemen');
	   
	   
	   
	   
	   
	   
	   
	   