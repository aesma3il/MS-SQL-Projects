CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE BudgetCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

CREATE TABLE SubCategory (
    SubCategoryID INT PRIMARY KEY,
    CategoryID INT,
    SubCategoryName VARCHAR(100),
    FOREIGN KEY (CategoryID) REFERENCES BudgetCategory(CategoryID)
);

CREATE TABLE BudgetLineItem (
    LineItemID INT PRIMARY KEY,
    ProjectID INT,
    SubCategoryID INT,
    Item VARCHAR(100),
    UnitType1 VARCHAR(100),
    Type1 VARCHAR(100),
    UnitType2 VARCHAR(100),
    Type2 VARCHAR(100),
    Cost DECIMAL(10, 2),
    LOE DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    IMSContribution DECIMAL(10, 2),
    NEDContribution DECIMAL(10, 2),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY (SubCategoryID) REFERENCES SubCategory(SubCategoryID)
);