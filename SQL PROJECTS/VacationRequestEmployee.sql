

CREATE TABLE [dbo].[Employees]
(
    [Id] INT IDENTITY(1, 1) PRIMARY KEY,
    [EmployeeCode] NVARCHAR(10) NOT NULL UNIQUE,
    [Name] NVARCHAR(100) NOT NULL,
    [ManagerCode] NVARCHAR(10) NULL,
    [CreatedAt] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    [UpdatedAt] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    [EmployeeNotificationEnabled] BIT NOT NULL DEFAULT 1,
    [ManagerNotificationEnabled] BIT NOT NULL DEFAULT 1
);

ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_Employees_Employees] FOREIGN KEY ([ManagerCode]) REFERENCES [dbo].[Employees]([EmployeeCode]);

CREATE TABLE [dbo].[VacationRequests]
(
    [Id] INT IDENTITY(1, 1) PRIMARY KEY,
    [EmployeeId] INT NOT NULL,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE NOT NULL,
    [Reason] NVARCHAR(MAX) NOT NULL,
    [Status] NVARCHAR(50) NOT NULL,
    [ManagerCode] NVARCHAR(10) NOT NULL,
    [ApprovedDate] DATETIME2(7) NULL,
    [RejectedDate] DATETIME2(7) NULL,
    [CreatedAt] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    [UpdatedAt] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employees]([Id]),
    FOREIGN KEY ([ManagerCode]) REFERENCES [dbo].[Employees]([EmployeeCode])
);

CREATE TABLE [dbo].[NotificationTypes]
(
    [Id] INT IDENTITY(1, 1) PRIMARY KEY,
    [Type] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(MAX) NULL
);

CREATE TABLE [dbo].[Notifications]
(
    [Id] INT IDENTITY(1, 1) PRIMARY KEY,
    [RecipientId] INT NOT NULL,
    [NotificationTypeId] INT NOT NULL,
    [Message] NVARCHAR(MAX) NOT NULL,
    [SentDate] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    [IsRead] BIT NOT NULL DEFAULT 0,
    FOREIGN KEY ([RecipientId]) REFERENCES [dbo].[Employees]([Id]),
    FOREIGN KEY ([NotificationTypeId]) REFERENCES [dbo].[NotificationTypes]([Id])
);