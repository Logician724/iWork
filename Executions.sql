EXEC ViewDepartmentSP  'facebook.com','PHP-5019'

EXEC  UserLoginSP 'Yousef.Mustafa','1234'

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

