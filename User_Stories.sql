DROP PROC AddManagerResponseToRequestSP;
DROP PROC ViewProjectsOfEmployeeSP;
DROP PROC ReplaceRegularHelperSP;
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
DROP PROC ApplyForLeaveRequestSP;
DROP PROC ReplaceManagerSP;
DROP PROC ReplaceRegularSP;
DROP PROC ReplaceHRSP;
DROP PROC FindTypeOfReplacementSp;
DROP PROC RemoveRegularFromProjectSp
DROP PROC RegularFinalizesTaskSP;
DROP PROC HRPostsAnnouncementSP 
DROP PROC ViewReceivedEmailsSP;
DROP PROC StaffCheckInSp;
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
DROP PROC ViewJobStatusSP;
DROP PROC CheckOutSP;
DROP PROC ViewTasksSP;
DROP PROC RespondToJobApplicationsSP;
DROP PROC DefineTaskSP;
DROP PROC ChangeTaskStatusSP;
DROP PROC EditJobInfoSP;
DROP PROC RegisterToWebsite;
DROP PROC ApplyForBusinessRequestSP;
DROP PROC ViewRequestsSP;
DROP PROC ViewLatestAnnouncementsSP;
DROP PROC SearchCompanyByNameSP;
DROP PROC SearchCompanyByAddressSP;
DROP PROC SearchCompanyByTypeSP;
DROP PROC ViewUserInfoSP;
DROP PROC DefineNewProject;
DROP PROC ReviewTaskSP;
DROP PROC ViewJobsWithVacancySP;












---------------------------------------------------------------------------------------------------------------------------------------------------------------

--“As an registered/unregistered user, I should be able to ...”

----------------------------------------------------------------------------------------------------------------------------------------------------------------


--1: Gharam

GO 
CREATE PROC SearchCompanyByNameSP
@keyWord VARCHAR(50)
AS
SELECT c.*
FROM Companies c
WHERE c.name LIKE CONCAT('%',@keyWord,'%');

GO
CREATE PROC SearchCompanyByAddressSP
@keyWord VARCHAR(300)
AS
SELECT c.*
FROM Companies c INNER JOIN Companies_Phones cp
ON c.domain_name = cp.company_domain
WHERE c.address LIKE CONCAT('%',@keyWord,'%')

GO
CREATE PROC SearchCompanyByTypeSP
@keyWord VARCHAR(50)
AS
SELECT c.*
FROM Companies c INNER JOIN Companies_Phones cp
ON c.domain_name = cp.company_domain
WHERE c.type LIKE CONCAT('%',@keyWord,'%')
--2:Yasmine--------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC ViewCompaniesSP 
AS
SELECT C.*,  CP.phone
FROM Companies C LEFT JOIN Companies_Phones CP
ON C.domain_name = CP.company_domain


--3:Abdullah------------------------------------------------------------------------------------------------------------------------------------
GO

CREATE PROC ViewCompanySP 
@companyDomain VARCHAR(150)
AS 
SELECT c.*
FROM Companies c 

WHERE (c.domain_name = @companyDomain)
-- Users story no.3 View the info of a certain company along with the department info
-- ViewDepartmentsPfCompanySP takes the company domain as input and displays the information of the all the departments in that company

GO

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
INSERT INTO Users(user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES(@username,@password,@personalEmail,@birthDate,@expYear,@firstName,@lastName)
SET @operationStatus = 1; --successful registration
END
ELSE
SET @operationStatus = 0; --failed registration

--6:Yasmine-----------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC SearchJobsSP --correct
@keywords TEXT
AS
SELECT j.* 
FROM Jobs j
where j.vacancies > 0 AND j.short_description LIKE CONCAT('%' ,@keywords,'%') OR  j.job_title LIKE CONCAT('%' ,@keywords,'%') 


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

GO
Create PROC ViewUserInfoSP
@userName VARCHAR(30)

AS
SELECT * 
FROM USERS 
WHERE user_name=@username
DROP PROC ViewUserInfoSp;



--3: Yasmine -------------------------------------------------------------------------------------------------------------------------------------------------------
GO

CREATE PROC EditPersonalInfoSP --correct
@username VARCHAR(30),
@password VARCHAR(30),
@personalEmail VARCHAR(70), --Make input nullifiable 
@birthDate DATETIME,
@expYear INT,
@firstName VARCHAR(25),
@lastName VARCHAR(25)
AS
UPDATE Users 
SET
password=@password, 
personal_email=@personalEmail, 
birth_date=@birthDate,
exp_year = @expYear,
first_name = @firstName, 
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
@companyDomain VARCHAR(150)
AS
IF(
NOT EXISTS(
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
)
AND 
EXISTS(
SELECT *
FROM Jobs j INNER JOIN Users u
ON u.exp_year >= j.min_years_experience
WHERE u.user_name = @seekerUserName
)

)
INSERT INTO Applications
(seeker_username,job_title,department_code,company_domain)
VALUES
(@seekerUserName,@jobTitle,@departmentCode,@companyDomain)


--2:Reda-------------------------------------------------------------------------------------------------------------------------- 


GO


CREATE PROC ViewQuetionsInInterviewSP --correct
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
SELECT q.question_title
FROM Questions q INNER JOIN Jobs_Have_Questions jq
ON jq.question_id = q.question_id
WHERE (jq.job_title = @jobTitle AND jq.department_code = @departmentCode AND jq.company_domain = @companyDomain)


--3: Gharam-------------------------------------------------------------------------------------------------------------------------

GO 
CREATE PROC ViewMyScoreSP  --finds the score of a certian job handles job seeker 3
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


--4: Yasmine----------------------------------------------------------------------------------------------------------------------------

GO  --to be edited  ( Yes it does )
CREATE PROC ViewJobStatusSP
@username VARCHAR(30)
AS
Select A.score, A.app_status --Missing score and job title Don't we need to see these next to the JOB title maybe?
FROM Applications A
WHERE A.seeker_username=@username

--5: Abdullah-----------------------------------------------------------------------------------------------------------------------------


--Job Seekers Story no.5 Choose a job from the jobs I was accepted in
-- ChooseJobFromAcceptedAppSP takes the user name of the job seeker, the job information
-- and the day off of choice and checks that the day off chosen is not friday. After that
-- the job seeker is added as a staff member if he satisfies all the constraints, other than taht
-- a statement is printed on the console requiring the user to revise his input values.
GO

CREATE PROC ChooseJobFromAcceptedAppSP 
@seekerUserName VARCHAR(30),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@jobTitle VARCHAR(150),
@dayOff VARCHAR(10)
AS
IF(	EXISTS(
			SELECT * 
			FROM Applications a
			WHERE a.company_domain = @companyDomain AND
			a.department_code = @departmentCode AND
			a.job_title = @jobTitle AND
			a.seeker_username = @seekerUserName AND
			a.app_status = 'Accepted'
			)
			AND
			@dayOff != 'Friday'
	)	
BEGIN
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
END

ELSE
PRINT 'Error Occured, please check back your input values'


--6: Reda------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO

CREATE PROC DeletePendingApplicationSP --correct
@seekerUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
DELETE FROM Applications
WHERE (Applications.seeker_username = @seekerUserName AND Applications.job_title = @jobTitle AND Applications.company_domain = @companyDomain AND Applications.app_status = 'Pending')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--“As a staff member, I should be able to ...”

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1: Gharam

GO
CREATE PROC StaffCheckInSp 
@username VARCHAR(30)
AS
IF EXISTS ( SELECT user_name From Staff_Members where @username=@username AND DATENAME(dw,GETDATE())!='friday') 

INSERT INTO Attendances 
(user_name,date,start_time )

VALUES(@username , CONVERT (date, SYSDATETIMEOFFSET()) ,CONVERT (time, CURRENT_TIMESTAMP)  ) --the rest will be handled by the query after this 
---------------------------------




--2: Yasmine------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC CheckOutSP --Correct but why did u do the join u can just check with the username
@leaveTime DATETIME, @username VARCHAR(30)
AS
UPDATE Attendances 
SET    leave_time = @leaveTime
WHERE  user_name=@username AND NOT EXISTS 
(
SELECT *
FROM Staff_Members S inner Join Attendances A on A.user_name=S.user_name
WHERE A.user_name=@username AND S.day_off = day(@leaveTime)
 )


--3: Reda---------------------------------------------------------------------------------------------------------------
GO
CREATE PROC ViewAttendanceSP --correct
@userName VARCHAR(30),
@periodStart DATETIME,
@periodEnd DATETIME
AS
SELECT a.*
FROM Attendances a
WHERE (DATEDIFF(DAY,@periodStart,a.date)>=0 AND DATEDIFF(DAY,@periodEnd,a.date) <=0)


--4: Gharam--------------------------------------- 
GO
Create PROC FindTypeOfReplacementSp
@username VARCHAR(30),
@username2 VARCHAR(30) ,
@job VARCHAR(30) OUTPUT
AS
IF EXISTS
( SELECT user_name 
FROM HR_Employees 
WHERE @userName =user_name ) 
AND EXISTS ( SELECT user_name 
FROM HR_Employees 
WHERE @userName2 =user_name ) 
SELECT @job='hr'



ELSE IF  EXISTS
( SELECT user_name 
FROM Managers
WHERE @userName =user_name ) 
AND EXISTS( SELECT user_name
FROM Managers
WHERE @userName2 =user_name )  
SELECT @job='Manager'


ELSE IF EXISTS 
( SELECT user_name 
FROM Regular_Employees 
WHERE @userName =user_name )
AND EXISTS 
( SELECT user_name 
FROM Regular_Employees 
WHERE @userName2 =user_name )  
SELECT @job='Regular'
PRINT @JOB



GO




GO
CREATE PROC ReplaceHRSP

@userName VARCHAR(30),
@replacementUserName VARCHAR(30),
@endDate DATETIME ,
@startDate DATETIME
AS

IF NOT EXISTS ( SELECT * FROM HR_Employees_Replace_HR_Employees h1,HR_Employees h2,Requests r WHERE h1.user_name_request_owner=h2.user_name AND r.request_id=h1.request_id
AND r.end_date>=@endDate AND r.start_date<=@startDate ) 
INSERT INTO Requests 
(end_date,request_date,start_date) 
VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate )

DECLARE @requestId INT
SELECT @requestId= MAX(request_id) 
FROM Requests
INSERT INTO HR_Employees_Replace_HR_Employees 
VALUES(@requestId,@replacementUserName,@userName)

EXEC ReplaceHRSP 'ahmed.hussain','ahmed.shehata' ,'05/05/2018','01/01/2018'


DROP PROC  ReplaceManagerSP;
GO

CREATE PROC ReplaceManagerSP

@userName VARCHAR(30), 
@replacementUserName VARCHAR(30),
@endDate DATETIME ,
@startDate DATETIME
AS

IF NOT EXISTS 
( SELECT * 
FROM Managers_Replace_Managers_In_Requests h1,Managers h2,Requests r 
WHERE h1.user_name_request_owner=h2.user_name 
AND r.request_id=h1.request_id
AND r.end_date<=@endDate AND r.start_date>=@startDate ) 

INSERT INTO Requests 
(end_date,request_date,start_date,manager_response_req,hr_response_req) 
VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate,'Accepted','Accepted')

declare @requestId int
SELECT @requestId= MAX(request_id) 
FROM Requests
INSERT INTO Managers_Replace_Managers_In_Requests
VALUES(@requestId,@replacementUserName,@userName)

DROP PROC ReplaceManagerSP 




GO

CREATE PROC ReplaceRegularHelperSP --this is a helper procedure not like the one above

@userName VARCHAR(30),
@replacementUserName VARCHAR(30), 
@endDate DATETIME , 
@startDate DATETIME
AS
--DECLARE @job VARCHAR(30)
--EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
IF NOT EXISTS 
( SELECT * 
FROM Regular_Employees_Replace_Regular_Employees h1,Regular_Employees h2,Requests r 
WHERE h1.user_name_request_owner=h2.user_name 
AND r.request_id=h1.request_id
AND r.end_date=@endDate AND r.start_date=@startDate ) 
INSERT INTO Requests 
(end_date,request_date,start_date) 
VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate )
declare @requestId int
SELECT @requestId= MAX(request_id) 
FROM Requests
INSERT INTO Regular_Employees_Replace_Regular_Employees
VALUES(@requestId,@replacementUserName,@userName)




GO 
CREATE PROC ApplyForLeaveRequestSP
@userName VARCHAR(30),
@replacementUserName VARCHAR(30),
@type VARCHAR(50), @endDate DATETIME ,
@startDate DATETIME
AS 
DECLARE @job VARCHAR(30)
EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
if (@job='hr') 
begin  
EXEC  ReplaceHrSP @userName , @replacementUserName  , @endDate , @startDate 
end
else if  (@job='Regular') 
begin  
EXEC  ReplaceRegularHelperSP @userName , @replacementUserName , @endDate , @startDate  
end
else if (@job='Manager')
begin  
EXEC  ReplaceManagerSP @userName , @replacementUserName  , @endDate , @startDate  
end
DECLARE @requestId int
SELECT @requestId= MAX(request_id) 
FROM Requests
INSERT INTO Leave_Requests
VALUES (@requestId,@type)




GO 
CREATE PROC ApplyForBusinessRequestSP
@userName VARCHAR(30),
@replacementUserName VARCHAR(30),
@tripDestination VARCHAR(150) ,
@tripPurpose TEXT ,
@endDate DATETIME ,
@startDate DATETIME
AS 
DECLARE @job VARCHAR(30)
EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
if (@job='hr') 
begin 
EXEC  ReplaceHrSP @userName , @replacementUserName  , @endDate , @startDate  
end
else if  (@job='Regular')
begin 
EXEC  ReplaceRegularHelperSP @userName , @replacementUserName , @endDate , @startDate  
end
else if (@job='Manager')
begin 
EXEC  ReplaceManagerSP @userName , @replacementUserName  , @endDate , @startDate 
end
DECLARE @requestId int
SELECT @requestId= MAX(request_id) 
FROM Requests
INSERT INTO Business_Trip_Requests 
VALUES (@requestId,@tripDestination,@tripPurpose)





--5: Yasmine------------------------------------------

--6: Abdullah -------------------------------------------------------------------------------------------------------------------------------------------

--Regular Employees Story no.6 Delete any request that is still in the review process
--DeletePendingRequestsSP takes the username of the employee as input and deletes all
--his requests that have an hr_response_req attr value of Pending
GO 

CREATE PROC DeletePendingRequestsSP 
@userName VARCHAR(30)
AS
DELETE Requests
	WHERE request_id = 
	(SELECT request_id 
	FROM Regular_Employees_Replace_Regular_Employees r 
	Where r.user_name_request_owner = @userName)
	OR request_id = (
	SELECT request_id 
	FROM HR_Employees_Replace_HR_Employees h 
	where h.user_name_request_owner = @userName)
	OR request_id = (
	SELECT request_id 
	FROM Managers_Replace_Managers_In_Requests m 
	WHERE m.user_name_request_owner = @userName)
	AND hr_response_req = 'Pending'


--7: Reda--------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC SendEmailSP --fixed
@senderUserName VARCHAR(30),
@senderEmail VARCHAR(70),
@recipientUserName VARCHAR(30),
@recipientEmail VARCHAR(70),
@emailSubject VARCHAR(140),
@emailBody TEXT
AS
DECLARE @timestamp DATETIME
SET @timestamp = CURRENT_TIMESTAMP
INSERT INTO Emails
(time_stamp,sender_user_name,sender_email,recipient_email,email_subject,email_body)
VALUES
(@timestamp,@senderUserName,@senderEmail,@recipientEmail,@emailSubject,@emailBody)
INSERT INTO Staff_Receives_Email
(time_stamp,sender_user_name,recipient_username)
VALUES
(@timestamp,@senderUserName,@recipientUserName)

--8: Gharam---------------------------------------------------------------------------------------------------


GO
CREATE PROC ViewReceivedEmailsSP --Returns a list of received emails handles as a staff member 8
@username VARCHAR(30)

AS
SELECT E.*
FROM Emails E inner Join Staff_Receives_Email R 
ON E.sender_user_name=r.sender_user_name AND E.time_stamp=R.time_stamp AND R.recipient_username=@username



--9: Yasmine--------------------------------------------------

--10: Abullah------------------------------------------------------------------------------------------------------------------------------------------------

GO

CREATE PROC ViewLatestAnnouncementsSP
@userName VARCHAR(150) --review needed
AS
SELECT a.*
	FROM Announcements a INNER JOIN StaffMember sm
	ON sm.company_domain = a.company_domain
	WHERE a.company_domain = sm.company_domain AND
	DATEDIFF(DAY, a.date, CURRENT_TIMESTAMP) < 21	

---------------------------------------------------------------------------------------------------------------------------------------------------------

--	“As an HR employee, I should be able to ...”

--------------------------------------------------------------------------------------------------------------------------------------------------------------

--1: Reda----------------------------------------------------------------------

GO
CREATE PROC AddJobSP --fix
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
@workingHours INT
AS
IF EXISTS
(
SELECT hr.*
FROM HR_Employees hr INNER JOIN Staff_Members sm
ON hr.user_name = sm.user_name
WHERE (hr.user_name = @hrUserName AND sm.department_code = @departmentCode AND sm.company_domain = @companyDomain )
)
INSERT INTO Jobs
(job_title,department_code,company_domain,application_deadline,detailed_description,min_years_experience,salary,short_description,vacancies,working_hours)
VALUES
(@jobTitle,@departmentCode,@companyDomain,@applicationDeadline,@detailedDescription,@minYearsExperience,@salary,@shortDescription,@vacancies,@workingHours)
ELSE
PRINT 'You cannot add a job in a different department than yours.'

GO
CREATE PROC AddQuestionSP
@questionTitle VARCHAR(700),
@answer BIT
AS
INSERT INTO Questions
(question_title,answer)
VALUES
(@questionTitle,@answer)

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

GO
CREATE PROC ViewJobInformationSP @username VARCHAR(30),@jobTitle VARCHAR(150)
AS
SELECT j.*
FROM Jobs j
WHERE j.job_title=@jobTitle AND 
j.company_domain 
IN ( SELECT s.company_domain FROM Staff_Members s WHERE s.user_name=@username) 
AND j.department_code
IN ( SELECT s.department_code FROM Staff_Members s WHERE s.user_name=@username) --I KNOW IT LOOKS STUPID BUT I'M LAZY
--3: Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC EditJobInfoSP --Also needs editing
@hrUsername VARCHAR(30),
@job_title VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@applicationDeadline DATETIME=NULL,
@detailedDescription TEXT=NULL,
@minYearsExperience INT=NULL,
@salary INT=NULL,
@shortDescription TEXT=NULL,
@vacancies INT=NULL , 
@workingHours INT=NULL 
AS 
--If the department is the HR Employee's Department, He/She can edit the info
IF EXISTS ( --We don't need this join we already have the HR username
SELECT*
FROM Staff_Members SM INNER JOIN HR_Employees HE ON SM.user_name=HE.user_name INNER JOIN Jobs J ON J.department_code=SM.department_code
WHERE SM.company_domain=J.company_domain AND HE.user_name=@hrUsername
)
BEGIN --BEGIN IF EXISTS
IF(@applicationDeadline IS NOT NULL)
BEGIN UPDATE Jobs SET application_deadline= @applicationDeadline WHERE job_title=@job_title AND department_code=@departmentCode AND company_domain=@companyDomain END 
IF(@detailedDescription IS NOT  NULL)
BEGIN UPDATE Jobs SET detailed_description= @detailedDescription WHERE job_title=@job_title AND department_code=@departmentCode AND company_domain=@companyDomain END 
IF(@minYearsExperience IS NOT NULL)
BEGIN UPDATE Jobs SET min_years_experience= @minYearsExperience WHERE job_title=@job_title AND department_code=@departmentCode AND company_domain=@companyDomain END 
IF(@salary IS NOT NULL)
BEGIN UPDATE Jobs SET salary = @salary WHERE job_title=@job_title AND department_code=@departmentCode AND company_domain=@companyDomain END 
IF(@shortDescription IS NOT NULL)
BEGIN UPDATE Jobs SET short_description = @shortDescription WHERE job_title=@job_title AND department_code=@departmentCode AND company_domain=@companyDomain END 
IF(@vacancies IS NOT NULL)
BEGIN UPDATE Jobs SET vacancies= @vacancies WHERE job_title=@job_title AND department_code=@departmentCode AND company_domain=@companyDomain END 
IF(@workingHours IS NOT NULL)
BEGIN UPDATE Jobs SET working_hours = @workingHours WHERE job_title=@job_title AND department_code=@departmentCode AND company_domain=@companyDomain END 
END --END IF EXISTS

--4: Abdullah----------------------------------------------------------------------------------------------------------------------------------------------- 
GO
CREATE PROC ViewNewApplicationsSP
@hrUserName VARCHAR(30),
@seekerUserName VARCHAR(30),
@companyDomain VARCHAR(150),
@departmentCode VARCHAR(30),
@jobTitle VARCHAR(150)
AS
IF EXISTS
(
SELECT *
FROM Staff_Members sm INNER JOIN Departments d
ON sm.department_code = d.department_code
WHERE d.department_code = @departmentCode AND sm.user_name = @hrUserName
)
SELECT *
FROM Applications a
WHERE a.seeker_username = @seekerUserName AND
a.job_title = @jobTitle AND
a.department_code = @departmentCode AND
a.company_domain = @companyDomain


--5: Reda------------------------------------------------------------------------------------------------------------------------------------------------
GO

CREATE PROC AddHrResponseSP --fixed
@seekerUserName VARCHAR(30),
@hrUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@hrResponse VARCHAR(20)
AS
UPDATE Applications
SET hr_response_app = @hrResponse , hr_username = @hrUserName
WHERE (Applications.seeker_username = @seekerUserName AND Applications.job_title = @jobTitle AND Applications.department_code = @departmentCode AND Applications.company_domain = @companyDomain)
--6: Gharam----------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC HRPostsAnnouncementSP --allows hr to post announcements handles hr 6
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



--7: Yasmine---------------------------------------------------------------------------------------------------------------------
GO 
CREATE PROC ViewRequestsSP
@hrUsername VARCHAR(30), @departmentCode VARCHAR(30), @companyDomain VARCHAR(150) --you don't need hr info for this .. don't need this number of joins
AS
IF EXISTS (
SELECT*
FROM Staff_Members SM INNER JOIN HR_Employees HE ON SM.user_name=HE.user_name INNER JOIN Jobs J ON J.department_code=SM.department_code
WHERE SM.company_domain=J.company_domain AND HE.user_name=@hrUsername
)
BEGIN
SELECT R.*
FROM Requests R, Regular_Employees_Replace_Regular_Employees RE, Managers_Replace_Managers_In_Requests M, HR_Employees_Replace_HR_Employee HE
WHERE (R.request_id=RE.request_id OR R.request_id=M.request_id OR R.request_id=HE.request_ID) AND R.manager_response_req='Accepted' AND (R.hr_response_req='Rejected' OR R.hr_response_req IS NULL)
AND EXISTS (
SELECT*
FROM Staff_Members SM INNER JOIN Departments D ON SM.department_code=D.department_code AND SM.company_domain=D.company_domain
WHERE D.department_code=@departmentCode AND D.company_domain=@companyDomain 
          )
END

--8: Yasmine------------------------------------------------------------------------------------------------------------------------------------------ 

--9: Abdullah ----------------------------------------------------------------------------------------------------------------------------------------
GO

CREATE PROC ViewAttendanceOfStaffSP
@hrUserName VARCHAR(30),
@regularUserName VARCHAR(30),
@periodStart DATETIME,
@periodEnd DATETIME
AS
IF EXISTS(
SELECT *
FROM Staff_Members sm1 INNER JOIN Staff_Members sm2
ON sm1.department_code = sm2.department_code
WHERE sm1.user_name = @hrUserName AND sm2.user_name = @regularUserName
)
SELECT a.*
FROM Attendances a
WHERE (DATEDIFF(DAY,@periodStart,a.date)>=0 AND DATEDIFF(DAY,@periodEnd,a.date) <=0)

--10: Reda----------------------------------------------------------------------------------------------------------------------------------

--Just to make things clear for the user in the output table .. we should put the month along with it's corresonding sum
GO

CREATE PROC ViewYearlyAttendanceOfStaffSP
@staffUserName VARCHAR(30),
@year INT
AS
SELECT SUM(a.duration)
FROM Attendances a
WHERE YEAR(a.date) = @year AND a.user_name = @staffUserName
GROUP BY MONTH(a.date)


--11: Gharam-------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE FUNCTION  RegularsWithFixed()
RETURNS  @Fixed TABLE 
(
    user_name  VARCHAR(30) NOT NULL   
)
AS
BEGIN
DECLARE @myTable table (user_name  VARCHAR(30) NOT NULL)

insert into @myTable 
SELECT  R.user_name 
FROM Tasks t ,Regular_Employees R ,  Managers_Assign_Tasks_To_Regulars  M 
WHERE  R.user_name=M.regular_user_name  
AND t.project_name=m.project_name 
And T.deadline=M.task_deadline 
AND T.name=M.task_name AND t.status='Fixed' 
And MONTH(t.deadline)=MONTH(getdate())

insert into @Fixed
SELECT USER_NAME 
FROM @mytable 
return
END


GO



CREATE PROC ViewTop3RegularSp
AS

SELECT TOP 3 first_name +' '+ last_name ,SUM(A.duration) 
FROM Attendances A ,DBO.RegularsWithFixed() R , Users U 
WHERE  R.user_name=A.user_name AND Month(a.leave_time)=MONTH(getdate())
AND R.user_name=U.user_name
GROUP BY first_name +' '+ last_name 
ORDER BY SUM(A.duration) desc



-----------------------------------------------------------------------------------------------------------------------------------------------------------

--“As a regular employee, I should be able to ...”

-------------------------------------------------------------------------------------------------------------------------------------------------------------


--1: Abdullah-
GO

CREATE PROC ViewProjectsOfEmployeeSP
@userName VARCHAR(30)
AS 
SELECT p.*
FROM Projects p INNER JOIN Managers_Assign_Projects_To_Regulars mapr
ON p.project_name = mapr.project_name
WHERE mapr.regular_user_name = @userName


--2: Reda----------------------------------------------------------------------------

GO
CREATE PROC ViewTasksInProjectSP --Also How to stop a regular employee from viewing tasks in other projects ?? the description says 'My' So maybe we should take the user as input ..otherwise it's correct
@projectName VARCHAR(100),
@userName VARCHAR(30)
AS
SELECT t.*
FROM Tasks t INNER JOIN Managers_Assign_Tasks_To_Regulars mar
ON t.deadline = mar.task_deadline AND t.name = mar.task_name AND t.project_name = mar.project_name
WHERE ( t.project_name = @projectName AND mar.regular_user_name = @userName)


--3: Gharam------------------------------------------------------------------------------------

GO
CREATE PROC RegularFinalizesTaskSP
@username VARCHAR(30) 
,@taskName VARCHAR(30),
@deadline DATETIME, 
@project VARCHAR(100)
AS 
IF EXISTS  (SELECT M.task_name 
FROM Managers_Assign_Tasks_To_Regulars M 
WHERE @username=M.regular_user_name 
AND @taskName=M.task_name 
AND @deadline=M.task_deadline 
AND @project=M.project_name) 
AND CONVERT (date, SYSDATETIMEOFFSET())<CONVERT (date, @deadline)
BEGIN
UPDATE Tasks
SET status='Fixed'
WHERE  @taskName=name
AND @deadline=deadline 
AND project_name=@project
END


--4: Yasmine---------------------------------------------------------------------------------------------------------------------------------------------

GO 
CREATE PROC ChangeTaskStatusSP --change task status to assigned this query is for changing a fixed task to assigned task .. also rename
@username VARCHAR(30), @status VARCHAR(10),@name VARCHAR(30), @deadline DATETIME , @projectname VARCHAR(100)
AS
IF EXISTS (
SELECT *
FROM Managers_Assign_Projects_To_Regulars M
WHERE M.regular_user_name= @username AND M.project_name=@projectname 

          )
BEGIN 
UPDATE Tasks 
SET Tasks.status =@status
WHERE Tasks.name=@name AND Tasks.deadline=@deadline AND Tasks.project_name=@projectName AND Tasks.deadline<CURRENT_TIMESTAMP 
END




-------------------------------------------------------------------------------------------------------------------------------------------------------------

--“As a manager, I should be able to ...”


---------------------------------------------------------------------------------------------------------------------------------------------------------------

--1: Gharam--------------------------------------------------------------------------------------------------------------------------------------
--EXEC ViewEmployeesRequestsSP 'cam.percival','Bob_Mark','Accepted',4
GO
CREATE PROC ViewEmployeesRequestsSP 
@username VARCHAR(30), 
@ManagerUserName VARCHAR(30),
@response VARCHAR(20),
@id int --View Single request at a time
AS 
IF EXISTS 
(SELECT user_name 
FROM HR_Employees 
WHERE @username=user_name)  AND NOT EXISTS (SELECT user_name
FROM Managers
WHERE @ManagerUserName =user_name AND type='HR')
BEGIN
print 'HR can only replace Hr'
END
ELSE
UPDATE Requests 
SET manager_response_req=@response
WHERE request_id=@id;







DROP PROC ViewEmployeesRequestsSP ;
--2: Abdullah ---------------------------------------------------------------------------------------------------------------------------

GO

CREATE PROC AddManagerResponseToRequestSP
@managerUserName VARCHAR(50),
@staffUserName VARCHAR(50),
@managerResponse VARCHAR(10),
@reasonOfDisapproval TEXT
AS
IF EXISTS
(
SELECT *
FROM Staff_Members sm1 INNER JOIN Staff_Members sm2
ON sm1.department_code = sm2.department_code
WHERE sm1.user_name = @managerUserName AND sm2.user_name = @staffUserName

)
BEGIN
IF(@managerResponse = 'Accepted')
	SET @reasonOfDisapproval = NULL
ELSE

UPDATE Requests 
	SET Requests.manager_response_req = @managerResponse, Requests.reason_of_disapproval = @reasonOfDisapproval, Requests.manager_user_name = @managerUserName
	WHERE (request_id =
	(SELECT request_id
	FROM Regular_Employees_Replace_Regular_Employees r
	WHERE r.user_name_request_owner = @staffUserName)
	OR request_id = 
	(SELECT request_id 
	FROM HR_Employees_Replace_HR_Employees h 
	WHERE h.user_name_request_owner = @staffUserName)
	OR request_id = (SELECT request_id 
	FROM Managers_Replace_Managers_In_Requests m 
	WHERE m.user_name_request_owner = @staffUserName)
	) AND ((SELECT s.department_code 
	FROM Staff_Members s INNER JOIN Managers m 
	ON s.user_name = m.user_name 
	WHERE  s.user_name = @managerUserName) 
	= (
	SELECT s.department_code 
	FROM Staff_Members s 
	WHERE s.user_name = @staffUserName))
END
--3: Reda--------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC ViewSeekerInfoSP
@seekerUserName VARCHAR(30)
AS
SELECT s.*
FROM Job_Seekers s
WHERE (s.user_name = @seekerUserName)

GO
CREATE PROC ViewJobInfoSP
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
SELECT j.*
FROM Jobs j
WHERE (j.job_title = @jobTitle AND j.department_code = @departmentCode AND j.company_domain = @companyDomain)


GO
CREATE PROC ViewApprovedJobAppSP
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@CompanyDomain VARCHAR(150)
AS
SELECT a.*
FROM Applications a
WHERE (a.job_title = @jobTitle AND a.department_code = @departmentCode AND a.company_domain = @CompanyDomain AND a.hr_response_app='Accepted')

--4: Yasmine-------------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROC RespondToJobApplicationsSP --This needs to be redone .. needs to take input information about the manager if u need to check the manager department .. and need to take info about the application you want to update
@managerResponse VARCHAR(20)
AS
UPDATE Applications
SET manager_response_app=@managerResponse
WHERE Applications.hr_response_app = 'Accepted' AND EXISTS  
     (
	   SELECT *
	   FROM Staff_Members SM INNER JOIN Managers M ON SM.user_name = M.user_name 
	   INNER JOIN Applications A on A.manager_username=M.user_name 
	   INNER JOIN Jobs J on J.department_code=A.department_code
     )

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
@projectName VARCHAR(100),
@managerUserName VARCHAR(30),
@regularUserName VARCHAR(30)
AS
IF (
SELECT COUNT(*)
FROM Managers_Assign_Projects_To_Regulars mapr
WHERE mapr.regular_user_name = @regularUserName
) < 2
AND EXISTS
(
SELECT *
FROM Staff_Members s1, Staff_Members s2
WHERE (s1.user_name = s2.user_name AND
s1.department_code = s2.department_code AND
s1.user_name = @managerUserName AND
s2.user_name = @regularUserName
)
)
INSERT INTO Managers_Assign_Projects_To_Regulars
(manager_user_name,regular_user_name,project_name)
VALUES (@managerUserName,@regularUserName,@projectName)
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
CREATE PROC DefineTaskSP --tasks can be defined by any manager don't need the exists condition Nor username as input
@managerUsername VARCHAR(30) , @projectName VARCHAR(100) , @deadline DATETIME , @taskName VARCHAR(30) , @status VARCHAR(10) = 'Open'
AS
IF EXISTS ( 
  SELECT *
  FROM Manager M INNER JOIN Projects P on M.user_name = P.manager_user_name
  WHERE @managerUsername = P.manager_user_name
          )
BEGIN 
INSERT INTO Tasks (project_name,deadline,name,status)
VALUES (@projectName, @deadline, @taskName , @status)
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

DECLARE @workingHours INT, @duration INT
SET @duration = DATEPART(HOUR,@leaveTime) - DATEPART(HOUR,@startTime)
SELECT @workingHours = j.working_hours
FROM Staff_Members s INNER JOIN Jobs j
ON s.job_title = j.job_title AND s.department_code = j.department_code AND s.company_domain = j.company_domain
WHERE s.user_name = @userName 
RETURN (@workingHours - @duration)
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


/*CREATE FUNCTION  TOP3hours()
RETURNS  @TOP3 TABLE 
(
    
    user_name  VARCHAR(30) NOT NULL,
    SUM INT  NOT NULL
)

AS
BEGIN
DECLARE @myTable table (user_name  VARCHAR(30) NOT NULL,SUM INT  NOT NULL

insert into @myTable 
SELECT TOP 3 R.user_name,SUM(A.duration) FROM Attendances A ,Regular_Employees R WHERE  R.user_name=A.user_name  GROUP BY R.user_name ORDER BY SUM(A.duration) desc

insert into @TOP3 
SELECT USER_NAME, sum FROM @mytable 
return
END */