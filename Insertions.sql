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
