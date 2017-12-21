﻿--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As an registered/unregistered user, I should be able to ...”
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````


--1:Gharam---------------------------------------------------------------------------------------------------------------------------------------------------------
GO
EXEC SearchCompanyByNameSP 'face'
GO
EXEC SearchCompanyByTypeSP 'digital'
GO
EXEC SearchCompanyByAddressSP 'Pal'



--2:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
EXEC ViewCompaniesSP


--3:Abdullah----------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
EXEC ViewCompanySP 'facebook.com'
GO
EXEC ViewDepartmentsOfCompanySP 'google.com'
GO
EXEC ViewCompanySP 'facebook.com'
GO 
EXEC ViewCompanySP 'google.com'
GO 
EXEC ViewCompanySP 'amazon.com'

GO
EXEC ViewDepartmentsOfCompanySP 'google.com'
GO
EXEC ViewDepartmentsOfCompanySP 'facebook.com'
GO
EXEC ViewDepartmentsOfCompanySP 'amazon.com'

--4:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
EXEC ViewDepartmentSP 'amazon.com', 'CSR-1263'


--5:Gharam------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--successful registration attempt
GO
DECLARE @status1 BIT
EXEC RegisterToWebsite 'Mohamed_Zaki','123455','Zaki@guc.edu.eg','05/05/1990',10,'Mohamed','Zaki',@status1 OUTPUT
PRINT @status1

--failed registration attempt
GO
DECLARE @operationStatus BIT;
EXEC RegisterToWebsite 'claire.carles','fadsfda','claire@gmail.com','05/05/1990',10,'Claire','Carles',@operationStatus OUTPUT
PRINT @operationStatus

--6:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
EXEC SearchJobsSP 'js'


--7:Abdullah----------------------------------------------------------------------------------------------------------------------------

EXEC ViewCompaniesSalariesSP



--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a registered user, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

--1:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------
--Non user registration
GO
DECLARE @type0 INT;
EXEC UserLoginSP 'korusaki.ichigo','korosu2017',@type0 OUTPUT
PRINT @type0

--seeker registration
GO
DECLARE @type1 INT;
EXEC UserLoginSP 'gawwad.gooda','batata24242',@type1 OUTPUT
PRINT @type1
--manager registration
GO
DECLARE @type2 INT;
EXEC UserLoginSP 'Mohamed_Ahmed','1234',@type2 OUTPUT
PRINT @type2

--hr registration
GO
DECLARE @type3 INT;
EXEC  UserLoginSP 'Yousef.Mustafa','WWE123',@type3 OUTPUT
PRINT @type3

--regular registration
GO
DECLARE @type4 INT;
EXEC UserLoginSP 'claire.carles','MyPassword2017',@type4 OUTPUT
PRINT @type4 
--2:Gharam ---------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC ViewUserInfoSP 'claire.carles'


--3:Yasmine -------------------------------------------------------------------------------------------------------------------------------------------------------------------
--change  password and email

EXEC EditPersonalInfoSP 'claire.carles','changedPassword2017','chill2017@gmail.com',NULL,NULL,NULL,NULL
--change years of experience
EXEC EditPersonalInfoSP 'claire.carles',NULL,NULL,NULL,7,NULL,NULL
--all permurations can be run, please consult User_Stories.sql for documentation


--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a job seeker, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1:Abdullah-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful job application//There is another application for the same job that is pending
GO
DECLARE @status1 INT
EXEC ApplyForJobSP 'shadi.aly', 'Manager- Managing PHP Department','PHP-5019','facebook.com',@status1 OUTPUT
PRINT @status1
--unsuccessful job application//Seeker doesn't have enough years of exp
GO
DECLARE @status2 INT;
EXEC ApplyForJobSP 'shadi.aly','Manager- Managing Location Department','LOC-4729', 'google.com',@status2 OUTPUT
PRINT @status2;
--successful job application
GO
DECLARE @status3 INT
EXEC ApplyForJobSP 'omar.mofti','Employee- Customer Managing','CSR-1263','amazon.com',@status3 OUTPUT
PRINT @status3

--2:Reda----------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
GO
EXEC ViewQuetionsInInterviewSP 'Manager- Managing PHP Department','PHP-5019','facebook.com'


--3:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
EXEC ViewMyScoreSP 'omar.mofti', 'Manager- Managing PHP Department', 'PHP-5019', 'facebook.com'

--4:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
EXEC ViewJobsStatusSP 'shadi.aly'

--5:Abdullah---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful operation//application is not an accpeted one
GO
DECLARE @status0 INT
EXEC ChooseJobFromAcceptedAppSP 'shadi.aly','PHP-5019','facebook.com', 'Manager- Managing PHP Department','Sunday',@status0 OUTPUT
PRINT @status0

--unsuccessful operation//chosen day off is Friday
GO
DECLARE @status1 INT
EXEC ChooseJobFromAcceptedAppSP 'shadi.aly','BS-3291','facebook.com','Employee- BootStrap Developer','Friday',@status1 OUTPUT
PRINT @status1

--successful operation//The seeker is now a staff member in his desired job.
GO
DECLARE @status2 INT
EXEC ChooseJobFromAcceptedAppSP 'shadi.aly', 'BS-3291', 'facebook.com','Employee- BootStrap Developer','Sunday',@status2 OUTPUT
PRINT @status2
--6:Reda----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful deletion// this application is not in the review process or it doesn't exist
GO
DECLARE @status0 BIT
EXEC DeletePendingApplicationSP 'shadi.aly', 'Employee- BootStrap Developer', 'BS-3291', 'facebook.com',@status0 OUTPUT
PRINT @status0
--successful deletion
GO
DECLARE @status1 BIT
EXEC DeletePendingApplicationSP 'shadi.aly', 'Manager- Managing PHP Department', 'PHP-5019', 'facebook.com',@status1 OUTPUT
PRINT @status1

--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a staff member, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--to display the case where the output indicates that the check in is disregarded please change the local clock on you PC to Friday or choose a staff member
--whose day off is equal to today
GO
DECLARE @status1 BIT
EXEC CheckInSP 'claire.carles', @status1 OUTPUT
PRINT @status1
--2:Yasmine-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- to display the case where the output indicates that the check out is disregarded please change the local clock on you PC to Friday or choose a staff member
DECLARE @status1 BIT
EXEC CheckOutSP 'claire.carles', @status1 OUTPUT
PRINT @status1
--3:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC ViewAttendanceSP 'salma.tarek', '2017-5-22','2017-12-21'

--4:Gharam-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--successful request application
GO
DECLARE @status1 BIT 
EXEC ApplyHRForRequestSP 'ahmed.hussain','basma.mohamed','2/18/2017','3/10/2017',NULL,'Paris','Business trip ', @status1 OUTPUT
PRINT @status1
--unsuccessful request application
GO
DECLARE @status0 BIT 
EXEC ApplyHRForRequestSP 'jdana.debs','ahmed.hussain','5/4/2017','5/2/2017','sick leave','','', @status0 OUTPUT
PRINT @status0
GO
--5:Yasmine--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC ViewRequestsStatusSP 'claire.carles'
--6:Abdullah-------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC DeletePendingRequestsSP 'claire.carles'

--7:Reda-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @status1 BIT
EXEC SendEmailSP 'andra.kyla','andra.kyla@facebook.com','Yousef.Mustafa','Yousef.Mustafa@facebook.com','Plan Delivery','To Mr. Yousef, I would like to inform you that the plan we agreed on has been revised and ready for delivery. When would you like us to deliver it? From, Andra', @status1 OUTPUT
PRINT @status1

DECLARE @status1 BIT
EXEC SendEmailSP 'claire.carles','claire.carles@facebook.com','Yousef.Mustafa','Yousef.Mustafa@facebook.com','Plan Delivery','To Mr. Yousef, I would like to inform you that the plan we agreed on has been revised and ready for delivery. When would you like us to deliver it? From, Andra', @status1 OUTPUT
PRINT @status1

DECLARE @status1 BIT
EXEC SendEmailSP 'sally.ramadan','sally.ramadan@facebook.com','Yousef.Mustafa','Yousef.Mustafa@facebook.com','Plan Delivery','To Mr. Yousef, I would like to inform you that the plan we agreed on has been revised and ready for delivery. When would you like us to deliver it? From, Andra', @status1 OUTPUT
PRINT @status1



--8:Gharam------------------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC ViewReceivedEmailsSP 'Yousef.Mustafa'

--9:Yasmine-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--the timestamp is dependent on when the insertions of the emails are handled. In order to test please run view received emails and get the email timestamp first to plug in
-- the procedure. At the time of insertion this procedure worked correctly
EXEC ReplyToEmailsSP 'Yousef.Mustafa', '2017-11-20 13:54:06.140','andra.kyla','',''
--10:Abullah------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC ViewLatestAnnouncementsSP 'claire.carles'


--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--	“As an HR employee, I should be able to ...”
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

--1:Reda-----------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @status0 BIT
EXEC AddJobSP 'Dina.AlMasry','Employee- the boss of Ads','JS-8938','facebook.com','2017-12-12','you will be managing everything related to the facebook ad experience with our viewers on the platform',12,80000,'Manage facebook Ads',3,9, @status0 OUTPUT
PRINT @status0

DECLARE @status1 BIT
EXEC AddJobSP 'Dina.AlMasry','Employee- the boss of Ads','PHP-5019','facebook.com','2017-12-12','you will be managing everything related to the facebook ad experience with our viewers on the platform',12,80000,'Manage facebook Ads',3,9, @status1 OUTPUT
PRINT @status1


--2:Gharam---------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful view//job is not in the department
DECLARE @status0 BIT
EXEC ViewJobInformationSP 'Fayrouz.Hussain', 'Manager- Managing JS Department','JS-8938','facebook.com',@status0 OUTPUT
PRINT @status0
--successful view
DECLARE @status1 BIT
EXEC ViewJobInformationSP 'Fayrouz.Hussain', 'Manager- Managing PHP Department','PHP-5019','facebook.com',@status1 OUTPUT
PRINT @status1
--3:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful edit//job is not in the department
DECLARE @status0 BIT
EXEC EditJobInfoSP 'Fayrouz.Hussain', 'Manager- Managing JS Department','JS-8938','facebook.com','1-1-2018',NULL,NULL,NULL,NULL,NULL,NULL,@status0 OUTPUT
PRINT @status0
--successful edit
DECLARE @status1 BIT
EXEC EditJobInfoSP 'Fayrouz.Hussain', 'Manager- Managing PHP Department','PHP-5019','facebook.com','2018-1-1','this job is not easy, expect your eyes to shut down after looking at a computer screen for days non-stop',NULL,NULL,NULL,NULL,NULL,@status1 OUTPUT
PRINT @status1
--4:Abdullah----------------------------------------------------------------------------------------------------------------------------------------------- 
-- unsuccessful view//the application does not belong to the HR employee's department
DECLARE @status0 BIT
EXEC ViewNewApplicationsSP 'Fayrouz.Hussain','Manager- Managing JS Department','JS-8938','facebook.com',@status0 OUTPUT
PRINT @status0 
-- successful view
DECLARE @status1 BIT
EXEC ViewNewApplicationsSP 'Fayrouz.Hussain','Manager- Managing PHP Department','PHP-5019','facebook.com',@status1 OUTPUT
PRINT @status1
--5:Reda------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful response addition// this job application does not belong to the HR's department 
DECLARE @status0 BIT
EXEC AddHrResponseSP 'shadi.aly', 'Fayrouz.Hussain', 'Employee- BootStrap Developer', 'BS-3291', 'facebook.com','Rejected',@status0 OUTPUT
PRINT @status0
--successful response additions
DECLARE @status1 BIT
EXEC AddHrResponseSP 'shadi.aly','Fayrouz.Hussain','Manager- Managing PHP Department','PHP-5019','facebook.com','Accepted',@status1 OUTPUT
PRINT @status1
DECLARE @status1 BIT
EXEC AddHrResponseSP 'gawwad.gooda','Dina.AlMasry','Manager- Managing PHP Department','PHP-5019','facebook.com','Accepted',@status1 OUTPUT
PRINT @status1
DECLARE @status1 BIT
EXEC AddHrResponseSP 'omar.mofti','Dina.AlMasry','Manager- Managing PHP Department','PHP-5019','facebook.com','Accepted',@status1 OUTPUT
PRINT @status1
--6:Gharam--------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC PostAnnouncementSP 'Fayrouz.Hussain','this is my first announcement','just chilling','fun'

--7:Yasmine----------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @status1 BIT
EXEC ViewRequestsSP 'Fayrouz.Hussain','PHP-5019','facebook.com',@status1
PRINT @status1

--8:Yasmine------------------------------------------------------------------------------------------------------------------------------------------ 
EXEC RespondHRToRequestSP 'firdous.ahmed',11,'Accepted'
--9:Abdullah ----------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful attendance view//the staff member doesn't belong to the HR's department or the user doesn't exists
DECLARE @status0 BIT
EXEC ViewAttendanceOfStaffSP 'Fayrouz.Hussain','mirna.alteer','2017-10-1','2017-10-30',@status0 OUTPUT
PRINT @status0
--successful attendance view
DECLARE @status1 BIT
EXEC ViewAttendanceOfStaffSP 'Fayrouz.Hussain','claire.carles','2017-10-1','2017-12-30',@status1 OUTPUT
PRINT @status1

--10:Reda----------------------------------------------------------------------------------------------------------------------------------
--unsuccessful working hours view//the staff member doesn't belong to the HR's department or the user doesn't exist
DECLARE @status0 BIT
EXEC ViewYearlyAttendanceOfStaffSP 'Fayrouz.Hussain','mirna.alteer',2017,@status0 OUTPUT
PRINT @status0
--successful working hours view
DECLARE @status1 BIT
EXEC ViewYearlyAttendanceOfStaffSP 'Fayrouz.Hussain','claire.carles',2017,@status1 OUTPUT
PRINT @status1
--another successful working hours view
DECLARE @status1 BIT
EXEC ViewYearlyAttendanceOfStaffSP 'salma.tarek','salma.tarek',2017,@status1 OUTPUT
PRINT @status1
--11:Gharam-------------------------------------------------------------------------------------------------------------------------------------------
--for testing purposes you can use this query to change the task status for everyone after running the insertions file, however you are asked 
--to run the DB.sql and Insertions.sql again before running any other execution
--UPDATE Tasks
--SET status = 'Fixed'
--GO
--DECLARE @status1 BIT
--EXEC CheckInSP 'rosannah.humphrey', @status1 OUTPUT
--PRINT @status1
--GO
--DECLARE @status1 BIT
--EXEC CheckOutSP 'rosannah.humphrey', @status1 OUTPUT
--PRINT @status1
--GO
--DECLARE @status1 BIT
--EXEC CheckInSP 'marisa.lavender', @status1 OUTPUT
--PRINT @status1
--GO
--DECLARE @status1 BIT
--EXEC CheckOUTSP 'marisa.lavender', @status1 OUTPUT
--PRINT @status1


EXEC ViewTop3RegularSP 'mirna.alteer','BS-3291','facebook.com'
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a regular employee, I should be able to ...”
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1: Abdullah---------------------------------------------------------------------------------------------------

EXEC ViewProjectsOfEmployeeSP 'godfrey.love'


--2: Reda------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful task view//the regular employee doesn't have tasks in this project
DECLARE @status0 BIT
EXEC ViewTasksInProjectSP 'Project Eris', 'marisa.lavender', @status0 OUTPUT 
PRINT @status0
--successful task view
DECLARE @status1 BIT
EXEC ViewTasksInProjectSP 'Project Neo', 'marisa.lavender', @status1 OUTPUT 
PRINT @status1
--3: Gharam---------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful task edit//task doesn't exist, or is not assigned to this staff member, or deadline passed
DECLARE @status0 BIT
EXEC FinalizeTaskSP 'rosannah.humphrey','Task 1','12/30/2017 12:00:00 AM','Project Neo',@status0 OUTPUT
PRINT @status0
--successful task edit
DECLARE @status1 BIT
EXEC FinalizeTaskSP 'marisa.lavender','Task 1','12/30/2017 12:00:00 AM','Project Neo',@status1 OUTPUT
PRINT @status1

--4: Yasmine-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--kindly apply FinalizeTaskSP beofre executing this procedure in order to make a successful change, all the pre-inserted tasks have a status of assigned
--unsuccessful task edit////task doesn't exist, or is not assigned to this staff member, or deadline passed 
DECLARE @status0 BIT
EXEC ChangeTaskStatusSP 'godfrey.love','Task 1','5/9/2017 12:00:00 AM','Project-5651AMU chat page developing BootStrap',@status0 OUTPUT
PRINT @status0
--successful task edit
DECLARE @status1 BIT
EXEC ChangeTaskStatusSP 'godfrey.love','Task 1','12/30/2017 12:00:00 AM','Project-3284NMD upgrade of exterior of home page BootStrap',@status1 OUTPUT
PRINT @status1
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a manager, I should be able to ...”
--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

--1:Gharam------------------------------------------------------------------------------------------------------------------------------------------------------------
--HR Manager View
EXEC ViewEmployeesRequestsSP 'Ahmed_Mahmoud','JS-8938','facebook.com'
--NON-HR Manager View
EXEC ViewEmployeesRequestsSP 'Mahmoud_Ahmed','JS-8938','facebook.com'
--2:Abdullah ----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Request is accepted by a manager in the same department
DECLARE @status1 BIT
EXEC AddManagerResponseToRequestSP 'Mahmoud_Ahmed','Ahmed_Mahmoud', 'Accepted', NULL, @status1 OUTPUT
PRINT @status1  
--Request is rejected by a manager in the same department
DECLARE @status1 BIT
EXEC AddManagerResponseToRequestSP 'Mahmoud_Ahmed','Ahmed_Mahmoud','Rejected','Does not meat qualifications at the moment',@status1 OUTPUT 
PRINT @status1 
--Request is reject by a manager not in the same department, so no rows are affected
DECLARE @status1 BIT
EXEC AddManagerResponseToRequestSP 'Jack_Bob','Ahmed_Mahmoud','Accepted',NULL,@status1 OUTPUT 
PRINT @status1 
--Request is rejected by a manager in the same department;however, reason of disapproval is null, so no rows are affected 
DECLARE @status0 BIT
EXEC AddManagerResponseToRequestSP 'Mahmoud_Ahmed', 'Ahmed_Mahmoud','Rejected',NULL,@status0 OUTPUT 
PRINT @status0 


--3:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful application view//job doesn't belong to the manager's department, or no accpeted applications yet by HR
DECLARE @status0 BIT
EXEC ViewApprovedJobAppSP 'Mahmoud_Ahmed','Manager- Managing PHP Department','PHP-5019','facebook.com',@status0 OUTPUT
PRINT @status0
--successful application view
DECLARE @status1 BIT
EXEC ViewApprovedJobAppSP 'Mohamed_Ahmed','Manager- Managing PHP Department','PHP-5019','facebook.com',@status1 OUTPUT
PRINT @status1
--procedures for viewing more app info
EXEC ViewJobInfoSP 'Manager- Managing PHP Department','PHP-5019','facebook.com'
--procedures for viewing more job seeker info
EXEC ViewSeekerInfoSP 'gawwad.gooda'

--4:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC RespondToJobApplicationsSP 'Mohamed_Ahmed','Accepted','gawwad.gooda','Manager- Managing PHP Department','PHP-5019','facebook.com'
EXEC RespondToJobApplicationsSP 'Mohamed_Ahmed','Rejected','omar.mofti','Manager- Managing PHP Department','PHP-5019','facebook.com'

--5:Abdullah-----------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC DefineNewProject 'Mohamed_Ahmed','2017-11-21','2017-12-30','Project Hela'

--6:Reda-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful assignment// the regular works on 2 project, and can't be assigned to more
DECLARE @status0 INT
EXEC AssignRegularToProjectSP 'rosannah.humphrey','Project Neo','Mahmoud_Mohamed',@status0 OUTPUT
PRINT @status0
--unsuccessful assignment// the regular doens't belong to the manager's department
DECLARE @status1 INT
EXEC AssignRegularToProjectSP 'Mohamed_Mahmoud','Project Mavis','claire.carles',@status1 OUTPUT
PRINT @status1
--unsuccessful assignment// the regular is already assigned to the project
DECLARE @status2 INT
EXEC AssignRegularToProjectSP 'godfrey.love','Project Mavis','Jack_Mark',@status2 OUTPUT
PRINT @status2
--successful assignment
DECLARE @status3 INT
EXEC AssignRegularToProjectSP 'claire.carles','Project Neo','Ahmed_Mohamed',@status3 OUTPUT
PRINT @status3
--7:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--unsuccessful removal// the employee is still assigned to tasks
DECLARE @status0 BIT
EXEC RemoveRegularFromProjectSP 'marisa.lavender','Project Neo',@status0 OUTPUT
PRINT @status0
--successful removal 
DECLARE @status1 BIT
EXEC RemoveRegularFromProjectSP 'godfrey.love','Project Deimos',@status1 OUTPUT
PRINT @status1
--8:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful task definition// the regular employee doesn't belong to the project's department
DECLARE @status0 BIT
EXEC DefineTaskSP 'Ahmed_Mohamed','Project Mavis','2017-12-30','Alpha stage','beginning the work','this is a project orientation task',@status0 OUTPUT
PRINT @status0
--successful task definition
DECLARE @status1 BIT
EXEC DefineTaskSP 'Mohamed_Mahmoud','Project Eris','2017-12-30','Alpha stage','beginning the work','this is a project orientation task',@status1 OUTPUT
PRINT @status1

--9:Reda -------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful task assignment// the regular employee is not assigned to the project
DECLARE @status0 BIT
EXEC AssignRegularToTaskSP 'Project Mavis','Mahmoud_Mohamed','andra.kyla','Task 1','12/30/2017 12:00:00 AM',@status0 OUTPUT
PRINT @status0
--successful task assignment
DECLARE @status1 BIT
EXEC AssignRegularToTaskSP 'Project Mavis','Mahmoud_Mohamed','marisa.lavender','Task 1','12/30/2017 12:00:00 AM',@status1 OUTPUT
PRINT @status1

--10:Gharam--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful reassignment
GO
DECLARE @status0 BIT
EXEC ReplaceRegularSP 'clark.maurine','Task 3','2017-12-30','Project Eris',@status0 OUTPUT
PRINT @status0

--successful reassignment
GO
DECLARE @status1 BIT
EXEC ReplaceRegularSP 'marisa.lavender','Task Beta','2017-12-30','Project Deimos',@status1 OUTPUT
PRINT @status1

--11:Yasmine--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Tasks viewed unsuccessfully because the Department of the Manager is different from the department of the Manager who created the project
DECLARE @status0 BIT 
EXEC ViewTasksSP 'Joe_John', 'Project Morpheus','Assigned', @status0  OUTPUT
PRINT @status0

--Tasks viewed succesfully 
DECLARE @status1 BIT 
EXEC ViewTasksSP 'Mohamed_Mahmoud', 'Project Mavis','Assigned', @status1  OUTPUT
PRINT @status1 


--12:Abdullah-------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @status0 BIT
EXEC ReviewTaskSP 'Mohamed_Mahmoud','Project Neo','Task 1','12/30/2017 12:00:00 AM','Accepted','2018-5-5',@status0 OUTPUT
PRINT @status0
DECLARE @status1 BIT
EXEC ReviewTaskSP 'Mahmoud_Mohamed','Project Neo','Task 1','12/30/2017 12:00:00 AM','Accepted','2018-5-5',@status1 OUTPUT
PRINT @status1