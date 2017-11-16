EXEC ViewDepartmentSP  'facebook.com','PHP-5019'

EXEC  UserLoginSP 'Yousef.Mustafa','1234'

EXEC ViewCompanySP 'facebook',' Palo Alto','computer marketing'


EXEC ViewCompanySP 'facebook.com' --View CompanySp exection
EXEC ViewDepartmentsOfCompanySP 'facebook.com' --View departments in a certian company

EXEC ViewCompaniesSalariesSP; --View companies ordered by their average salary
EXEC ApplyForJobSP 'gawwad.gooda','Employee- BootStrap Developer','BS-3291','facebook.com'

INSERT INTO Applications (seeker_username,job_title,department_code,company_domain,app_status) Values ('shadi.aly','Employee- BootStrap Developer','BS-3291','facebook.com','Accepted') 

EXEC ChooseJobFromAcceptedAppSP 
'shadi.aly','BS-3291','facebook.com','Employee- BootStrap Developer','Sunday' --Creates a referencing conflict 

EXEC ChooseJobFromAcceptedAppSP 
'shadi.aly','BS-3291','facebook.com','Employee- BootStrap Developer','Friday ' --Works correctly returns error