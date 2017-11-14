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
CREATE PROC ViewTasksInProjectSP
@projectName VARCHAR(100),
@userName VARCHAR(30)
AS
SELECT t.*
FROM Tasks t INNER JOIN Managers_Assign_Tasks_To_Regulars mar
ON t.deadline = mar.task_deadline AND t.name = mar.task_name AND t.project_name = mar.project_name
WHERE ( t.project_name = @projectName AND mar.regular_user_name = @userName)




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