-- COMPANIES INSERTIONS
INSERT INTO Companies (domain_name,name,address,field,type,vision,email) 
VALUES('facebook.com','facebook',' Palo Alto','computer marketing',
		'social media','connection of all humanity','info@facebook.com')

INSERT INTO Companies (domain_name,name,address,field,type,vision,email)
VALUES('google.com','google','600 Amphitheatre Parkway in Mountain View, Santa Clara County, California, United States',
		'computer marketing','internet managing','have all humanity search through it','google@google.com')

INSERT INTO Companies (domain_name,name,address,field,type,vision,email)
VALUES('amazon.com','amazon','Beacon Hill neighborhood','computer marketing',
		'digital marketing','sell to all humanity','amazon@amazon.com')


INSERT INTO Users VALUES ('Yousef.Mustafa', 'WWE123','yousef.mustafa@gmail.com','12/11/1993',2,'Yousef', 'Mustafa'); 
INSERT INTO Users VALUES ('Fayrouz.Hussain','02306FM','fayrouz.hussain@hotmail.com','06/23/1994',1,'Fayrouz','Hussain');
INSERT INTO Users VALUES ('Dina.AlMasry','DMAm111','dinamohamed@gmail.com','11/1/1990',5,'Dina', 'AlMasry');
INSERT INTO Users VALUES ('mirna.alteer','mirna12321','mirna.alteer@yahoo.com','2/2/1992',1,'Mirna','Alteer');
INSERT INTO Users VALUES ('sally.ramadan','miss341','sally@yahoo.com','2/5/1993',3,'Sally','Mohamed');
INSERT INTO Users VALUES ('firdous.ahmed','afH12321','fifo12@gmail.com','12/9/1985',6,'Firdous','Ahmed');
INSERT INTO Users VALUES ('hadeel.mohamed','Hadeel12321','hadeel@outlook.com','3/3/1992',0,'Hadeel','Moahmed');
INSERT INTO Users VALUES ('islam.osama','osama00hs','islamosama@hotmail.com','10/10/1985',10,'Islam','Osama');
INSERT INTO Users VALUES ('mohamed.osama','ma1s8hds','mohamed.osama@gmail.com','10/2/1983',12,'Mohamed','Osama');
INSERT INTO Users VALUES ('dana.debs','ddns34','dana.debs1995@yahoo.com','2/9/1995',3,'Dana','Debs');
INSERT INTO Users VALUES ('ahmed.hussain','asdfg567','ahmedH@live.com','9/10/1990',3,'Ahmed','AlTayeb');
INSERT INTO Users VALUES ('amr.mohsen','rthdfv3435','amrMohsen@yahoo.com','7/20/1989',3,'Amr','Ahmed');
INSERT INTO Users VALUES ('dahlia.karass','dahkar238','karass.dahlia@outlook.com','12/10/1996',0,'Dahlia','Karas');
INSERT INTO Users VALUES ('ahmed.shehata','lps8034','ahmed.s@gmail.com','2/2/1984',6,'Ahmed','Morsey');
INSERT INTO Users VALUES ('youmna.marzook','seegsd0097','youmna.marzook@yahoo.com','5/27/1994',2,'Youmna','Marzook');
INSERT INTO Users VALUES ('bonita.bon','msibee90','bonita@yahoo.com','6/21/1960',15,'Bonita','Bon');
INSERT INTO Users VALUES ('basma.mohamed','soweds342','basma.mohamed@hotmail.com','3/2/1995',1,'Mirna','Alteer');
INSERT INTO Users VALUES ('salma.tarek','tarek12321','salma.tarek@gmail.com','8/9/1990',2,'Salma','Hussain');



INSERT INTO Job_Seekers VALUES ('Yousef.Mustafa');
INSERT INTO Job_Seekers VALUES ('Fayrouz.Hussain');
INSERT INTO Job_Seekers VALUES ('Dina.AlMasry');

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

