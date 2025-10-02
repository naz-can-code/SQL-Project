--EmpoloyeeProject
INSERT INTO EmployeeProjects (EmpID, ProjectID, Role)
VALUES
(1, 3, 'Developer'),
(2, 3, 'Project Manager'),
(3, 1, 'HR Coordinator'),
(4, 4, 'Recruiter'),
(5, 2, 'Analyst'),
(6, 2, 'Manager'),
(7, 3, 'Tester'),
(8, 3, 'Junior Developer'),
(9, 5, 'Developer'),
(10, 6, 'Developer');

--Departmemnts
INSERT INTO Departments (DeptName, Location) VALUES
('IT', 'Newcastle'),
('HR', 'London'),
('Finance', 'Manchester'),
('Marketing', 'Birmingham'),
('Operations', 'Leeds');

--Projects
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget, Status) VALUES
('HR System Upgrade', '2023-01-01', '2023-06-30', 50000, 'Completed'),
('Finance Dashboard', '2023-03-15', '2023-12-31', 120000, 'Active'),
('Mobile App Development', '2022-09-01', '2023-11-30', 200000, 'Active'),
('Recruitment Portal', '2023-04-01', '2023-08-31', 40000, 'Completed'),
('Marketing Analytics', '2023-02-10', '2023-09-30', 90000, 'Active'),
('Logistics Optimization', '2022-06-01', '2023-12-01', 150000, 'Active');

INSERT INTO Employees (FirstName, LastName, Email, HireDate, Salary, JobTitle, DeptID)
VALUES
-- IT Department (12)
('Alice','Johnson','alice.johnson@company.com','2020-03-15',65000,'Software Engineer',1),
('Bob','Smith','bob.smith@company.com','2019-07-01',80000,'IT Manager',1),
('Grace','Lee','grace.lee@company.com','2020-06-12',60000,'Software Tester',1),
('Henry','Clark','henry.clark@company.com','2023-02-01',48000,'Junior Developer',1),
('Isabella','Moore','isabella.moore@company.com','2019-04-12',67000,'Software Engineer',1),
('Jack','Hall','jack.hall@company.com','2020-07-18',55000,'Tester',1),
('Sophia','Allen','sophia.allen@company.com','2018-12-03',82000,'Project Manager',1),
('Liam','Young','liam.young@company.com','2021-08-22',46000,'Junior Developer',1),
('Charlotte','Perez','charlotte.perez@company.com','2020-07-01',64000,'Software Engineer',1),
('Lucas','Roberts','lucas.roberts@company.com','2021-06-16',47000,'Junior Developer',1),
('Harper','Turner','harper.turner@company.com','2018-10-10',56000,'Tester',1),
('Benjamin','Phillips','benjamin.phillips@company.com','2019-12-20',88000,'Project Manager',1),

-- HR Department (10)
('Clara','Davis','clara.davis@company.com','2021-01-20',50000,'HR Specialist',2),
('David','Wilson','david.wilson@company.com','2018-11-10',55000,'Recruiter',2),
('Mia','King','mia.king@company.com','2019-01-25',52000,'HR Specialist',2),
('Noah','Scott','noah.scott@company.com','2020-05-30',58000,'Recruiter',2),
('Olivia','Adams','olivia.adams@company.com','2022-11-10',73000,'HR Analyst',2),
('James','Evans','james.evans@company.com','2017-06-14',99000,'HR Manager',2),
('Ella','Campbell','ella.campbell@company.com','2021-09-01',53000,'Recruiter',2),
('William','Parker','william.parker@company.com','2020-01-15',60000,'HR Specialist',2),
('Evelyn','Edwards','evelyn.edwards@company.com','2018-05-25',94000,'HR Manager',2),
('Michael','Collins','michael.collins@company.com','2022-03-28',72000,'HR Analyst',2),

-- Finance Department (10)
('Emma','Brown','emma.brown@company.com','2022-05-05',72000,'Financial Analyst',3),
('Frank','Taylor','frank.taylor@company.com','2017-09-18',95000,'Finance Manager',3),
('Amelia','Baker','amelia.baker@company.com','2021-03-19',61000,'Financial Analyst',3),
('Ethan','Ward','ethan.ward@company.com','2020-02-11',87000,'Finance Manager',3),
('Ava','Mitchell','ava.mitchell@company.com','2019-09-09',45000,'Accounts Assistant',3),
('Mason','Carter','mason.carter@company.com','2022-04-22',69000,'Financial Analyst',3),
('Abigail','Stewart','abigail.stewart@company.com','2019-08-19',78000,'Financial Analyst',3),
('Alexander','Morris','alexander.morris@company.com','2017-04-03',102000,'Finance Director',3),
('Emily','Murphy','emily.murphy@company.com','2020-10-11',54000,'Accounts Assistant',3),
('Daniel','Cook','daniel.cook@company.com','2021-07-20',67000,'Financial Analyst',3),

-- Marketing Department (9)
('Madison','Rogers','madison.rogers@company.com','2019-02-02',59000,'Marketing Analyst',4),
('Scarlett','Murphy','scarlett.murphy@company.com','2019-05-12',62000,'Marketing Specialist',4),
('Sebastian','Bailey','sebastian.bailey@company.com','2020-09-19',70000,'Marketing Coordinator',4),
('Grace','Rivera','grace.rivera@company.com','2021-12-13',48000,'Content Creator',4),
('Carter','Cooper','carter.cooper@company.com','2017-01-21',98000,'Marketing Manager',4),
('Chloe','Richardson','chloe.richardson@company.com','2022-06-05',66000,'SEO Specialist',4),
('Zoe','Brooks','zoe.brooks@company.com','2020-08-14',63000,'Digital Marketer',4),
('Hannah','Price','hannah.price@company.com','2019-06-03',56000,'Marketing Analyst',4),
('Matthew','Long','matthew.long@company.com','2022-09-22',91000,'Marketing Director',4),

-- Operations Department (9)
('Logan','Cox','logan.cox@company.com','2020-12-09',85000,'Operations Manager',5),
('Lily','Howard','lily.howard@company.com','2018-11-17',46000,'Operations Assistant',5),
('Owen','Ward','owen.ward@company.com','2021-05-08',72000,'Logistics Coordinator',5),
('Aiden','Sanders','aiden.sanders@company.com','2021-02-27',47000,'Supply Chain Analyst',5),
('Sofia','Foster','sofia.foster@company.com','2020-02-16',61000,'Operations Specialist',5),
('Megan','Walker','megan.walker@company.com','2019-03-05',54000,'Warehouse Supervisor',5),
('Ryan','Hughes','ryan.hughes@company.com','2020-07-23',69000,'Procurement Officer',5),
('Natalie','Barnes','natalie.barnes@company.com','2018-12-11',88000,'Logistics Manager',5),
('Oliver','James','oliver.james@company.com','2021-10-14',52000,'Operations Coordinator',5);
