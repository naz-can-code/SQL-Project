/* ============================================
   HR Projects Database - Business Questions
   ============================================ */

/* 1. Which department has the highest average salary? */
SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY AvgSalary DESC;

/* 2. Who are the top 5 highest-paid employees? */
SELECT TOP 5 FirstName, LastName, Salary, JobTitle
FROM Employees
ORDER BY Salary DESC;

/* 3. How many employees work in each department? */
SELECT d.DeptName, COUNT(e.EmpID) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON d.DeptID = e.DeptID
GROUP BY d.DeptName
ORDER BY EmployeeCount DESC;

/* 4. Which employees are not assigned to any project? */
SELECT e.EmpID, e.FirstName, e.LastName, e.JobTitle
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmpID = ep.EmpID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmpID;

/* 5. What is the total salary cost per department? */
SELECT d.DeptName, SUM(e.Salary) AS TotalSalaryCost
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY TotalSalaryCost DESC;

/* 6. Which project has the largest budget? */
SELECT ProjectName, Budget
FROM Projects
ORDER BY Budget DESC;

/* 7. Which project has the longest duration (EndDate – StartDate)? */
SELECT ProjectName,
       DATEDIFF(DAY, StartDate, EndDate) AS DurationDays
FROM Projects
ORDER BY DurationDays DESC;

/* 8. How many employees are working on more than one project? */
SELECT e.EmpID, e.FirstName, e.LastName, COUNT(ep.ProjectID) AS ProjectCount
FROM Employees e
JOIN EmployeeProjects ep ON e.EmpID = ep.EmpID
GROUP BY e.EmpID, e.FirstName, e.LastName
HAVING COUNT(ep.ProjectID) > 1
ORDER BY ProjectCount DESC;

/* 9. What is the average tenure of employees by department (based on HireDate)? */
WITH EmpTenure AS (
    SELECT e.EmpID, e.DeptID,
           CAST(DATEDIFF(MONTH, e.HireDate, GETDATE()) / 12.0 AS DECIMAL(5,2)) AS TenureYears
    FROM Employees e
)
SELECT d.DeptName, ROUND(AVG(et.TenureYears), 2) AS AvgTenureYears, COUNT(*) AS Headcount
FROM EmpTenure et
JOIN Departments d ON d.DeptID = et.DeptID
GROUP BY d.DeptName
ORDER BY AvgTenureYears DESC;

/* 10. Which manager manages the most employees? */
SELECT m.EmpID,
       m.FirstName,
       m.LastName,
       m.JobTitle,
       COUNT(e.EmpID) AS EmployeeCount
FROM Employees m
JOIN Employees e ON m.DeptID = e.DeptID
WHERE m.JobTitle LIKE '%Manager%'
  AND m.EmpID <> e.EmpID
GROUP BY m.EmpID, m.FirstName, m.LastName, m.JobTitle
ORDER BY EmployeeCount DESC;
