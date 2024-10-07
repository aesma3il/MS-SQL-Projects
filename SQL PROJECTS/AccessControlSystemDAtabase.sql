--create database AccessControlSystem;
--use AccessControlSystem

-- Users table
CREATE TABLE Users (
  UserId INT PRIMARY KEY,
  Username VARCHAR(50) NOT NULL
);

-- Groups table
CREATE TABLE Groups (
  GroupId INT PRIMARY KEY,
  GroupName VARCHAR(50) NOT NULL
);

-- Resources table
CREATE TABLE Resources (
  ResourceId INT PRIMARY KEY,
  ResourceName VARCHAR(50) NOT NULL
);

-- Permissions table
CREATE TABLE [Permissions] (
  PermissionId INT PRIMARY KEY,
  PermissionName VARCHAR(50) NOT NULL
);

-- UserPermissions table (many-to-many relationship between Users and Permissions)
CREATE TABLE UserPermissions (
  UserId INT,
  PermissionId INT,
  FOREIGN KEY (UserId) REFERENCES Users(UserId),
  FOREIGN KEY (PermissionId) REFERENCES [Permissions](PermissionId),
  PRIMARY KEY (UserId, PermissionId)
);

-- GroupPermissions table (many-to-many relationship between Groups and Permissions)
CREATE TABLE GroupPermissions (
  GroupId INT,
  PermissionId INT,
  FOREIGN KEY (GroupId) REFERENCES Groups(GroupId),
  FOREIGN KEY (PermissionId) REFERENCES [Permissions](PermissionId),
  PRIMARY KEY (GroupId, PermissionId)
);

-- GroupUsers table (many-to-many relationship between Groups and Users)
CREATE TABLE GroupUsers (
  GroupId INT,
  UserId INT,
  FOREIGN KEY (GroupId) REFERENCES Groups(GroupId),
  FOREIGN KEY (UserId) REFERENCES Users(UserId),
  PRIMARY KEY (GroupId, UserId)
);

-- ResourcePermissions table (many-to-many relationship between Resources and Permissions)
CREATE TABLE ResourcePermissions (
  ResourceId INT,
  PermissionId INT,
  FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId),
  FOREIGN KEY (PermissionId) REFERENCES [Permissions](PermissionId),
  PRIMARY KEY (ResourceId, PermissionId)
);


-- Insert sample data into Users table
INSERT INTO Users (UserId, Username) VALUES
  (1, 'John'),
  (2, 'Emma'),
  (3, 'Michael'),
  (4, 'Sophia');

-- Insert sample data into Groups table
INSERT INTO Groups (GroupId, GroupName) VALUES
  (1, 'Admins'),
  (2, 'Editors'),
  (3, 'Viewers');

-- Insert sample data into Resources table
INSERT INTO Resources (ResourceId, ResourceName) VALUES
  (1, 'File1'),
  (2, 'File2'),
  (3, 'File3');

-- Insert sample data into Permissions table
INSERT INTO Permissions (PermissionId, PermissionName) VALUES
  (1, 'Read'),
  (2, 'Write'),
  (3, 'Delete');

-- Insert sample data into UserPermissions table
INSERT INTO UserPermissions (UserId, PermissionId) VALUES
  (1, 1), -- John has Read permission
  (2, 2), -- Emma has Write permission
  (3, 1), -- Michael has Read permission
  (4, 3); -- Sophia has Delete permission

-- Insert sample data into GroupPermissions table
INSERT INTO GroupPermissions (GroupId, PermissionId) VALUES
  (1, 1), -- Admins have Read permission
  (2, 2), -- Editors have Write permission
  (3, 1); -- Viewers have Read permission

-- Insert sample data into GroupUsers table
INSERT INTO GroupUsers (GroupId, UserId) VALUES
  (1, 1), -- John is part of Admins group
  (2, 2), -- Emma is part of Editors group
  (2, 3), -- Michael is part of Editors group
  (3, 4); -- Sophia is part of Viewers group

-- Insert sample data into ResourcePermissions table
INSERT INTO ResourcePermissions (ResourceId, PermissionId) VALUES
  (1, 1), -- File1 has Read permission
  (2, 1), -- File2 has Read permission
  (2, 2), -- File2 has Write permission
  (3, 3); -- File3 has Delete permission

  create table Requirements(
  ID INT primary key identity,
  Content nvarchar(max) not null
  
  );



  insert into Requirements(Content) values ('Certainly! Here are 50 programs that you can implement within an Access Control System:

Add a user to the system.
Remove a user from the system.
Add a group to the system.
Remove a group from the system.
Add a resource to the system.
Remove a resource from the system.
Assign a permission to a user for a specific resource.
Remove a permission from a user for a specific resource.
Assign a permission to a group for a specific resource.
Remove a permission from a group for a specific resource.
Add a user to a group.
Remove a user from a group.
List all users in the system.
List all groups in the system.
List all resources in the system.
List all permissions assigned to a user.
List all permissions assigned to a group.
List all users belonging to a group.
List all permissions assigned to a resource.
Check if a user has a specific permission for a resource.
Check if a group has a specific permission for a resource.
Check if a user belongs to a specific group.
Check if a resource exists in the system.
Check if a user exists in the system.
Check if a group exists in the system.
Rename a user.
Rename a group.
Rename a resource.
Move a user from one group to another.
Clear all permissions assigned to a user.
Clear all permissions assigned to a group.
Clear all permissions assigned to a resource.
Delete all users from the system.
Delete all groups from the system.
Delete all resources from the system.
Export user data to a file.
Import user data from a file.
Export group data to a file.
Import group data from a file.
Export resource data to a file.
Import resource data from a file.
Generate a report of all users and their assigned permissions.
Generate a report of all groups and their assigned permissions.
Generate a report of all resources and their assigned permissions.
Backup the access control system data.
Restore the access control system data from a backup.
Lock a user account.
Unlock a user account.
Suspend a user account.
Unsuspend a user account.');


select Content From Requirements;


  --To check if a user has a specific permission for a resource, you can use a query that joins the UserPermissions, GroupUsers, and ResourcePermissions tables. Here's an example query:

  SELECT COUNT(*) AS HasPermission
FROM UserPermissions AS UP
JOIN GroupUsers AS GU ON UP.UserId = GU.UserId
JOIN ResourcePermissions AS RP ON UP.PermissionId = RP.PermissionId
WHERE UP.UserId = 1 -- Replace <UserId> with the actual user ID
  AND GU.GroupId IN (
    SELECT GroupId
    FROM GroupUsers
    WHERE UserId =1 -- Replace <UserId> with the actual user ID
  )
  AND RP.ResourceId = 1 -- Replace <ResourceId> with the actual resource ID
  AND RP.PermissionId = 1 -- Replace <PermissionId> with the actual permission ID



  SELECT P.PermissionName
FROM Permissions AS P
JOIN ResourcePermissions AS RP ON P.PermissionId = RP.PermissionId
WHERE RP.ResourceId = 2 -- Replace <ResourceId> with the actual resource ID