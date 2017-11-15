TRUNCATE TABLE HR_Employees;
TRUNCATE TABLE Managers;
TRUNCATE TABLE Regular_Employees;
TRUNCATE TABLE Job_Seekers;
TRUNCATE TABLE Staff_Members;
TRUNCATE TABLE Departments;
TRUNCATE TABLE Companies;

-- COMPANIES INSERTIONS
INSERT INTO Companies (domain_name,name,address,field,type,vision,email) 
VALUES('facebook.com','facebook',' Palo Alto','computer marketing',
		'social media','connection of all humanity','info@facebook.com');

INSERT INTO Companies (domain_name,name,address,field,type,vision,email)
VALUES('google.com','google','600 Amphitheatre Parkway in Mountain View, Santa Clara County, California, United States',
		'computer marketing','internet managing','have all humanity search through it','google@google.com');

INSERT INTO Companies (domain_name,name,address,field,type,vision,email)
VALUES('amazon.com','amazon','Beacon Hill neighborhood','computer marketing',
		'digital marketing','sell to all humanity','amazon@amazon.com');




--DEPARTMENTS INSERTIONS
INSERT INTO Departments (company_domain,department_code,name)
VALUES('facebook.com','PHP-5019','Facebook PHP handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('facebook.com','JS-8938','Facebook JS handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('facebook.com','BS-3291','Facebook BootStrap handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('amazon.com','MRC-8738','Amazon Merchandise handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('amazon.com','CSR-1263','Amazon CUSTOMER handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('amazon.com','WBST-2429','Amazon WEBSITE handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('google.com','LOC-4729','Google location handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('google.com','MPS-2849','Google Maps handlers');

INSERT INTO Departments (company_domain,department_code,name)
VALUES('google.com','SRC-2837','Google Search handlers');







--JOBS INSERTIONS

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES	('facebook.com','PHP-5019','Employee- PHP Developer','2/1/2010','coding in facebook pages using PHP coding language on back end coding',
3,10000,'coding in facebook with PHP',10,8)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('facebook.com','JS-8938','Employee- JS Developer','1/3/2012','coding in facebook pages using JS coding language on front end coding',
3,15000,'coding in facebook with JS',2,8)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('facebook.com','BS-3291','Employee- BootStrap Developer','1/7/2007','coding in facebook pages using BOOTSTRAP coding language on front end coding',
3,15000,'coding in facebook with BOOTSTRAP',7,8)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('amazon.com','MRC-8738','Employee- Merchandise Managing','5/12/2000',
'Handling merchandise where from storage, quality check, and posting to customers',1,5000,
'Handling merchandise in amazon',6,7)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('amazon.com','CSR-1263','Employee- Customer Managing','8/9/2017',
'Handling customer where from complaints, Refunds, and quality check with the customers',1,7000,
'Handling merchandise in amazon',8,7)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('amazon.com','WBST-2429','Employee- Website Developer','9/11/2010',
'Developing website with doing maintenance and making new websites',3,15000,
'website handling in amazon with BOOTSTRAP',1,7)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('google.com','LOC-4729','Employee- Developer in Location Department','12/8/2010',
'responsible for working for the location department presented by google by doing maintenance and contributions',
10,50000,'working in location department google',13,8)


INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES('google.com','MPS-2849','Employee- Developer in Maps Department','12/11/2011',
'responsible for working for the maps department presented by google with applying maintenance and contributions',
3,50000,'working in maps department google',25,8)

INSERT INTO Jobs (company_domain,department_code,job_title,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours) 
VALUES('google.com','SRC-2837','Employee- Developer in Search Department','5/1/2003',
'responsible for working for the search engine department presented by google with maintenance and contributions',
3,50000,'working in search engine department google',6,8)

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
 VALUES ('HR- PHP Web Programmer','facebook.com','PHP-5019','1/1/2018','detailed description',
2,4000,'short descriptions',10,8);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES ('HR- Application Developer','facebook.com','BS-3291','1/5/2018','detailed description',
2,3000,'short descriptions',5,10);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
 VALUES ('HR- Developer','facebook.com','JS-8938','10/12/2017',
 'We are looking for a skilled Web programmer to join our IT team. You’ll be responsible for designing, coding and improving our company web pages, programs and applications.',
3,5000,'Produce fully functional programs writing clean, testable code',5,8);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
VALUES ('HR- Cashier','amazon.com','MRC-8738','1/3/2018','Receive payment by cash, check, credit cards, vouchers, or automatic debits.',
5,6000,'Compute and record totals of transactions.',8,12);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
 VALUES ('HR- Customer Service','amazon.com','CSR-1263','12/30/2017','Assists with complaints, orders, errors, account questions, billing, cancelations, and other queries.',
5,8000,'Resolve customer complaints via phone, email, mail, or social media.',4,12);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
 VALUES ('HR- Web Developer','amazon.com','WBST-2429','1/11/2017',
 'Write well designed, testable, efficient code by using best software development practices. Create website layout/user interface by using standard HTML/CSS practices. Integrate data from various back-end services and databases.',
2,15000,'We are looking for an outstanding Web Developer to be responsible for the coding, innovative design and layout of our website.',6,10);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
 VALUES ('HR- Researcher','google.com','LOC-4729','1/1/2018','Research across Google is advancing the state-of-the-art in almost every domain of computer science. The scale at which Google operates allows research teams integrated throughout Google to pursue work of strategic interest, and makes the innovation behind our products possible.',
2,4000,'We tackle the most challenging problems in Computer Science and related fields',10,8);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
 VALUES ('HR- Designer','google.com','MPS-2849','1/20/2018','Although the work is mostly studio-based, travel within the working day to meet clients may be required. Working away from home, however, is rare.',
6,30000,'thinking creatively to produce new ideas and concepts and developing interactive design',13,6);

INSERT INTO Jobs(job_title,company_domain,department_code,application_deadline,detailed_description,
min_years_experience,salary,short_description,vacancies,working_hours)
 VALUES  ('HR- Search Engine Managing','google.com','SRC-2837','1/12/2018','Execute tests, collect and analyze data and results, identify trends and insights in order to achieve maximum ROI in paid search campaigns',
2,4000,'Research and implement search engine optimization recommendations',4,6);




--USERS INSERTIONS
INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES('Mohamed_Ahmed','1234','Mohamed.Ahmed@hotmail.com','16/4/1990',5,'Mohamed','Ahmed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES('Ahmed_Mohamed','1234','Ahmed.Mohamed@hotmail.com','18/5/1990',5,'Ahmed','Mohamed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mahmoud_Ahmed','1234','Mahmoud.Ahmed@hotmail.com','19/7/1990',5,'Mahmoud','Ahmed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Ahmed_Mahmoud','1234','Ahmed.Mahmoud@hotmail.com','12/11/1990',5,'Ahmed','Mahmoud');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mahmoud_Mohamed','1234','Mahmoud.Mohamed@hotmail.com','14/6/1990',5,'Mahmoud','Mohamed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mohamed_Mahmoud','1234','Mohamed.Mahmoud@hotmail.com','13/3/1990',5,'Mohamed','Mahmoud');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Joe_Matt','1234','Joe.Matt@hotmail.com','16/4/1980',15,'Joe','Matt');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Matt_Joe','1234','Matt.Joe@hotmail.com','18/5/1980',15,'Matt','Joe');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('John_Matt','1234','John.Matt@hotmail.com','19/7/1980',15,'John','Matt');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Matt_John','1234','Matt.John@hotmail.com','12/11/1980',15,'Matt','John');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Joe_John','1234','Joe.John@hotmail.com','14/6/1980',15,'Joe','John');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('John_Joe','1234','John.Joe@hotmail.com','13/3/1980',15,'John','Joe');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Bob_Mark','1234','Bob.Mark@hotmail.com','16/4/1970',25,'Bob','Mark');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mark_Bob','1234','Mark.Bob@hotmail.com','18/5/1970',25,'Mark','Bob');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Jack_Bob','1234','Jack.Bob@hotmail.com','19/7/1970',25,'Jack','Bob');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Bob_Jack','1234','Bob.Jack@hotmail.com','12/11/1970',25,'Bob','Jack');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES('Jack_Mark','1234','Joe.John@hotmail.com','14/6/1970',25,'Joe','John');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES('Mark_Jack','1234','Mark.Jack@hotmail.com','13/3/1970',25,'Mark','Jack');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('Yousef.Mustafa', 'WWE123','yousef.mustafa@gmail.com','12/11/1993',2,'Yousef', 'Mustafa'); 

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('Fayrouz.Hussain','02306FM','fayrouz.hussain@hotmail.com','06/23/1994',1,'Fayrouz','Hussain');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('Dina.AlMasry','DMAm111','dinamohamed@gmail.com','11/1/1990',5,'Dina', 'AlMasry');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('mirna.alteer','mirna12321','mirna.alteer@yahoo.com','2/2/1992',1,'Mirna','Alteer');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('sally.ramadan','miss341','sally@yahoo.com','2/5/1993',3,'Sally','Mohamed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('firdous.ahmed','afH12321','fifo12@gmail.com','12/9/1985',6,'Firdous','Ahmed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('hadeel.mohamed','Hadeel12321','hadeel@outlook.com','3/3/1992',0,'Hadeel','Moahmed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('islam.osama','osama00hs','islamosama@hotmail.com','10/10/1985',10,'Islam','Osama');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('mohamed.osama','ma1s8hds','mohamed.osama@gmail.com','10/2/1983',12,'Mohamed','Osama');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('dana.debs','ddns34','dana.debs1995@yahoo.com','2/9/1995',3,'Dana','Debs');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('ahmed.hussain','asdfg567','ahmedH@live.com','9/10/1990',3,'Ahmed','AlTayeb');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('amr.mohsen','rthdfv3435','amrMohsen@yahoo.com','7/20/1989',3,'Amr','Ahmed');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('dahlia.karass','dahkar238','karass.dahlia@outlook.com','12/10/1996',0,'Dahlia','Karas');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('ahmed.shehata','lps8034','ahmed.s@gmail.com','2/2/1984',6,'Ahmed','Morsey');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('youmna.marzook','seegsd0097','youmna.marzook@yahoo.com','5/27/1994',2,'Youmna','Marzook');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('bonita.bon','msibee90','bonita@yahoo.com','6/21/1960',15,'Bonita','Bon');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('basma.mohamed','soweds342','basma.mohamed@hotmail.com','3/2/1995',1,'Mirna','Alteer');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name) 
VALUES ('salma.tarek','tarek12321','salma.tarek@gmail.com','8/9/1990',2,'Salma','Hussain');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('claire.carles','MyPassword2017','claireX@gmail.com','12/10/1995',5,'claire','carles');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('clark.maurine','coolPass168','clarky222@gmail.com','7/5/1992',7,'Clark','Maurine');
	
INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('wade.brandee','sakamotokun-japan','woodybrand@gmail.com','9/9/1993',9,'Wade','Brandee');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('andra.kyla','qwerty15690','androla334@gmail.com','8/7/1990',10,'Andra','Kyla');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('rosannah.humphrey','HisPasswordiseasy','rosyno4@gmail.com','9/10/1998',10,'Rosannah','Humprey');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('marisa.lavender','passuwadu','smartxd998@gmail.com','11/11/1987',10,'Marisa','Lavender');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('elisabeth.aveline','elipassword6698','sotired889@gmail.com','9/9/1991',8,'Elisabeth','Aveline');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('sunny.debbie','ghpass9978','sunshinedip@gmail.com','8/8/1988',13,'Sunny','Debbie');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('coral.gaye','coryhas998','coralbe88@gmail.com','8/7/1990',3,'Coral','Gaye');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('sherwood.alysa','sherryPass999','sherwood198@gmail.com','1/2/1991',4,'Sherwood','Alysa');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('van.krystal','vanyou778','vanny44@gmail.com','19/8/1993',5,'Van','Krystal');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('cam.percival','cammyouw2019','camerahere778@gmail.com','1/1/1990',8,'Cam','Percival');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('mindy.adella','mindyou7709','mindour445@gmail.com','2/4/1981',5,'Mindy','Adella');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('juliana.clover','juliyo6690','juli-killer@gmail.com','8/8/1988',9,'Juliana','Clover');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('wilburn.theresa','wilburnyxd88xdxd','willyburning@gmail.com','7/6/1984',3,'Wilburn','Theresa');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('octavia.harlan','octano88','octave9@gmail.com','7/6/1989',3,'Octavia','Harlen');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('tracee.charlton','tracemexd1998','tracer.tracee882@gmail.com','8/8/1991',6,'Tracee','Charlton');

INSERT INTO Users (user_name,password,personal_email,birth_date,exp_year,first_name,last_name)
VALUES ('godfrey.love','holypass12345','banme1998j@gmail.com','7/8/1991',6,'Godgfrey','Love');



--STAFF MEMBERS INSERTIONS
INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Mohamed_Ahmed','Saturday',30,10000,'MANAGERS PHP DEVELOPER','PHP-5019','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Ahmed_Mohamed','Saturday',30,10000,'MANAGERS PHP DEVELOPER','PHP-5019','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Mahmoud_Ahmed','Sunday',30,15000,'MANAGERS JS DEVELOPER','JS-8938','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Ahmed_Mahmoud','Sunday',30,15000,'MANAGERS JS DEVELOPER','JS-8938','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Mahmoud_Mohamed','Sunday',30,15000,'MANAGERS JS DEVELOPER','BS-3291','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Mohamed_Mahmoud','Sunday',30,15000,'MANAGERS BOOTSTRAP DEVELOPER','BS-3291','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain) 
VALUES('Joe_Matt','Sunday',30,5000,'MANAGERS MERCHANDISE MANAGING','MRC-8738','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Matt_Joe','Sunday',30,5000,'MANAGERS MERCHANDISE MANAGING','MRC-8738','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('John_Matt','Sunday',30,7000,'MANAGERS CUSTOMER MANAGING','CSR-1263','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Matt_John','Sunday',30,7000,'MANAGERS CUSTOMER MANAGING','CSR-1263','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Joe_John','Sunday',30,15000,'MANAGERS WEBSITE DEVELOPER','WBST-2429','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('John_Joe','Sunday',30,15000,'MANAGERS WEBSITE DEVELOPER','WBST-2429','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain) 
VALUES('Bob_Mark','Monday',30,50000,'MANAGERS LOCATION MANAGING','LOC-4729','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Mark_Bob','Monday',30,50000,'MANAGERS LOCATION MANAGING','LOC-4729','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Jack_Bob','Monday',30,50000,'MANAGERS MAPS MANAGING','MPS-2849','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Bob_Jack','Monday',30,50000,'MANAGERS MAPS MANAGING','MPS-2849','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Jack_Mark','Monday',30,50000,'MANAGERS SEARCH MANAGING','SRC-2837','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('Mark_Jack','Monday',30,50000,'MANAGERS SEARCH MANAGING','SRC-2837','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('claire.carles','Monday',23,2000,'leave','PHP-5019','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('clark.maurine','Tuesday',30,5000,'leave','PHP-5019','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('wade.brandee','Wednesday',16,10000,'leave','JS-8938','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('andra.kyla','Thursday',1,90000,'leave','JS-8938','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('rosannah.humphrey','Sunday',10,8599,'leave','BS-3291','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('marisa.lavender','Saturday',9,4500,'leave','BS-3291','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('elisabeth.aveline','Monday',13,6300,'leave','MRC-8738','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('sunny.debbie','Tuesday','leave','MRC-8738','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('coral.gaye','Wednesday',18,9000,'leave','CSR-1263','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES ('sherwood.alysa','Tuesday',15,8700,'leave','CSR-1263','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('van.krystal','Thursday',29,9000,'leave','WBST-2429','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('cam.percival','Monday',14,9500,'leave','WBST-2429','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('mindy.adella','Tuesday',19,7800,'leave','LOC-4729','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('juliana.clover','Saturday',11,8000,'leave','LOC-4729','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('wilburn.theresa','Tuesday',29,70000,'leave','MPS-2849','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('octavia.harlan','Wednesday',13,8000,'leave','MPS-2849','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('tracee.charlton','Monday',17,8000,'leave','SRC-2837','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,job_title,department_code,company_domain)
VALUES('godfrey.love','Tuesday',21,10000,'leave','SRC-2837','google.com');


INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('salma.adel','Saturday',3,4000,'x','HR PHP Web Programmer','PHP-5019','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('yasmeen.sameh','Saturday',2,4000,'x','HR PHP Web Programmer','PHP-5019','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('hajer.haitham','Sunday',4,3000,'x','HR BS-3291 Application Developer','BS-3291','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('mirna.alteer','Monday',1,3000,'x','HR BS-3291 Application Developer','BS-3291','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('sally.ramadan','Friday',1,5000,'x','HR JS-8938 Developer','JS-8938','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('firdous.ahmed','Tuesday',2,5000,'x','HR JS-8938 Developer','JS-8938','facebook.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('hadeel.mohamed','Sunday',3,6000,'x','HR MRC-8738 Cashier','MRC-8738','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('islam.osama','Sunday',2,6000,'x','HR MRC-8738 Cashier','MRC-8738','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('mohamed.osama','Monday',2,8000,'x','HR CSR-1263 Customer Service','CSR-1263','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('dana.debs','Sunday',2,8000,'x','HR CSR-1263 Customer Service','CSR-1263','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('ahmed.hussain','Sunday',1,15000,'x','HR WBST-2429 Web Developer','WBST-2429','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('amr.mohsen','Monday',1,15000,'x','HR WBST-2429 Web Developer','WBST-2429','amazon.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('dahlia.karass','Sunday',1,4000,'x','HR LOC-4729 Researcher','LOC-4729','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('ahmed.shehata','Sunday',1,4000,'x','HR LOC-4729 Researcher','LOC-4729','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('youmna.marzook','Tuesday',2,30000,'x','HR MPS-2849 Designer','MPS-2849','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('bonita.bon','Tuesday',2,30000,'x','HR MPS-2849 Designer','MPS-2849','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('basma.mohamed','Friday',2,4000,'x','HR SRC-2837 Search Engine Managing','SRC-2837','google.com');

INSERT INTO Staff_Members (user_name,day_off,no_annual_leaves,salary,company_email,job_title,department_code,company_domain)
VALUES ('salma.tarek','Tuesday',2,4000,'x','HR SRC-2837 Search Engine Managing','SRC-2837','google.com');




--MANAGERS INSERTIONS
INSERT INTO Managers (user_name,type)
VALUES('Mohamed_Ahmed','HR');

INSERT INTO Managers (user_name,type)
VALUES('Ahmed_Mohamed','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Mahmoud_Ahmed','Regular Employee');

INSERT INTO Managers (user_name,type)
VALUES('Ahmed_Mahmoud','HR');

INSERT INTO Managers (user_name,type)
VALUES('Mahmoud_Mohamed','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Mohamed_Mahmoud','Regular Eployee');

INSERT INTO Managers (user_name,type)
VALUES('Joe_Matt','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Matt_Joe','Manager');

INSERT INTO Managers (user_name,type)
VALUES('John_Matt','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Matt_John','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Joe_John','Manager');

INSERT INTO Managers (user_name,type)
VALUES('John_Joe','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Bob_Mark','HR');

INSERT INTO Managers (user_name,type)
VALUES('Mark_Bob','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Jack_Bob','Regular Employee');

INSERT INTO Managers (user_name,type)
VALUES('Bob_Jack','HR');

INSERT INTO Managers (user_name,type)
VALUES('Jack_Mark','Manager');

INSERT INTO Managers (user_name,type)
VALUES('Mark_Jack','Regular Eployee');

--RERGULARS INSERTIONS
INSERT INTO RegularEmployees (user_name)
VALUES('claire.carles');
INSERT INTO RegularEmployees (user_name)
VALUES('clark.maurine');
INSERT INTO RegularEmployees (user_name)
VALUES('wade.brandee');
INSERT INTO RegularEmployees (user_name)
VALUES('andra.kyla');
INSERT INTO RegularEmployees (user_name)
VALUES('rosannah.humphrey');
INSERT INTO RegularEmployees (user_name)
VALUES('marisa.lavender');
INSERT INTO RegularEmployees (user_name)
VALUES('elisabeth.aveline');
INSERT INTO RegularEmployees (user_name)
VALUES('sunny.debbie');
INSERT INTO RegularEmployees (user_name)
VALUES('coral.gaye');
INSERT INTO RegularEmployees (user_name)
VALUES('sherwood.alysa');
INSERT INTO RegularEmployees (user_name)
VALUES('van.krystal');
INSERT INTO RegularEmployees (user_name)
VALUES('cam.percival');
INSERT INTO RegularEmployees (user_name)
VALUES('mindy.adella');
INSERT INTO RegularEmployees (user_name)
VALUES('juliana.clover');
INSERT INTO RegularEmployees (user_name)
VALUES('wilburn.theresa');
INSERT INTO RegularEmployees (user_name)
VALUES('octavia.harlan');
INSERT INTO RegularEmployees (user_name)
VALUES('tracee.charlton');
INSERT INTO RegularEmployees (user_name)
VALUES('godfrey.love');


--JOB SEEKER INSERTIONS

INSERT INTO Job_Seekers (user_name) VALUES ('Yousef.Mustafa')

INSERT INTO Job_Seekers (user_name) VALUES ('Fayrouz.Hussain')

INSERT INTO Job_Seekers (user_name) VALUES ('Dina.AlMasry')

