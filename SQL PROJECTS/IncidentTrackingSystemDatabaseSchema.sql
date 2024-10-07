--CREATE DATABASE IncidentTrackingSystem;
--go
--use IncidentTrackingSystem;

--go
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Password VARCHAR(255),
    Email VARCHAR(255),
    RoleID INT

);

CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY,
    Title VARCHAR(255),
    Description VARCHAR(MAX),
    PriorityID INT,
    StatusID INT,
    AssignedToUserID INT,
    ReportedByUserID INT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    CreatedByUserID INT,
    UpdatedByUserID INT
   
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(MAX)
);

CREATE TABLE Comments (
    CommentID INT PRIMARY KEY,
    IncidentID INT,
    UserID INT,
    Comment VARCHAR(MAX),
    CreatedAt DATETIME,

);

CREATE TABLE Attachments (
    AttachmentID INT PRIMARY KEY,
    IncidentID INT,
    UserID INT,
    Filename VARCHAR(255),
    Filepath VARCHAR(255),
    CreatedAt DATETIME
 
);

CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(MAX)
);

CREATE TABLE Statuses (
    StatusID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(MAX)
);

CREATE TABLE Priorities (
    PriorityID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(MAX)
);

CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY,
    UserID INT,
    IncidentID INT,
    Message VARCHAR(MAX),
    Timestamp DATETIME,
    IsRead BIT
   
);

CREATE TABLE Tags (
    TagID INT PRIMARY KEY,
    TagName VARCHAR(255)
  
);


alter table Incidents
add CategoryID int