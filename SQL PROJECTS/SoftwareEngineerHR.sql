
CREATE TABLE hr_department (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    manager_id INT,
    parent_id INT,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES hr_employee(id),
    CONSTRAINT fk_parent FOREIGN KEY (parent_id) REFERENCES hr_department(id)
);

CREATE TABLE hr_job (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    job_title VARCHAR(100)
);

CREATE TABLE hr_contract_type (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100)
);

CREATE TABLE hr_contract (
    id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT,
    start_date DATE,
    end_date DATE,
    salary DECIMAL(10, 2),
    working_hours FLOAT,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES hr_employee(id)
);

CREATE TABLE WorkSchedule (
    ID INT PRIMARY KEY,
    AverageHoursPerDay DECIMAL(5, 2),
    Timezone VARCHAR(100)
);

CREATE TABLE WorkPeriod (
    ID INT PRIMARY KEY,
    WorkScheduleID INT,
    Name VARCHAR(100),
    DayOfWeek VARCHAR(50),
    DayPeriod VARCHAR(50),
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (WorkScheduleID) REFERENCES WorkSchedule(ID)
);


CREATE TABLE TimeOffType (
    ID INT PRIMARY KEY,
    TypeName VARCHAR(100)
);

CREATE TABLE EmployeeTimeOff (
    ID INT PRIMARY KEY,
    EmployeeID INT,
    TimeOffTypeID INT,
    Description VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Requested FLOAT,
    Status VARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(ID),
    FOREIGN KEY (TimeOffTypeID) REFERENCES TimeOffType(ID)
);


CREATE TABLE LeaveRequest (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    DateFrom DATE,
    DateTo DATE,
    NumberOfDays FLOAT,
    NumberOfHours FLOAT
);

CREATE TABLE hr_leave (
    id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT,
    leave_type VARCHAR(100),
    start_date DATE,
    end_date DATE,
    leave_duration FLOAT,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES hr_employee(id)
);

CREATE TABLE hr_holidays (
    id INT PRIMARY KEY IDENTITY(1,1),
    holiday_type VARCHAR(100),
    start_date DATE,
    end_date DATE
);

CREATE TABLE hr_attendance (
    id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT,
    check_in_time DATETIME,
    check_out_time DATETIME,
    attendance_status VARCHAR(100),
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES hr_employee(id)
);

CREATE TABLE hr_payslip (
    id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT,
    payment_date DATE,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES hr_employee(id)
);

CREATE TABLE payslip_component (
    id INT PRIMARY KEY IDENTITY(1,1),
    payslip_id INT,
    component_name VARCHAR(100),
    amount DECIMAL(10, 2),
    CONSTRAINT fk_payslip_component FOREIGN KEY (payslip_id) REFERENCES hr_payslip(id)
);

CREATE TABLE payslip_deduction (
    id INT PRIMARY KEY IDENTITY(1,1),
    payslip_id INT,
    deduction_name VARCHAR(100),
    amount DECIMAL(10, 2),
    CONSTRAINT fk_payslip_deduction FOREIGN KEY (payslip_id) REFERENCES hr_payslip(id)
);

CREATE TABLE payslip_allowance (
    id INT PRIMARY KEY IDENTITY(1,1),
    payslip_id INT,
    allowance_name VARCHAR(100),
    amount DECIMAL(10, 2),
    CONSTRAINT fk_payslip_allowance FOREIGN KEY (payslip_id) REFERENCES hr_payslip(id)
);






CREATE TABLE ExpenseCategories (
   CategoryID INT IDENTITY(1,1) PRIMARY KEY,
   CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Expenses (
   ExpenseID INT IDENTITY(1,1) PRIMARY KEY,
   ExpenseDate DATE NOT NULL,
   TotalAmount DECIMAL(10,2) NOT NULL,
   CategoryID INT NOT NULL,
   Description VARCHAR(255),
   CONSTRAINT FK_Expenses_ExpenseCategories
      FOREIGN KEY (CategoryID)
      REFERENCES ExpenseCategories(CategoryID)
);

CREATE TABLE ExpenseDetails (
   DetailID INT IDENTITY(1,1) PRIMARY KEY,
   ExpenseID INT NOT NULL,
   ItemDescription VARCHAR(255) NOT NULL,
   ItemAmount DECIMAL(10,2) NOT NULL,
   CONSTRAINT FK_ExpenseDetails_Expenses
      FOREIGN KEY (ExpenseID)
      REFERENCES Expenses(ExpenseID)
);


-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100)
);

-- Create Shifts table
CREATE TABLE Shifts (
    ShiftID INT PRIMARY KEY,
    StartTime TIME,
    EndTime TIME,
    BreakDuration INT -- in minutes
);

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100)
);

-- Create TimeEntries table
CREATE TABLE TimeEntries (
    TimeEntryID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    TimeIn TIME,
    TimeOut TIME,
    Duration DECIMAL(5,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create Attendance table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    ShiftID INT,
    AttendanceStatus VARCHAR(20),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ShiftID) REFERENCES Shifts(ShiftID)
);

-- Create ClockEvents table
CREATE TABLE ClockEvents (
    ClockEventID INT PRIMARY KEY,
    EmployeeID INT,
    EventDate DATE,
    EventTime TIME,
    EventType VARCHAR(20), -- Clock-In or Clock-Out
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create Timesheets table
CREATE TABLE Timesheets (
    TimesheetID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    Date DATE,
    Hours DECIMAL(5,2),
    Description VARCHAR(200),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

--approached to model the payroll system

-- Employee-Based Model
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    -- Add other employee-related fields
);

CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT,
    PayPeriod DATE,
    Salary DECIMAL(10,2),
    Overtime DECIMAL(10,2),
    Bonuses DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    NetPay DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Time-Based Model
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    -- Add other employee-related fields
);

CREATE TABLE TimeEntries (
    TimeEntryID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    HoursWorked DECIMAL(5,2),
    PayRate DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Salary-Based Model
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    -- Add other employee-related fields
);

CREATE TABLE Salary (
    SalaryID INT PRIMARY KEY,
    EmployeeID INT,
    EffectiveDate DATE,
    SalaryAmount DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Deduction-Based Model
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    -- Add other employee-related fields
);

CREATE TABLE Deductions (
    DeductionID INT PRIMARY KEY,
    EmployeeID INT,
    DeductionType VARCHAR(100),
    Amount DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Tax-Based Model
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    -- Add other employee-related fields
);

CREATE TABLE Tax (
    TaxID INT PRIMARY KEY,
    EmployeeID INT,
    TaxYear INT,
    TaxRate DECIMAL(5,2),
    TaxableIncome DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);



-- Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    -- Add other employee-related fields
);

-- Payroll table
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT,
    PayPeriod DATE,
    Salary DECIMAL(10,2),
    Overtime DECIMAL(10,2),
    Bonuses DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    NetPay DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- TimeEntries table
CREATE TABLE TimeEntries (
    TimeEntryID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    HoursWorked DECIMAL(5,2),
    PayRate DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Salary table
CREATE TABLE Salary (
    SalaryID INT PRIMARY KEY,
    EmployeeID INT,
    EffectiveDate DATE,
    SalaryAmount DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Deductions table
CREATE TABLE Deductions (
    DeductionID INT PRIMARY KEY,
    EmployeeID INT,
    DeductionType VARCHAR(100),
    Amount DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Tax table
CREATE TABLE Tax (
    TaxID INT PRIMARY KEY,
    EmployeeID INT,
    TaxYear INT,
    TaxRate DECIMAL(5,2),
    TaxableIncome DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Benefits table
CREATE TABLE Benefits (
    BenefitID INT PRIMARY KEY,
    EmployeeID INT,
    BenefitType VARCHAR(100),
    BenefitAmount DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Allowances table
CREATE TABLE Allowances (
    AllowanceID INT PRIMARY KEY,
    EmployeeID INT,
    AllowanceType VARCHAR(100),
    AllowanceAmount DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- EmployeeLeave table
CREATE TABLE EmployeeLeave (
    LeaveID INT PRIMARY KEY,
    EmployeeID INT,
    LeaveType VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- EmployeeExpenses table
CREATE TABLE EmployeeExpenses (
    ExpenseID INT PRIMARY KEY,
    EmployeeID INT,
    ExpenseDate DATE,
    ExpenseAmount DECIMAL(10,2),
    ExpenseDescription VARCHAR(200),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Other tables and relationships can be added based on specific requirements