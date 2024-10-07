create database AccessControlList;
go
use AccessControlList;
go


-- Create Users table
CREATE TABLE Users (
    UserId INT PRIMARY KEY identity,
    Username NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    PhoneNumber NVARCHAR(255),
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    CONSTRAINT UC_Users_Username UNIQUE (Username),
    CONSTRAINT UC_Users_Email UNIQUE (Email)
);

-- Create Roles table
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY identity,
    RoleName NVARCHAR(255) NOT NULL,
    CONSTRAINT UC_Roles_RoleName UNIQUE (RoleName)
);

-- Create Permissions table
CREATE TABLE Permissions (
    PermissionId INT PRIMARY KEY identity,
    PermissionName NVARCHAR(255) NOT NULL,
    CONSTRAINT UC_Permissions_PermissionName UNIQUE (PermissionName)
);

-- Create UserRoles table
CREATE TABLE UserRoles (
    UserId INT,
    RoleId INT,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    PRIMARY KEY (UserId, RoleId)
);

-- Create RolePermissions table
CREATE TABLE RolePermissions (
    RoleId INT,
    PermissionId INT,
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    FOREIGN KEY (PermissionId) REFERENCES Permissions(PermissionId),
    PRIMARY KEY (RoleId, PermissionId)
);

-- Create Resources table
CREATE TABLE Resources (
    ResourceId INT PRIMARY KEY identity,
    ResourceName NVARCHAR(255) NOT NULL,
    CONSTRAINT UC_Resources_ResourceName UNIQUE (ResourceName)
);

-- Create AccessControlList table
CREATE TABLE AccessControlList (
    AclId INT PRIMARY KEY identity,
    ResourceId INT,
    RoleId INT,
    PermissionId INT,
    FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId),
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    FOREIGN KEY (PermissionId) REFERENCES Permissions(PermissionId)
);


go
-- CreateNewUser - Insert a new user into the Users table
CREATE PROCEDURE UserRepository_CreateUser
    @Username NVARCHAR(255),
    @Password NVARCHAR(255),
    @Email NVARCHAR(255),
    @FirstName NVARCHAR(255),
    @LastName NVARCHAR(255),
    @PhoneNumber NVARCHAR(255)
AS
BEGIN
    INSERT INTO Users (Username, Password, Email, FirstName, LastName, PhoneNumber, CreatedAt, UpdatedAt)
    VALUES (@Username, @Password, @Email, @FirstName, @LastName, @PhoneNumber, GETDATE(), GETDATE())
END
go
-- GetUserById - Retrieve a user by the user ID
CREATE PROCEDURE UserRepository_GetUserById
    @UserId INT,
    @Username NVARCHAR(255) OUTPUT,
    @Password NVARCHAR(255) OUTPUT,
    @Email NVARCHAR(255) OUTPUT,
    @FirstName NVARCHAR(255) OUTPUT,
    @LastName NVARCHAR(255) OUTPUT,
    @PhoneNumber NVARCHAR(255) OUTPUT,
    @CreatedAt DATETIME OUTPUT,
    @UpdatedAt DATETIME OUTPUT
AS
BEGIN
    SELECT @Username = Username,
           @Password = Password,
           @Email = Email,
           @FirstName = FirstName,
           @LastName = LastName,
           @PhoneNumber = PhoneNumber,
           @CreatedAt = CreatedAt,
           @UpdatedAt = UpdatedAt
    FROM Users
    WHERE UserId = @UserId
END

-- UpdateUser - Update an existing user in the Users table
CREATE PROCEDURE UserRepository_UpdateUser
    @UserId INT,
    @Username NVARCHAR(255),
    @Password NVARCHAR(255),
    @Email NVARCHAR(255),
    @FirstName NVARCHAR(255),
    @LastName NVARCHAR(255),
    @PhoneNumber NVARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET Username = @Username,
        Password = @Password,
        Email = @Email,
        FirstName = @FirstName,
        LastName = @LastName,
        PhoneNumber = @PhoneNumber,
        UpdatedAt = GETDATE()
    WHERE UserId = @UserId
END

-- DeleteUser - Delete a user from the Users table
CREATE PROCEDURE UserRepository_DeleteUser
    @UserId INT
AS
BEGIN
    DELETE FROM Users
    WHERE UserId = @UserId
END








--Stored Procedure: CreateNewUser

--Input: Username, Password, Email, FirstName, LastName, PhoneNumber
--Description: Inserts a new user into the Users table.
--Usage: EXEC CreateNewUser @Username, @Password, @Email, @FirstName, @LastName, @PhoneNumber
--Stored Procedure: AssignUserRole

--Input: UserId, RoleId
--Description: Assigns a role to a user by inserting a new entry into the UserRoles table.
--Usage: EXEC AssignUserRole @UserId, @RoleId
--Stored Procedure: RevokeUserRole

--Input: UserId, RoleId
--Description: Revokes a role from a user by deleting the corresponding entry from the UserRoles table.
--Usage: EXEC RevokeUserRole @UserId, @RoleId
--Function: GetUserRoles

--Input: UserId
--Output: Table (RoleName)
--Description: Retrieves the roles assigned to a user.
--Usage: SELECT * FROM GetUserRoles(@UserId)
--Function: GetRolePermissions

--Input: RoleId
--Output: Table (PermissionName)
--Description: Retrieves the permissions associated with a role.
--Usage: SELECT * FROM GetRolePermissions(@RoleId)
--Stored Procedure: GrantPermission

--Input: RoleId, PermissionId, ResourceId
--Description: Grants a permission to a role for a specific resource by inserting a new entry into the AccessControlList table.
--Usage: EXEC GrantPermission @RoleId, @PermissionId, @ResourceId
--Stored Procedure: RevokePermission

--Input: RoleId, PermissionId, ResourceId
--Description: Revokes a permission from a role for a specific resource by deleting the corresponding entry from the AccessControlList table.
--Usage: EXEC RevokePermission @RoleId, @PermissionId, @ResourceId