﻿-- Romy Started  fixing here
--DROP PROC RegisterToWebsite;
GO
CREATE PROC RegisterToWebsite   -- Handles 5 in unregistered user
@userName VARCHAR(30)  , --takes entity as input 
@password VARCHAR(30) ,
@personalEmail VARCHAR(70) ,
@birthDate DATETIME ,
@expYear INT ,
@firstName VARCHAR(25) ,
@lastName VARCHAR(25) 
AS
insert into Users
Values(@username,@password,@personalEmail,@birthDate,@expYear,@firstName,@lastName)



-- She eneded here 
EXEC RegisterToWebsite 'Mohamed_Zaki','123455','Zaki@guc.edu.eg','05/05/2012',10,'Mohamed','Zaki' --executes RegisterToWebsite Using inputs



DROP PROC ViewMyScoreSP ;
GO 
CREATE PROC ViewMyScoreSP  --finds the score of a certian job handles job seeker 3
@username VARCHAR(30),
@job VARCHAR(150),
@departmentCode VARCHAR(150),
@CompanyDomain VARCHAR(150)

AS 
SELECT  score
From  Applications 
WHERE @username=seeker_username 
AND @CompanyDomain=company_domain
AND @job=job_title
AND @departmentCode =department_code




INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) --iNSERTION FOR TEST 
VALUES('hassan_hasannen','1234','Mohamed.Ahmed@hotmail.com','1/4/1990',5,'hassan','Ahmed');
 INSERT INTO Job_Seekers (user_name) --INSERTING FOR TEST
VALUES ('hassan_hasannen'); 
INSERT INTO Applications (seeker_username,job_title,department_code,company_domain,score) Values ('hassan_hasannen','Manager- Managing PHP Department','PHP-5019','facebook.com',10) 

EXEC ViewMyScoreSP 'hassan_hasannen','Manager- Managing PHP Department','PHP-5019','facebook.com'--executiong ViewMyScore working 





DROP PROC StaffCheckInSp --Staff Checks in creates entity with without leave time handles staff memeber number 1 
GO
CREATE PROC StaffCheckInSp 
@username VARCHAR(30)
AS
IF EXISTS ( SELECT user_name From Staff_Members where @username=@username AND DATENAME(dw,GETDATE())!='friday') 

INSERT INTO Attendances 
(user_name,date,start_time )

VALUES(@username , CONVERT (date, SYSDATETIMEOFFSET()) ,CONVERT (time, CURRENT_TIMESTAMP)  ) --the rest will be handled by the query after this 
---------------------------------


EXEC StaffCheckInSp 'Mohamed_Mahmoud' --Making an exec for testing 

-------------------------------------------------------------------

DROP PROC SendEmailSP

GO
CREATE PROC SendEmailSP --this is done by reda .. had to execute and test it to test mine .. the one next to this , Handles sending emails
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

EXEC SendEmailSP 'Mohamed_Ahmed','Mohamed.Ahmed@hotmail.com','Ahmed_Mohamed','Ahmed.Mohamed@hotmail.com','0428080','29829840'






--------------------------------------------------------------------

DROP PROC ViewReceivedEmailsSP;

GO
CREATE PROC ViewReceivedEmailsSP --Returns a list of received emails handles as a staff member 8
@username VARCHAR(30)

AS
SELECT E.*
FROM Emails E inner Join Staff_Receives_Email R 
ON E.sender_user_name=r.sender_user_name AND E.time_stamp=R.time_stamp AND R.recipient_username=@username


EXEC ViewReceivedEmailsSP 'Ahmed_Mohamed' --EXECUTING  ViewReceivedEmails


DROP PROC HRPostsAnnouncementSP ;
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


EXEC HRPostsAnnouncementSP 'ahmed.hussain','TEST','TEST','TEST' --executing HRPostsAnnouncementSP 
------------------------Manager Defines task done by Abdullah ------------------------------
DROP PROC ManagerCreateProjectSP;


GO

CREATE PROC ManagerCreateProjectSP
@manager_username VARCHAR(30),
@start_date DATETIME,
@end_date DATETIME,
@project_name VARCHAR(100)
AS
INSERT Projects Values(@project_name,@manager_username,@start_date,@end_date)

EXEC ManagerCreateProjectSP 'Ahmed_Mohamed','05/11/2015','10/10/2016','DATABASES'


---------------------------------------------------------------------------------------------

-------------------------Manager defines task done by Yasmine-------------------------------

DROP PROC DefineTaskSP;

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










--------------------------------------------------------------------------------------------


DROP PROC RegularFinalizesTaskSP;

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

