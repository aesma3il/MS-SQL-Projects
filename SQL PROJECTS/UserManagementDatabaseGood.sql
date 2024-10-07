-- Create User table
CREATE TABLE [dbo].[User] (
    [UserId] INT IDENTITY(1,1) PRIMARY KEY,
    [Username] NVARCHAR(50) NOT NULL,
    [Password] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

-- Create Role table
CREATE TABLE [dbo].[Role] (
    [RoleId] INT IDENTITY(1,1) PRIMARY KEY,
    [RoleName] NVARCHAR(50) NOT NULL
);

-- Create UserRole table to establish a many-to-many relationship between User and Role
CREATE TABLE [dbo].[UserRole] (
    [UserId] INT NOT NULL,
    [RoleId] INT NOT NULL,
    PRIMARY KEY ([UserId], [RoleId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[User]([UserId]),
    FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role]([RoleId])
);

-- Create Permission table
CREATE TABLE [dbo].[Permission] (
    [PermissionId] INT IDENTITY(1,1) PRIMARY KEY,
    [PermissionName] NVARCHAR(50) NOT NULL
);

-- Create RolePermission table to establish a many-to-many relationship between Role and Permission
CREATE TABLE [dbo].[RolePermission] (
    [RoleId] INT NOT NULL,
    [PermissionId] INT NOT NULL,
    PRIMARY KEY ([RoleId], [PermissionId]),
    FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role]([RoleId]),
    FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[Permission]([PermissionId])
);

-- Create UserSession table
CREATE TABLE [dbo].[UserSession] (
    [SessionId] INT IDENTITY(1,1) PRIMARY KEY,
    [UserId] INT NOT NULL,
    [StartTime] DATETIME NOT NULL DEFAULT GETDATE(),
    [EndTime] DATETIME,
    [IpAddress] NVARCHAR(50),
    [UserAgent] NVARCHAR(500),
    [DeviceInformation] NVARCHAR(500),
    [SessionStatus] NVARCHAR(20),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[User]([UserId])
);

-- Create PasswordResetToken table
CREATE TABLE [dbo].[PasswordResetToken] (
    [TokenId] INT IDENTITY(1,1) PRIMARY KEY,
    [UserId] INT NOT NULL,
    [Token] NVARCHAR(100) NOT NULL,
    [ExpirationTime] DATETIME NOT NULL,
    [IsUsed] BIT NOT NULL DEFAULT 0,
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[User]([UserId])
);