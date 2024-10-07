CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  PhoneNumber VARCHAR(20) NOT NULL,
  DisplayName VARCHAR(50) NOT NULL,
  ProfilePicture VARBINARY(MAX),
  LastSeen DATETIME,
  IsOnline BIT
);

CREATE TABLE Conversations (
  ConversationID INT PRIMARY KEY,
  ConversationType VARCHAR(10) NOT NULL,
  Title VARCHAR(50) NULL,
  CreatorID INT NOT NULL,
  CreatedDate DATETIME NOT NULL,
  ModifiedDate DATETIME,
  CONSTRAINT FK_Conversations_Users FOREIGN KEY (CreatorID) REFERENCES Users(UserID)
);

CREATE TABLE Participants (
  ParticipantID INT PRIMARY KEY,
  ConversationID INT NOT NULL,
  UserID INT NOT NULL,
  CONSTRAINT FK_Participants_Conversations FOREIGN KEY (ConversationID) REFERENCES Conversations(ConversationID),
  CONSTRAINT FK_Participants_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Messages (
  MessageID INT PRIMARY KEY,
  ConversationID INT NOT NULL,
  SenderID INT NOT NULL,
  MessageText VARCHAR(255) NOT NULL,
  MessageDate DATETIME NOT NULL,
  IsRead BIT NOT NULL,
  CONSTRAINT FK_Messages_Conversations FOREIGN KEY (ConversationID) REFERENCES Conversations(ConversationID),
  CONSTRAINT FK_Messages_Users FOREIGN KEY (SenderID) REFERENCES Users(UserID)
);

CREATE TABLE Attachments (
  AttachmentID INT PRIMARY KEY,
  MessageID INT NOT NULL,
  FileName VARCHAR(255) NOT NULL,
  FileType VARCHAR(10) NOT NULL,
  FileSize INT NOT NULL,
  FileData VARBINARY(MAX) NOT NULL,
  CONSTRAINT FK_Attachments_Messages FOREIGN KEY (MessageID) REFERENCES Messages(MessageID)
);

CREATE TABLE Statuses (
  StatusID INT PRIMARY KEY,
  UserID INT NOT NULL,
  StatusText VARCHAR(255) NOT NULL,
  StatusDate DATETIME NOT NULL,
  CONSTRAINT FK_Statuses_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Calls (
  CallID INT PRIMARY KEY,
  ConversationID INT NOT NULL,
  CallerID INT NOT NULL,
  ReceiverID INT NOT NULL,
  CallType VARCHAR(10) NOT NULL,
  CallDuration INT NOT NULL,
  CallDate DATETIME NOT NULL,
  CONSTRAINT FK_Calls_Conversations FOREIGN KEY (ConversationID) REFERENCES Conversations(ConversationID),
  CONSTRAINT FK_Calls_CallerUsers FOREIGN KEY (CallerID) REFERENCES Users(UserID),
  CONSTRAINT FK_Calls_ReceiverUsers FOREIGN KEY (ReceiverID) REFERENCES Users(UserID)
);

CREATE TABLE Contacts (
  ContactID INT PRIMARY KEY,
  UserID INT NOT NULL,
  ContactPhoneNumber VARCHAR(20) NOT NULL,
  ContactDisplayName VARCHAR(50) NOT NULL,
  ContactProfilePicture VARBINARY(MAX),
  CONSTRAINT FK_Contacts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);