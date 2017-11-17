﻿EXEC ViewDepartmentSP  'facebook.com','PHP-5019'

DECLARE @type INT;
EXEC  UserLoginSP 'Yousef.Mustafa','WWE123',@type OUTPUT
PRINT @type

EXEC ViewQuetionsInInterviewSP  'Manager- Managing PHP Department','PHP-5019','facebook.com'

EXEC DeletePendingApplicationSP 'shadi.aly','Manager- Managing PHP Department','PHP-5019','facebook.com'

EXEC ViewAttendanceSP 'salma.tarek','2017-8-20','2017-8-22'

EXEC SendEmailSP 'andra.kyla','andra.kyla@facebook.com','Yousef.Mustafa','Yousef.Mustafa@facebook.com','Plan Delivery','To Mr. Yousef, I would like to inform you that the plan we agreed on has been revised and ready for delivery. When would you like us to deliver it? From, Andra'

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

EXEC ViewJobInformationSP 'Dina.AlMasry','Employee- Debuging Handling PHP Department' -- working right

EXEC ViewTop3RegularSp  -- shows a table but no values appear\\\\\\\\\\\\\\\\\\\\\\\\\

EXEC RegularFinalizesTaskSP 'cam.percival','Task 1','2017-7-13', 'Project-5651AMU chat page developing BootStrap' -- Works but be careful with your taskdeadline date should be > today .. careful

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
EXEC SearchCompanyByNameSP 'face'
EXEC SearchCompanyByTypeSP 'digital'
EXEC SearchCompanyByAddressSP 'Pal'


--2:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------




--3:Abdullah----------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO 
exec ViewCompanySP 'facebook.com'
GO 
exec ViewCompanySP 'google.com'
GO 
exec ViewCompanySP 'amazon.com'

GO
exec ViewDepartmentsOfCompanySP 'google.com'
GO
exec ViewDepartmentsOfCompanySP 'facebook.com'
GO
exec ViewDepartmentsOfCompanySP 'amazon.com'


--4:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--5:Gharam------------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC RegisterToWebsite 'Mohamed_Zaki','123455','Zaki@guc.edu.eg','05/05/1990',10,'Mohamed','Zaki'

--6:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------



--7:Abdullah----------------------------------------------------------------------------------------------------------------------------



--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a registered user, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

--1:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------


--2:Gharam ---------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC ViewUserInfoSP 'claire.carles'


--3:Yasmine -------------------------------------------------------------------------------------------------------------------------------------------------------------------


--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a job seeker, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1:Abdullah-------------------------------------------------------------------------------------------------------------------------------------------------------------------


--2:Reda----------------------------------------------------------------------------------------------------------------------------------------------------------------------- 



--3:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC ViewMyScoreSP 'omar.mofti', 'Manager- Managing PHP Department', 'PHP-5019', 'facebook.com'

--4:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------



--5:Abdullah---------------------------------------------------------------------------------------------------------------------------------------------------------------------


--6:Reda----------------------------------------------------------------------------------------------------------------------------------------------------------------------



--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a staff member, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC StaffCheckInSp 'claire.carles'



--2:Yasmine-------------------------------------------------------------------------------------------------------------------------------------------------------------------


--3:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------------



--4:Gharam-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


--5:Yasmine--------------------------------------------------------------------------------------------------------------------------------------------------------------------

--6:Abdullah-------------------------------------------------------------------------------------------------------------------------------------------------------------------


--7:Reda-----------------------------------------------------------------------------------------------------------------------------------------------------------------------



--8:Gharam------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--9:Yasmine-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--10:Abullah------------------------------------------------------------------------------------------------------------------------------------------------------------------




--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--	“As an HR employee, I should be able to ...”
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

--1:Reda-----------------------------------------------------------------------------------------------------------------------------------------------



--2:Gharam---------------------------------------------------------------------------------------------------------------------------------------------------

--3:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------

--4:Abdullah----------------------------------------------------------------------------------------------------------------------------------------------- 

--5:Reda------------------------------------------------------------------------------------------------------------------------------------------------



--6:Gharam--------------------------------------------------------------------------------------------------------------------------------------------------------------




--7:Yasmine----------------------------------------------------------------------------------------------------------------------------------------------------------------


--8:Yasmine------------------------------------------------------------------------------------------------------------------------------------------ 

--9:Abdullah ----------------------------------------------------------------------------------------------------------------------------------------


--10:Reda----------------------------------------------------------------------------------------------------------------------------------

--11:Gharam-------------------------------------------------------------------------------------------------------------------------------------------




--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a regular employee, I should be able to ...”
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1: Abdullah-


--2: Reda------------------------------------------------------------------------------------------------------------------------------------------------------------------



--3: Gharam---------------------------------------------------------------------------------------------------------------------------------------------------------------



--4: Yasmine-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a manager, I should be able to ...”
--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

--1:Gharam------------------------------------------------------------------------------------------------------------------------------------------------------------


--2:Abdullah ----------------------------------------------------------------------------------------------------------------------------------------------------------------


--3:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------------



--4:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------



--5:Abdullah-----------------------------------------------------------------------------------------------------------------------------------------------------------------


--6:Reda-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--7:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------- 


--8:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------


--9:Reda -------------------------------------------------------------------------------------------------------------------------------------------------------------------


--10:Gharam--------------------------------------------------------------------------------------------------------------------------------------------------------------------


--11:Yasmine-------------------------------------------------------------------------------------------------------------------------------------------------------------


--12:Abdullah---------------------------------------------------------------------------------------------------------------------------------------------------------