-- Create Database
CREATE DATABASE HRProjectsDB;
GO
USE HRProjectsDB;
GO

-- Departments
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY IDENTITY(1,1),
    DeptName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

-- Employees
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    HireDate DATE DEFAULT GETDATE(),
    Salary DECIMAL(10,2) CHECK (Salary > 1000),
    JobTitle VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Projects
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12,2),
    Status VARCHAR(20) DEFAULT 'Active'
);

-- EmployeeProjects (Many-to-Many)
CREATE TABLE EmployeeProjects (
    EmpID INT,
    ProjectID INT,
    Role VARCHAR(50),
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
