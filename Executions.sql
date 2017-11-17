﻿EXEC ViewDepartmentSP  'facebook.com','PHP-5019'

DECLARE @type INT;
EXEC  UserLoginSP 'Yousef.Mustafa','WWE123',@type OUTPUT
PRINT @type

EXEC ViewCompanySP 'facebook',' Palo Alto','computer marketing'

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

EXEC ViewCompaniesSalariesSP; --View companies ordered by their average salary

EXEC ApplyForJobSP 'gawwad.gooda','Employee- BootStrap Developer','BS-3291','facebook.com'

EXEC ChooseJobFromAcceptedAppSP 'shadi.aly','BS-3291','facebook.com','Employee- BootStrap Developer','Sunday' --Creates a referencing conflict 

EXEC ChooseJobFromAcceptedAppSP 'shadi.aly','BS-3291','facebook.com','Employee- BootStrap Developer','Friday ' --Works correctly returns error



EXEC RegisterToWebsite 'Mohamed_Zaki','123455','Zaki@guc.edu.eg','05/05/2012',10,'Mohamed','Zaki' --executes RegisterToWebsite Using inputs


EXEC StaffCheckInSp 'Mohamed_Mahmoud' --Making an exec for testing 
EXEC ManagerCreateProjectSP 'Ahmed_Mohamed','05/11/2015','10/10/2016','DATABASES'
EXEC ManagerCreateProjectSP 'Ahmed_Mohamed','05/11/2015','10/10/2016','DSD'

EXEC ViewCompanySP 'facebook.com' --View CompanySp exection
EXEC ViewDepartmentsOfCompanySP 'facebook.com' --View departments in a certian company
EXEC ViewMyScoreSP 'hassan_hasannen','Manager- Managing PHP Department','PHP-5019','facebook.com'--executiong ViewMyScore working 

--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As an registered/unregistered user, I should be able to ...”
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````


--1:Gharam---------------------------------------------------------------------------------------------------------------------------------------------------------




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


--6:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------



--7:Abdullah----------------------------------------------------------------------------------------------------------------------------



--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a registered user, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

--1:Reda--------------------------------------------------------------------------------------------------------------------------------------------------------


--2:Gharam ---------------------------------------------------------------------------------------------------------------------------------------------------------




--3:Yasmine -------------------------------------------------------------------------------------------------------------------------------------------------------------------


--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a job seeker, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1:Abdullah-------------------------------------------------------------------------------------------------------------------------------------------------------------------


--2:Reda----------------------------------------------------------------------------------------------------------------------------------------------------------------------- 



--3:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------------


--4:Yasmine---------------------------------------------------------------------------------------------------------------------------------------------------------------------



--5:Abdullah---------------------------------------------------------------------------------------------------------------------------------------------------------------------


--6:Reda----------------------------------------------------------------------------------------------------------------------------------------------------------------------



--`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--“As a staff member, I should be able to ...”
--``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````



--1:Gharam----------------------------------------------------------------------------------------------------------------------------------------------------------------------




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

