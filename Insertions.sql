﻿-- COMPANIES INSERTIONS
INSERT INTO Companies (domain_name,name,address,field,type,vision,email) 
VALUES('facebook.com','facebook',' Palo Alto','computer marketing',
		'social media','connection of all humanity','info@facebook.com')

INSERT INTO Companies (domain_name,name,address,field,type,vision,email)
VALUES('google.com','google','600 Amphitheatre Parkway in Mountain View, Santa Clara County, California, United States',
		'computer marketing','internet managing','have all humanity search through it','google@google.com')

INSERT INTO Companies (domain_name,name,address,field,type,vision,email)
VALUES('amazon.com','amazon','Beacon Hill neighborhood','computer marketing',
		'digital marketing','sell to all humanity','amazon@amazon.com')




--DEPARTMENTS INSERTIONS
INSERT INTO Departments (company_domain,department_code,name)
VALUES('facebook.com','PHP-5019','Facebook PHP handlers ')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('facebook.com','JS-8938','Facebook JS handlers')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('facebook.com','BS-3291','Facebook BootStrap handlers')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('amazon.com','MRC-8738','Amazon Merchandise handlers')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('amazon.com','CSR-1263','Amazon CUSTOMER handlers')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('amazon.com','WBST-2429','Amazon WEBSITE handlers')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('google.com','LOC-4729','Google location handlers')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('google.com','MPS-2849','Google Maps handlers')

INSERT INTO Departments (company_domain,department_code,name)
VALUES('google.com','SRC-2837','Google Search handlers')






--JOBS INSERTIONS
INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES	('facebook.com','PHP-5019','MANAGERS PHP DEVELOPER',1/1/2014,'coding in facebook pages using PHP coding language on back end coding',
3,10000,'coding in facebook with PHP',10,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('facebook.com','JS-8938','MANAGERS JS DEVELOPER',1/1/2014,'coding in facebook pages using JS coding language on front end coding',
3,15000,'coding in facebook with JS',10,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('facebook.com','BS-3291','MANAGERS BOOTSTRAP DEVELOPER',1/1/2014,'coding in facebook pages using BOOTSTRAP coding language on front end coding',
3,15000,'coding in facebook with BOOTSTRAP',10,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('amazon.com','MRC-8738','MANAGERS MERCHANDISE MANAGING',19/11/2010,
'Handling merchandise where from storage, quality check, and posting to customers',1,5000,
'Handling merchandise in amazon',7,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('amazon.com','CSR-1263','MANAGERS CUSTOMER MANAGING',19/11/2010,
'Handling customer where from complaints, Refunds, and quality check with the customers',1,7000,
'Handling merchandise in amazon',7,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('amazon.com','WBST-2429','MANAGERS WEBSITE MANAGING',19/11/2010,
'Handling website where from maintenance and making new websites',3,15000,
'website handling in amazon with BOOTSTRAP',7,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('google.com','LOC-4729','MANAGERS LOCATION MANAGING',1/11/2010,
'responsible for handling the location feature presented by google with maintenance and inventions',
10,50000,'handling location feature google',10,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('google.com','MPS-2849','MANAGERS MAPS MANAGING',1/11/2010,
'responsible for handling the maps feature presented by google with maintenance and inventions',
3,50000,'handling maps feature google',10,9)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours) 
VALUES('google.com','SRC-2837','MANAGERS SEARCH MANAGING',1/11/2010,
'responsible for handling the search feature presented by google with maintenance and inventions',
3,50000,'handling search feature google',10,9)







--USERS INSERTIONS
INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES('Mohamed_Ahmed','1234','Mohamed.Ahmed@hotmail.com','16/4/1990',5,'Mohamed','Ahmed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES('Ahmed_Mohamed','1234','Ahmed.Mohamed@hotmail.com','18/5/1990',5,'Ahmed','Mohamed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mahmoud_Ahmed','1234','Mahmoud.Ahmed@hotmail.com','19/7/1990',5,'Mahmoud','Ahmed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Ahmed_Mahmoud','1234','Ahmed.Mahmoud@hotmail.com','12/11/1990',5,'Ahmed','Mahmoud')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mahmoud_Mohamed','1234','Mahmoud.Mohamed@hotmail.com','14/6/1990',5,'Mahmoud','Mohamed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mohamed_Mahmoud','1234','Mohamed.Mahmoud@hotmail.com','13/3/1990',5,'Mohamed','Mahmoud')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Joe_Matt','1234','Joe.Matt@hotmail.com','16/4/1980',15,'Joe','Matt')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Matt_Joe','1234','Matt.Joe@hotmail.com','18/5/1980',15,'Matt','Joe')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('John_Matt','1234','John.Matt@hotmail.com','19/7/1980',15,'John','Matt')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Matt_John','1234','Matt.John@hotmail.com','12/11/1980',15,'Matt','John')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Joe_John','1234','Joe.John@hotmail.com','14/6/1980',15,'Joe','John')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('John_Joe','1234','John.Joe@hotmail.com','13/3/1980',15,'John','Joe')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Bob_Mark','1234','Bob.Mark@hotmail.com','16/4/1970',25,'Bob','Mark')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mark_Bob','1234','Mark.Bob@hotmail.com','18/5/1970',25,'Mark','Bob')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Jack_Bob','1234','Jack.Bob@hotmail.com','19/7/1970',25,'Jack','Bob')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Bob_Jack','1234','Bob.Jack@hotmail.com','12/11/1970',25,'Bob','Jack')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES('Jack_Mark','1234','Joe.John@hotmail.com','14/6/1970',25,'Joe','John')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mark_Jack','1234','Mark.Jack@hotmail.com','13/3/1970',25,'Mark','Jack')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('Yousef.Mustafa', 'WWE123','yousef.mustafa@gmail.com','12/11/1993',2,'Yousef', 'Mustafa') 

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('Fayrouz.Hussain','02306FM','fayrouz.hussain@hotmail.com','06/23/1994',1,'Fayrouz','Hussain')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('Dina.AlMasry','DMAm111','dinamohamed@gmail.com','11/1/1990',5,'Dina', 'AlMasry')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('mirna.alteer','mirna12321','mirna.alteer@yahoo.com','2/2/1992',1,'Mirna','Alteer')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('sally.ramadan','miss341','sally@yahoo.com','2/5/1993',3,'Sally','Mohamed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('firdous.ahmed','afH12321','fifo12@gmail.com','12/9/1985',6,'Firdous','Ahmed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('hadeel.mohamed','Hadeel12321','hadeel@outlook.com','3/3/1992',0,'Hadeel','Moahmed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('islam.osama','osama00hs','islamosama@hotmail.com','10/10/1985',10,'Islam','Osama')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('mohamed.osama','ma1s8hds','mohamed.osama@gmail.com','10/2/1983',12,'Mohamed','Osama')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('dana.debs','ddns34','dana.debs1995@yahoo.com','2/9/1995',3,'Dana','Debs')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('ahmed.hussain','asdfg567','ahmedH@live.com','9/10/1990',3,'Ahmed','AlTayeb')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('amr.mohsen','rthdfv3435','amrMohsen@yahoo.com','7/20/1989',3,'Amr','Ahmed')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('dahlia.karass','dahkar238','karass.dahlia@outlook.com','12/10/1996',0,'Dahlia','Karas')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('ahmed.shehata','lps8034','ahmed.s@gmail.com','2/2/1984',6,'Ahmed','Morsey')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('youmna.marzook','seegsd0097','youmna.marzook@yahoo.com','5/27/1994',2,'Youmna','Marzook')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('bonita.bon','msibee90','bonita@yahoo.com','6/21/1960',15,'Bonita','Bon')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('basma.mohamed','soweds342','basma.mohamed@hotmail.com','3/2/1995',1,'Mirna','Alteer')

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('salma.tarek','tarek12321','salma.tarek@gmail.com','8/9/1990',2,'Salma','Hussain')



--STAFF MEMBERS INSERTIONS
INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Mohamed_Ahmed','Saturday',30,10000,'x','MANAGERS PHP DEVELOPER','PHP-5019','facebook.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Ahmed_Mohamed','Saturday',30,10000,'x','MANAGERS PHP DEVELOPER','PHP-5019','facebook.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Mahmoud_Ahmed','Sunday',30,15000,'x','MANAGERS JS DEVELOPER','JS-8938','facebook.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Ahmed_Mahmoud','Sunday',30,15000,'x','MANAGERS JS DEVELOPER','JS-8938','facebook.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Mahmoud_Mohamed','Sunday',30,15000,'x','MANAGERS JS DEVELOPER','BS-3291','facebook.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Mohamed_Mahmoud','Sunday',30,15000,'x','MANAGERS BOOTSTRAP DEVELOPER','BS-3291','facebook.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain) 
VALUES('Joe_Matt','Sunday',30,5000,'y','MANAGERS MERCHANDISE MANAGING','MRC-8738','amazon.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Matt_Joe','Sunday',30,5000,'y','MANAGERS MERCHANDISE MANAGING','MRC-8738','amazon.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('John_Matt','Sunday',30,7000,'y','MANAGERS CUSTOMER MANAGING','CSR-1263','amazon.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Matt_John','Sunday',30,7000,'y','MANAGERS CUSTOMER MANAGING','CSR-1263','amazon.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Joe_John','Sunday',30,15000,'y','MANAGERS WEBSITE DEVELOPER','WBST-2429','amazon.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('John_Joe','Sunday',30,15000,'y','MANAGERS WEBSITE DEVELOPER','WBST-2429','amazon.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain) 
VALUES('Bob_Mark','Monday',30,50000,'y','MANAGERS LOCATION MANAGING','LOC-4729','google.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Mark_Bob','Monday',30,50000,'y','MANAGERS LOCATION MANAGING','LOC-4729','google.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Jack_Bob','Monday',30,50000,'y','MANAGERS MAPS MANAGING','MPS-2849','google.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Bob_Jack','Monday',30,50000,'y','MANAGERS MAPS MANAGING','MPS-2849','google.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Jack_Mark','Monday',30,50000,'y','MANAGERS SEARCH MANAGING','SRC-2837','google.com')

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES('Mark_Jack','Monday',30,50000,'y','MANAGERS SEARCH MANAGING','SRC-2837','google.com')



--MANAGERS INSERTIONS
INSERT INTO Managers (user_name,type) VALUES('Mohamed_Ahmed','HR')

INSERT INTO Managers (user_name,type) VALUES('Ahmed_Mohamed','Manager')

INSERT INTO Managers (user_name,type) VALUES('Mahmoud_Ahmed','Regular Employee')

INSERT INTO Managers (user_name,type) VALUES('Ahmed_Mahmoud','HR')

INSERT INTO Managers (user_name,type) VALUES('Mahmoud_Mohamed','Manager')

INSERT INTO Managers (user_name,type) VALUES('Mohamed_Mahmoud','Regular Eployee')

INSERT INTO Managers (user_name,type) VALUES('Joe_Matt','Manager')

INSERT INTO Managers (user_name,type) VALUES('Matt_Joe','Manager')

INSERT INTO Managers (user_name,type) VALUES('John_Matt','Manager')

INSERT INTO Managers (user_name,type) VALUES('Matt_John','Manager')

INSERT INTO Managers (user_name,type) VALUES('Joe_John','Manager')

INSERT INTO Managers (user_name,type) VALUES('John_Joe','Manager')

INSERT INTO Managers (user_name,type) VALUES('Bob_Mark','HR')

INSERT INTO Managers (user_name,type) VALUES('Mark_Bob','Manager')

INSERT INTO Managers (user_name,type) VALUES('Jack_Bob','Regular Employee')

INSERT INTO Managers (user_name,type) VALUES('Bob_Jack','HR')

INSERT INTO Managers (user_name,type) VALUES('Jack_Mark','Manager')

INSERT INTO Managers (user_name,type) VALUES('Mark_Jack','Regular Eployee')



--JOB SEEKER INSERTIONS

INSERT INTO Job_Seekers (user_name) VALUES ('Yousef.Mustafa')

INSERT INTO Job_Seekers (user_name) VALUES ('Fayrouz.Hussain')

INSERT INTO Job_Seekers (user_name) VALUES ('Dina.AlMasry')
