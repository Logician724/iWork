DROP PROC ViewDepartmentSP;
DROP PROC ViewQuetionsInInterviewSP;
DROP PROC UserLoginSP;
GO

CREATE PROC ViewDepartmentSP
@companyDomain VARCHAR(150),
@departmentCode VARCHAR(30)
AS
SELECT d.*
FROM Departments d
WHERE ((d.company_domain = @companyDomain) AND (d.department_code = @departmentCode))

GO

CREATE PROC UserLoginSP
@userName VARCHAR(30),
@password  VARCHAR(30)
AS
BEGIN
IF
NOT EXISTS (
SELECT u.*
FROM Users u
WHERE (u.user_name = @userName AND u.password = @password)
)

PRINT 'User not found'

ELSE IF
EXISTS ( 
SELECT s.*
FROM Job_Seekers s
WHERE (s.user_name = @userName)
)
PRINT 'Hello Seeker'

ELSE IF
EXISTS (
SELECT m.*
FROM Managers m
WHERE (m.user_name = @userName)
)
PRINT 'Hello Manager'
ELSE IF
EXISTS (
SELECT h.*
FROM HR_Employees h
WHERE (h.user_name = @userName)
)
PRINT  'Hello HR'

ELSE IF
EXISTS (
SELECT r.*
FROM Regular_Employees r
WHERE (r.user_name = @userName)
)
PRINT 'Hello Employee'

END


GO


CREATE PROC ViewQuetionsInInterviewSP
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
SELECT q.question_title
FROM Question q INNER JOIN Jobs_Have_Questions jq
ON jq.question_id = q.question_id
WHERE (jq.job_title = @jobTitle AND jq.department_code = @departmentCode AND jq.company_domain = @companyDomain)

GO

CREATE PROC DeletePendingApplicationSP
@seekerUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
DELETE FROM Applications
WHERE (Applications.seeker_username = @seekerUserName AND Applications.job_title = @jobTitle AND Applications.company_domain = @companyDomain AND Applications.app_status = 'Pending')

GO
CREATE PROC ViewAttendaceSP
@userName VARCHAR(30),
@periodStart DATETIME,
@periodEnd DATETIME
AS
SELECT a.*
FROM Attendances a
WHERE (DATEDIFF(DAY,@periodStart,a.date)>=0 AND DATEDIFF(DAY,@periodEnd,a.date) <=0)

GO
CREATE PROC SendEmailSP
@senderUserName VARCHAR(30),
@senderEmail VARCHAR(70),
@recepientEmail VARCHAR(70),
@emailSubject VARCHAR(140),
@emailBody TEXT
AS 
INSERT INTO Emails
(time_stamp,sender_user_name,sender_email,recipient_email,email_subject,email_body)
VALUES
(CURRENT_TIMESTAMP,@senderUserName,@senderEmail,@recepientEmail,@emailSubject,@emailBody)

GO
CREATE PROC AddJobSP
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
INSERT INTO Jobs
(job_title,department_code,company_domain,application_deadline,detailed_description,min_years_experience,salary,short_description,vacancies,working_hours)
VALUES
(@jobTitle,@departmentCode,@companyDomain,@applicationDeadline,@detailedDescription,@minYearsExperience,@salary,@shortDescription,@vacancies,@workingHours)

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
CREATE PROC AddQuestionToJobSP
@questionID INT,
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
INSERT INTO Jobs_Have_Questions
(question_id,job_title,department_code,company_domain)
VALUES(@questionID,@jobTitle,@departmentCode,@companyDomain)

GO
CREATE PROC HrResponseSP
@seekerUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150),
@hrResponse VARCHAR(20)
AS
UPDATE Applications
SET hr_response_app = @hrResponse
WHERE (Applications.seeker_username = @seekerUserName AND Applications.job_title = @jobTitle AND Applications.department_code = @departmentCode AND Applications.company_domain = @companyDomain)

GO
CREATE PROC ViewAttendanceOfStaffSP
@staffUserName VARCHAR(30),
@year INT
AS
SELECT SUM(a.duration)
FROM Attendances a
WHERE YEAR(a.date) = @year AND a.user_name = @staffUserName
GROUP BY MONTH(a.date)

GO
CREATE PROC ViewTasksInProjectSP
@projectName VARCHAR(100),
@userName VARCHAR(30)
AS
SELECT t.*
FROM Tasks t INNER JOIN Managers_Assign_Tasks_To_Regulars mar
ON t.deadline = mar.task_deadline AND t.name = mar.task_name AND t.project_name = mar.project_name
WHERE ( t.project_name = @projectName AND mar.regular_user_name = @userName)

GO
CREATE PROC ViewApprovedJobAppSP
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@CompanyDomain VARCHAR(150)
AS
SELECT a.*
FROM Applications a
WHERE (a.job_title = @jobTitle AND a.department_code = @departmentCode AND a.company_domain = @CompanyDomain AND a.hr_response_app='Accepted')

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
CREATE PROC AssignRegularToProjectSP
@userName VARCHAR(30),
@projectName VARCHAR(100),
@definingUser VARCHAR(30), --user name of the manager that defined the project--
@regularUserName VARCHAR(30)
AS
IF EXISTS (
SELECT *
FROM Staff_Members s1 INNER JOIN Staff_Members s2
ON s1.user_name = s2.user_name
WHERE(s1.department_code = s2.department_code AND s1.user_name = @userName AND s2.user_name = @definingUser)
)
INSERT INTO Managers_Assign_Projects_To_Regulars
(manager_user_name,regular_user_name,project_name)
VALUES (@userName,@regularUserName,@projectName)

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


-- Romy Was here too --
GO 

CREATE PROC ViewCompanySP 
@companyName varchar(50),
@companyAddress varchar(300),
@companyType varchar(80)
AS
Select C.* From Companies C Where C.field =@companyType OR  C.address=@companyAddress OR C.name=@companyName


GO
CREATE PROC RegisterToWebsite 
@userName VARCHAR(30)  ,
@password VARCHAR(30) ,
@personalEmail VARCHAR(70) ,
@birthDate DATETIME ,
@expYear INT ,
@firstName VARCHAR(25) ,
@lastName VARCHAR(25) 
AS
insert into Users Values(@username,@password,@personalEmail,@birthDate,@expYear,@firstName,@lastName)

GO 
CREATE PROC ViewMyScoreSP 
@username VARCHAR(3), @job VARCHAR(150),
@score INT OUTPUT
AS 
SELECT @score= score From  Applications  WHERE @username=seeker_username AND @job=job_title
print @score


GO 

CREATE PROC StaffCheckInSp @username VARCHAR(30)
AS
IF EXISTS ( SELECT user_name From Staff_Members where @username=@username AND DATENAME(dw,GETDATE())!='friday')
INSERT INTO Attendances (user_name,date,start_time )VALUES(@username , CONVERT (date, SYSDATETIMEOFFSET()) ,CONVERT (time, CURRENT_TIMESTAMP)  ) --the rest will be handled by the query after this 

GO
CREATE PROC ViewReceivedEmailsSP @username VARCHAR(30)

AS
SELECT E.*
FROM Emails E inner Join Staff_Receives_EmailS R ON E.sender_user_name=sender_user_name AND R.recepient_username=@username


GO
CREATE PROC ViewJobInformationSP @username VARCHAR(30),@jobTitle VARCHAR(150)
AS
SELECT j.* FROM Jobs j WHERE j.job_title=@jobTitle AND j.company_domain IN ( SELECT s.company_domain FROM Staff_Members s WHERE s.user_name=@username) 
AND j.department_code IN ( SELECT s.department_code FROM Staff_Members s WHERE s.user_name=@username) --I KNOW IT LOOKS STUPID BUT I'M LAZY

DROP PROC ViewJobInformationSP;
GO
CREATE PROC HRPostsAnnouncementSP 
@username varchar(30),

@title VARCHAR(280) ,
@description TEXT ,
@type VARCHAR(20) 
AS
DECLARE @domainName varchar(150)
SELECT @domainName=company_domain FROM Staff_Members WHERE @username=user_name AND @username IN ( SELECT * FROM HR_Employees)
INSERT INTO Announcements VALUES (CONVERT (date, SYSDATETIMEOFFSET()),@domainName,@title,@username,@description,@type)

GO
CREATE PROC RegularFinalizesTaskSP
@username VARCHAR(30) ,@taskName VARCHAR(30),@deadline DATETIME, @project VARCHAR(100)
AS 
IF EXISTS  (SELECT M.task_name FROM Managers_Assign_Tasks_To_Regulars M WHERE @username=M.regular_user_name AND @taskName=M.task_name AND @deadline=M.task_deadline AND @project=M.project_name) AND CONVERT (date, SYSDATETIMEOFFSET())<CONVERT (date, @deadline)
UPDATE Tasks
SET status='Fixed'
WHERE  @taskName=name AND @deadline=deadline AND project_name=@project

GO
CREATE PROC RemoveRegularFromProjectSp
@username VARCHAR(30),@project VARCHAR(100)
AS
IF NOT EXISTS ( SELECT M.regular_user_name FROM Managers_Assign_Tasks_To_Regulars M , TASKS t WHERE @username=M.regular_user_name AND t.name=M.task_name AND t.project_name=M.project_name AND t.deadline=M.task_deadline AND t.status='Assigned')


DELETE Managers_Assign_Projects_To_Regulars WHERE @username=regular_user_name


GO
CREATE PROC ReplaceRegularSp @username VARCHAR(30), @taskName VARCHAR(30),@deadline DATETIME, @project VARCHAR(100) --THIS ONLY TAKES THE ONE WHO IS GOING TO REPLACE NOT THE THE one being replaces 
AS
IF  EXISTS ( SELECT M.regular_user_name FROM Managers_Assign_Tasks_To_Regulars M , TASKS t WHERE   t.name=M.task_name AND t.project_name=M.project_name
AND t.deadline=M.task_deadline AND
@taskName=t.name AND @project=t.project_name AND @deadline=t.deadline AND t.status='Assigned')

UPDATE Managers_Assign_Tasks_To_Regulars 
SET Regular_user_name=@username
WHERE @taskName=task_name AND @deadline=task_deadline AND @project=project_name 

GO 

Create PROC FindTypeOfReplacementSp @username VARCHAR(30),@username2 VARCHAR(30) ,@job VARCHAR(30) OUTPUT
AS
IF EXISTS ( SELECT USER_NAME FROM HR_Employees WHERE @userName =user_name ) AND EXISTS ( SELECT USER_NAME FROM HR_Employees WHERE @userName2 =user_name )   SELECT @job='hr'
else if  EXISTS ( SELECT USER_NAME FROM Regular_Employees WHERE @userName =user_name ) AND EXISTS ( SELECT USER_NAME FROM Regular_Employees WHERE @userName2 =user_name )  SELECT @job='Manager'
else if EXISTS ( SELECT USER_NAME FROM Regular_Employees WHERE @userName =user_name ) AND EXISTS ( SELECT USER_NAME FROM Regular_Employees WHERE @userName2 =user_name )  SELECT @job='Regular'

GO

CREATE PROC ReplaceHRSP

@userName VARCHAR(30), @replacementUserName VARCHAR(30),@type VARCHAR(50), @endDate DATETIME , @startDate DATETIME
AS
--DECLARE @job VARCHAR(30)
--EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
IF NOT EXISTS ( SELECT * FROM HR_Employees_Replace_HR_Employees h1,HR_Employees h2,Requests r WHERE h1.user_name_request_owner=h2.user_name AND r.request_id=h1.request_id
AND r.end_date=@endDate AND r.start_date=@startDate ) 
INSERT INTO Requests (end_date,request_date,start_date) VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate )
declare @requestId int
SELECT @requestId= MAX(request_id) FROM Requests
INSERT INTO HR_Employees_Replace_HR_Employees VALUES(@requestId,@replacementUserName,@userName)
INSERT INTO Leave_Requests VALUES (@requestId,@type)


GO

CREATE PROC ReplaceManagerSP

@userName VARCHAR(30), @replacementUserName VARCHAR(30),@type VARCHAR(50), @endDate DATETIME , @startDate DATETIME
AS
--DECLARE @job VARCHAR(30)
--EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
IF NOT EXISTS ( SELECT * FROM Managers_Replace_Managers_In_Requests h1,Managers h2,Requests r WHERE h1.user_name_request_owner=h2.user_name AND r.request_id=h1.request_id
AND r.end_date=@endDate AND r.start_date=@startDate ) 
INSERT INTO Requests (end_date,request_date,start_date) VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate )
declare @requestId int
SELECT @requestId= MAX(request_id) FROM Requests
INSERT INTO Managers_Replace_Managers_In_Requests VALUES(@requestId,@replacementUserName,@userName)
INSERT INTO Leave_Requests VALUES (@requestId,@type)

GO

CREATE PROC ReplaceRegularSP

@userName VARCHAR(30), @replacementUserName VARCHAR(30),@type VARCHAR(50), @endDate DATETIME , @startDate DATETIME
AS
--DECLARE @job VARCHAR(30)
--EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
IF NOT EXISTS ( SELECT * FROM Regular_Employees_Replace_Regular_Employees h1,Regular_Employees h2,Requests r WHERE h1.user_name_request_owner=h2.user_name AND r.request_id=h1.request_id
AND r.end_date=@endDate AND r.start_date=@startDate ) 
INSERT INTO Requests (end_date,request_date,start_date) VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate )
declare @requestId int
SELECT @requestId= MAX(request_id) FROM Requests
INSERT INTO Regular_Employees_Replace_Regular_Employees VALUES(@requestId,@replacementUserName,@userName)
INSERT INTO Leave_Requests VALUES (@requestId,@type)


DROP PROC ReplaceRegularSP;

DROP PROC ReplaceHRSP;






DROP PROC ReplaceRegularSp;

DROP PROC FindTypeOfReplacementSp;

DROP PROC RemoveRegularFromProjectSp


DROP PROC RegularFinalizesTaskSP;



DROP PROC HRPostsAnnouncementSP 

DROP PROC ViewReceivedEmailsSP;
DROP PROC StaffCheckInSp;
DROP PROC ViewMyInformationSP;
DROP PROC ViewMyScoreSP;




-- And she ended here --


GO
CREATE PROC ViewCompaniesSP
AS
SELECT C.* , CP.phone
FROM Companies C INNER JOIN  Companies_Phones CP
ON  C.domain_name = CP.company_domain
GO


GO
CREATE PROC SearchJobsSP
@keywords TEXT
AS
SELECT J.* , C.name AS company_name, D.name AS department_name
FROM Departments D INNER JOIN Companies C ON D.company_domain = C. domain_name
INNER JOIN Jobs J on J.department_code = D.department_code AND J.company_domain=D.company_domain 
where J.vacancies > 0 AND J.short_description LIKE CONCAT('%' ,@keywords,'%') OR  J.job_title LIKE CONCAT('%' ,@keywords,'%') 
GO


GO
CREATE PROC EditPersonalInfoSP
@username VARCHAR(30) , @password VARCHAR(30), @personalEmail VARCHAR(70), @birthDate DATETIME, @expYear INT, @firstName VARCHAR(25), @lastName VARCHAR(25)
AS
UPDATE Users 
SET Users.password=@password, 
Users.personal_email=@personalEmail, 
Users.birth_date=@birthDate,
Users.exp_year = @expYear,
Users.first_name = @firstName, 
Users.last_name = @lastName
WHERE Users.user_name = @username
GO


GO  --to be edited 
CREATE PROC ViewJobStatusSP
@username VARCHAR(30)
AS
Select A.score, A.app_status
FROM Applications A
WHERE A.seeker_username=@username
GO

GO
CREATE PROC CheckOutSP
@leaveTime DATETIME, @username VARCHAR(30)
AS
UPDATE Attendances 
SET  Attendances.leave_time = @leaveTime
WHERE Attendances.user_name=@username AND NOT EXISTS 
(
SELECT *
FROM Staff_Members S inner Join Attendances A on A.user_name=S.user_name
WHERE A.user_name=@username AND S.day_off = day(@leaveTime)
 )
GO


GO
CREATE PROC ViewTasksSP
@project VARCHAR(100), @status VARCHAR(10)
AS 
SELECT T.*
FROM Task T inner join Project P on T.project_name = P.project_name
WHERE T.project_name = @project AND T.status=@status
GO



GO
CREATE PROC RespondToJobApplicationsSP
@managerResponse VARCHAR(20)
AS
UPDATE Applications
SET Applications.manager_response_app=@managerResponse
WHERE Applications.hr_response_app = 'Accepted' AND EXISTS  
     (
	   SELECT *
	   FROM Staff_Members SM INNER JOIN Managers M ON SM.user_name = M.user_name 
	   INNER JOIN Applications A on A.manager_username=M.user_name 
	   INNER JOIN Jobs J on J.department_code=A.department_code
     )
GO




GO 
CREATE PROC DefineTaskSP
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
GO





GO

CREATE PROC AllCompaniesAndDepartmentsSP
AS 
SELECT *
FROM Companies c, Departments d
WHERE c.domain_name = d.company_domain

GO
-- i tried to do this one but i seriously couldnt i am so sorry
CREATE PROC CompaniesSalaryOrderedSP
AS
SELECT c.*
FROM Companies c INNER JOIN 
(SELECT AVG(salary) AS s, Staff_Members.company_domain FROM Staff_Members GROUP BY Staff_Members.company_domain) AS m 
ON c.domain_name = m. company_domain

GO

CREATE PROC ApplyJobCheckSP
@min_years_experience INT,
@seeker_user_name VARCHAR(30),
@job_title VARCHAR(150),
@department_code VARCHAR(30),
@company_domain VARCHAR(150)
AS
IF(
 EXISTS(
SELECT *
FROM Jobs j INNER JOIN Applications a
ON j.company_domain = a.company_domain AND
	j.department_code = a.department_code AND
	j.job_title = a.job_title
WHERE min_years_experience < @min_years_experience AND
		a.job_title = @job_title AND
		a.seeker_username = @seeker_user_name AND
		a.company_domain = @company_domain AND
		a.department_code = @department_code AND
		app_status != 'pending'
)
)
INSERT INTO Applications VALUES
(NULL,NULL,NULL,NULL,NULL,NULL,@seeker_user_name,@job_title,@department_code,@company_domain)

GO

CREATE PROC ChooseJobFromAcceptedSP
@seeker_username VARCHAR(30),
@department_code VARCHAR(30),
@company_domain VARCHAR(150),
@job_title VARCHAR(150),
@day_off VARCHAR(10),
@company_email VARCHAR(70)
AS
IF(	EXISTS(
			SELECT * 
			FROM Applications a
			WHERE a.company_domain = @company_domain AND
			a.department_code = @department_code AND
			a.job_title = @job_title AND
			a.seeker_username = @seeker_username AND
			a.app_status = 'Accepted'
			)
	)	
BEGIN
DELETE FROM Job_Seekers 
	WHERE Job_Seekers.user_name = @seeker_username
DECLARE @salary INT
SELECT @salary = salary
	FROM Jobs
	WHERE department_code = @department_code AND company_domain = @company_domain AND job_title = @job_title 
INSERT INTO Staff_Members 
	VALUES(@seeker_username,@day_off,30,@salary,@company_email,@job_title,@department_code,@company_domain)
UPDATE Jobs 
	SET vacancies = vacancies-1
	WHERE Jobs.company_domain = @company_domain AND
			Jobs.department_code = @department_code AND
			Jobs.job_title = @job_title 

END

GO 

CREATE PROC DeletePendingRequestsSP
@username VARCHAR(30)
AS
DELETE Requests
	WHERE request_id = (SELECT request_id FROM Regular_Employees_Replace_Regular_Employees r Where r.user_name_request_owner = @username)
	OR request_id = (SELECT request_id FROM HR_Employees_Replace_HR_Employees h where h.user_name_request_owner = @username)
	OR request_id = (SELECT request_id FROM Managers_Replace_Managers_In_Requests m where m.user_name_request_owner = @username)
	AND hr_response_req = NULL

GO

CREATE PROC AnnouncementWithinTwentyDaysSP
@company_domain VARCHAR(150)
AS
SELECT a.*
	FROM Announcements a 
	WHERE a.company_domain = @company_domain AND DATEDIFF(DAY, a.date, CURRENT_TIMESTAMP)<21

GO

CREATE PROC ViewNewApplicationsSP
@seeker_username VARCHAR(30),
@compnay_domain VARCHAR(150),
@department_code VARCHAR(30),
@job_title VARCHAR(150)
AS
SELECT *,a.score 
	FROM Applications a INNER JOIN Job_Seekers js ON a.seeker_username = js.user_name INNER JOIN Jobs j 
	ON a.company_domain = j.company_domain AND a.department_code = j.department_code 
	WHERE j.department_code = @department_code AND j.company_domain  = @compnay_domain AND j.job_title = @job_title

GO

CREATE PROC RegularShowAttendanceWithinPeriodSP
@period1 DATETIME,
@period2 DATETIME,
@department_code VARCHAR(30),
@company_domain VARCHAR(150),
@missing_hours INT
AS
-- missing hours is for many staff members so this implementation is not complete needs the function of missing missing hours
SELECT a.start_time, a.leave_time, a.duration, @missing_hours
	FROM Attendances a INNER JOIN Staff_Members s
	ON a.user_name = s.user_name
	WHERE s.company_domain = @company_domain AND s.department_code = @department_code AND a.date IN (@period1,@period2)

GO

CREATE PROC ManagerViewProjectInfoSP
@user_name VARCHAR(50)
AS
SELECT p.*
	FROM Managers_Assign_Projects_To_Regulars m INNER JOIN Projects p 
	ON m.project_name = p.project_name
	WHERE m.manager_user_name = @user_name

GO

CREATE PROC ManagerDecidingRequestSP
@manager_username VARCHAR(50),
@staff_username VARCHAR(50),
@manager_response VARCHAR(10),
@reason_of_disapproval TEXT
AS

BEGIN
IF(@manager_response = 'Accepted')
	SET @reason_of_disapproval = NULL
END

UPDATE Requests 
	SET Requests.manager_response_req = @manager_response, Requests.reason_of_disapproval = @reason_of_disapproval, Requests.manager_user_name = @manager_username
	WHERE (request_id = (SELECT request_id FROM Regular_Employees_Replace_Regular_Employees r Where r.user_name_request_owner = @staff_username)
	OR request_id = (SELECT request_id FROM HR_Employees_Replace_HR_Employees h where h.user_name_request_owner = @staff_username)
	OR request_id = (SELECT request_id FROM Managers_Replace_Managers_In_Requests m where m.user_name_request_owner = @staff_username)
	) AND (SELECT s.department_code FROM Staff_Members s INNER JOIN Managers m ON s.user_name = m.user_name WHERE  s.user_name = @manager_username) 
	= (SELECT s.deparmtnet_code FROM Staff_Members s WHERE s.user_name = @staff_username) 

GO

-- tihs part needs to be discussed because we might need to change something on the schema
CREATE PROC ManagerCreateProjectSP
@manager_username VARCHAR(30),
@start_date DATETIME,
@end_date DATETIME,
@project_name VARCHAR(100)
AS
INSERT Projects Values(@project_name,@manager_username,@start_date,@end_date)

GO

CREATE PROC ManagerReviewTaskSP
@manager_user_name VARCHAR(50),
@project_name VARCHAR(100),
@tasks_name VARCHAR(30),
@acceptance VARCHAR(10),
@new_deadline DATETIME
AS
BEGIN
IF(@acceptance='Accepted')
	UPDATE Tasks
		SET Tasks.status = 'Closed'
		WHERE Tasks.name= @tasks_name AND Tasks.project_name = @project_name 
ELSE
IF(@acceptance = 'Rejected')
	BEGIN
	DECLARE @description NVARCHAR(MAX), @comments NVARCHAR(MAX)
	SELECT @description  = Tasks.description, @comments = Tasks.comments 
		FROM Tasks
		WHERE Tasks.name= @tasks_name AND Tasks.project_name = @project_name 
	DELETE Tasks
		
		WHERE Tasks.name= @tasks_name AND Tasks.project_name = @project_name 
	INSERT INTO Tasks VALUES(@new_deadline,@tasks_name,@project_name,@comments,@description,@acceptance)
	END
END

GO
CREATE FUNCTION MakeCompanyEmail
( @seeker_user_name VARCHAR(30),
@company_name VARCHAR(50)
)
RETURNS VARCHAR
BEGIN
DECLARE @email VARCHAR(70)
SET @email =  @seeker_user_name+'@'+@company_name+'.com'
RETURN @email
END
GO


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
IF(@jobTitle LIKE 'Manager%' OR @jobTitle LIKE 'HR%' OR @jobTitle LIKE 'Regular%')
SET @returnedBit = '1'
ELSE
SET @returnedBit ='0'
RETURN @returnedBit
END

GO
DROP PROC AllCompaniesAndDepartmentsSP 
DROP PROC CompaniesSalaryOrderedSP
DROP PROC ChooseJobFromAcceptedSP
DROP PROC ApplyJobCheckSP
DROP PROC DeletePendingRequestsSP
DROP PROC AnnouncementWithinTwentyDaysSP
DROP PROC ViewNewApplicationsSP
DROP PROC RegularShowAttendanceWithinPeriodSP
DROP PROC ManagerViewProjectInfoSP
DROP PROC ManagerDecidingRequestSP
DROP PROC ManagerCreateProjectSP
DROP PROC ManagerReviewTaskSP
DROP FUNCTION MakeCompanyEmail

GO