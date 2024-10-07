CREATE PROC SearchByID
	@ID INT
AS
BEGIN
	SELECT * FROM Customer
	WHERE ID = @ID;
END;
GO
CREATE PROC AddCustomer
	@UserName VARCHAR(50),
	@Email VARCHAR(50),
	@Password varchar(50)
AS
BEGIN
	INSERT INTO Customer(UserName, Email, Password) VALUES(@UserName, @Email, @Password);
END;

GO

CREATE PROC DeleteCustomer
	@ID int
AS
BEGIN
	DELETE FROM Customer WHERE ID = @ID;
END;
GO

CREATE PROC UpdateCustomer
	@ID INT,
	@UserName varchar(50),
	@Email varchar(50),
	@Password varchar(50)
AS
BEGIN
	UPDATE Customer SET
	UserName = @UserName,
	Email = @Email,
	Password = @Password
	WHERE ID = @ID
END;

GO
CREATE PROC GetMySendMessage
	@ID int
AS
BEGIN 
	SELECT  s.UserName, m.ID as MessageID, m.MessageText, r.UserName
	FROM Messages m
	INNER JOIN Customer s on m.SenderID = s.ID
	INNER JOIN Customer R ON M.ReceiverID = R.ID
	WHERE (m.SenderID = @ID)
END;
GO

CREATE PROC GetDeliveredMessage
	@ReceiverID INT
AS
BEGIN
	SELECT M.ID AS MessageID, S.UserName AS SENDER, M.MessageText, R.UserName AS Receiver, M.SendDate
	FROM Messages M
	INNER JOIN Customer S ON  M.SenderID = S.ID
	INNER JOIN Customer R ON M.ReceiverID = R.ID
	WHERE M.ReceiverID = @ReceiverID
END;
GO

CREATE PROC ValidLogin
	@UserName varchar(50),
	@Password varchar(50)
AS
BEGIN
	SELECT * FROM Customer 
	WHERE UserName = @UserName AND Password = @Password;
END;
GO

CREATE PROC GetAllCustomer

AS
BEGIN
	SELECT * FROM Customer
END;

