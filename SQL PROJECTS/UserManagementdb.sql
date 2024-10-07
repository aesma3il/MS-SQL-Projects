use  UserManagement

CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY(1,1) ,
    RoleName VARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    RoleId INT,
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);

CREATE TABLE Permission (
    PermissionId INT PRIMARY KEY IDENTITY(1,1),
    PermissionName VARCHAR(50) NOT NULL
);

CREATE TABLE RolePermissions (
    RoleId INT,
    PermissionId INT,
    PRIMARY KEY (RoleId, PermissionId),
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    FOREIGN KEY (PermissionId) REFERENCES Permission(PermissionId)
);


INSERT INTO Roles (RoleName)
VALUES ('Admin'), ('Librarian'), ('Member');


INSERT INTO Users (Username, FullName, RoleId)
VALUES ('ad1', 'Admin User', 1),
       ('lib1', 'Librarian User', 2),
       ('mem1', 'Member User', 3);


	   INSERT INTO Permission (PermissionName)
VALUES ('CreateBook'), ('UpdateBook'), ('DeleteBook'), ('BorrowBook'), ('ReturnBook');


INSERT INTO RolePermissions (RoleId, PermissionId)
VALUES (1, 1),
		(1, 2), 
		(1, 3), 
		(1, 4), 
		(1, 5),
       (2, 1), 
	   (2, 2), 
	   (2, 3), 
	   (2, 4),
       (3, 4),
	   (3, 5);

	   GO

	 DECLARE @UserId INT;
DECLARE @RequiredPermission VARCHAR(50);
DECLARE @HasPermission BIT;

SET @UserId = 2; -- Replace with the actual user ID
SET @RequiredPermission = 'ReturnBook'; -- Replace with the required permission

EXEC CheckPermission @UserId, @RequiredPermission, @HasPermission OUTPUT;

SELECT @HasPermission AS HasPermission;

	   Go




	   CREATE PROCEDURE CheckPermission
    @UserId INT,
    @RequiredPermission VARCHAR(50),
    @HasPermission BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RoleIds TABLE (RoleId INT);

    -- Retrieve the user's assigned roles from the Users table
    INSERT INTO @RoleIds (RoleId)
    SELECT RoleId
    FROM Users
    WHERE UserId = @UserId;

    SET @HasPermission = 0;

    -- Fetch the corresponding permissions from the RolePermissions table
    SELECT @HasPermission = 1
    FROM RolePermissions rp
    INNER JOIN Permission p ON rp.PermissionId = p.PermissionId
    WHERE rp.RoleId IN (SELECT RoleId FROM @RoleIds)
        AND p.PermissionName = @RequiredPermission;
END

DECLARE @RoleIds TABLE (RoleId INT);

-- Insert some sample role IDs into the table variable
INSERT INTO @RoleIds (RoleId)
VALUES (1), (2), (3);

-- Retrieve the role IDs from the table variable
SELECT RoleId
FROM @RoleIds;

DECLARE @RoleIds TABLE (RoleId INT);

  INSERT INTO @RoleIds (RoleId)
    SELECT RoleId
    FROM Users
    WHERE UserId = 2;

	select * from @RoleIds