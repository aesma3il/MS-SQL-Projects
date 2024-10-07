-- Create database
CREATE DATABASE HRDatabase;
GO

-- Use the HRDatabase
USE HRDatabase;
GO

-- Create tables

-- Employees table to store employee information
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Gender NVARCHAR(10),
    ContactNumber NVARCHAR(20),
    Email NVARCHAR(100),
    Address NVARCHAR(100),
    DepartmentID INT,
    JobTitle NVARCHAR(100),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID)
);
GO

-- Departments table to store department information
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100),
    ManagerID INT,
    Location NVARCHAR(100),
    CONSTRAINT FK_Departments_Employees FOREIGN KEY (ManagerID) REFERENCES Employees (EmployeeID)
);
GO

-- JobTitles table to store job title information
CREATE TABLE JobTitles (
    JobTitleID INT PRIMARY KEY,
    JobTitle NVARCHAR(100),
    Description NVARCHAR(200)
);
GO

-- Salaries table to store historical salary information
CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY,
    EmployeeID INT,
    Salary DECIMAL(10, 2),
    EffectiveDate DATE,
    CONSTRAINT FK_Salaries_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- TimeOffRequests table to store employee time off requests
CREATE TABLE TimeOffRequests (
    RequestID INT PRIMARY KEY,
    EmployeeID INT,
    StartDate DATE,
    EndDate DATE,
    RequestStatus NVARCHAR(20),
    CONSTRAINT FK_TimeOffRequests_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- PerformanceReviews table to store employee performance review records
CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewDate DATE,
    Reviewer NVARCHAR(100),
    Comments NVARCHAR(MAX),
    CONSTRAINT FK_PerformanceReviews_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- Skills table to store employee skills information
CREATE TABLE Skills (
    SkillID INT PRIMARY KEY,
    SkillName NVARCHAR(100),
    Description NVARCHAR(200)
);
GO

-- EmployeeSkills table to store employee and skill relationships
CREATE TABLE EmployeeSkills (
    EmployeeID INT,
    SkillID INT,
    CONSTRAINT PK_EmployeeSkills PRIMARY KEY (EmployeeID, SkillID),
    CONSTRAINT FK_EmployeeSkills_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeSkills_Skills FOREIGN KEY (SkillID) REFERENCES Skills (SkillID)
);
GO

-- TrainingPrograms table to store training program information
CREATE TABLE TrainingPrograms (
    ProgramID INT PRIMARY KEY,
    ProgramName NVARCHAR(100),
    Description NVARCHAR(MAX),
    StartDate DATE,
    EndDate DATE
);
GO

-- EmployeeTraining table to store employee and training program relationships
CREATE TABLE EmployeeTraining (
    EmployeeID INT,
    ProgramID INT,
    CompletionDate DATE,
    CONSTRAINT PK_EmployeeTraining PRIMARY KEY (EmployeeID, ProgramID),
    CONSTRAINT FK_EmployeeTraining_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeTraining_TrainingPrograms FOREIGN KEY (ProgramID) REFERENCES TrainingPrograms (ProgramID)
);
GO
-- Use the HRDatabase
USE HRDatabase;
GO

-- Create additional tables

-- JobPostings table to store job posting information
CREATE TABLE JobPostings (
    JobPostingID INT PRIMARY KEY,
    JobTitle NVARCHAR(100),
    DepartmentID INT,
    Description NVARCHAR(MAX),
    PostingDate DATE,
    CONSTRAINT FK_JobPostings_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID)
);
GO

-- JobApplications table to store job applications submitted by candidates
CREATE TABLE JobApplications (
    ApplicationID INT PRIMARY KEY,
    JobPostingID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    ContactNumber NVARCHAR(20),
    Resume NVARCHAR(MAX),
    ApplicationDate DATE,
    CONSTRAINT FK_JobApplications_JobPostings FOREIGN KEY (JobPostingID) REFERENCES JobPostings (JobPostingID)
);
GO

-- Benefits table to store employee benefits information
CREATE TABLE Benefits (
    BenefitID INT PRIMARY KEY,
    BenefitName NVARCHAR(100),
    Description NVARCHAR(MAX),
    Cost DECIMAL(10, 2)
);
GO

-- EmployeeBenefits table to establish relationships between employees and benefits
CREATE TABLE EmployeeBenefits (
    EmployeeID INT,
    BenefitID INT,
    EnrollmentDate DATE,
    CONSTRAINT PK_EmployeeBenefits PRIMARY KEY (EmployeeID, BenefitID),
    CONSTRAINT FK_EmployeeBenefits_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeBenefits_Benefits FOREIGN KEY (BenefitID) REFERENCES Benefits (BenefitID)
);
GO

-- EmployeeDocuments table to store employee-related documents
CREATE TABLE EmployeeDocuments (
    DocumentID INT PRIMARY KEY,
    EmployeeID INT,
    DocumentName NVARCHAR(100),
    DocumentType NVARCHAR(50),
    DocumentPath NVARCHAR(MAX),
    UploadDate DATE,
    CONSTRAINT FK_EmployeeDocuments_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeReviews table to store employee self-reviews and manager reviews
CREATE TABLE EmployeeReviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewDate DATE,
    ReviewType NVARCHAR(20),
    Reviewer NVARCHAR(100),
    Comments NVARCHAR(MAX),
    CONSTRAINT FK_EmployeeReviews_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeePromotions table to store employee promotion information
CREATE TABLE EmployeePromotions (
    PromotionID INT PRIMARY KEY,
    EmployeeID INT,
    PromotionDate DATE,
    PreviousJobTitle NVARCHAR(100),
    NewJobTitle NVARCHAR(100),
    CONSTRAINT FK_EmployeePromotions_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeTerminations table to store employee termination information
CREATE TABLE EmployeeTerminations (
    TerminationID INT PRIMARY KEY,
    EmployeeID INT,
    TerminationDate DATE,
    TerminationReason NVARCHAR(MAX),
    CONSTRAINT FK_EmployeeTerminations_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeTransfers table to store employee transfer information
CREATE TABLE EmployeeTransfers (
    TransferID INT PRIMARY KEY,
    EmployeeID INT,
    TransferDate DATE,
    PreviousDepartmentID INT,
    NewDepartmentID INT,
    CONSTRAINT FK_EmployeeTransfers_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeTransfers_Departments_Previous FOREIGN KEY (PreviousDepartmentID) REFERENCES Departments (DepartmentID),
    CONSTRAINT FK_EmployeeTransfers_Departments_New FOREIGN KEY (NewDepartmentID) REFERENCES Departments (DepartmentID)
);
GO
-- Use the HRDatabase
USE HRDatabase;
GO

-- Create additional tables

-- PerformanceCriteria table to store performance evaluation criteria
CREATE TABLE PerformanceCriteria (
    CriteriaID INT PRIMARY KEY,
    CriteriaName NVARCHAR(100),
    Description NVARCHAR(MAX)
);
GO

-- PerformanceScores table to store performance scores for each criteria
CREATE TABLE PerformanceScores (
    ScoreID INT PRIMARY KEY,
    CriteriaID INT,
    ScoreValue DECIMAL(5, 2),
    CONSTRAINT FK_PerformanceScores_PerformanceCriteria FOREIGN KEY (CriteriaID) REFERENCES PerformanceCriteria (CriteriaID)
);
GO

-- EmployeePerformance table to store employee performance evaluation data
CREATE TABLE EmployeePerformance (
    PerformanceID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewDate DATE,
    Reviewer NVARCHAR(100),
    CONSTRAINT FK_EmployeePerformance_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeEducation table to store employee educational background
CREATE TABLE EmployeeEducation (
    EducationID INT PRIMARY KEY,
    EmployeeID INT,
    DegreeTitle NVARCHAR(100),
    Institution NVARCHAR(100),
    CompletionYear INT,
    CONSTRAINT FK_EmployeeEducation_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeAttendance table to track employee attendance
CREATE TABLE EmployeeAttendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT,
    AttendanceDate DATE,
    ClockInTime TIME,
    ClockOutTime TIME,
    CONSTRAINT FK_EmployeeAttendance_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeRewards table to store employee rewards and recognition
CREATE TABLE EmployeeRewards (
    RewardID INT PRIMARY KEY,
    EmployeeID INT,
    RewardName NVARCHAR(100),
    RewardDate DATE,
    CONSTRAINT FK_EmployeeRewards_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeWarnings table to store employee warnings or disciplinary actions
CREATE TABLE EmployeeWarnings (
    WarningID INT PRIMARY KEY,
    EmployeeID INT,
    WarningDate DATE,
    WarningType NVARCHAR(100),
    Description NVARCHAR(MAX),
    CONSTRAINT FK_EmployeeWarnings_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeContacts table to store emergency contact information for employees
CREATE TABLE EmployeeContacts (
    ContactID INT PRIMARY KEY,
    EmployeeID INT,
    ContactName NVARCHAR(100),
    Relationship NVARCHAR(50),
    ContactNumber NVARCHAR(20),
    CONSTRAINT FK_EmployeeContacts_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeQueries table to store employee queries or helpdesk tickets
CREATE TABLE EmployeeQueries (
    QueryID INT PRIMARY KEY,
    EmployeeID INT,
    QueryDate DATE,
    QueryDescription NVARCHAR(MAX),
    QueryStatus NVARCHAR(20),
    CONSTRAINT FK_EmployeeQueries_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeSurveyResponses table to store employee survey responses
CREATE TABLE EmployeeSurveyResponses (
    ResponseID INT PRIMARY KEY,
    EmployeeID INT,
    SurveyID INT,
    QuestionID INT,
    Response NVARCHAR(MAX),
    CONSTRAINT FK_EmployeeSurveyResponses_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeSurveyResponses_Surveys FOREIGN KEY (SurveyID) REFERENCES Surveys (SurveyID),
    CONSTRAINT FK_EmployeeSurveyResponses_Questions FOREIGN KEY (QuestionID) REFERENCES SurveyQuestions (QuestionID)
);
GO

-- Surveys table to store information about employee surveys
CREATE TABLE Surveys (
    SurveyID INT PRIMARY KEY,
    SurveyName NVARCHAR(100),
    Description NVARCHAR(MAX),
    StartDate DATE,
    EndDate DATE
);
GO

-- SurveyQuestions table to store survey questions for employee surveys
CREATE TABLE SurveyQuestions (
    QuestionID INT PRIMARY KEY,
    SurveyID INT,
    QuestionText NVARCHAR(MAX),
    CONSTRAINT FK_SurveyQuestions_Surveys FOREIGN KEY (SurveyID) REFERENCES Surveys (SurveyID)
);
GO
-- Use the HRDatabase
USE HRDatabase;
GO

-- Create additional tables

-- EmployeeSkills table to store employee skills and competencies
CREATE TABLE EmployeeSkills (
    SkillID INT PRIMARY KEY,
    EmployeeID INT,
    SkillName NVARCHAR(100),
    Description NVARCHAR(MAX),
    SkillLevel INT,
    CONSTRAINT FK_EmployeeSkills_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeTrainings table to store employee training records
CREATE TABLE EmployeeTrainings (
    TrainingID INT PRIMARY KEY,
    EmployeeID INT,
    TrainingName NVARCHAR(100),
    Description NVARCHAR(MAX),
    StartDate DATE,
    EndDate DATE,
    CONSTRAINT FK_EmployeeTrainings_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeVacations table to track employee vacation requests and approvals
CREATE TABLE EmployeeVacations (
    VacationID INT PRIMARY KEY,
    EmployeeID INT,
    StartDate DATE,
    EndDate DATE,
    RequestDate DATE,
    ApprovalStatus NVARCHAR(20),
    CONSTRAINT FK_EmployeeVacations_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeBenefitsEnrollments table to track employee benefit enrollments and changes
CREATE TABLE EmployeeBenefitsEnrollments (
    EnrollmentID INT PRIMARY KEY,
    EmployeeID INT,
    BenefitID INT,
    EnrollmentDate DATE,
    TerminationDate DATE,
    CONSTRAINT FK_EmployeeBenefitsEnrollments_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeBenefitsEnrollments_Benefits FOREIGN KEY (BenefitID) REFERENCES Benefits (BenefitID)
);
GO

-- EmployeePayroll table to store employee payroll information
CREATE TABLE EmployeePayroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT,
    PayPeriodStartDate DATE,
    PayPeriodEndDate DATE,
    Salary DECIMAL(10, 2),
    CONSTRAINT FK_EmployeePayroll_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeAppraisals table to store employee performance appraisals
CREATE TABLE EmployeeAppraisals (
    AppraisalID INT PRIMARY KEY,
    EmployeeID INT,
    AppraisalDate DATE,
    AppraisalType NVARCHAR(50),
    Appraiser NVARCHAR(100),
    Rating DECIMAL(5, 2),
    CONSTRAINT FK_EmployeeAppraisals_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeDemographics table to store employee demographic information
CREATE TABLE EmployeeDemographics (
    DemographicID INT PRIMARY KEY,
    EmployeeID INT,
    Gender NVARCHAR(10),
    DateOfBirth DATE,
    Nationality NVARCHAR(50),
    MaritalStatus NVARCHAR(20),
    CONSTRAINT FK_EmployeeDemographics_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeBenefitsClaims table to store employee benefit claims
CREATE TABLE EmployeeBenefitsClaims (
    ClaimID INT PRIMARY KEY,
    EmployeeID INT,
    BenefitID INT,
    ClaimDate DATE,
    ClaimAmount DECIMAL(10, 2),
    CONSTRAINT FK_EmployeeBenefitsClaims_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeBenefitsClaims_Benefits FOREIGN KEY (BenefitID) REFERENCES Benefits (BenefitID)
);
GO

-- EmployeeProjects table to store employee project assignments
CREATE TABLE EmployeeProjects (
    ProjectID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectName NVARCHAR(100),
    Description NVARCHAR(MAX),
    StartDate DATE,
    EndDate DATE,
    CONSTRAINT FK_EmployeeProjects_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- Use the HRDatabase
USE HRDatabase;
GO

-- Create additional tables

-- JobPositions table to store information about job positions
CREATE TABLE JobPositions (
    PositionID INT PRIMARY KEY,
    PositionTitle NVARCHAR(100),
    DepartmentID INT,
    SalaryRangeMin DECIMAL(10, 2),
    SalaryRangeMax DECIMAL(10, 2),
    CONSTRAINT FK_JobPositions_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID)
);
GO

-- JobApplications table to store employee job applications
CREATE TABLE JobApplications (
    ApplicationID INT PRIMARY KEY,
    EmployeeID INT,
    PositionID INT,
    ApplicationDate DATE,
    ApplicationStatus NVARCHAR(20),
    CONSTRAINT FK_JobApplications_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_JobApplications_JobPositions FOREIGN KEY (PositionID) REFERENCES JobPositions (PositionID)
);
GO

-- EmployeePromotions table to store employee promotion records
CREATE TABLE EmployeePromotions (
    PromotionID INT PRIMARY KEY,
    EmployeeID INT,
    PositionID INT,
    PromotionDate DATE,
    CONSTRAINT FK_EmployeePromotions_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeePromotions_JobPositions FOREIGN KEY (PositionID) REFERENCES JobPositions (PositionID)
);
GO

-- EmployeeTerminations table to track employee terminations
CREATE TABLE EmployeeTerminations (
    TerminationID INT PRIMARY KEY,
    EmployeeID INT,
    TerminationDate DATE,
    TerminationReason NVARCHAR(MAX),
    CONSTRAINT FK_EmployeeTerminations_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeSkillsCertifications table to store employee skills certifications
CREATE TABLE EmployeeSkillsCertifications (
    CertificationID INT PRIMARY KEY,
    EmployeeID INT,
    SkillID INT,
    CertificationName NVARCHAR(100),
    CertificationDate DATE,
    CONSTRAINT FK_EmployeeSkillsCertifications_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeSkillsCertifications_EmployeeSkills FOREIGN KEY (SkillID) REFERENCES EmployeeSkills (SkillID)
);
GO

-- EmployeeBenefitsCoverage table to store employee benefit coverage details
CREATE TABLE EmployeeBenefitsCoverage (
    CoverageID INT PRIMARY KEY,
    EmployeeID INT,
    BenefitID INT,
    CoverageStartDate DATE,
    CoverageEndDate DATE,
    CONSTRAINT FK_EmployeeBenefitsCoverage_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeBenefitsCoverage_Benefits FOREIGN KEY (BenefitID) REFERENCES Benefits (BenefitID)
);
GO

-- EmployeeSkillsTraining table to track employee skills training history
CREATE TABLE EmployeeSkillsTraining (
    TrainingID INT PRIMARY KEY,
    EmployeeID INT,
    SkillID INT,
    TrainingName NVARCHAR(100),
    TrainingDate DATE,
    CONSTRAINT FK_EmployeeSkillsTraining_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeSkillsTraining_EmployeeSkills FOREIGN KEY (SkillID) REFERENCES EmployeeSkills (SkillID)
);
GO

-- EmployeeTimeOffRequests table to track employee time-off requests
CREATE TABLE EmployeeTimeOffRequests (
    RequestID INT PRIMARY KEY,
    EmployeeID INT,
    RequestDate DATE,
    TimeOffType NVARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    RequestStatus NVARCHAR(20),
    CONSTRAINT FK_EmployeeTimeOffRequests_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);
GO

-- EmployeeBenefitsUsage table to track employee benefit usage
CREATE TABLE EmployeeBenefitsUsage (
    UsageID INT PRIMARY KEY,
    EmployeeID INT,
    BenefitID INT,
    UsageDate DATE,
    UsageAmount DECIMAL(10, 2),
    CONSTRAINT FK_EmployeeBenefitsUsage_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmployeeBenefitsUsage_Benefits FOREIGN KEY (BenefitID) REFERENCES Benefits (BenefitID)
);
GO