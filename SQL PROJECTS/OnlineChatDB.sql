
CREATE TABLE Customer (
  ID INT PRIMARY KEY IDENTITY(1,1),
  UserName VARCHAR(50),
  Email VARCHAR(100),
  [Password] VARCHAR(50)
);


CREATE TABLE Messages (
  ID INT PRIMARY KEY IDENTITY(1,1),
  SenderID INT,
  ReceiverID INT,
  MessageText VARCHAR(MAX),
  SendDate DATETIME DEFAULT GETDATE(),
  CONSTRAINT FK_Message_Sender FOREIGN KEY (SenderID) REFERENCES Customer(ID),
  CONSTRAINT FK_Message_Receiver FOREIGN KEY (ReceiverID) REFERENCES Customer(ID)
)



-- Insert some customers
INSERT INTO Customer (UserName, Email, [Password])
VALUES
  ('johndoe', 'johndoe@example.com', 'password123'),
  ('janedoe', 'janedoe@example.com', 'password456'),
  ('bobsmith', 'bobsmith@example.com', 'password789');

-- Insert some messages
INSERT INTO Messages (SenderID, ReceiverID, MessageText)
VALUES
  (1, 2, 'Hey Jane, i want to help you  out?'),
  (2, 1, 'I am doing well, thanks for asking.'),
  (1, 3, 'Hi Bob, did you go to bark to  at th?'),
  (3, 1, 'no, I did not. Looks good!'),
  (2, 3, 'Bob, can you come with me tomrrow?'),
  (3, 2, 'Sure,  when?');

  select * from Customer

SELECT m.ID, m.MessageText, m.SendDate, s.UserName AS Sender, r.UserName AS Receiver
FROM Messages m
JOIN Customer s ON m.SenderID = s.ID
JOIN Customer r ON m.ReceiverID = r.ID
WHERE (m.SenderID = 1 AND m.ReceiverID = 2) -- Replace with the actual sender and receiver IDs
ORDER BY m.SendDate ASC;








create proc GetMessagesReceivedForAPerson
@UserID int
as
SELECT UserName, SenderID, MessageText
FROM Customer c
INNER JOIN Messages m on c.ID = m.SenderID
where c.ID = @UserID

select * from Customer

exec GetMessagesReceivedForAPerson 2

exec GetMessagesReceivedForAPerson 1

exec GetMessageBetweenTwoUsers 3 , 1
create proc GetMessageBetweenTwoUsers
@User1ID int, @User2ID int
as
SELECT m.ID, m.MessageText, m.SendDate, s.UserName AS Sender, r.UserName AS Receiver
FROM Messages m
JOIN Customer s ON m.SenderID = s.ID
JOIN Customer r ON m.ReceiverID = r.ID
WHERE (m.SenderID = @User1ID AND m.ReceiverID = @User2ID) -- Replace with the actual sender and receiver IDs
ORDER BY m.SendDate ASC;



select c.UserName, m.ID, m.MessageText
from Messages m
inner join Customer c on m.SenderID = c.ID
where m.SenderID = 1

create proc GetSentMessage
@SenderID int
as
SELECT m.ID, m.MessageText, m.SendDate, s.UserName AS Sender, r.UserName AS Receiver
FROM Messages m
JOIN Customer s ON m.SenderID = s.ID
JOIN Customer r ON m.ReceiverID = r.ID
WHERE m.SenderID = @SenderID;


create proc GetReceivedMessage
@ReceiverID int
as
SELECT m.ID, m.MessageText, m.SendDate, s.UserName AS Sender, r.UserName AS Receiver
FROM Messages m
JOIN Customer s ON m.SenderID = s.ID
JOIN Customer r ON m.ReceiverID = r.ID
WHERE m.ReceiverID = @ReceiverID;

exec GetSentMessage 2
exec GetReceivedMessage 2
exec GetMessageBetweenTwoUsers 1 , 2