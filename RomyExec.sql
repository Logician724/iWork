-- Romy Started  fixing here
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





DROP PROC StaffCheckInSp
GO
CREATE PROC StaffCheckInSp 
@username VARCHAR(30)
AS
IF EXISTS ( SELECT user_name From Staff_Members where @username=@username AND DATENAME(dw,GETDATE())!='friday')

INSERT INTO Attendances 
(user_name,date,start_time )
VALUES(@username , CONVERT (date, SYSDATETIMEOFFSET()) ,CONVERT (time, CURRENT_TIMESTAMP)  ) --the rest will be handled by the query after this 