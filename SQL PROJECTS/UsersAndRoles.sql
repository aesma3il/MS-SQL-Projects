

-- User table
CREATE TABLE [dbo].[User] (
    [UserId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Username] NVARCHAR(50) NOT NULL,
    [Password] NVARCHAR(50) NOT NULL,
  
);


insert into [User] Values('ghadeer', 'ghadeer')

CREATE TABLE notify (
  notification_id INT IDENTITY(1,1) PRIMARY KEY,
  sender INT NOT NULL,
  receiver int not null,
  msg NVARCHAR(MAX) NOT NULL,
  msg_status	 NVARCHAR(50) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE(),
  
);


drop table notify
-- UserRole table
CREATE TABLE [dbo].[UserRole] (
    [UserId] INT NOT NULL,
    [RoleId] INT NOT NULL,
    CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId]),
    CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId])
);

-- Role table
CREATE TABLE [dbo].[Role] (
    [RoleId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [RoleName] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(200) NULL
);

-- Permission table
CREATE TABLE [dbo].[Permission] (
    [PermissionId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [PermissionName] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(200) NULL
);

-- RolePermission table
CREATE TABLE [dbo].[RolePermission] (
    [RoleId] INT NOT NULL,
    [PermissionId] INT NOT NULL,
    CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED ([RoleId] ASC, [PermissionId] ASC),
    CONSTRAINT [FK_RolePermission_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]),
    CONSTRAINT [FK_RolePermission_Permission] FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[Permission] ([PermissionId])
);

-- ActivityLog table
CREATE TABLE [dbo].[ActivityLog] (
    [LogId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL,
    [ActivityType] NVARCHAR(50) NOT NULL,
    [ActivityTime] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [FK_ActivityLog_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId])
);


select * from [User]