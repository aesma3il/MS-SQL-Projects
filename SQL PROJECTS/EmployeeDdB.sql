CREATE TABLE [dbo].[Country] (
    [CountryID] [int] IDENTITY(1,1) NOT NULL,
    [CountryName] [varchar](50) NOT NULL,

    CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([CountryID] ASC)
)

CREATE TABLE [dbo].[City] (
    [CityID] [int] IDENTITY(1,1) NOT NULL,
    [CityName] [varchar](50) NOT NULL,
    [CountryID] [int] NOT NULL,

    CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED ([CityID] ASC),
    CONSTRAINT [FK_City_Country] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[Country] ([CountryID])
)

CREATE TABLE [dbo].[Department] (
    [DepartmentID] [int] IDENTITY(1,1) NOT NULL,
    [DepartmentName] [varchar](50) NOT NULL,

    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
)

CREATE TABLE [dbo].[JobTitle] (
    [JobTitleID] [int] IDENTITY(1,1) NOT NULL,
    [JobTitleName] [varchar](50) NOT NULL,

    CONSTRAINT [PK_JobTitle] PRIMARY KEY CLUSTERED ([JobTitleID] ASC)
)

CREATE TABLE [dbo].[Gender] (
    [GenderID] [int] IDENTITY(1,1) NOT NULL,
    [GenderName] [varchar](10) NOT NULL,

    CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED ([GenderID] ASC)
)

CREATE TABLE [dbo].[Employee] (
    [EmployeeID] [int] IDENTITY(1,1) NOT NULL,
    [FirstName] [varchar](50) NOT NULL,
    [LastName] [varchar](50) NOT NULL,
    [GenderID] [int] NOT NULL,
    [CityID] [int] NOT NULL,
    [DepartmentID] [int] NOT NULL,
    [JobTitleID] [int] NOT NULL,
    [HireDate] [date] NOT NULL,

    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [FK_Employee_Gender] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[Gender] ([GenderID]),
    CONSTRAINT [FK_Employee_City] FOREIGN KEY ([CityID]) REFERENCES [dbo].[City] ([CityID]),
    CONSTRAINT [FK_Employee_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID]),
    CONSTRAINT [FK_Employee_JobTitle] FOREIGN KEY ([JobTitleID]) REFERENCES [dbo].[JobTitle] ([JobTitleID])
)

CREATE TABLE [dbo].[DepartmentHistory] (
    [DepartmentHistoryID] [int] IDENTITY(1,1) NOT NULL,
    [EmployeeID] [int] NOT NULL,
    [DepartmentID] [int] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,

    CONSTRAINT [PK_DepartmentHistory] PRIMARY KEY CLUSTERED ([DepartmentHistoryID] ASC),
    CONSTRAINT [FK_DepartmentHistory_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]),
    CONSTRAINT [FK_DepartmentHistory_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID])
)


CREATE TABLE [dbo].[EmployeeTerms] (
    [EmployeeTermsID] [int] IDENTITY(1,1) NOT NULL,
    [EmployeeID] [int] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    [Salary] [decimal](18, 2) NOT NULL,
    [EmploymentType] [varchar](50) NOT NULL,
    [ContractType] [varchar](50) NOT NULL,

    CONSTRAINT [PK_EmployeeTerms] PRIMARY KEY CLUSTERED ([EmployeeTermsID] ASC),
    CONSTRAINT [FK_EmployeeTerms_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
)