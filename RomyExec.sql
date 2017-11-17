-- Romy Started  fixing here
--DROP PROC RegisterToWebsite;




-- She eneded here 




DROP PROC ViewMyScoreSP ;




INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) --iNSERTION FOR TEST 
VALUES('hassan_hasannen','1234','Mohamed.Ahmed@hotmail.com','1/4/1990',5,'hassan','Ahmed');
 INSERT INTO Job_Seekers (user_name) --INSERTING FOR TEST
VALUES ('hassan_hasannen'); 
INSERT INTO Applications (seeker_username,job_title,department_code,company_domain,score) Values ('hassan_hasannen','Manager- Managing PHP Department','PHP-5019','facebook.com',10) 






DROP PROC StaffCheckInSp --Staff Checks in creates entity with without leave time handles staff memeber number 1 


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



EXEC HRPostsAnnouncementSP 'ahmed.hussain','TEST','TEST','TEST' --executing HRPostsAnnouncementSP 
------------------------Manager Defines project done by Abdullah ------------------------------
DROP PROC ManagerCreateProjectSP;


GO

CREATE PROC ManagerCreateProjectSP
@manager_username VARCHAR(30),
@start_date DATETIME,
@end_date DATETIME,
@project_name VARCHAR(100)
AS
INSERT Projects Values(@project_name,@manager_username,@start_date,@end_date)



---------------------------------------------------------------------------------------------

-------------------------Manager defines task done by Yasmine-------------------------------

DROP PROC DefineTaskSP;

GO 
CREATE PROC DefineTaskSP --handles Defining tasks
 @projectName VARCHAR(100) , @deadline DATETIME , @taskName VARCHAR(30)  --@status VARCHAR(10) = 'Open'
AS
/*IF EXISTS ( 
  SELECT *
  FROM Manager M INNER JOIN Projects P on M.user_name = P.manager_user_name
  WHERE @managerUsername = P.manager_user_name
          )*/
BEGIN 
INSERT INTO Tasks (project_name,deadline,name,status)
VALUES (@projectName, @deadline, @taskName ,'Open')
END



EXEC DefineTaskSP 'DATABASES','2012/04/06 12:23:45','M2'






--------------------------------------------------------------------------------------------



------------------------------Manager Hires Regular in project  Originally by reda ----------------
DROP PROC AssignRegularToProjectSP;

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



---------------------Find type of replacement ----------------------------------

---------------------------registered user 2 ----------------------------------




