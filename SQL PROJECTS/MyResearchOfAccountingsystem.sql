-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    ContactInformation VARCHAR(100),
    EmploymentStartDate DATE,
    EmploymentEndDate DATE,
    DepartmentID INT,
    PositionID INT,
    BankAccountID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Position(PositionID),
    FOREIGN KEY (BankAccountID) REFERENCES BankAccount(BankAccountID)
);

-- Create SalaryTable table
CREATE TABLE SalaryTable (
    SalaryTableID INT PRIMARY KEY,
    EmployeeID INT,
    EffectiveStartDate DATE,
    EffectiveEndDate DATE,
    SalaryAmount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create PayrollRun table
CREATE TABLE PayrollRun (
    PayrollRunID INT PRIMARY KEY,
    PayrollMonth VARCHAR(50),
    PayrollYear INT,
    PayDate DATE
);

-- Create PayrollItem table
CREATE TABLE PayrollItem (
    PayrollItemID INT PRIMARY KEY,
    PayrollRunID INT,
    EmployeeID INT,
    SalaryTableID INT,
    HoursWorked DECIMAL(5, 2),
    OvertimeHours DECIMAL(5, 2),
    Deductions DECIMAL(10, 2),
    AdditionalIncome DECIMAL(10, 2),
    FOREIGN KEY (PayrollRunID) REFERENCES PayrollRun(PayrollRunID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (SalaryTableID) REFERENCES SalaryTable(SalaryTableID)
);

-- Create DeductionTable table
CREATE TABLE DeductionTable (
    DeductionTableID INT PRIMARY KEY,
    DeductionName VARCHAR(50),
    Description VARCHAR(100),
    Amount DECIMAL(10, 2)
);

-- Create TaxTable table
CREATE TABLE TaxTable (
    TaxTableID INT PRIMARY KEY,
    TaxName VARCHAR(50),
    Description VARCHAR(100),
    TaxRate DECIMAL(5, 2)
);

-- Create Paycheck table
CREATE TABLE Paycheck (
    PaycheckID INT PRIMARY KEY,
    PayrollRunID INT,
    EmployeeID INT,
    NetPay DECIMAL(10, 2),
    GrossPay DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    Taxes DECIMAL(10, 2),
    FOREIGN KEY (PayrollRunID) REFERENCES PayrollRun(PayrollRunID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create TaxWithholding table
CREATE TABLE TaxWithholding (
    TaxWithholdingID INT PRIMARY KEY,
    EmployeeID INT,
    TaxTableID INT,
    WithholdingAmount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (TaxTableID) REFERENCES TaxTable(TaxTableID)
);

-- Create AttendanceTable table
CREATE TABLE AttendanceTable (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT,
    AttendanceDate DATE,
    HoursWorked DECIMAL(5, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Description VARCHAR(100)
);

-- Create Position table
CREATE TABLE Position (
    PositionID INT PRIMARY KEY,
    PositionName VARCHAR(50),
    Description VARCHAR(100)
);

-- Create BankAccount table
CREATE TABLE BankAccount (
    BankAccountID INT PRIMARY KEY,
    EmployeeID INT,
    AccountNumber VARCHAR(50),
    BankName VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create AllowanceTable table
CREATE TABLE AllowanceTable (
    AllowanceID INT PRIMARY KEY,
    EmployeeID INT,
    AllowanceName VARCHAR(50),
    Description VARCHAR(100),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create LeaveTable table
CREATE TABLE LeaveTable (
    LeaveID INT PRIMARY KEY,
    EmployeeID INT,
    LeaveType VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Reason VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create TimeSheet table
CREATE TABLE TimeSheet (
    TimeSheetID INT PRIMARY KEY,
    EmployeeID INT,
    StartDate DATE,
    EndDate DATE,
    HoursWorked DECIMAL(5, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create HolidayCalendar table
CREATE TABLE HolidayCalendar (
    HolidayID INT PRIMARY KEY,
    HolidayName VARCHAR(50),
    HolidayDate DATE
);

-- Create ExpenseTable table
CREATETABLE ExpenseTable (
    ExpenseID INT PRIMARY KEY,
    EmployeeID INT,
    ExpenseCategoryID INT,
    ExpenseDate DATE,
    Amount DECIMAL(10, 2),
    Description VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ExpenseCategoryID) REFERENCES ExpenseCategory(ExpenseCategoryID)
);

-- Create BenefitTable table
CREATE TABLE BenefitTable (
    BenefitID INT PRIMARY KEY,
    EmployeeID INT,
    BenefitName VARCHAR(50),
    Description VARCHAR(100),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create PayrollConfiguration table
CREATE TABLE PayrollConfiguration (
    ConfigurationID INT PRIMARY KEY,
    ConfigName VARCHAR(50),
    ConfigValue VARCHAR(100)
);

-- Create BonusTable table
CREATE TABLE BonusTable (
    BonusID INT PRIMARY KEY,
    EmployeeID INT,
    BonusName VARCHAR(50),
    Description VARCHAR(100),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create TaxExemptionTable table
CREATE TABLE TaxExemptionTable (
    ExemptionID INT PRIMARY KEY,
    EmployeeID INT,
    ExemptionName VARCHAR(50),
    Description VARCHAR(100),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create PayrollHistory table
CREATE TABLE PayrollHistory (
    HistoryID INT PRIMARY KEY,
    PayrollRunID INT,
    EmployeeID INT,
    PayDate DATE,
    NetPay DECIMAL(10, 2),
    GrossPay DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    Taxes DECIMAL(10, 2),
    FOREIGN KEY (PayrollRunID) REFERENCES PayrollRun(PayrollRunID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create EmployeeLeaveBalance table
CREATE TABLE EmployeeLeaveBalance (
    BalanceID INT PRIMARY KEY,
    EmployeeID INT,
    LeaveType VARCHAR(50),
    LeaveBalance DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create PayrollReport table
CREATE TABLE PayrollReport (
    ReportID INT PRIMARY KEY,
    ReportName VARCHAR(50),
    ReportDate DATE,
    ReportContent TEXT
);

-- Create PTOAccrualTable table
CREATE TABLE PTOAccrualTable (
    AccrualID INT PRIMARY KEY,
    EmployeeID INT,
    AccrualStartDate DATE,
    AccrualEndDate DATE,
    AccrualRate DECIMAL(5, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create ExpenseCategory table
CREATE TABLE ExpenseCategory (
    ExpenseCategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    Description VARCHAR(100)
);

-- Create PayrollTaxTable table
CREATE TABLE PayrollTaxTable (
    TaxTableID INT PRIMARY KEY,
    TaxName VARCHAR(50),
    Description VARCHAR(100),
    TaxRate DECIMAL(5, 2)
);

-- Create SalaryGrade table
CREATE TABLE SalaryGrade (
    GradeID INT PRIMARY KEY,
    GradeName VARCHAR(50),
    MinSalary DECIMAL(10, 2),
    MaxSalary DECIMAL(10, 2)
);

-- Create PayrollVendor table
CREATE TABLE PayrollVendor (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(50),
    VendorContact VARCHAR(100),
    VendorAddress VARCHAR(100)
);

-- Create EmployeeBeneficiary table
CREATE TABLE EmployeeBeneficiary (
    BeneficiaryID INT PRIMARY KEY,
    EmployeeID INT,
    BeneficiaryName VARCHAR(50),
    Relationship VARCHAR(50),
    ContactInformation VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create PayrollApproval table
CREATE TABLE PayrollApproval (
    ApprovalID INT PRIMARY KEY,
    PayrollRunID INT,
    ApproverID INT,
    ApprovalDate DATE,
    FOREIGN KEY (PayrollRunID) REFERENCES PayrollRun(PayrollRunID),
    FOREIGN KEY (ApproverID) REFERENCES Employee(EmployeeID)
);

-- Create PayrollJournalEntry table
CREATE TABLE PayrollJournalEntry (
    EntryID INT PRIMARY KEY,
    PayrollRunID INT,
    JournalDate DATE,
    DebitAccount VARCHAR(50),
    CreditAccount VARCHAR(50),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (PayrollRunID) REFERENCES PayrollRun(PayrollRunID)
);

-- Create EmployeeTraining table
CREATE TABLE EmployeeTraining (
    TrainingID INT PRIMARY KEY,
    EmployeeID INT,
    TrainingName VARCHAR(50),
    TrainingDate DATE,
    Description VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create PayrollCompliance table
CREATE TABLE PayrollCompliance (
    ComplianceID INT PRIMARY KEY,
    PayrollRunID INT,
    EmployeeID INT,
    ComplianceType VARCHAR(50),
    ComplianceDate DATE,
    FOREIGN KEY (PayrollRunID) REFERENCES PayrollRun(PayrollRunID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create ExpenseReceipt table
CREATE TABLE ExpenseReceipt (
    ReceiptID INT PRIMARY KEY,
    ExpenseID INT,
    ReceiptNumber VARCHAR(50),
    ReceiptDate DATE,
    ReceiptAmount DECIMAL(10, 2),
    FOREIGN KEY (ExpenseID) REFERENCES ExpenseTable(ExpenseID)
);

-- Create ExpenseApproval table
CREATE TABLE ExpenseApproval (
    ApprovalID INT PRIMARY KEY,
    ExpenseID INT,
    ApproverID INT,
    ApprovalDate DATE,
    FOREIGN KEY (ExpenseID) REFERENCES ExpenseTable(ExpenseID),
    FOREIGN KEY (ApproverID) REFERENCES Employee(EmployeeID)
);


-- Create ExpenseCategory table
CREATE TABLE ExpenseCategory (
    ExpenseCategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    Description VARCHAR(100)
);

-- Create ExpenseVendor table
CREATE TABLE ExpenseVendor (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(50),
    ContactInformation VARCHAR(100),
    Address VARCHAR(100)
);

-- Create ExpenseTransaction table
CREATE TABLE ExpenseTransaction (
    TransactionID INT PRIMARY KEY,
    ExpenseID INT,
    VendorID INT,
    TransactionDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (ExpenseID) REFERENCES ExpenseTable(ExpenseID),
    FOREIGN KEY (VendorID) REFERENCES ExpenseVendor(VendorID)
);

-- Create DepartmentManager table
CREATE TABLE DepartmentManager (
    DepartmentManagerID INT PRIMARY KEY,
    EmployeeID INT,
    DepartmentID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Create EmployeeReview table
CREATE TABLE EmployeeReview (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewDate DATE,
    ReviewerID INT,
    Rating INT,
    Comments VARCHAR(200),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ReviewerID) REFERENCES Employee(EmployeeID)
);

-- Create EmployeePromotion table
CREATE TABLE EmployeePromotion (
    PromotionID INT PRIMARY KEY,
    EmployeeID INT,
    PromotionDate DATE,
    PreviousPositionID INT,
    NewPositionID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (PreviousPositionID) REFERENCES Position(PositionID),
    FOREIGN KEY (NewPositionID) REFERENCES Position(PositionID)
);

-- Create EmployeeTermination table
CREATE TABLE EmployeeTermination (
    TerminationID INT PRIMARY KEY,
    EmployeeID INT,
    TerminationDate DATE,
    TerminationReason VARCHAR(200),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create EmployeeTransfer table
CREATE TABLE EmployeeTransfer (
    TransferID INT PRIMARY KEY,
    EmployeeID INT,
    TransferDate DATE,
    PreviousDepartmentID INT,
    NewDepartmentID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (PreviousDepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (NewDepartmentID) REFERENCES Department(DepartmentID)
);

-- Create EmployeeSuspension table
CREATE TABLE EmployeeSuspension (
    SuspensionID INT PRIMARY KEY,
    EmployeeID INT,
    SuspensionStartDate DATE,
    SuspensionEndDate DATE,
    SuspensionReason VARCHAR(200),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create EmployeeWarning table
CREATE TABLE EmployeeWarning (
    WarningID INT PRIMARY KEY,
    EmployeeID INT,
    WarningDate DATE,
    WarningReason VARCHAR(200),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create EmployeeTerminationReason table
CREATE TABLE EmployeeTerminationReason (
    ReasonID INT PRIMARY KEY,
    TerminationReason VARCHAR(200)
);





-- Create Project table
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(10, 2),
    DepartmentID INT,
    ProjectManagerID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (ProjectManagerID) REFERENCES Employee(EmployeeID)
);

-- Create Task table
CREATE TABLE Task (
    TaskID INT PRIMARY KEY,
    TaskName VARCHAR(100),
    Description VARCHAR(200),
    StartDate DATE,
    EndDate DATE,
    ProjectID INT,
    AssigneeID INT,
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY (AssigneeID) REFERENCES Employee(EmployeeID)
);

-- Create TaskDependency table
CREATE TABLE TaskDependency (
    DependencyID INT PRIMARY KEY,
    TaskID INT,
    DependentTaskID INT,
    FOREIGN KEY (TaskID) REFERENCES Task(TaskID),
    FOREIGN KEY (DependentTaskID) REFERENCES Task(TaskID)
);

-- Create TaskProgress table
CREATE TABLE TaskProgress (
    ProgressID INT PRIMARY KEY,
    TaskID INT,
    ProgressDate DATE,
    ProgressStatus VARCHAR(50),
    FOREIGN KEY (TaskID) REFERENCES Task(TaskID)
);

-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

-- Create SalesOrder table
CREATE TABLE SalesOrder (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    SalespersonID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SalespersonID) REFERENCES Employee(EmployeeID)
);

-- Create OrderItem table
CREATE TABLE OrderItem (
    ItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES SalesOrder(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Supplier table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

-- Create PurchaseOrder table
CREATE TABLE PurchaseOrder (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    SupplierID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Create PurchaseOrderItem table
CREATE TABLE PurchaseOrderItem (
    ItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES PurchaseOrder(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description VARCHAR(200),
    UnitPrice DECIMAL(10, 2)
);

-- Create Warehouse table
CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(100),
    Location VARCHAR(200)
);

-- Create Stock table
CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

-- Create SupplierInvoice table
CREATE TABLE SupplierInvoice (
    InvoiceID INT PRIMARY KEY,
    SupplierID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Create InvoiceItem table
CREATE TABLE InvoiceItem (
    ItemID INT PRIMARY KEY,
    InvoiceID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (InvoiceID) REFERENCES SupplierInvoice(InvoiceID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create CustomerInvoice table
CREATE TABLE CustomerInvoice (
    InvoiceID INT PRIMARY KEY,
    CustomerID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create OrderItem table
CREATE TABLE InvoiceItem (
    ItemID INT PRIMARY KEY,
    InvoiceID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (InvoiceID) REFERENCES CustomerInvoice(InvoiceID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (InvoiceID) REFERENCES CustomerInvoice(InvoiceID)
);

-- Create Review table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Rating INT,
    Comment VARCHAR(500),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create Message table
CREATE TABLE Message (
    MessageID INT PRIMARY KEY,
    SenderID INT,
    ReceiverID INT,
    MessageText VARCHAR(500),
    SendDateTime DATETIME,
    FOREIGN KEY (SenderID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ReceiverID) REFERENCES Employee(EmployeeID)
);