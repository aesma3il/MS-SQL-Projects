CREATE DATABASE CustomerServiceTicketSys;
GO

USE CustomerServiceTicketSys;
GO

CREATE TABLE tblRole (
    RoleID int PRIMARY KEY IDENTITY(1,1),
    RoleName nvarchar(100) NOT NULL
);

CREATE TABLE tblCustomer (
    CustomerID int PRIMARY KEY IDENTITY(1,1),
    FullName nvarchar(100) NOT NULL,
    PhoneNumber nvarchar(50) NULL,
    EmailAddress nvarchar(100) NULL,
    UserID nvarchar(100) NOT NULL,
    Pass nvarchar(255) NOT NULL, -- Encrypted password
    RoleID int FOREIGN KEY REFERENCES tblRole(RoleID) ON DELETE CASCADE
);

CREATE TABLE tblAgent (
    AgentID int PRIMARY KEY IDENTITY(1,1),
    FullName nvarchar(100) NOT NULL,
    PhoneNumber nvarchar(50) NULL,
    EmailAddress nvarchar(100) NULL,
    UserID nvarchar(100) NOT NULL,
    Pass nvarchar(255) NOT NULL, -- Encrypted password
    RoleID int FOREIGN KEY REFERENCES tblRole(RoleID) ON DELETE CASCADE
);

CREATE TABLE tblAdmin (
    AdminID int PRIMARY KEY IDENTITY(1,1),
    FullName nvarchar(100) NOT NULL,
    PhoneNumber nvarchar(50) NULL,
    EmailAddress nvarchar(100) NULL,
    UserID nvarchar(100) NOT NULL,
    Pass nvarchar(255) NOT NULL, -- Encrypted password
    RoleID int FOREIGN KEY REFERENCES tblRole(RoleID) ON DELETE CASCADE
);

CREATE TABLE tblPriority (
    PriorityID int PRIMARY KEY IDENTITY(1,1),
    PriorityName nvarchar(100) NOT NULL
);

CREATE TABLE tblCategory (
    CategoryID int PRIMARY KEY IDENTITY(1,1),
    CategoryName nvarchar(100) NOT NULL
);

CREATE TABLE tblStatus (
    StatusID int PRIMARY KEY IDENTITY(1,1),
    StatusName nvarchar(100) NOT NULL
);

CREATE TABLE tblTicket (
    TicketID int PRIMARY KEY IDENTITY(1,1),
    TicketNumber uniqueidentifier DEFAULT NEWID() NOT NULL,
    SubjectLine nvarchar(100) NOT NULL,
    BodyDescription nvarchar(max) NULL,
    CustomerID int FOREIGN KEY REFERENCES tblCustomer(CustomerID) ON DELETE CASCADE,
    CategoryID int FOREIGN KEY REFERENCES tblCategory(CategoryID),
    AgentID int FOREIGN KEY REFERENCES tblAgent(AgentID),
    PriorityID int FOREIGN KEY REFERENCES tblPriority(PriorityID),
    StatusID int FOREIGN KEY REFERENCES tblStatus(StatusID),
    CreatedAt datetime DEFAULT GETDATE(),
    UpdatedAt datetime NULL
);

CREATE TABLE tblComment (
    CommentID int PRIMARY KEY IDENTITY(1,1),
    TicketID int FOREIGN KEY REFERENCES tblTicket(TicketID) ON DELETE CASCADE,
    AgentID int FOREIGN KEY REFERENCES tblAgent(AgentID),
    CommentText nvarchar(max) NOT NULL,
    CreatedAt datetime DEFAULT GETDATE()
);



-- Insert 10 records into tblRole
INSERT INTO tblRole (RoleName)
VALUES 
('Customer'),
('Agent'),
('Admin');

-- Insert 10 records into tblCustomer
INSERT INTO tblCustomer (FullName, PhoneNumber, EmailAddress, UserID, Pass, RoleID)
VALUES
('John Doe', '555-1234', 'johndoe@example.com', 'johndoe', 'password', 1),
('Jane Smith', '555-5678', 'janesmith@example.com', 'janesmith', 'password', 1),
('Mike Johnson', '555-9012', 'mikejohnson@example.com', 'mikejohnson', 'password',1),
('Emily Wilson', '555-3456', 'emilywilson@example.com', 'emilywilson', 'password', 1),
('David Lee', '555-7890', 'davidlee@example.com', 'davidlee', 'password', 1),
('Amy Chen', '555-2345', 'amychen@example.com', 'amychen', 'password', 1),
('Brian Kim', '555-6789', 'briankim@example.com', 'briankim', 'password', 1),
('Karen Brown', '555-0123', 'karenbrown@example.com', 'karenbrown', 'password', 1),
('Tommy Davis', '555-4567', 'tommydavis@example.com', 'tommydavis', 'password', 1),
('Samantha Green', '555-8901', 'samanthagreen@example.com', 'samanthagreen', 'password', 1);

-- Insert 10 records into tblAgent
INSERT INTO tblAgent (FullName, PhoneNumber, EmailAddress, UserID, Pass, RoleID)
VALUES
('Adam Lee', '555-1234', 'adamlee@example.com', 'adamlee', 'password', 2),
('Karen Johnson', '555-5678', 'karenjohnson@example.com', 'karenjohnson', 'password', 2),
('James Smith', '555-9012', 'jamessmith@example.com', 'jamessmith', 'password', 2),
('Jessica Wilson', '555-3456', 'jessicawilson@example.com', 'jessicawilson', 'password', 2),
('Brian Lee', '555-7890', 'brianlee@example.com', 'brianlee', 'password', 2),
('Grace Chen', '555-2345', 'gracechen@example.com', 'gracechen', 'password', 2),
('David Kim', '555-6789', 'davidkim@example.com', 'davidkim', 'password', 2),
('Amy Brown', '555-0123', 'amybrown@example.com', 'amybrown', 'password', 2),
('Tommy Davis', '555-4567', 'tommydavis@example.com', 'tommydavis', 'password', 2),
('Samantha Green', '555-8901', 'samanthagreen@example.com', 'samanthagreen', 'password', 2);

-- Insert 10 records into tblAdmin
INSERT INTO tblAdmin (FullName, PhoneNumber, EmailAddress, UserID, Pass, RoleID)
VALUES
('Admin 1', '555-1234', 'admin1@example.com', 'admin1', 'password', 3),
('Admin 2', '555-5678', 'admin2@example.com', 'admin2', 'password', 3),
('Admin 3', '555-9012', 'admin3@example.com', 'admin3', 'password', 3),
('Admin 4', '555-3456', 'admin4@example.com', 'admin4', 'password', 3),
('Admin 5', '555-7890', 'admin5@example.com', 'admin5', 'password', 3),
('Admin 6', '555-2345', 'admin6@example.com', 'admin6', 'password', 3),
('Admin 7', '555-6789', 'admin7@example.com', 'admin7', 'password', 3),
('Admin 8', '555-0123', 'admin8@example.com', 'admin8', 'password', 3),
('Admin 9', '555-4567', 'admin9@example.com', 'admin9', 'password', 3),
('Admin 10', '555-8901', 'admin10@example.com', 'admin10', 'password', 3);

-- Insert 10 records intotblPriority
INSERT INTO tblPriority (PriorityName)
VALUES
('Low'),
('Medium'),
('High'),
('Urgent'),
('Emergency'),
('Critical'),
('Important'),
('Normal'),
('Minor'),
('Major');

-- Insert 10 records into tblCategory
INSERT INTO tblCategory (CategoryName)
VALUES
('Ticket Request'),
('Technical Support'),
('Sales'),
('Product Inquiry'),
('General Inquiry'),
('Complaint'),
('Feedback'),
('Account Management'),
('Refund'),
('Cancellation');

-- Insert 10 records into tblStatus
INSERT INTO tblStatus (StatusName)
VALUES
('New'),
('Assigned'),
('In Progress'),
('On Hold'),
('Resolved'),
('Closed'),
('Canceled'),
('Waiting for Customer'),
('Waiting for Agent'),
('Waiting for Third Party');

-- Insert 10 records into tblTicket
INSERT INTO tblTicket (SubjectLine, BodyDescription, CustomerID, CategoryID, AgentID, PriorityID, StatusID)
VALUES
('Issue with billing', 'I have been charged incorrectly on my bill. Please help me resolve this issue.', 1, 1, 2, 3, 1),
('Problem with website', 'I am unable to login to my account on the website. Can you please assist me?', 2, 2, 3, 2, 2),
('Sales inquiry', 'I am interested in purchasing your product. Can you provide me with more information?', 3, 3, NULL, 1, 1),
('Product feedback', 'I recently purchased your product and would like to provide some feedback on its performance.', 4, 4, NULL, 5, 1),
('Technical issue', 'I am experiencing a technical issue with your product and need assistance in resolving it.', 5, 2, 4, 4, 3),
('General inquiry', 'I have a question about your company and its policies. Can you please provide me with more information?', 6, 5, NULL, 6, 1),
('Complaint', 'I am very dissatisfied with the level of service I have received from your company. Please address this issue.', 7, 6, NULL, 7, 1),
('Refund request', 'I would like to request a refund for a product I recently purchased that did not meet my expectations.', 8, 9, NULL, 3, 1),
('Cancellation request', 'I would like to cancel my subscription with your company. Please assist me in doing so.', 9, 9, NULL, 2, 1),
('Account issue', 'I am having issues accessing my account and need assistance in resolving the issue.', 10, 8, 5, 8, 1);

-- Insert 10 records into tblComment
INSERT INTO tblComment (TicketID, AgentID, CommentText)
VALUES
(1, 2, 'We apologize for the inconvenience. We will investigate the issue and get back to you soon.'),
(1, 4, 'Thank you for bringing this to our attention. We will work to resolve the issue as soon as possible.'),
(2, 3, 'We are sorry for the inconvenience. Our technical support team will reach out to you shortly.'),
(2, 4, 'Thank you for reaching out to us. We will work quickly to resolve the issue.'),
(3, NULL, 'Thank you for your interest in our product. Our sales team will be in touch with you shortly.'),
(4, NULL, 'Thank you for your feedback. We appreciate your input and will use it to improve our product.'),
(5, 4, 'We apologize for the technical issue you are experiencing. Our support team will reach out to you shortly.'),
(5, 5, 'Thank you for bringing this to our attention. We will work to resolve the issue as soon as possible.'),
(6, NULL, 'Thank you for your inquiry. Our team will be in touch with you shortly.'),
(7, NULL, 'We apologize for the level of service you have received. We will work to address the issue and improve our service in the future.');



-- Create stored procedure to update a role

go
-- Create stored procedure to delete a role





--------------------------------------


-- Create stored procedure to update a customer
CREATE PROCEDURE spUpdateCustomer
    @CustomerID int,
    @FullName nvarchar(100),
    @PhoneNumber nvarchar(50),
    @EmailAddress nvarchar(100),
    @UserID nvarchar(100),
    @Pass nvarchar(255),
    @RoleID int
AS
BEGIN
    UPDATE tblCustomer
    SET FullName = @FullName, PhoneNumber = @PhoneNumber, EmailAddress = @EmailAddress, UserID = @UserID, Pass = @Pass, RoleID = @RoleID
    WHERE CustomerID = @CustomerID
END

-- Create stored procedure to delete a customer
CREATE PROCEDURE spDeleteCustomer
    @CustomerID int
AS
BEGIN
    DELETE FROM tblCustomer
    WHERE CustomerID = @CustomerID
END

-- Create stored procedure to retrieve all customers
CREATE PROCEDURE spGetAllCustomers
AS
BEGIN
    SELECT *
    FROM tblCustomer
END

-- Create stored procedure to retrieve a customer by ID
CREATE PROCEDURE spGetCustomerByID
    @CustomerID int
AS
BEGIN
    SELECT *
    FROM tblCustomer
    WHERE CustomerID = @CustomerID
END







	-- Create stored procedure to insert a new admin
CREATE PROCEDURE spInsertAdmin
    @FullName nvarchar(100),
    @PhoneNumber nvarchar(50),
    @EmailAddress nvarchar(100),
    @UserID nvarchar(100),
    @Pass nvarchar(255),
    @RoleID int
AS
BEGIN
    INSERT INTO tblAdmin (FullName, PhoneNumber, EmailAddress, UserID, Pass, RoleID)
    VALUES (@FullName, @PhoneNumber, @EmailAddress, @UserID, @Pass, @RoleID)
END

-- Create stored procedure to update an admin
CREATE PROCEDURE spUpdateAdmin
    @AdminID int,
    @FullName nvarchar(100),
    @PhoneNumber nvarchar(50),
    @EmailAddress nvarchar(100),
    @UserID nvarchar(100),
    @Pass nvarchar(255),
    @RoleID int
AS
BEGIN
    UPDATE tblAdmin
    SET FullName = @FullName, PhoneNumber = @PhoneNumber, EmailAddress = @EmailAddress, UserID = @UserID, Pass = @Pass, RoleID = @RoleID
    WHERE AdminID = @AdminID
END

-- Create stored procedure to delete an admin
CREATE PROCEDURE spDeleteAdmin
    @AdminID int
AS
BEGIN
    DELETE FROM tblAdmin
    WHERE AdminID = @AdminID
END

-- Create stored procedure to retrieve all admins
CREATE PROCEDURE spGetAllAdmins
AS
BEGIN
    SELECT *
    FROM tblAdmin
END

-- Create stored procedure to retrieve an admin by ID
CREATE PROCEDURE spGetAdminByID
    @AdminID int
AS
BEGIN
    SELECT *
    FROM tblAdmin
    WHERE AdminID = @AdminID
END
----------------------------
-- Create stored procedure to insert a new priority
CREATE PROCEDURE spInsertPriority
    @PriorityName nvarchar(100)
AS
BEGIN
    INSERT INTO tblPriority (PriorityName)
    VALUES (@PriorityName)
END

-- Create stored procedure to update a priority
CREATE PROCEDURE spUpdatePriority
    @PriorityID int,
    @PriorityName nvarchar(100)
AS
BEGIN
    UPDATE tblPriority
    SET PriorityName = @PriorityName
    WHERE PriorityID = @PriorityID
END

-- Create stored procedure to delete a priority
CREATE PROCEDURE spDeletePriority
    @PriorityID int
AS
BEGIN
    DELETE FROM tblPriority
    WHERE PriorityID = @PriorityID
END

-- Create stored procedure to retrieve all priorities
CREATE PROCEDURE spGetAllPriorities
AS
BEGIN
    SELECT *
    FROM tblPriority
END

-- Create stored procedure to retrieve a priority by ID
CREATE PROCEDURE spGetPriorityByID
    @PriorityID int
AS
BEGIN
    SELECT *
    FROM tblPriority
    WHERE PriorityID = @PriorityID
END



------------------------
-- Create stored procedure to insert a new category
CREATE PROCEDURE spInsertCategory
    @CategoryName nvarchar(100)
AS
BEGIN
    INSERT INTO tblCategory (CategoryName)
    VALUES (@CategoryName)
END

-- Create stored procedure to update a category
CREATE PROCEDURE spUpdateCategory
    @CategoryID int,
    @CategoryName nvarchar(100)
AS
BEGIN
    UPDATE tblCategory
    SET CategoryName = @CategoryName
    WHERE CategoryID = @CategoryID
END

-- Create stored procedure to delete a category
CREATE PROCEDURE spDeleteCategory
    @CategoryID int
AS
BEGIN
    DELETE FROM tblCategory
    WHERE CategoryID = @CategoryID
END

-- Create stored procedure to retrieve all categories
CREATE PROCEDURE spGetAllCategories
AS
BEGIN
    SELECT *
    FROM tblCategory
END

-- Create stored procedure to retrieve a category by ID
CREATE PROCEDURE spGetCategoryByID
    @CategoryID int
AS
BEGIN
    SELECT *
    FROM tblCategory
    WHERE CategoryID = @CategoryID
END

-- Create stored procedure to insert a new status
CREATE PROCEDURE spInsertStatus
    @StatusName nvarchar(100)
AS
BEGIN
    INSERT INTO tblStatus (StatusName)
    VALUES (@StatusName)
END

-- Create stored procedure to update a status
CREATE PROCEDURE spUpdateStatus
    @StatusID int,
    @StatusName nvarchar(100)
AS
BEGIN
    UPDATE tblStatus
    SET StatusName = @StatusName
    WHERE StatusID = @StatusID
END

-- Create stored procedure to delete a status
CREATE PROCEDURE spDeleteStatus
    @StatusID int
AS
BEGIN
    DELETE FROM tblStatus
    WHERE StatusID = @StatusID
END

-- Create stored procedure to retrieve all statuses
CREATE PROCEDURE spGetAllStatuses
AS
BEGIN
    SELECT *
    FROM tblStatus
END

-- Create stored procedure to retrieve a status by ID
CREATE PROCEDURE spGetStatusByID
    @StatusID int
AS
BEGIN
    SELECT *
    FROM tblStatus
	WHERE StatusID = @StatusID
end































































CREATE VIEW vwTicketInformation
AS
SELECT t.TicketID, t.TicketNumber, t.SubjectLine, t.BodyDescription, 
       c.FullName AS CustomerName, a.FullName AS AgentName, 
       p.PriorityName, cat.CategoryName, s.StatusName,
       t.CreatedAt, t.UpdatedAt
FROM tblTicket t
INNER JOIN tblCustomer c ON t.CustomerID = c.CustomerID
LEFT JOIN tblAgent a ON t.AgentID = a.AgentID
LEFT JOIN tblPriority p ON t.PriorityID = p.PriorityID
LEFT JOIN tblCategory cat ON t.CategoryID = cat.CategoryID
LEFT JOIN tblStatus s ON t.StatusID = s.StatusID



CREATE VIEW vwTicketComments
AS
SELECT c.CommentID, c.TicketID, a.FullName AS AgentName, 
       c.CommentText, c.CreatedAt
FROM tblComment c
INNER JOIN tblAgent a ON c.AgentID = a.AgentID


CREATE VIEW vwAgentTickets
AS
SELECT t.TicketID, t.TicketNumber, t.SubjectLine, t.BodyDescription, 
       c.FullName AS CustomerName, p.PriorityName, cat.CategoryName, s.StatusName,
       t.CreatedAt, t.UpdatedAt
FROM tblTicket t
INNER JOIN tblCustomer c ON t.CustomerID = c.CustomerID
INNER JOIN tblPriority p ON t.PriorityID = p.PriorityID
INNER JOIN tblCategory cat ON t.CategoryID = cat.CategoryID
INNER JOIN tblStatus s ON t.StatusID = s.StatusID
WHERE t.AgentID = @agentId



CREATE VIEW vwCustomerTickets
AS
SELECT t.TicketID, t.TicketNumber, t.SubjectLine, t.BodyDescription, 
       a.FullName AS AgentName, p.PriorityName, cat.CategoryName, s.StatusName,
       t.CreatedAt, t.UpdatedAt
FROM tblTicket t
LEFT JOIN tblAgent a ON t.AgentID = a.AgentID
INNER JOIN tblPriority p ON t.PriorityID = p.PriorityID
INNER JOIN tblCategory cat ON t.CategoryID = cat.CategoryID
INNER JOIN tblStatus s ON t.StatusID = s.StatusID
WHERE t.CustomerID = @customerId


CREATE VIEW vwCustomerTickets
AS
SELECT t.TicketID, t.TicketNumber, t.SubjectLine, t.BodyDescription, 
       a.FullName AS AgentName, p.PriorityName, cat.CategoryName, s.StatusName,
       t.CreatedAt, t.UpdatedAt
FROM tblTicket t
LEFT JOIN tblAgent a ON t.AgentID = a.AgentID
INNER JOIN tblPriority p ON t.PriorityID = p.PriorityID
INNER JOIN tblCategory cat ON t.CategoryID = cat.CategoryID
INNER JOIN tblStatus s ON t.StatusID = s.StatusID
WHERE t.CustomerID = @customerId