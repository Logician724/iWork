EXEC ViewDepartmentSP  'facebook.com','PHP-5019'



EXEC ViewQuetionsInInterviewSP  'Manager- Managing PHP Department','PHP-5019','facebook.com'

EXEC DeletePendingApplicationSP 'shadi.aly','Manager- Managing PHP Department','PHP-5019','facebook.com'

EXEC ViewAttendanceSP 'salma.tarek','2017-8-20','2017-8-22'

EXEC SendEmailSP 'andra.kyla','andra.kyla@facebook.com','Yousef.Mustafa','Yousef.Mustafa@facebook.com','Plan Delivery','To Mr. Yousef, I would like to inform you that the plan we agreed on has been revised and ready for delivery. When would you like us to deliver it? From, Andra'

EXEC SendEmailSP 'claire.carles','claire.carles@facebook.com','Yousef.Mustafa','Yousef.Mustafa@facebook.com','Plan Delivery','To Mr. Yousef, I would like to inform you that the plan we agreed on has been revised and ready for delivery. When would you like us to deliver it? From, Andra'

EXEC AddJobSP 'Dina.AlMasry','Employee- Debuging Handling PHP Department','PHP-5019','facebook.com','2018-2-28',
				'Employees will handle testing codes produced by other coders in the department and debuging those codes',4,10000,
				'Handling testing and debuging code in PHP Department',8,7

EXEC AddQuestionSP 'Have you ever had a serious conflict in a previous employment?',1

EXEC AddQuestionToJobSP 6,'Employee- Debuging Handling PHP Department','PHP-5019','facebook.com'

EXEC AddHrResponseSP  'omar.mofti','Yousef.Mustafa','Manager- Managing PHP Department','PHP-5019','facebook.com','Accepted'

EXEC ViewYearlyAttendanceOfStaffSP 'salma.tarek',2017

EXEC ViewTasksInProjectSP 'Project-5651AMU chat page developing BootStrap','cam.percival'

EXEC ViewApprovedJobAppSP 'Manager- Managing PHP Department','PHP-5019','facebook.com'

EXEC ViewSeekerInfoSP 'gawwad.gooda'

EXEC ViewJobInfoSP 'Employee- Debuging Handling PHP Department','PHP-5019','facebook.com'

EXEC AssignRegularToProjectSP 'Project-5651AMU chat page developing BootStrap','Mahmoud_Mohamed','van.krystal'

EXEC AssignRegularToTaskSP 'Project-5651AMU chat page developing BootStrap','Mahmoud_Mohamed','van.krystal','Task 1','2017-7-13'

-- end of reda's procedures' executions

-- start of gharam's procedures' executions

DECLARE @myTable table (user_name  VARCHAR(30) NOT NULL)
Select * from DBO.RegularsWithFixed()  --getting top employees helper function
EXEC ViewCompanySP 'facebook.com' --View CompanySp exection

EXEC ViewDepartmentsOfCompanySP 'facebook.com' --View departments in a certian company

EXEC ViewCompaniesSalariesSP --View companies ordered by their average salary

EXEC ApplyForJobSP 'gawwad.gooda','Employee- BootStrap Developer','BS-3291','facebook.com'

EXEC ChooseJobFromAcceptedAppSP 'shadi.aly','BS-3291','facebook.com','Employee- BootStrap Developer','Sunday' --Creates a referencing conflict 

EXEC ChooseJobFromAcceptedAppSP 'shadi.aly','BS-3291','facebook.com','Employee- BootStrap Developer','Friday' --Works correctly returns error

EXEC RegisterToWebsite 'Mohamed_Zaki','123455','Zaki@guc.edu.eg','05/05/2012',10,'Mohamed','Zaki' --executes RegisterToWebsite Using inputs

EXEC StaffCheckInSp 'Mohamed_Mahmoud' --Making an exec for testing 

EXEC DefineNewProject 'Ahmed_Mohamed','05/11/2015','10/10/2016','DATABASES'

EXEC DefineNewProject 'Ahmed_Mohamed','05/11/2015','10/10/2016','DSD'

EXEC StaffCheckInSp 'Mohamed_Mahmoud' --Making an exec for testing 

EXEC ManagerCreateProjectSP 'Ahmed_Mohamed','05/11/2015','10/10/2016','DATABASES'

EXEC ManagerCreateProjectSP 'Ahmed_Mohamed','05/11/2015','10/10/2016','DSD'

EXEC ViewCompanySP 'facebook.com' --View CompanySp exection

EXEC ViewDepartmentsOfCompanySP 'facebook.com' --View departments in a certian company

EXEC ViewMyScoreSP 'shadi.aly','Employee- BootStrap Developer','BS-3291','facebook.com'--executiong ViewMyScore working 

EXEC ViewReceivedEmailsSP 'Yousef.Mustafa' -- does not show the table \\\\\\\\\\\\\\\\ -- Shows table in Romy's
EXEC ViewReceivedEmailsSP 'Yousef.Mustafa' -- does not show the table \\\\\\\\\\\\\\\\

EXEC ViewJobInformationSP 'Dina.AlMasry','Employee- Debuging Handling PHP Department' -- working right

EXEC ViewTop3RegularSp  -- shows a table but no values appear\\\\\\\\\\\\\\\\\\\\\\\\\

EXEC RegularFinalizesTaskSP 'cam.percival','Task 1','2017-7-13', 'Project-5651AMU chat page developing BootStrap' -- Works but be careful with your taskdeadline date should be > today .. careful .. change computer date or put another execution

EXEC ViewEmployeesRequestsSP -- not tested yet

EXEC RemoveRegularFromProjectSp 'cam.percival','Project-5651AMU chat page developing BootStrap' -- working right

EXEC ReplaceRegularSp 'claire.carles','Task 1','2017-7-13', 'Project-5651AMU chat page developing BootStrap' -- working right


----- Gharam exeucting here----
EXEC ViewEmployeesRequestsSP  'cam.percival','Bob_Mark','Accepted',4 --Working
EXEC RemoveRegularFromProjectSp 'cam.percival','Project-3284NMD upgrade of exterior of home page BootStrap' --Working


DECLARE @job VARCHAR(30)

EXEC FindTypeOfReplacementSp 'andra.kyla','cam.percival',@jOB

EXEC FindTypeOfReplacementSp 'Ahmed_Mahmoud','Ahmed_Mohamed',@jOB

EXEC FindTypeOfReplacementSp  'ahmed.hussain','ahmed.shehata' ,@JOB

EXEC ReplaceManagerSP 'Ahmed_Mohamed','Bob_Jack','05/05/2018','01/01/2018'

EXEC ViewReceivedEmailsSP 'Ahmed_Mohamed' --EXECUTING  ViewReceivedEmails

EXEC ReplaceRegularHelperSP 'cam.percival','claire.carles','05/05/2018','01/01/2018'

EXEC ApplyForLeaveRequestSP 'cam.percival','claire.carles','Sick','05/05/2018','01/01/2018'

EXEC ApplyForBusinessRequestSP 'Bob_Jack','Bob_Mark','Monaco','Chilling','05/05/2018','01/01/2018'

--end of gharam's executions

-- start of yasmin's executions


EXEC ViewCompaniesSP -- not working

EXEC SearchJobsSP 'managing' -- working right

EXEC EditPersonalInfoSP 'cam.percival', 'balabizo','cam.percival@hotmail.com','1980-2-5',7,'cam','percival' -- working right

EXEC ViewJobStatusSP 'shadi.aly' -- working right

EXEC ViewJobStatusSP 'gawwad.gooda' -- same, working right

EXEC CheckOutSP '2017-8-20 16:23:37', 'claire.carles' -- not working

EXEC EditJobInfoSP 'basma.mohamed', 'HR- Search Engine Managing', 'SRC-2837', 'google.com','1/12/2017 3:00:00 AM', NULL, 4, 7000,NULL,6 , 7 -- working right

EXEC ViewRequestsSP  -- not tested yet

EXEC ChangeTaskStatusSP 'godfrey.love', 'Fixed','Task 1', '5/9/2017 12:00:00 AM' , 'Project-3284NMD upgrade of exterior of home page BootStrap' -- compiles but does not work

EXEC RespondToJobApplicationsSP 'Accepted' -- does not do the right job

EXEC DefineTaskSP 'Joe_John' , 'Project-3284NMD upgrade of exterior of home page BootStrap','5/11/2017 12:00:00 AM' , 'Task 2' -- typo error in user story where Managers is written Manager, compiles but doesnt work

EXEC ViewTasksSP 'Project-5651AMU chat page developing BootStrap','Assigned' -- typo error in user story where Tasks is written Task and Projects is written Project, but it works correctly 

-- end of yasmin's executions 






-----------

--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
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

--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a regular employee, I should be able to ...”
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1: Abdullah---------------------------------------------------------------------------------------------------

EXEC ViewProjectsOfEmployeeSP 'godfrey.love'


--2: Reda------------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful task view//the regular employee doesn't have tasks in this project
DECLARE @status0 BIT
EXEC ViewTasksInProjectSP 'Project-3284NMD upgrade of exterior of home page BootStrap', 'cam.percival', @status0 OUTPUT 
PRINT @status0
--successful task view
DECLARE @status1 BIT
EXEC ViewTasksInProjectSP 'Project-3284NMD upgrade of exterior of home page BootStrap', 'godfrey.love', @status1 OUTPUT 
PRINT @status1
--3: Gharam---------------------------------------------------------------------------------------------------------------------------------------------------------------
--unsuccessful task edit//task doesn't exist, or is not assigned to this staff member, or deadline passed
DECLARE @status0 BIT
EXEC FinalizeTaskSP 'godfrey.love','Task 1','5/9/2017 12:00:00 AM','Project-5651AMU chat page developing BootStrap',@status0 OUTPUT
PRINT @status0
--successful task edit
DECLARE @status1 BIT
EXEC FinalizeTaskSP 'godfrey.love','Task 1','12/30/2017 12:00:00 AM','Project-3284NMD upgrade of exterior of home page BootStrap',@status1 OUTPUT
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
EXEC AssignRegularToProjectSP 'Mohamed_Mahmoud','Project-3284NMD upgrade of exterior of home page BootStrap','claire.carles',@status1 OUTPUT
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


--8:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------


--9:Reda -------------------------------------------------------------------------------------------------------------------------------------------------------------------


--10:Gharam--------------------------------------------------------------------------------------------------------------------------------------------------------------------


--11:Yasmine-------------------------------------------------------------------------------------------------------------------------------------------------------------


--12:Abdullah---------------------------------------------------------------------------------------------------------------------------------------------------------