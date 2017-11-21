﻿DROP PROC AddManagerResponseToRequestSP;
DROP PROC ViewProjectsOfEmployeeSP;
DROP PROC ViewDepartmentSP;
DROP PROC ViewCompaniesSP;
DROP PROC UserLoginSP;
DROP PROC ViewQuetionsInInterviewSP;
DROP PROC DeletePendingApplicationSP;
DROP PROC ViewYearlyAttendanceOfStaffSP;
DROP PROC SendEmailSP;
DROP PROC AddJobSP;
DROP PROC AddQuestionSP;
DROP PROC AddQuestionToJobSP;
DROP PROC AddHrResponseSP;
DROP PROC ViewAttendanceSP;
DROP PROC ViewTasksInProjectSP;
DROP PROC ViewApprovedJobAppSP;
DROP PROC ViewSeekerInfoSP;
DROP PROC ViewJobInfoSP;
DROP PROC AssignRegularToProjectSP;
DROP PROC AssignRegularToTaskSP;
DROP PROC ViewEmployeesRequestsSP;
DROP PROC ViewTop3RegularSp;
DROP PROC ReplaceRegularSP;
DROP PROC RemoveRegularFromProjectSp
DROP PROC HRPostsAnnouncementSP 
DROP PROC ViewReceivedEmailsSP;
DROP PROC CheckInSP;
DROP PROC ViewJobInformationSP;
DROP PROC ViewMyScoreSP;
DROP PROC ViewDepartmentsOfCompanySP;
DROP PROC ViewCompaniesSalariesSP;
DROP PROC ChooseJobFromAcceptedAppSP;
DROP PROC ApplyForJobSP;
DROP PROC DeletePendingRequestsSP;
DROP PROC ViewNewApplicationsSP;
DROP PROC ViewAttendanceOfStaffSP;
DROP PROC ViewCompanySP;
DROP PROC SearchJobsSP;
DROP PROC EditPersonalInfoSP;
DROP PROC ViewJobsStatusSP;
DROP PROC CheckOutSP;
DROP PROC ViewTasksSP;
DROP PROC RespondToJobApplicationsSP;
DROP PROC DefineTaskSP;
DROP PROC ChangeTaskStatusSP;
DROP PROC EditJobInfoSP;
DROP PROC RegisterToWebsite;
DROP PROC ViewRequestsSP;
DROP PROC ViewLatestAnnouncementsSP;
DROP PROC SearchCompanyByNameSP;
DROP PROC SearchCompanyByAddressSP;
DROP PROC SearchCompanyByTypeSP;
DROP PROC ViewUserInfoSP;
DROP PROC DefineNewProject;
DROP PROC ReviewTaskSP;
DROP PROC ViewJobsWithVacancySP;
DROP PROC ApplyManagerForRequestSP;
DROP PROC ApplyRegularForRequestSP;
DROP PROC ApplyHRForRequestSP;
DROP PROC ViewRequestsStatusSP;
DROP PROC ReplyToEmailsSP;
DROP PROC ShowRequestInfoSP;
DROP PROC RespondHRToRequestSP;
DROP PROC FinalizeTaskSP;
---------------------------------------------------------------------------------------------------------------------------------------------------------------

--“As an registered/unregistered user, I should be able to ...”

----------------------------------------------------------------------------------------------------------------------------------------------------------------


--1: Gharam-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Users story no.1 views the info of companies with its name containing a key word
-- The procedure takes keyWord as input and returns the information of the companies containing keyWord in its name
GO 

CREATE PROC SearchCompanyByNameSP
@keyWord VARCHAR(50)
AS
SELECT c.*,cp.phone
FROM Companies c LEFT JOIN Companies_Phones cp
ON c.domain_name = cp.company_domain
WHERE c.name LIKE CONCAT('%',@keyWord,'%');

-- The procedure views the information of companies with its adress containing a key word
-- The procedure takes keyWord as input and returns the information of the companies containing keyWord in its adress
GO

CREATE PROC SearchCompanyByAddressSP
@keyWord VARCHAR(300)
AS
SELECT c.*,cp.phone
FROM Companies c LEFT JOIN Companies_Phones cp
ON c.domain_name = cp.company_domain
WHERE c.address LIKE CONCAT('%',@keyWord,'%')

-- The procedure views the information of companies with its type containing a key word
-- The procedure takes keyWord as input and returns the information of the companies containing keyWord in its type
GO

CREATE PROC SearchCompanyByTypeSP
@keyWord VARCHAR(50)
AS
SELECT c.*,cp.phone
FROM Companies c LEFT JOIN Companies_Phones cp
ON c.domain_name = cp.company_domain
WHERE c.type LIKE CONCAT('%',@keyWord,'%')
--2:Yasmine--------------------------------------------------------------------------------------------------------------------------------------------
--Registered/Unregistered Stories no. 2: View all companies with their informations.The procedure shows all columns of table Companies joined with the 
--table Companies_Phones to show also the phones available for each company. 

GO
CREATE PROC ViewCompaniesSP 
AS
SELECT C.*,  CP.phone
FROM Companies C LEFT JOIN Companies_Phones CP
ON C.domain_name = CP.company_domain


--3:Abdullah-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Users story no.3 views the information of a certain company along with all of its departments info 
GO
-- The procedure takes the companyDomain as input and outputs the information of the company specified with the companyDomain
CREATE PROC ViewCompanySP 
@companyDomain VARCHAR(150)
AS 
SELECT c.*,cp.phone
FROM Companies c LEFT JOIN Companies_Phones cp
ON c.domain_name = cp.company_domain
WHERE (c.domain_name = @companyDomain)


GO

-- The procedure takes the companyDomain as input and outputs the information of all the departments in that company
CREATE PROC ViewDepartmentsOfCompanySP
@companyDomain VARCHAR(150)
AS
SELECT d.*
FROM Departments d
WHERE (d.company_domain= @companyDomain)


--4:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Users story no.4 view the info of jobs in a departments in a certain company that have vacancies in it
-- The procedure takes the company domain and the department code as input and returns the info of the department
GO

CREATE PROC ViewDepartmentSP
@companyDomain VARCHAR(150),
@departmentCode VARCHAR(30)
AS
SELECT d.*
FROM Departments d
WHERE ((d.company_domain = @companyDomain) AND (d.department_code = @departmentCode))
--The procedure takes the department code and company domain as input and return the info of all the jobs in that 
--department that have vacancies greater than 0
GO
CREATE PROC ViewJobsWithVacancySP
@companyDomain VARCHAR(150),
@departmentCode VARCHAR(30)
AS
SELECT j.*
FROM Jobs j
WHERE j.department_code = @departmentCode AND j.company_domain = @companyDomain AND j.vacancies > 0

--5: Gharam----------------------------------------------------------------------------------------------------------------------------------------------
-- Users story no.5 registers a user into the website with the information he/she enters with the condition of the user name being unique
-- The Procedure takes userName, password, personalEmail, birthDate, expYear, firstName and lastName as input and outputs
--  1 -->  username  unique with respect to the database , and a successful registration
--  0 --> username not unique with reprect to the database, and a failed registration
GO

CREATE PROC RegisterToWebsite
@userName VARCHAR(30)  ,
@password VARCHAR(30) ,
@personalEmail VARCHAR(70) ,
@birthDate DATETIME ,
@expYear INT ,
@firstName VARCHAR(25) ,
@lastName VARCHAR(25),
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS
(
SELECT *
FROM Users
WHERE Users.user_name = @userName
)
BEGIN
SET @operationStatus = 1; --successful registration
INSERT INTO Users(user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES(@username,@password,@personalEmail,@birthDate,@expYear,@firstName,@lastName)
END
ELSE
SET @operationStatus = 0; --failed registration

--6:Yasmine-----------------------------------------------------------------------------------------------------------------------------------

--Registered/Unregestered User stories no.6: The user searches for the jobs that have vacancies by giving the procedure a text. 
-- The procedure checks if the job title or job description contains this text as keywords in the search.

GO
CREATE PROC SearchJobsSP 
@keywords TEXT
AS
SELECT j.* 
FROM Jobs j
WHERE j.vacancies > 0 AND j.short_description LIKE CONCAT('%' ,@keywords,'%') OR  j.job_title LIKE CONCAT('%' ,@keywords,'%') 


--7:Abdullah----------------------------------------------------------------------------------------------------------------------------

--Users Story no.7 View the companies in the order of having the highest average salaries
-- ViewCompaniesSalaries returns the average salary of all staff members grouped by the companies they are in while ordering those averages descendingly
GO

CREATE PROC ViewCompaniesSalariesSP
AS
SELECT sm.company_domain, AVG(sm.salary) AS average_salary
FROM Staff_Members sm
GROUP BY (sm.company_domain)
ORDER BY AVG(sm.salary) DESC


------------------------------------------------------------------------------------------------------------------------------------------------------------------

--“As a registered user, I should be able to ...”

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. Reda
--registered user story no.1 login to the website with your username and password and checks whether you are an existing user or and defines the type of the user
-- the procedure takes the username and password as input and returns the an int variable as output with values as follow
-- 0 --> not a user
-- 1 --> job seeker
-- 2 --> manager
-- 3 --> hr
-- 4 --> regular
GO

CREATE PROC UserLoginSP
@userName VARCHAR(30),
@password  VARCHAR(30),
@type INT OUTPUT
AS
BEGIN
IF
NOT EXISTS (
SELECT u.*
FROM Users u
WHERE (u.user_name = @userName AND u.password = @password)
)

SET @type = 0;

ELSE IF
EXISTS ( 
SELECT s.*
FROM Job_Seekers s
WHERE (s.user_name = @userName)
)
SET @type = 1;

ELSE IF
EXISTS (
SELECT m.*
FROM Managers m
WHERE (m.user_name = @userName)
)
SET @type = 2;
ELSE IF
EXISTS (
SELECT h.*
FROM HR_Employees h
WHERE (h.user_name = @userName)
)
SET @type = 3;

ELSE IF
EXISTS (
SELECT r.*
FROM Regular_Employees r
WHERE (r.user_name = @userName)
)
SET @type = 4;

END

--2: Gharam ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Users story user no.2 views the all the information of a user
-- The procedure takes userName as input and outpus all the information of a user with his/her name matching the userName
GO
Create PROC ViewUserInfoSP
@userName VARCHAR(30)

AS
SELECT * 
FROM USERS 
WHERE user_name=@username
DROP PROC ViewUserInfoSp;



--3: Yasmine -------------------------------------------------------------------------------------------------------------------------------------------------------
--Registered User stories no.3:The user can edit his personal info.
--The user chooses to edit certain info or all of them. If an input is null, no change will happen to the corresponding attribute. If the user entered a value. changes 
--will be applied
GO
CREATE PROC EditPersonalInfoSP
@username VARCHAR(30),
@password VARCHAR(30),
@personalEmail VARCHAR(70),
@birthDate DATETIME,
@expYear INT,
@firstName VARCHAR(25),
@lastName VARCHAR(25)
AS

IF(@password IS NOT NULL)
UPDATE Users 
SET
password=@password
WHERE user_name = @username
IF(@personalEmail IS NOT NULL)
UPDATE Users 

SET
personal_email=@personalEmail
WHERE user_name = @username
IF(@birthDate IS NOT NULL)
UPDATE Users 
SET
birth_date=@birthDate
WHERE user_name = @username
IF(@expYear IS NOT NULL)
UPDATE Users 
SET
exp_year = @expYear
WHERE user_name = @username
IF(@firstName IS NOT NULL)
UPDATE Users 
SET
first_name = @firstName
WHERE user_name = @username
IF(@lastName IS NOT NULL)
UPDATE Users
SET
last_name = @lastName
WHERE user_name = @username




------------------------------------------------------------------------------------------------------------------------------------------------------

--“As a job seeker, I should be able to ...”

----------------------------------------------------------------------------------------------------------------------------------------------------------
--1: Abdullah

-- Job Seekers Story no.1 Apply for any job as long as I have the needed years of experience for the job. 
-- ApplyForJobSP takes seeker user name and application info as inputs and checks that there is no application 
-- for the same seeker that has a pending status for the same job, while checking that the seeker experience
-- exceeds the min years of experience required by the job he applied for.
GO

CREATE PROC ApplyForJobSP 
@seekerUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@operationStatus INT OUTPUT
AS
IF(
EXISTS(
SELECT *
FROM  Jobs j INNER JOIN Applications a
ON j.company_domain = a.company_domain AND
	j.department_code = a.department_code AND
	j.job_title = a.job_title
WHERE a.app_status = 'Pending' AND
	  a.job_title = @jobTitle AND
	  a.department_code = @departmentCode AND
	  a.company_domain = @companyDomain AND
	  a.seeker_username = @seekerUserName
))
SET @operationStatus = 1; -- there is another application for the same job with pending status
ELSE IF
NOT EXISTS(
SELECT *
FROM Jobs j INNER JOIN Users u
ON u.exp_year >= j.min_years_experience
WHERE u.user_name = @seekerUserName AND
j.job_title = @jobTitle AND
j.department_code = @departmentCode AND 
j.company_domain = @companyDomain
)
SET @operationStatus = 2; -- the seeker doesn't have enough exp
ELSE
BEGIN
INSERT INTO Applications
(seeker_username,job_title,department_code,company_domain)
VALUES
(@seekerUserName,@jobTitle,@departmentCode,@companyDomain)
SET @operationStatus = 3; --successful application
END

--2:Reda----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- job seeker story no.2 view the interview questions related to the job I am applying for
-- this procedure takes the job title, department code and company domain of the target job as input and
-- returns all the titles of the interview questions related to that job.
GO
CREATE PROC ViewQuetionsInInterviewSP
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
SELECT q.question_title
FROM Questions q INNER JOIN Jobs_Have_Questions jq
ON jq.question_id = q.question_id
WHERE (jq.job_title = @jobTitle AND jq.department_code = @departmentCode AND jq.company_domain = @companyDomain)


--3: Gharam---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Users story job seeker no.3 views the scores of applications, which matches the job he/she applied for and his/her username
-- The Procedure takes userName,jobTitle, departmentCode and CompanyDomain as input and outputs the score of a certain application 
GO 
CREATE PROC ViewMyScoreSP  
@username VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@CompanyDomain VARCHAR(150)
AS 
SELECT  score
From  Applications 
WHERE @username=seeker_username 
AND @CompanyDomain=company_domain
AND @jobTitle =job_title
AND @departmentCode =department_code


--4: Yasmine----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Job Seeker User Stories no.4: The job seeker checks the status and score of each application he/she applied for.
--The procedure takes the username of the jobseeker as input and shows the status of all applications, where their usernae equals the input
GO 
CREATE PROC ViewJobsStatusSP
@username VARCHAR(30)
AS
Select A.job_title, A.department_code, A.company_domain, A.score, A.app_status
FROM Applications A
WHERE A.seeker_username=@username

--5: Abdullah------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Job Seekers Story no.5 Choose a job from the jobs I was accepted in
-- ChooseJobFromAcceptedAppSP takes the user name of the job seeker, the job information
-- and the day off of choice as input and returns a int as output representing the result of the procedure as follows
-- 0 --> This is not an accepted application
-- 1 --> This chosen day off is friday
-- 2 --> operation successful. the job seeker is now a staff member in his specified job, and number of vacancies in the

GO
Create PROC ChooseJobFromAcceptedAppSP 
@seekerUserName VARCHAR(30),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@jobTitle VARCHAR(150),
@dayOff VARCHAR(10),
@operationStatus INT OUTPUT
AS
IF(NOT EXISTS
(
SELECT * 
FROM Applications a
WHERE a.company_domain = @companyDomain AND
a.department_code = @departmentCode AND
a.job_title = @jobTitle AND
a.seeker_username = @seekerUserName AND
a.app_status = 'Accepted'
))
SET @operationStatus = 0 --The chosen application is not an accepted one
ELSE IF(@dayOff = 'Friday')
SET @operationStatus = 1 --The chosen day off is friday
ELSE
BEGIN
DELETE FROM Applications
    WHERE 
	Applications.seeker_username=@seekerUserName 
	AND Applications.company_domain=@companyDomain 
	AND Applications.department_code=@departmentCode 
	AND Applications.job_title=@jobTitle
DELETE FROM Job_Seekers 
WHERE Job_Seekers.user_name = @seekerUserName
DECLARE @salary INT
SELECT @salary = salary
	FROM Jobs
	WHERE department_code = @departmentCode AND
	company_domain = @companyDomain AND
	job_title = @jobTitle
INSERT INTO Staff_Members 
(user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES
(@seekerUserName,@dayOff,30,@salary,@jobTitle,@departmentCode,@companyDomain)
UPDATE Jobs 
SET vacancies = vacancies - 1
WHERE Jobs.company_domain = @companyDomain AND
		Jobs.department_code = @departmentCode AND
		Jobs.job_title = @jobTitle
SET @operationStatus = 2 --Successful job choice
END


--6: Reda------------------------------------------------------------------------------------------------------------------------------------------------------------------
--job seekers story no.6 delete any job application as long as it is still in the review process. The procedure takes as input the seeker username, job title, department code
-- and company domain, returns an output bit that specifies the following
-- 0 --> unsuccessful operation//this application is not in the review process or this application does not exist
-- 1 --> successful operation// the application specified has a status 'Pending' and was deleted as a result
GO
CREATE PROC DeletePendingApplicationSP
@seekerUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS (
SELECT *
FROM Applications a
WHERE a.job_title = @jobTitle AND a.department_code = @departmentCode AND a.company_domain = @companyDomain AND a.seeker_username = @seekerUserName AND a.app_status = 'pending'
)
SET @operationStatus = 0 
ELSE
BEGIN
DELETE FROM Applications
WHERE (Applications.seeker_username = @seekerUserName AND Applications.job_title = @jobTitle AND Applications.company_domain = @companyDomain AND Applications.app_status = 'Pending')
SET @operationStatus = 1 
END
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--“As a staff member, I should be able to ...”

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1: Gharam
-- Users story staff member no.1 inserts a check-in attednace of a staff member 
-- The procedure takes username as input and outputs operation status 0 or 1
-- 0 -->  no attendance inserted
-- 1 --> attendance inserted
-- The procedure gets the staff member's day_off and then checks 
--if the current day of check-in is friday or his/her day_off then no attendace will be inserted
-- Else attendance will be inserted
GO

CREATE PROC CheckInSP 
@username VARCHAR(30),
@operationStatus BIT OUTPUT
AS
DECLARE @timestamp DATETIME
DECLARE @dayOff VARCHAR(10)
SET @timestamp = CURRENT_TIMESTAMP

SELECT @dayOff = s.day_off
FROM Staff_Members s
WHERE s.user_name = @username 
IF (EXISTS (
SELECT user_name
FROM Staff_Members
WHERE Staff_Members.user_name = @username AND
(
(DATENAME(dw,GETDATE())='Friday') OR
DATENAME(dw,GETDATE())=@dayOff)
))
SET @operationStatus = 0
ELSE
BEGIN
INSERT INTO Attendances 
(user_name,start_time)
VALUES(@username , @timestamp)
SET @operationStatus = 1
END


--2: Yasmine------------------------------------------------------------------------------------------------------------------------------------------------------------

--Staff Member user stories no.2: The procedure saves the leave time of the staff members. 
--The procedure takes as input the staff member's username, if his/her dayoff equals the timestamp, the procedure return 0 (false) and we disregard the leave time. 
--Otherwise, the procedure sets the leavetime in the Attendance table to the timestamp and outputs 1 (true), meaning we regarded the leavetime.
GO
CREATE PROC CheckOutSP 
@username VARCHAR(30),
@operationStatus BIT OUTPUT
AS
DECLARE @timestamp DATETIME
SET @timestamp = CURRENT_TIMESTAMP
IF( EXISTS 
(
SELECT *
FROM Attendances a INNER JOIN Staff_Members sm
ON a.user_name = sm.user_name
WHERE a.user_name=@username AND sm.day_off = DATENAME(dw,@timestamp)
))
SET @operationStatus=0 
ELSE
BEGIN
UPDATE Attendances 
SET    leave_time = @timestamp
WHERE  user_name = @username AND CAST( Attendances.start_time AS DATE) = CAST(@timestamp AS DATE)
SET @operationStatus = 1 
END


--3: Reda------------------------------------------------------------------------------------------------------------------------------------------------------------
-- staff member story no.3 View all my attendance records within certain period of time.
-- The procedure takes the user name of the staff member that wants to view his attendance records as input
-- and the dates over which he wants to check his attendance, and generates all the attendance records 
-- in between those 2 dates. 
GO
CREATE PROC ViewAttendanceSP
@userName VARCHAR(30),
@periodStart DATETIME,
@periodEnd DATETIME
AS
SELECT a.start_time, a.leave_time, a.duration, a.missing_hours
FROM Attendances a
WHERE (DATEDIFF(DAY,@periodStart,a.start_time)>=0 AND DATEDIFF(DAY,@periodEnd,a.start_time) <=0)



--4: Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- staff member story no.4 Apply for requests of both types: business trip and leave requests.
-- The procedures take the request info as input and distinguish wether the insertion is for
-- A leave request or a business trip request as follows
-- in case the leave type input is not null the request is considered a leave request
-- in case the leave type is kept null the request is considered a business trip request
-- The procedures also return an operation status output this output is represented as follow
-- 0 --> the replacer is not from the same type and request is not applable
-- 1 --> successful request application

--This procedure applies the above documented functionality on regular employees only
GO
CREATE PROC ApplyRegularForRequestSP
@ownerUserName VARCHAR(30),
@replacementUserName VARCHaR(30),
@startDate DATETIME,
@endDate DATETIME,
@leaveType VARCHAR(50) = NULL,
@tripDestination VARCHAR(150) = NULL,
@tripPurpose TEXT = NULL,
@operationStatus BIT OUTPUT
AS
DECLARE @identity INT
DECLARE @requestType BIT
DECLARE @timestamp DATETIME
SET @timestamp = CURRENT_TIMESTAMP
IF NOT EXISTS(
SELECT *
FROM Regular_Employees re
WHERE re.user_name = @ownerUserName
)SET @operationStatus = 0; -- your replacer is not a regular employee
ELSE
BEGIN
IF(@leaveType IS NULL) 
SET @requestType = 0 --this is a business trip request
ELSE 
SET @requestType = 1 -- this is a leave request
INSERT INTO Requests
(start_date,end_date,request_date)
VALUES(@startDate,@endDate,@timestamp)
SELECT @identity = Requests.request_id
FROM Requests
WHERE Requests.request_date= @timestamp
IF(@requestType = 0)
INSERT INTO Business_Trip_Requests
(request_id,trip_destination,trip_purpose)
VALUES(@identity,@tripDestination,@tripPurpose)
ELSE
INSERT INTO Leave_Requests
(request_id,type)
VALUES (@identity,@leaveType)
INSERT INTO Regular_Employees_Replace_Regular_Employees
(request_id,user_name_request_owner,user_name_replacer)
VALUES(@identity,@ownerUserName,@replacementUserName);
SET @operationStatus = 1; --successful request application
END

--This procedure applies the above documented functionality for HR Employees only
GO
CREATE PROC ApplyHRForRequestSP
@ownerUserName VARCHAR(30),
@replacementUserName VARCHaR(30),
@startDate DATETIME,
@endDate DATETIME,
@leaveType VARCHAR(50) = NULL,
@tripDestination VARCHAR(150) = NULL,
@tripPurpose TEXT = NULL,
@operationStatus BIT OUTPUT
AS
DECLARE @identity INT
DECLARE @requestType BIT
DECLARE @timestamp DATETIME
SET @timestamp = CURRENT_TIMESTAMP
IF NOT EXISTS(
SELECT *
FROM HR_Employees hr
WHERE hr.user_name = @ownerUserName
)SET @operationStatus = 0; -- your replacer is not an HR employee
ELSE 
BEGIN
IF(@leaveType IS NULL) 
SET @requestType = 0 --this is a business trip request
ELSE 
SET @requestType = 1 -- this is a leave request
INSERT INTO Requests
(start_date,end_date,request_date)
VALUES(@startDate,@endDate,@timestamp)
SELECT @identity = Requests.request_id
FROM Requests
WHERE Requests.request_date= @timestamp
IF(@requestType = 0)
INSERT INTO Business_Trip_Requests
(request_id,trip_destination,trip_purpose)
VALUES(@identity,@tripDestination,@tripPurpose)
ELSE
INSERT INTO Leave_Requests
(request_id,type)
VALUES (@identity,@leaveType)
INSERT INTO HR_Employees_Replace_HR_Employees
(request_id,user_name_request_owner,user_name_replacer)
VALUES(@identity,@ownerUserName,@replacementUserName);
SET @operationStatus = 1; --successful request application
END
--This procedure applies the above documented functionality on managers only
GO
CREATE PROC ApplyManagerForRequestSP
@ownerUserName VARCHAR(30),
@replacementUserName VARCHaR(30),
@startDate DATETIME,
@endDate DATETIME,
@leaveType VARCHAR(50) = NULL,
@tripDestination VARCHAR(150) = NULL,
@tripPurpose TEXT = NULL,
@operationStatus BIT OUTPUT
AS
DECLARE @identity INT
DECLARE @requestType BIT
DECLARE @timestamp DATETIME
SET @timestamp = CURRENT_TIMESTAMP
IF NOT EXISTS(
SELECT *
FROM Managers m
WHERE m.user_name = @ownerUserName
)SET @operationStatus = 0; -- your replacer is not manager
ELSE
BEGIN
IF(@leaveType IS NULL) 
SET @requestType = 0 --this is a business trip request
ELSE 
SET @requestType = 1 -- this is a leave request
INSERT INTO Requests
(start_date,end_date,request_date)
VALUES(@startDate,@endDate,@timestamp)
SELECT @identity = Requests.request_id
FROM Requests
WHERE Requests.request_date= @timestamp
IF(@requestType = 0)
INSERT INTO Business_Trip_Requests
(request_id,trip_destination,trip_purpose)
VALUES(@identity,@tripDestination,@tripPurpose)
ELSE
INSERT INTO Leave_Requests
(request_id,type)
VALUES (@identity,@leaveType)
INSERT INTO Managers_Replace_Managers
(request_id,user_name_request_owner,user_name_replacer)
VALUES(@identity,@ownerUserName,@replacementUserName);
SET @operationStatus = 1; --successful request application
END
--5: Yasmine------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Staff Members User Stories No.5: The staff member checks the status (respond of Manager and HR ) to the requests he/she applied for.
--The procedure has 1 input, the username of the Staff member... 
--As we have three tables for Staff member-applies-for-Request-relations, one for each of the Managers, HR_Employees, and Regular Employees, 
--the procedure makes a union of those 3 tables and matches the Staff member's Username 
-- to  whatever comes from the Union. 
GO
CREATE PROC ViewRequestsStatusSP
@userName VARCHAR(30)
AS
SELECT r.request_id, r.hr_response_req, r.manager_response_req 
FROM Requests r
WHERE r.request_id = ANY(
SELECT hrr.request_id 
FROM HR_Employees_Replace_HR_Employees hrr
WHERE hrr.user_name_request_owner = @userName
UNION
SELECT mmr.request_id
FROM Managers_Replace_Managers mmr
WHERE mmr.user_name_request_owner = @userName
UNION
SELECT rrr.request_id
FROM Regular_Employees_Replace_Regular_Employees rrr
WHERE rrr.user_name_request_owner = @userName
) 




--6: Abdullah --------------------------------------------------------------------------------------------------------------------------------------------------------------
--staff member Story no.6 Delete any request that is still in the review process
--DeletePendingRequestsSP takes the username of the employee as input and deletes all
--his requests that have an hr_response_req attr value of NULL
GO 

CREATE PROC DeletePendingRequestsSP 
@userName VARCHAR(30)
AS
--first delete the replacement part of the request
--in case the user is a manager
DELETE FROM Managers_Replace_Managers
WHERE (user_name_request_owner = @userName AND
Managers_Replace_Managers.request_id = ANY(
SELECT Requests.request_id
FROM Requests
WHERE hr_response_req IS NULL))
--in case the user is a regular employee
DELETE FROM Regular_Employees_Replace_Regular_Employees
WHERE (user_name_request_owner = @userName AND
Regular_Employees_Replace_Regular_Employees.request_id = ANY(
SELECT Requests.request_id
FROM Requests
WHERE hr_response_req IS NULL))
--in case the user is an HR employee
DELETE FROM HR_Employees_Replace_HR_Employees
WHERE (user_name_request_owner = @userName AND
HR_Employees_Replace_HR_Employees.request_id = ANY(
SELECT Requests.request_id
FROM Requests
WHERE hr_response_req = NULL))
--Then delete the request sub-type whenever its ID is not available anywhere in the replacement tables
--in case part of the target requests is leave requests
DELETE FROM Leave_Requests
WHERE NOT( request_id = ANY(
	SELECT request_id
	FROM Managers_Replace_Managers
	)
	OR request_id = ANY(
	SELECT request_id
	FROM Regular_Employees_Replace_Regular_Employees
	)
	OR request_id = ANY(
	SELECT request_id
	FROM HR_Employees_Replace_HR_Employees
	))
--in case part of the target requests is business trip requests 
DELETE FROM Business_Trip_Requests
WHERE NOT(request_id = ANY(
	SELECT request_id
	FROM Managers_Replace_Managers
	)
	OR request_id = ANY(
	SELECT request_id
	FROM Regular_Employees_Replace_Regular_Employees
	)
	OR request_id = ANY(
	SELECT request_id
	FROM HR_Employees_Replace_HR_Employees
	))
--then delete all the requests that don't have equivalent IDS is either the leave or business trip request tables
DELETE FROM Requests
	WHERE NOT (request_id = ANY(
	SELECT request_id
	FROM Leave_Requests
	)
	OR request_id = ANY(
	SELECT request_id
	FROM Business_Trip_Requests
	))


--7: Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- staff member story no.7 the procedure takes the email info as input and performs
-- a basic insertion operation with that info to the Emails and the Staff_Receives_Emails tables
GO
CREATE PROC SendEmailSP
@senderUserName VARCHAR(30),
@senderEmail VARCHAR(180),
@recipientUserName VARCHAR(30),
@recipientEmail VARCHAR(180),
@emailSubject VARCHAR(140),
@emailBody TEXT,
@operationStatus BIT OUTPUT
AS
DECLARE @timestamp DATETIME
SET @timestamp = CURRENT_TIMESTAMP

IF EXISTS(
 SELECT *
 FROM Staff_Members 
 WHERE Staff_Members.user_name=@senderUserName AND
 Staff_Members.company_domain = ANY(
 SELECT Staff_Members.company_domain
 FROM Staff_Members
 WHERE Staff_Members.user_name= @recipientUserName
 )
 )
BEGIN 
 
INSERT INTO Emails
(time_stamp,sender_user_name,sender_email,recipient_email,email_subject,email_body)
VALUES
(@timestamp,@senderUserName,@senderEmail,@recipientEmail,@emailSubject,@emailBody)
INSERT INTO Staff_Receives_Email
(time_stamp,sender_user_name,recipient_username)
VALUES
(@timestamp,@senderUserName,@recipientUserName)
SET @operationStatus = 1 
END
ELSE BEGIN 
SET @operationStatus=0 
END 

--8:Gharam-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Staff Member User Stories No.9: The Staff Member views all the Received emails from other staff members in the same company. 
-- The procedure 
-- takes the username of the staff member as input, returns 
-- shows the emails of the username according to the primary keys of table Emails
-- only if sender are in the same company as the receiver (handled with an Exists)


GO
CREATE PROC ViewReceivedEmailsSP 
@username VARCHAR(30)
AS
SELECT e.*
FROM Emails e INNER JOIN Staff_Receives_Email r
ON e.sender_user_name = r.sender_user_name AND e.time_stamp = r.time_stamp AND r.recipient_username = @username
WHERE EXISTS (
  
SELECT*
FROM Staff_Members sm 
WHERE sm.user_name = @username 
 AND  sm.company_domain = ANY(
 SELECT sm1.company_domain
 FROM Staff_Members sm1
 WHERE sm1.user_name= e.sender_user_name
 ))
--9:Yasmine--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Staff Member User Stories no.9: The Staff memeber replies to a received email, and this email is added to the table Email. 
--So the procedure has 5 inputs:-
--@recipientUSername is the username of the staff member checking the received emails
--@timestamp is the time at which the staff member received the email
--@senderUSername is the one who sent the email to the staff member
--The staff member will type the email subject in @emailSubject
--the staff member will type the email body in @emailBody
--then it gets the emails of both sender and receiver from the Staff Member Table
--Finally we insert the input values in tables Emails and Staff_Receive_Email 
--The time of the reply will then be the Current timesatamp
GO
CREATE PROC ReplyToEmailsSP 
@recipientUsername VARCHAR(30),
@timestamp DATETIME,
@senderUsername VARCHAR(30),
@emailSubject VARCHAR(140) = '',
@emailBody TEXT = ''
AS 
DECLARE @ts DATETIME
SET @ts = CURRENT_TIMESTAMP
DECLARE @senderEmail VARCHAR(180)
DECLARE @recipientEmail VARCHAR(180)

SELECT @senderEmail = sm.company_email 
FROM Staff_Members sm
WHERE sm.user_name=@senderUsername


SELECT @recipientEmail = sm.company_email 
FROM Staff_Members sm
WHERE sm.user_name=@recipientUsername


INSERT INTO Emails 
(time_stamp,sender_user_name,sender_email,recipient_email,email_subject,email_body)
VALUES
(@ts,@recipientUsername, @recipientEmail,@senderEmail,@emailSubject,@emailBody);

INSERT INTO Staff_Receives_Email
(time_stamp,sender_user_name,recipient_username)
VALUES 
(@ts,@recipientUsername,@senderUsername);


--10: Abullah------------------------------------------------------------------------------------------------------------------------------------------------

--Staff Member user story no.10:- 
--Staff member can view the Announcement made in his company within the past 21 days
--The procedure takes the staff member username as an input.
--Gets the announcements that are in the same company as the Staff Member
--Checks whether the date of the announcements is in difference less than 21 from the current time/date

GO
CREATE PROC ViewLatestAnnouncementsSP
@userName VARCHAR(150)
AS
SELECT a.*
	FROM Announcements a INNER JOIN Staff_Members sm
	ON sm.company_domain = a.company_domain
	WHERE a.company_domain = sm.company_domain 
	AND  sm.user_name=@userName  
	AND DATEDIFF(DAY, a.date, CURRENT_TIMESTAMP) < 21
---------------------------------------------------------------------------------------------------------------------------------------------------------
--	“As an HR employee, I should be able to ...”
--------------------------------------------------------------------------------------------------------------------------------------------------------------

--1: Reda----------------------------------------------------------------------
-- HR employee story no.1 Add a new job that belongs to my department
-- AddJobSP takes the all the job related info as input, checks whether
-- the hr employee is adding a job to the same company as his or not
-- and when the check is true a new job is inserted with the input info
GO
CREATE PROC AddJobSP
@hrUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@applicationDeadline DATETIME,
@detailedDescription TEXT,
@minYearsExperience INT,
@salary INT,
@shortDescription TEXT,
@vacancies INT,
@workingHours INT,
@operationStatus INT OUTPUT
AS
IF NOT EXISTS
(
SELECT hr.*
FROM HR_Employees hr INNER JOIN Staff_Members sm
ON hr.user_name = sm.user_name
WHERE (hr.user_name = @hrUserName AND sm.department_code = @departmentCode AND sm.company_domain = @companyDomain )
)
SET @operationStatus = 0; -- This HR employee is trying to add a job that is not in his department
ELSE
BEGIN
INSERT INTO Jobs
(job_title,department_code,company_domain,application_deadline,detailed_description,min_years_experience,salary,short_description,vacancies,working_hours)
VALUES
(@jobTitle,@departmentCode,@companyDomain,@applicationDeadline,@detailedDescription,@minYearsExperience,@salary,@shortDescription,@vacancies,@workingHours)
SET @operationStatus = 1; --successful job addition 
END
-- AddQustionSP taeks the question title and its answer as input, 
-- and insert a new question record with this info to the Questions table
GO
CREATE PROC AddQuestionSP
@questionTitle VARCHAR(700),
@answer BIT
AS
INSERT INTO Questions
(question_title,answer)
VALUES
(@questionTitle,@answer)

-- AddQuestionToJobSP takes the job info and the target question id as input  inserts the
-- this info to the Job_Have_Questions as input to link the job with the target question in
-- that table
GO
CREATE PROC AddQuestionToJobSP --check if the question is in the question list first .. just in case
@questionID INT,
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
INSERT INTO Jobs_Have_Questions
(question_id,job_title,department_code,company_domain)
VALUES(@questionID,@jobTitle,@departmentCode,@companyDomain)

--2: Gharam---------------------------------------------------------------------------------------------------------------------------------------------------
--HR User Stories no.2: The procedures outputs informations about a Job in the HR's Department
--The procedure takes as inputs the HR's username and the Jobtitle, department Code and Compnay name of the Job he/she wants to view 
--If this job is not in the same department as the HR, then the procedure will output false.
--Otherwise, the procedure outputs the information of this job (ture/1)


GO
CREATE PROC ViewJobInformationSP 
@username VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@operationStatus BIT OUTPUT
AS
IF( NOT EXISTS
(
SELECT *
FROM Staff_Members
WHERE Staff_Members.user_name = @username AND
Staff_Members.department_code = @departmentCode
AND Staff_Members.company_domain =@companyDomain
))
SET @operationStatus = 0
ELSE
BEGIN
SELECT *
FROM Jobs j
WHERE j.job_title = @jobTitle AND
j.department_code = @departmentCode AND
j.company_domain = @companyDomain
SET @operationStatus = 1
END
--3: Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------
--HR User Stories no.3:- In this procedure, HR can edit Job info in his/her department.
--The procedure takes as inputs the Username of the HR, the jobtitle,departmentCode, and company domain (primary keys) of the job he/she wants to edit.
--Then, The HR has the choice to give any of the following inputs to be updated in the table:-
--1.application Deadline  2.detailed Description  3.min Years Experience 4.salary 5.shortDescription 6.vacancies 7. working Hours
--If the HR didn't add values for certain inputs, their corresponding attributes won't change
--If the job is not in the department of the HR, the procedure return false(0), and the HR can't edit it 
--Otherwise , the procedure updates the table jobs according to the given inputs, returning true (1) 
GO
CREATE PROC EditJobInfoSP
@hrUsername VARCHAR(30),
@job_title VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@applicationDeadline DATETIME =NULL,
@detailedDescription TEXT = NULL,
@minYearsExperience INT = NULL,
@salary INT = NULL,
@shortDescription TEXT = NULL,
@vacancies INT = NULL , 
@workingHours INT = NULL ,
@operationStatus BIT OUTPUT
AS
IF( NOT EXISTS
(
SELECT *
FROM Staff_Members
WHERE Staff_Members.user_name = @hrUsername AND
Staff_Members.department_code = @departmentCode
AND Staff_Members.company_domain =@companyDomain
))
SET @operationStatus = 0
ELSE
BEGIN
IF(@applicationDeadline IS NOT NULL)
UPDATE Jobs
SET application_deadline= @applicationDeadline
WHERE job_title=@job_title AND
department_code=@departmentCode AND 
company_domain=@companyDomain
IF(@detailedDescription IS NOT  NULL)
UPDATE Jobs
SET detailed_description= @detailedDescription
WHERE job_title=@job_title AND
department_code=@departmentCode AND
company_domain=@companyDomain 
IF(@minYearsExperience IS NOT NULL)
UPDATE Jobs 
SET min_years_experience= @minYearsExperience 
WHERE job_title=@job_title AND 
department_code=@departmentCode AND 
company_domain=@companyDomain 
IF(@salary IS NOT NULL)
UPDATE Jobs
SET salary = @salary
WHERE job_title=@job_title AND 
department_code=@departmentCode AND
company_domain=@companyDomain
IF(@shortDescription IS NOT NULL)
UPDATE Jobs 
SET short_description = @shortDescription 
WHERE job_title=@job_title AND 
department_code=@departmentCode AND 
company_domain=@companyDomain 
IF(@vacancies IS NOT NULL)
UPDATE Jobs 
SET vacancies= @vacancies 
WHERE job_title=@job_title AND 
department_code=@departmentCode AND 
company_domain=@companyDomain 
IF(@workingHours IS NOT NULL)
UPDATE Jobs 
SET working_hours = @workingHours 
WHERE job_title=@job_title AND 
department_code=@departmentCode AND 
company_domain=@companyDomain 
SET @operationStatus = 1
END 

--4: Abdullah----------------------------------------------------------------------------------------------------------------------------------------------- 

--HR User Stories No.4: The HR can view new applications (that has no responses yet, basically 'Pending') for a specific job in his department.
--The procedure takes as inputs the HR's username and job title, department code, and company domain (primary keys for table job) he/she wants to view applications for.
--So, the procedure first checks if this job is within the HR's departments.
--If it's not, the procedure ouputs 0 (false), and The HR won't view it.
--Otherwisem, the procedure shows All new Applications, and outputs 1 (true)
GO
CREATE PROC ViewNewApplicationsSP
@hrUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS
(
SELECT *
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode AND sm.user_name = @hrUserName --AND sm.company_domain=@companyDomain ??
)
SET @operationStatus = 0
ELSE
BEGIN
SELECT *
FROM Applications a
WHERE a.job_title = @jobTitle AND
a.department_code = @departmentCode AND
a.company_domain = @companyDomain AND
a.app_status = 'Pending' AND
a.hr_response_app IS NULL AND
a.manager_response_app IS NULL
SET @operationStatus = 1
END

--5: Reda------------------------------------------------------------------------------------------------------------------------------------------------
--HR user stories no.5: HR can accept or reject Applications for jobs in his department.
--The procedure takes as inputs the HR's username and the Job seeker username, jobtitle, department code, and company domain of the Application he/she
--wants to respond to. The HR gives his/her response in @hrResponse
--The procedure check first if the application is in a job in the HR's department.
--If not, the HR can't respond to it, and the procedure returns 0 (false)
--Otherwise, the procedure update the table Applications, adding the HR's response to column hr_response and returning 1 (true)

GO
CREATE PROC AddHrResponseSP
@seekerUserName VARCHAR(30),
@hrUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@hrResponse VARCHAR(20),
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS
(
SELECT *
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode AND
sm.user_name = @hrUserName
)
SET @operationStatus = 0
ELSE
BEGIN
UPDATE Applications
SET hr_response_app = @hrResponse , hr_username = @hrUserName
WHERE (Applications.seeker_username = @seekerUserName AND 
Applications.job_title = @jobTitle AND 
Applications.department_code = @departmentCode AND 
Applications.company_domain = @companyDomain)
SET @operationStatus = 1
END
--6: Gharam------------------------------------------------------------------------------------------------------------------------------------------------------

--HR user stories no.6:- The HR can post announcements to his/her company to inform the staff members about new updates
--The procedure takes as inputs HR's username, and the entries to create an instance in the announcement table: title, description, type
--We got the company domain name of the HR using his/her username.
--Then, insert into table Announcements a record with the title, description, type , given by the HR, and the company domain.  
GO
CREATE PROC HRPostsAnnouncementSP 
@username varchar(30),
@title VARCHAR(280) ,
@description TEXT ,
@type VARCHAR(20) 
AS
DECLARE @domainName varchar(150)
SELECT @domainName=company_domain
FROM Staff_Members
WHERE @username=user_name
AND @username 
IN ( SELECT * FROM HR_Employees)
INSERT INTO Announcements 
VALUES (CONVERT (date, SYSDATETIMEOFFSET()),@domainName,@title,@username,@description,@type)



--7: Yasmine---------------------------------------------------------------------------------------------------------------------------

--HR User Stories no.7: 
--The HR can View requests (business or leave) approved by manager only of staff members in the same department as the HR 
--The procedure takes as inputs the HR's username and his/her department info (department Code and company domain)
--First, we check if the HR member belongs to this department.If not, the procedure just return false (0).
--Otherwise,
--We select info that we want to display from the Requests table. 
--The procedure shows info from three tables: HR_Employees_Replace_HR_Employees, Regular_Employees_Replace_Regular_Employees,and Managers_Replace_Managers 
--Each represents the requests info for HR, Regular, and Manager, respectively.
--The procedure also filters out requests that are for staff members not in the HR's department, and selects requests that are accepted bt the manager only.
--After knowing the request ID's, the HR can then view the Request info based on whether it is a Business trip request or a leave request.
--If it's a leave request, the HR views its type
--If it's a trip purpose request, The HR views its trip purpose and destination

GO 
CREATE PROC ViewRequestsSP
@hrUsername VARCHAR(30),
@departmentCode VARCHAR(30), 
@companyDomain VARCHAR(150),
@operationStatus BIT OUTPUT
AS
IF EXISTS (
SELECT *
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode AND sm.user_name = @hrUserName 
)
BEGIN
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,mrm.user_name_request_owner,mrm.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN Managers_Replace_Managers mrm 
ON r.request_id = mrm.request_id
WHERE mrm.user_name_request_owner IN (
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req = 'Accepted'
UNION
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,hrh.user_name_request_owner,hrh.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN HR_Employees_Replace_HR_Employees hrh
ON r.request_id = hrh.request_id
WHERE hrh.user_name_request_owner IN(
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req = 'Accepted' 
UNION
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,rrr.user_name_request_owner,rrr.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN Regular_Employees_Replace_Regular_Employees rrr
ON r.request_id = rrr.request_id
WHERE rrr.user_name_request_owner IN (
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req = 'Accepted'
SET @operationStatus = 1
END
ELSE 
SET @operationStatus = 0

GO
CREATE PROC ShowRequestInfoSP
@hrUserName VARCHAR(30),
@requestID INT
AS
IF EXISTS(
SELECT *
FROM Leave_Requests
WHERE Leave_Requests.request_id = @requestID
)
SELECT type
FROM Leave_Requests
WHERE request_id = @requestID
ELSE 
SELECT trip_purpose, trip_destination
FROM Business_Trip_Requests 

--8: Yasmine------------------------------------------------------------------------------------------------------------------------------------------ 

--HR user stories No.8: The HR give the final respond for the requests, and takes into
--consideration that if the duration of the request includes the staff member’s weekly day-off and/or
--Friday, they should not be counted as annual leaves.
--So the procedure takes as inputs the HR username, the requestID , and the HR response. 
--The procedure 1st check if the requests  are accepted by the manager only. 
--Then, we check if the HR response accepted the Request. If yes we'll update the requests table and the annual leaves. 

CREATE PROC RespondHRToRequestSP
@hrUserName VARCHAR(30),
@requestID INT,
@hrResponse VARCHAR(10)
AS
DECLARE @noOfLeaveDays INT
DECLARE @staffUserName VARCHAR(30)
UPDATE Requests
SET hr_user_name = @hrUserName,
hr_response_req = @hrResponse
WHERE manager_response_req = 'Accepted' AND
request_id = @requestID
IF(@hrResponse = 'Accepted')
BEGIN
SELECT @noOfLeaveDays = no_of_leave_days 
FROM Requests
WHERE request_id = @requestIDgi
UPDATE Staff_Members
SET no_annual_leaves = no_annual_leaves - @noOfLeaveDays
WHERE Staff_Members.user_name IN(
SELECT Managers_Replace_Managers.user_name_request_owner
FROM Managers_Replace_Managers
WHERE request_id = @requestID
UNION
SELECT user_name_request_owner
FROM Regular_Employees_Replace_Regular_Employees
WHERE request_id = @requestID
UNION
SELECT user_name_request_owner
FROM HR_Employees_Replace_HR_Employees
WHERE request_id = @requestID
)
END



--9: Abdullah ----------------------------------------------------------------------------------------------------------------------------------------

--HR user stories no.9:-
--The HR can view the attendance records of any staff member in my department (check-in time, check-out time,
--duration, missing hours) within a certain period of time.
--The procedure takes as inputs the HR's username, and the username of the Regular employee whose attendance will be viewed, and the start and end period of the attendance
--records. 

GO
CREATE PROC ViewAttendanceOfStaffSP
@hrUserName VARCHAR(30),
@regularUserName VARCHAR(30),
@periodStart DATETIME,
@periodEnd DATETIME,
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS(
SELECT *
FROM Staff_Members sm1 INNER JOIN Staff_Members sm2
ON sm1.department_code = sm2.department_code AND
sm1.company_domain = sm2.company_domain
WHERE sm1.user_name = @hrUserName AND 
sm2.user_name = @regularUserName
)
SET @operationStatus = 0
ELSE
BEGIN
SELECT a.*
FROM Attendances a
WHERE (DATEDIFF(DAY,@periodStart,a.start_time)>=0 AND DATEDIFF(DAY,@periodEnd,a.start_time) <=0)
SET @operationStatus = 1
END

--10: Reda----------------------------------------------------------------------------------------------------------------------------------

--HR user stories no.10:- 
--The HR can view the total number of hours for any staff member in my department in each month of a certain year.
--The procedure takes as inputs the HR's username, Staff Member's username, and the year he/she wants to view records for.
--The procedure first checks that the HR username and Staff Member username are in the same department.
--If not the procedure outputs false. (0)
--Otherwise, we group by the month, and sum the working hours for the staff member in each month, returning true (1).

GO

CREATE PROC ViewYearlyAttendanceOfStaffSP
@hrUserName VARCHAR(30),
@staffUserName VARCHAR(30),
@year INT,
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS(
SELECT *
FROM Staff_Members sm1 INNER JOIN Staff_Members sm2
ON sm1.department_code = sm2.department_code AND
sm1.company_domain = sm2.company_domain
WHERE sm1.user_name = @hrUserName AND 
sm2.user_name = @staffUserName
)
SET @operationStatus = 0
ELSE
BEGIN
SELECT MONTH(a.start_time) AS month ,SUM(a.duration) AS working_hours
FROM Attendances a
WHERE YEAR(a.start_time) = @year AND a.user_name = @staffUserName
GROUP BY MONTH(a.start_time)
SET @operationStatus = 1
END

--11: Gharam-------------------------------------------------------------------------------------------------------------------------------------------

--HR user stories no.11:- 
--View names of the top 3 high achievers in my department. A high achiever is a regular employee
--who stayed the longest hours in the company for a certain month and all tasks assigned to him/her with deadline within this month are fixed.
--The procedure order the records descendignly by the duration, selecting the staff member that has a Tasks status 'Fixed'  

GO
CREATE PROC ViewTop3RegularSP
AS
SELECT TOP 3 first_name+' '+ last_name AS full_name, SUM(a.duration) AS working_hours
FROM Attendances a INNER JOIN
(SELECT mtr.regular_user_name AS user_name
FROM Tasks t INNER JOIN Managers_Assign_Tasks_To_Regulars mtr
ON t.deadline = mtr.task_deadline AND
t.project_name = mtr.project_name AND
t.name = mtr.task_name
WHERE t.status = 'Fixed' AND
MONTH(t.deadline) = MONTH(GETDATE())) Regulars_Have_Fixed_Tasks 
ON a.user_name = Regulars_Have_Fixed_Tasks.user_name 
INNER JOIN Users u
ON Regulars_Have_Fixed_Tasks.user_name = u.user_name 
WHERE MONTH(a.start_time) = MONTH(GETDATE())
GROUP BY first_name + ' '+ last_name
ORDER By SUM(a.duration) desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------

--“As a regular employee, I should be able to ...”

-------------------------------------------------------------------------------------------------------------------------------------------------------------


--1: Abdullah-

--Regular Emplyees User Stories no.1: 
--The regular employe can view all projects assigned to him/her with their info.
--The procedure simply takes the regular username as input.
--it then selects from the Project table and the Assigning table for Regular Employees
--and displays the records for the regular employee

GO
CREATE PROC ViewProjectsOfEmployeeSP
@userName VARCHAR(30)
AS 
SELECT p.*
FROM Projects p INNER JOIN Managers_Assign_Projects_To_Regulars mapr 
ON p.project_name = mapr.project_name
WHERE mapr.regular_user_name = @userName


--2:Reda----------------------------------------------------------------------------

--Regular Employees User Stories No.2:- 
--The regular employee can view tasks in a certain project assigned to him/her
--The procedure takes as inputs the username of the regular employee and the name of the project he/she wants to view tasks for
--If the regular employee does not have tasks in this project ,, the procedure outputs false (0)
--Otherwise, the regular employee can view the info

GO
CREATE PROC ViewTasksInProjectSP 
@projectName VARCHAR(100),
@userName VARCHAR(30),
@operationStatus BIT OUTPUT
AS
IF EXISTS ( --If this regular employee has tasks in this project 
SELECT *
FROM Managers_Assign_Tasks_To_Regulars mar
WHERE mar.regular_user_name=@userName AND mar.project_name=@projectName
           )
BEGIN
SELECT t.*
FROM Tasks t INNER JOIN Managers_Assign_Tasks_To_Regulars mar
ON t.deadline = mar.task_deadline AND t.name = mar.task_name AND t.project_name = mar.project_name
WHERE ( t.project_name = @projectName AND mar.regular_user_name = @userName)
SET @operationStatus = 1
END
ELSE 
SET @operationStatus = 0


--3:Gharam------------------------------------------------------------------------------------

--Regular Emloyees User Stories no.3:-
--After finalizing a task, I can change the status of this task to ‘Fixed’ as long as it did not pass the deadline.
--The procedure takes as inputs username of the regular employee and the task name and deadline and project name (Primary Keys of the Tasks Table).
--The Procedure 1st checks if the deadline of the task did not pass, 
--If it did pass , the procedure outputs false (0)
--Otherwise, it changes the status of the procedure to 'Fixed', returning true (1).


GO
CREATE PROC FinalizeTaskSP
@username VARCHAR(30),
@taskName VARCHAR(30),
@deadline DATETIME, 
@projectName VARCHAR(100),
@operationStatus BIT OUTPUT
AS 
IF NOT EXISTS  (
SELECT *
FROM Managers_Assign_Tasks_To_Regulars m
WHERE @username=m.regular_user_name 
AND @taskName = m.task_name 
AND @deadline = m.task_deadline 
AND @projectName = m.project_name 
AND DATEDIFF(DAY,CURRENT_TIMESTAMP,@deadline) >= 0)
SET @operationStatus = 0
ELSE
BEGIN
UPDATE Tasks
SET status='Fixed'
WHERE  @taskName=name
AND @deadline=deadline 
AND project_name=@projectName
SET @operationStatus = 1
END

--4: Yasmine---------------------------------------------------------------------------------------------------------------------------------------------


--Regular Employees User Stories no.4:- 
--Work on the task again (a task that was assigned to me before). I can change the status of this
--task from ‘Fixed’ to ‘Assigned’ as long as the deadline did not pass and it was not reviewed by the manager yet.
--The procedure takes the username of the regular employee, the status of the task he/she wants to edit, and the task name, deadline , 
--and project name (primary keys for table Tasks)... 
--The Procedure 1st checks if the deadline of the task did not pass, and if the status of the task is fixed.
--If the deadline passed or the status is fixed, the procedure outputs false.
--otherwise, the task status is updated, returning true (1).

GO 
CREATE PROC ChangeTaskStatusSP
@username VARCHAR(30),
@taskName VARCHAR(30),
@deadline DATETIME,
@projectName VARCHAR(100),
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS (
SELECT *
FROM Managers_Assign_Tasks_To_Regulars m INNER JOIN Tasks t
ON t.name = m.task_name
AND t.deadline = m.task_deadline
AND t.project_name = m.project_name
WHERE @username = m.regular_user_name 
AND @taskName = m.task_name 
AND @deadline = m.task_deadline 
AND @projectName = m.project_name 
AND DATEDIFF(DAY,GETDATE(),@deadline) >= 0
AND t.status = 'Fixed')
SET @operationStatus =0
ELSE
BEGIN 
UPDATE Tasks 
SET Tasks.status ='Assigned'
WHERE Tasks.name=@taskName
AND Tasks.deadline=@deadline 
AND Tasks.project_name=@projectName 
AND Tasks.status = 'Fixed'
AND DATEDIFF(DAY,GETDATE(),@deadline) >= 0
SET @operationStatus = 1
END





-------------------------------------------------------------------------------------------------------------------------------------------------------------
--“As a manager, I should be able to ...

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--1: Gharam--------------------------------------------------------------------------------------------------------------------------------------------------

--Managers User Stories No.1:-
--Managers can view new requests from staff members working in my department. 
--The procedure takes as inputs the manager's username and the department code and the company domain (primary keys for Departments table)
--If the manager is of type HR, he/she can view requests of all three (Managers, Regular Employees, and HR Employees) in the same department.
--So, we first check if the manager is of type HR, then we select columns we want to show from three Inner Joins:- 
--1. Table Requests and the Relational table for Managers
--2. Table Requests and the Relational table for Regular Employees
--3.Table Requests and the Relational table for HR Employees
--If the manager is not of type HR, he/she can view requesrs of onlt (Managers and Regular Employees)
--So, we then let that manager view the selected columns from only two inner joins:-
--1. Table Requests and the Relational table for Managers
--2. Table Requests and the Relational table for Regular Employees
--For each select we check if the manager's department and the request owner's department are the same.

GO
CREATE PROC ViewEmployeesRequestsSP 
@managerUserName VARCHAR(30),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
IF EXISTS(
SELECT *
FROM Managers m
WHERE m.user_name = @managerUserName
AND m.type = 'HR'
)
BEGIN
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,mrm.user_name_request_owner,mrm.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN Managers_Replace_Managers mrm 
ON r.request_id = mrm.request_id
WHERE mrm.user_name_request_owner IN (
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req IS NULL
UNION
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,hrh.user_name_request_owner,hrh.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN HR_Employees_Replace_HR_Employees hrh
ON r.request_id = hrh.request_id
WHERE hrh.user_name_request_owner IN(
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req IS NULL 
UNION
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,rrr.user_name_request_owner,rrr.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN Regular_Employees_Replace_Regular_Employees rrr
ON r.request_id = rrr.request_id
WHERE rrr.user_name_request_owner IN (
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req IS NULL
END
ELSE
BEGIN
IF EXISTS(
SELECT *
FROM Managers m
WHERE m.user_name = @managerUserName
)
BEGIN
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,mrm.user_name_request_owner,mrm.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN Managers_Replace_Managers mrm 
ON r.request_id = mrm.request_id
WHERE mrm.user_name_request_owner IN (
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req IS NULL
UNION
SELECT r.request_id, r.request_date, r.start_date, r.end_date,r.no_of_leave_days,rrr.user_name_request_owner,rrr.user_name_replacer,r.hr_user_name,r.hr_response_req,r.manager_user_name,r.manager_response_req,r.reason_of_disapproval
FROM Requests r INNER JOIN Regular_Employees_Replace_Regular_Employees rrr
ON r.request_id = rrr.request_id
WHERE rrr.user_name_request_owner IN (
SELECT sm.user_name
FROM Staff_Members sm
WHERE sm.department_code = @departmentCode
) AND r.manager_response_req IS NULL
END
END
--2: Abdullah ---------------------------------------------------------------------------------------------------------------------------

--Managers User Stories no.2:
--The manager can respond to requests of Staff members in the same department as the Manager.
--The procedure takes as inputs the Manager username, and the staff member username, the manager's response, and reason of disapproval..
--If the request is rejected and Reason of diaspproval is not, the procedure won't update the Requests table.. It will output 0 (false)
--If the status is status is accepted, reason of disapproval is set to NULL.
--Then, we update the Request record that corresponds to the request id,,, 
--We have 3 relational tables for HR, Regular, and Manager requests,, so we select from one of them,
--Finally the procedure returns 1 (true)

GO
CREATE PROC AddManagerResponseToRequestSP
@managerUserName VARCHAR(50),
@staffUserName VARCHAR(50),
@managerResponse VARCHAR(10),
@reasonOfDisapproval TEXT = NULL,
@operationStatus BIT OUTPUT
AS
IF EXISTS
(
SELECT*
FROM Staff_Members sm1 INNER JOIN Staff_Members sm2
ON sm1.department_code = sm2.department_code
WHERE sm1.user_name = @managerUserName 
AND sm2.user_name = @staffUserName
)
BEGIN
IF(@managerResponse='Rejected' AND  @reasonOfDisapproval is NULL)
SET @operationStatus = 0;
ELSE 
BEGIN 
IF(@managerResponse = 'Accepted')
SET @reasonOfDisapproval = NULL

UPDATE Requests 
	SET Requests.manager_response_req = @managerResponse, Requests.reason_of_disapproval = @reasonOfDisapproval, Requests.manager_user_name = @managerUserName
	WHERE request_id 
	IN (
	(SELECT request_id
	FROM Regular_Employees_Replace_Regular_Employees r
	WHERE r.user_name_request_owner = @staffUserName),
   
    (SELECT request_id 
	FROM HR_Employees_Replace_HR_Employees h 
	WHERE h.user_name_request_owner = @staffUserName),
	
	(SELECT request_id 
	FROM Managers_Replace_Managers m 
	WHERE m.user_name_request_owner = @staffUserName)
	 )
SET @operationStatus = 1;
END
END
--3: Reda--------------------------------------------------------------------------------------------------------------------------------------




GO
CREATE PROC ViewSeekerInfoSP
@seekerUserName VARCHAR(30)
AS
SELECT u.user_name,u.personal_email,u.birth_date,u.exp_year,u.first_name,u.last_name,u.age
FROM Users u
WHERE (u.user_name = @seekerUserName)

GO
CREATE PROC ViewJobInfoSP
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
SELECT j.*
FROM Jobs j
WHERE (
j.job_title = @jobTitle 
AND j.department_code = @departmentCode 
AND j.company_domain = @companyDomain)

GO
CREATE PROC ViewApprovedJobAppSP
@hrUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@CompanyDomain VARCHAR(150),
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS(
SELECT *
FROM Staff_Members
WHERE Staff_Members.user_name = @hrUserName
AND Staff_Members.department_code = @departmentCode
)
SET @operationStatus = 0
ELSE
BEGIN
SELECT a.*
FROM Applications a
WHERE (
a.job_title = @jobTitle
AND a.department_code = @departmentCode 
AND a.company_domain = @CompanyDomain 
AND a.hr_response_app='Accepted')
END
--4: Yasmine-------------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC RespondToJobApplicationsSP 
@managerUserName VARCHAR(30),
@managerResponse VARCHAR(20),
@seekerUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
IF(@managerResponse = 'Accepted')
UPDATE Applications
SET manager_response_app=@managerResponse, manager_username = @managerUserName, app_status = 'Accepted'
WHERE Applications.hr_response_app = 'Accepted'
AND Applications.seeker_username = @seekerUserName
AND Applications.job_title = @jobTitle
AND Applications.department_code = @departmentCode
AND Applications.company_domain = @companyDomain
ELSE
UPDATE Applications
SET manager_response_app=@managerResponse, manager_username = @managerUserName, app_status = 'Rejected'
WHERE Applications.hr_response_app = 'Accepted'
AND Applications.seeker_username = @seekerUserName
AND Applications.job_title = @jobTitle
AND Applications.department_code = @departmentCode
AND Applications.company_domain = @companyDomain


--5: Abdullah-------------------------------------------------------------------------------------------------------

GO
CREATE PROC DefineNewProject
@managerUserName VARCHAR(30),
@startDate DATETIME,
@endDate DATETIME,
@projectName VARCHAR(100)
AS
INSERT Projects (project_name,manager_user_name,start_date,end_date)
Values(@projectName,@managerUserName,@startDate,@endDate)

--6: Reda--------------------------------------------------------------------------------------------------------------
GO
CREATE PROC AssignRegularToProjectSP
@regularUserName VARCHAR(30),
@projectName VARCHAR(100),
@managerUserName VARCHAR(30),
@operationStatus INT OUTPUT
AS
IF (
SELECT COUNT(*)
FROM Managers_Assign_Projects_To_Regulars mapr
WHERE mapr.regular_user_name = @regularUserName
) = 2
SET @operationStatus = 0 --the employee is working on 2 project, you can't assign him to more projects
ELSE
IF NOT EXISTS
(
SELECT *
FROM Staff_Members s1, Staff_Members s2
WHERE (s1.department_code = s2.department_code
AND s1.user_name = @managerUserName
AND s2.user_name = @regularUserName
)
)
SET @operationStatus = 1 --the regular is not in the same department as the manager
ELSE
IF  (
SELECT COUNT(*)
FROM Managers_Assign_Projects_To_Regulars
WHERE regular_user_name = @regularUserName
AND project_name = @projectName
) = 1
SET @operationStatus = 2 --the regular is already assigned to the project.
ELSE
BEGIN
INSERT INTO Managers_Assign_Projects_To_Regulars
(manager_user_name,regular_user_name,project_name)
VALUES (@managerUserName,@regularUserName,@projectName)
SET @operationStatus = 3 --successful assignment
END
--7: Gharam----------------------------------------------------------------------------------------------------------- 

GO
CREATE PROC RemoveRegularFromProjectSp
@username VARCHAR(30),
@project VARCHAR(100)
AS
IF NOT EXISTS 
( SELECT M.regular_user_name FROM Managers_Assign_Tasks_To_Regulars M , TASKS t
WHERE @username=M.regular_user_name 
AND t.name=M.task_name 
AND t.project_name=M.project_name 
AND t.deadline=M.task_deadline 
AND t.status='Assigned')


DELETE Managers_Assign_Projects_To_Regulars
WHERE @username=regular_user_name


--8: Yasmine------------------------------------------------------------------------------------------------------------------------------------
GO 
CREATE PROC DefineTaskSP
@managerUsername VARCHAR(30),
@projectName VARCHAR(100), 
@deadline DATETIME, 
@taskName VARCHAR(30),
@operationStatus BIT OUTPUT
AS
IF NOT EXISTS ( 
SELECT *
FROM Staff_Members s1 INNER JOIN Projects p 
ON s1.user_name = p.manager_user_name
INNER JOIN Staff_Members s2
ON s2.department_code = s1.department_code
WHERE @managerUsername = p.manager_user_name
)
SET @operationStatus = 0
ELSE
BEGIN 
INSERT INTO Tasks (project_name,deadline,name,status)
VALUES (@projectName, @deadline, @taskName , 'Open')
SET @operationStatus = 1
END
--9: Reda ------------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC AssignRegularToTaskSP
@projectName VARCHAR(100),
@userName VARCHAR(30),
@regularUserName VARCHAR(30),
@taskName VARCHAR(30),
@taskDeadline DATETIME
AS
IF EXISTS(
SELECT *
FROM Managers_Assign_Projects_To_Regulars mapr
WHERE (mapr.project_name = @projectName AND mapr.regular_user_name = @regularUserName)
)
INSERT INTO Managers_Assign_Tasks_To_Regulars
(manager_user_name,task_name,task_deadline,project_name)
VALUES (@userName,@taskName,@taskDeadline,@projectName)


--10: Gharam----------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC ReplaceRegularSp 
@username VARCHAR(30),
@taskName VARCHAR(30),
@deadline DATETIME,
@project VARCHAR(100) --THIS ONLY TAKES THE ONE WHO IS GOING TO REPLACE NOT THE THE one being replaces 
AS
IF  EXISTS
( SELECT M.regular_user_name 
FROM Managers_Assign_Tasks_To_Regulars M , TASKS t
WHERE   t.name=M.task_name 
AND t.project_name=M.project_name
AND t.deadline=M.task_deadline 
AND @taskName=t.name AND @project=t.project_name
AND @deadline=t.deadline 
AND t.status='Assigned')

UPDATE Managers_Assign_Tasks_To_Regulars 
SET Regular_user_name=@username
WHERE @taskName=task_name 
AND @deadline=task_deadline
AND @project=project_name 

--11: Yasmine---------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC ViewTasksSP --project name is already in the table task u don't have to join !
@project VARCHAR(100), @status VARCHAR(10)
AS 
SELECT T.*
FROM Task T inner join Project P on T.project_name = P.project_name
WHERE T.project_name = @project AND T.status=@status

--12: Abdullah-------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC ReviewTaskSP
@managerUserName VARCHAR(50),
@projectName VARCHAR(100),
@tasksName VARCHAR(30),
@response VARCHAR(10), 
@newDeadline DATETIME
AS
BEGIN
IF(@response='Accepted')
	UPDATE Tasks
		SET Tasks.status = 'Closed'
		WHERE Tasks.name= @tasksName AND Tasks.project_name = @projectName 
ELSE
IF(@response = 'Rejected')
	UPDATE Tasks
		SET Tasks.status= 'Assigned', Tasks.deadline = @newDeadline;
END
------------------------FUNCTIONS----------------------------------------------------
GO
CREATE FUNCTION MakeCompanyEmail
( @userName VARCHAR(30),
  @companyDomain VARCHAR(150)
)
RETURNS VARCHAR(180)
BEGIN
DECLARE @email VARCHAR(180)
SET @email =  @userName+'@'+@companyDomain
RETURN @email
END


GO
CREATE FUNCTION GetMissingHours
(
@userName VARCHAR(30),
@startTime DATETIME,
@leaveTime DATETIME
)
RETURNS INT
BEGIN

DECLARE @workingHours INT
DECLARE @duration INT
DECLARE @missingHours INT
SET @duration = DATEPART(HOUR,@leaveTime) - DATEPART(HOUR,@startTime)
SELECT @workingHours = j.working_hours
FROM Staff_Members s INNER JOIN Jobs j
ON s.job_title = j.job_title AND s.department_code = j.department_code AND s.company_domain = j.company_domain
WHERE s.user_name = @userName 
IF( (@workingHours - @duration) < 0)
SET @missingHours = 0
ELSE
SET @missingHours = @workingHours - @duration
RETURN @missingHours
END



GO
CREATE FUNCTION CheckJobTitle
(@jobTitle VARCHAR(150))
RETURNS BIT
AS
BEGIN
DECLARE @returnedBit BIT
IF(@jobTitle LIKE 'Manager%' OR @jobTitle LIKE 'HR%' OR @jobTitle LIKE 'Employee%')
SET @returnedBit = '1'
ELSE
SET @returnedBit ='0'
RETURN @returnedBit
END

GO
CREATE FUNCTION NumberOfDays(@requestID INT,@startDate DATETIME , @endDate DATETIME)
RETURNS INT
AS
BEGIN 
DECLARE @totaldays INT
DECLARE @weekenddays INT
DECLARE @weekEndDay INT
DECLARE @dayOff VARCHAR(10)
DECLARE @userName VARCHAR(30)
IF EXISTS(
SELECT *
FROM Managers_Replace_Managers
WHERE request_id = @requestID
)
SELECT @userName = mrm.user_name_request_owner
FROM Managers_Replace_Managers mrm
WHERE mrm.request_id = @requestID
ELSE IF EXISTS(
SELECT *
FROM Regular_Employees_Replace_Regular_Employees rrr
WHERE rrr.request_id = @requestID
)
SELECT @userName = rrr.user_name_request_owner
FROM Regular_Employees_Replace_Regular_Employees rrr
WHERE rrr.request_id = @requestID
ELSE IF EXISTS(
SELECT *
FROM HR_Employees_Replace_HR_Employees hrh
WHERE hrh.request_id = @requestID
)
SELECT @userName = hrh.user_name_request_owner
FROM HR_Employees_Replace_HR_Employees hrh
WHERE hrh.request_id = @requestID

SELECT @dayOff = sm.day_off
FROM Staff_Members sm
WHERE sm.user_name = @userName

SET @weekEndDay = CASE @dayOff
WHEN 'Saturday' THEN  0
WHEN 'Sunday'   THEN  1 
WHEN 'Monday'   THEN  2
WHEN 'Tuesday'  THEN  3
WHEN 'Wednesday'THEN  4
WHEN 'Thursday' THEN  5
ELSE 6
END

SET @totaldays = DATEDIFF(DAY, @startDate, @endDate) 
SET @weekenddays = ((DATEDIFF(WEEK, @startDate, @endDate) * 2) + 
                       CASE WHEN DATEPART(WEEKDAY, @startDate) = @weekEndDay THEN 1 ELSE 0 END + 
					   CASE WHEN DATEPART(WEEKDAY, @startDate) = 6 THEN 1 ELSE 0 END +
					   CASE WHEN DATEPART(WEEKDAY, @endDate)   = @weekEndDay THEN 1 ELSE 0 END +
                       CASE WHEN DATEPART(WEEKDAY, @endDate)   = 6 THEN 1 ELSE 0 END)
			

RETURN (@totaldays - @weekenddays)
END