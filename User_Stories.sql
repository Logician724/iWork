
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
DROP PROC AnnouncementWithinTwentyDaysSP;
DROP PROC ViewNewApplicationsSP;
DROP PROC RegularShowAttendanceWithinPeriodSP;
DROP PROC ManagerViewProjectInfoSP;
DROP PROC ManagerDecidingRequestSP;
DROP PROC ManagerCreateProjectSP;
DROP PROC ManagerReviewTaskSP;
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
DROP FUNCTION RegularsWithFixed;

GO
-- User Story User no.4
CREATE PROC ViewDepartmentSP --Missing Viewing all jobs in this department .. if you make a View jobs in department procedure .. make a third procedure that links both of them maybe?
@companyDomain VARCHAR(150),
@departmentCode VARCHAR(30)
AS
SELECT d.*
FROM Departments d
WHERE ((d.company_domain = @companyDomain) AND (d.department_code = @departmentCode))


GO
-- User Story Registered User no.1
CREATE PROC UserLoginSP --suspecious
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

--User Story Job Seeker no.2
CREATE PROC ViewQuetionsInInterviewSP --correct
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
SELECT q.question_title
FROM Questions q INNER JOIN Jobs_Have_Questions jq
ON jq.question_id = q.question_id
WHERE (jq.job_title = @jobTitle AND jq.department_code = @departmentCode AND jq.company_domain = @companyDomain)

GO
--User Story Job Seeker no.6
CREATE PROC DeletePendingApplicationSP --correct
@seekerUserName VARCHAR(30),
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
DELETE FROM Applications
WHERE (Applications.seeker_username = @seekerUserName AND Applications.job_title = @jobTitle AND Applications.company_domain = @companyDomain AND Applications.app_status = 'Pending')

GO
--User Story Staff Member no.3
CREATE PROC ViewAttendanceSP --correct
@userName VARCHAR(30),
@periodStart DATETIME,
@periodEnd DATETIME
AS
SELECT a.*
FROM Attendances a
WHERE (DATEDIFF(DAY,@periodStart,a.date)>=0 AND DATEDIFF(DAY,@periodEnd,a.date) <=0) --Logic .. greater than one equal in each should be reversed , should also check year ,month

GO
-- User Story Staff Member no.7
CREATE PROC SendEmailSP --fixed
@senderUserName VARCHAR(30),
@senderEmail VARCHAR(70),
@recipientUserName VARCHAR(30),
@recipientEmail VARCHAR(70),
@emailSubject VARCHAR(140),
@emailBody TEXT
AS 
INSERT INTO Emails
(time_stamp,sender_user_name,sender_email,recipient_email,email_subject,email_body)
VALUES
(CURRENT_TIMESTAMP,@senderUserName,@senderEmail,@recipientEmail,@emailSubject,@emailBody)
INSERT INTO Staff_Receives_Email
(time_stamp,sender_user_name,recipient_username)
VALUES
(CURRENT_TIMESTAMP,@senderUserName,@recipientUserName)

GO
-- User Story HR no.1
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
-- User Story HR no.1
CREATE PROC AddQuestionSP
@questionTitle VARCHAR(700),
@answer BIT
AS
INSERT INTO Questions
(question_title,answer)
VALUES
(@questionTitle,@answer)

GO
-- User Story HR no.1
CREATE PROC AddQuestionToJobSP --check if the question is in the question list first .. just in case
@questionID INT,
@jobTitle VARCHAR(150),
@departmentCode VARCHAR(30),
@companyDomain VARCHAR(150)
AS
INSERT INTO Jobs_Have_Questions
(question_id,job_title,department_code,company_domain)
VALUES(@questionID,@jobTitle,@departmentCode,@companyDomain)

GO
-- User Story HR no.5
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

GO
--Just to make things clear for the user in the output table .. we should put the month along with it's corresonding sum
-- User Story HR no.10
CREATE PROC ViewYearlyAttendanceOfStaffSP
@staffUserName VARCHAR(30),
@year INT
AS
SELECT SUM(a.duration)
FROM Attendances a
WHERE YEAR(a.date) = @year AND a.user_name = @staffUserName
GROUP BY MONTH(a.date)

GO
-- User Story Regular Employee no.2
CREATE PROC ViewTasksInProjectSP --Also How to stop a regular employee from viewing tasks in other projects ?? the description says 'My' So maybe we should take the user as input ..otherwise it's correct
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
VALUES (@manageUserName,@regularUserName,@projectName)

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
--a similar query already exists
--CREATE PROC ViewCompanySP 
--@companyName varchar(50),
--@companyAddress varchar(300),
--@companyType varchar(80)
--AS
--Select C.*
--From Companies C
--Where  C.name=@companyName 
--OR C.field =@companyType 
--OR C.address=@companyAddress 



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
insert into Users
Values(@username,@password,@personalEmail,@birthDate,@expYear,@firstName,@lastName)

GO 
CREATE PROC ViewMyScoreSP 
@username VARCHAR(3),
@job VARCHAR(150),
@score INT OUTPUT
AS 
SELECT @score= score
From  Applications 
WHERE @username=seeker_username 
AND @job=job_title
print @score


GO 

CREATE PROC StaffCheckInSp 
@username VARCHAR(30)
AS
IF EXISTS ( SELECT user_name From Staff_Members where @username=@username AND DATENAME(dw,GETDATE())!='friday')

INSERT INTO Attendances 
(user_name,date,start_time )
VALUES(@username , CONVERT (date, SYSDATETIMEOFFSET()) ,CONVERT (time, CURRENT_TIMESTAMP)  ) --the rest will be handled by the query after this 

GO
CREATE PROC ViewReceivedEmailsSP @username VARCHAR(30)

AS
SELECT E.*
FROM Emails E inner Join Staff_Receives_EmailS R 
ON E.sender_user_name=sender_user_name AND R.recipient_username=@username


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
UPDATE Tasks
SET status='Fixed'
WHERE  @taskName=name
AND @deadline=deadline 
AND project_name=@project

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
FROM Regular_Employees 
WHERE @userName =user_name ) 
AND EXISTS( SELECT user_name
FROM Regular_Employees 
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

GO

CREATE PROC ReplaceHRSP

@userName VARCHAR(30),
@replacementUserName VARCHAR(30),
@endDate DATETIME ,
@startDate DATETIME
AS
--DECLARE @job VARCHAR(30)
--EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
IF NOT EXISTS ( SELECT * FROM HR_Employees_Replace_HR_Employees h1,HR_Employees h2,Requests r WHERE h1.user_name_request_owner=h2.user_name AND r.request_id=h1.request_id
AND r.end_date=@endDate AND r.start_date=@startDate ) 
INSERT INTO Requests 
(end_date,request_date,start_date) 
VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate )

DECLARE @requestId INT
SELECT @requestId= MAX(request_id) 
FROM Requests
INSERT INTO HR_Employees_Replace_HR_Employees 
VALUES(@requestId,@replacementUserName,@userName)



GO

CREATE PROC ReplaceManagerSP

@userName VARCHAR(30), 
@replacementUserName VARCHAR(30),
@endDate DATETIME ,
@startDate DATETIME
AS
--DECLARE @job VARCHAR(30)
--EXEC FindTypeOfReplacementSp  @userName , @replacementUserName , @job OUTPUT
IF NOT EXISTS 
( SELECT * 
FROM Managers_Replace_Managers_In_Requests h1,Managers h2,Requests r 
WHERE h1.user_name_request_owner=h2.user_name 
AND r.request_id=h1.request_id
AND r.end_date=@endDate AND r.start_date=@startDate ) 

INSERT INTO Requests 
(end_date,request_date,start_date) 
VALUES( @endDate, CONVERT (date, SYSDATETIMEOFFSET() ), @startDate )

declare @requestId int
SELECT @requestId= MAX(request_id) 
FROM Requests
INSERT INTO Managers_Replace_Managers_In_Requests
VALUES(@requestId,@replacementUserName,@userName)


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
And task_deadline>CONVERT(date, SYSDATETIMEOFFSET())

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
WHERE  R.user_name=A.user_name
AND R.user_name=U.user_name
GROUP BY first_name +' '+ last_name 
ORDER BY SUM(A.duration) desc

GO
CREATE PROC ViewEmployeesRequestsSP 
@username VARCHAR(30), 
@ManagerUserName VARCHAR(30)
, @response VARCHAR(20)
, @id int --View Single request at a time
AS 
if EXISTS 
(SELECT user_name 
FROM HR_Employees 
WHERE @username=user_name) 
BEGIN
IF EXISTS (SELECT user_name
FROM HR_Employees 
WHERE @ManagerUserName =user_name)
SELECT *
From Requests R,HR_Employees_Replace_HR_Employees H 
WHERE R.request_id=H.request_id AND @username=h.user_name_request_owner AND r.request_id=@id
UPDATE Requests
SET hr_response_req=@response
WHERE request_id=@id
END
ELSE if EXISTS (SELECT user_name 
FROM Regular_Employees 
WHERE @username=user_name) 
BEGIN 
SELECT * 
From Requests R,Regular_Employees_Replace_Regular_Employees H 
WHERE R.request_id=H.request_id
AND @username=h.user_name_request_owner 
AND r.request_id=@id
UPDATE Requests
SET hr_response_req=@response
WHERE request_id=@id 
END

ELSE 
BEGIN
SELECT 
* From Requests R,Managers_Replace_Managers_In_Requests H
WHERE R.request_id=H.request_id 
AND @username=h.user_name_request_owner 
AND r.request_id=@id
UPDATE Requests
SET hr_response_req=@response
WHERE request_id=@id 
END

-- And she ended here --

GO
CREATE PROC ViewCompaniesSP --correct
AS
SELECT C.* , CP.phone
FROM Companies C INNER JOIN  Companies_Phones CP
ON  C.domain_name = CP.company_domain

GO
CREATE PROC SearchJobsSP --correct
@keywords TEXT
AS
SELECT J.* , C.name AS company_name, D.name AS department_name
FROM Departments D INNER JOIN Companies C ON D.company_domain = C. domain_name
INNER JOIN Jobs J on J.department_code = D.department_code AND J.company_domain=D.company_domain 
where J.vacancies > 0 AND J.short_description LIKE CONCAT('%' ,@keywords,'%') OR  J.job_title LIKE CONCAT('%' ,@keywords,'%') 

GO

CREATE PROC EditPersonalInfoSP --correct
@username VARCHAR(30),
@password VARCHAR(30),
@personalEmail VARCHAR(70),
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


GO  --to be edited  ( Yes it do )
CREATE PROC ViewJobStatusSP
@username VARCHAR(30)
AS
Select A.score, A.app_status --Missing score and job title Don't we need to see these next to the JOB title maybe?
FROM Applications A
WHERE A.seeker_username=@username

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


GO
CREATE PROC ViewTasksSP --project name is already in the table task u don't have to join !
@project VARCHAR(100), @status VARCHAR(10)
AS 
SELECT T.*
FROM Task T inner join Project P on T.project_name = P.project_name
WHERE T.project_name = @project AND T.status=@status

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

GO
CREATE PROC EditJobInfoSP --Also needs editing
@hrUsername VARCHAR(30), @job_title VARCHAR(150), @departmentCode VARCHAR(30), @companyDomain VARCHAR(150),
@applicationDeadline DATETIME=NULL, @detailedDescription TEXT=NULL, @minYearsExperience INT=NULL, @salary INT=NULL, @shortDescription TEXT=NULL,
@vacancies INT=NULL , @workingHours INT=NULL 
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


GO 
CREATE PROC ViewRequestsSP
@hrUsername VARCHAR(30), @departmentCode VARCHAR(30), @companyDomain VARCHAR(150)
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







-- Users story no.3 View the info of a certain company along with the department info
-- ViewCompanySP takes the companyDomain as input and returns the info of the target company

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

--Users Story no.7 View the companies in the order of having the highest average salaries
-- ViewCompaniesSalaries returns the average salary of all staff members grouped by the companies they are in while ordering those averages descendingly
GO

CREATE PROC ViewCompaniesSalariesSP
AS
SELECT sm.company_domain, AVG(sm.salary) AS average_salary
FROM Staff_Members sm
GROUP BY (sm.company_domain)
ORDER BY AVG(sm.salary) DESC


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


GO

CREATE PROC ViewLatestAnnouncementsSP
@userName VARCHAR(150) --review needed
AS
SELECT a.*
	FROM Announcements a INNER JOIN StaffMember sm
	ON sm.company_domain = a.company_domain
	WHERE a.company_domain = sm.company_domain AND
	DATEDIFF(DAY, a.date, CURRENT_TIMESTAMP) < 21	

GO

CREATE PROC ViewNewApplicationsSP --Another tiny issue
@seeker_username VARCHAR(30),
@compnay_domain VARCHAR(150),
@department_code VARCHAR(30),
@job_title VARCHAR(150)
AS
SELECT *,a.score --select all will return a.score already 
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
	= (SELECT s.department_code FROM Staff_Members s WHERE s.user_name = @staff_username) 

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
