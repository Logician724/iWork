--put your creations in here
CREATE TABLE Users (
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
password VARCHAR(30) NOT NULL,
personal_email VARCHAR(70) NOT NULL,
birth_date DATETIME NOT NULL,
exp_year INT NOT NULL,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25) NOT NULL,
age  AS (YEAR(CURRENT_TIMESTAMP)-YEAR(birth_date))
);

CREATE TABLE USER_Prev_Jobs(
PRIMARY KEY(user_name, prev_job),
user_name VARCHAR(30)  NOT NULL,
prev_job VARCHAR(15)  NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Job_Seekers(
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

--Implementation of staff member has job relation missing, discussion is needed--
CREATE TABLE Staff_Members( 
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
day_off VARCHAR(15) NOT NULL,
no_annual_leaves INT NOT NULL,
salary INT NOT NULL,
company_email VARCHAR(70) NOT NULL,
department_code INT NOT NULL,
company_domain VARCHAR(50) NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
--Assumption: Removing a department results in removing all its staff members
FOREIGN KEY (department_code,company_domain) REFERENCES Departments(department_code,domain_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Attendances(
PRIMARY KEY (user_name,date),
user_name VARCHAR(30) NOT NULL,
date DATETIME NOT NULL,
start_time DATETIME NOT NULL,
leave_time DATETIME NOT NULL,
FOREIGN KEY (user_name) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Regular_Employees (
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Tasks(
PRIMARY KEY(deadline,name,project_name),
deadline DATETIME NOT NULL,
name VARCHAR(30) NOT NULL,
project_name VARCHAR(50) NOT NULL,
comments TEXT NOT NULL,
description TEXT NOT NULL,
regular_user_name VARCHAR(30) NOT NULL,
status VARCHAR(20) NOT NULL,
FOREIGN KEY (project_name) REFERENCES Projects(project_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Projects(
project_name VARCHAR(20) PRIMARY KEY NOT NULL,
start_date DATETIME NOT NULL,
end_date DATETIME NOT NULL,
);

CREATE TABLE Managers_Assign_Projects_To_Regulars(
PRIMARY KEY(manager_user_name,regular_user_name,project_name),
manager_user_name VARCHAR(30)  NOT NULL,
regular_user_name VARCHAR(30)  NOT NULL,
project_name VARCHAR(50)  NOT NULL,
FOREIGN KEY (manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE SET NULL,
FOREIGN KEY (regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE SET NULL ON UPDATE SET NULL,
FOREIGN KEY (project_name) REFERENCES Projects(project_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Managers_Assign_Tasks_To_Regulars(
PRIMARY KEY(manager_user_name,regular_user_name,task_name,task_deadline,project_name),
manager_user_name VARCHAR(30) NOT NULL,
regular_user_name VARCHAR(30) NOT NULL,
project_name VARCHAR(50) NOT NULL,
task_name VARCHAR(30) NOT NULL,
task_deadline DATETIME NOT NULL,
FOREIGN KEY(manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(task_name,task_deadline,project_name) REFERENCES Tasks(name,deadline,project_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Departments(
PRIMARY KEY (department_code, company_domain_name),
department_code INT NOT NULL,
name VARCHAR(50) NOT NULL,
company_domain_name VARCHAR(20) NOT NULL,
FOREIGN KEY (company_domain_name) REFERENCES Companies(domain_name)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Requests(
request_id INT PRIMARY KEY NOT NULL, 
end_date TIMESTAMP NOT NULL,
hr_response VARCHAR(20) NOT NULL,
hr_user_name VARCHAR(50) NOT NULL,
manager_response VARCHAR(20) NOT NULL,
manager_user_name VARCHAR(50) NOT NULL,
--no_of_leave_days INT AS (YEAR(end_date)-YEAR(start_date)),
request_date TIMESTAMP NOT NULL ,
reason_of_disapproval  VARCHAR(50) NOT NULL ,
start_date TIMESTAMP NOT NULL ,
FOREIGN KEY (hr_user_name) REFERENCES HR_Employees ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY  (manager_user_name) REFERENCES Managers ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Leave_Requests(
request_id INT PRIMARY KEY NOT NULL,
type VARCHAR(50) NOT NULL ,
--Adjustment: attribute type should be changed
FOREIGN KEY (request_id) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Business_Trip_Requests(
request_id INT PRIMARY KEY NOT NULL ,
trip_destination VARCHAR(50) NOT NULL ,
trip_purpose VARCHAR(50) NOT NULL, 
FOREIGN KEY (request_id) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE HR_Employees(
user_name VARCHAR(50) PRIMARY KEY NOT NULL, 
FOREIGN KEY (user_name) REFERENCES Staff_Members ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Jobs(
PRIMARY KEY (job_title,department_code,compamy_domain),
company_domain VARCHAR(50) NOT NULL ,
job_title VARCHAR(50) NOT NULL,
department_code INT NOT NULL, 
short_description VARCHAR(100) NOT NULL,
detailed_description TEXT NOT NULL,
salary INT NOT NULL,
min_years_experience INT NOT NULL,
working_hours INT NOT NULL,
vacancies INT NOT NULL,
application_deadline TIMESTAMP NOT NULL,
FOREIGN KEY (department_code, company_domain) REFERENCES Departments ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Replace_Managers(
PRIMARY KEY(user_name_request_owner,user_name_replacer,request_id),
request_id INT NOT NULL,
user_name_replacer VARCHAR(20) NOT NULL,
user_name_request_owner VARCHAR(20) NOT NULL,
FOREIGN KEY(user_name_request) REFERENCES Managers(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_name_request_owner) REFERENCES Managers(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(request_id) REFERENCES Request(request_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Replace_HRs(
PRIMARY KEY(user_name_request_owner,user_name_replacer,request_id),
request_id INT NOT NULL,
user_name_replacer VARCHAR(20) NOT NULL,
user_name_request_owner VARCHAR(20) NOT NULL,
FOREIGN KEY(user_name_request) REFERENCES HR_Employees(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_name_request_owner) REFERENCES HR_Employees(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(request_id) REFERENCES Request(request_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Replace_Regulars(
PRIMARY KEY(user_name_request_owner,user_name_replacer,request_id),
request_id INT NOT NULL,
user_name_replacer VARCHAR(20) NOT NULL,
user_name_request_owner VARCHAR(20) NOT NULL,
FOREIGN KEY(user_name_request) REFERENCES Regular_Employees(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_name_request_owner) REFERENCES Regular_Employees(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(request_id) REFERENCES Request(request_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Announcements(
PRIMARY KEY(domain_name,title,date),
date DATETIME NOT NULL,
domain_name VARCHAR(20) NOT NULL,
title VARCHAR(20) NOT NULL,
hr_user_name VARCHAR(20) NOT NULL,
description TEXT NOT NULL,
type VARCHAR(20) NOT NULL,
FOREIGN KEY(hr_user_name) REFERENCES HR_Employees(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(domain_name) REFERENCES Companys(domain_name) ON DELETE CASCADE ON UPDATE CASCADE
);


-- ROMY Was here--
<<<<<<< HEAD
create table Countries(
=======

Create table Managers(
user_name varchar(30) primary key not null,

manager_type varchar(20),

FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE,


);



create table Companies(
>>>>>>> b4f4b3781965edd847dd0df49d09675675a18cf5

 domain_name varchar(20) primary key not null, -- company_type ,_name etc are because these are predefined names in sql --
company_name varchar(20),
company_address varchar(20),

field varchar(20),
company_type varchar(20),
vision varchar(50),
email varchar(20),







);


Create table Companies_Phones(
PRIMARY KEY(phone,domain_name) ,
phone int not null,
domain_name varchar(20),

FOREIGN KEY (domain_name) REFERENCES Companies(domain_name) ON DELETE CASCADE ON UPDATE CASCADE
);

Create table Applications (
PRIMARY KEY(seeker_username,job_title,department_code,company_domain_name) ,
score int,
app_status varchar(20),
hr_response varchar(20),
manager_response varchar(20),
hr_username varchar(30),
manager_username varchar(30),
seeker_username varchar(30),
job_title varchar(20),
department_code INT NOT NULL, 
company_domain_name varchar(20),
FOREIGN KEY (seeker_username) REFERENCES Job_Seekers(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (manager_username) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (hr_username) REFERENCES HR_Employees(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (job_title,department_code, company_domain_name) REFERENCES Jobs(job_title,department_code, domain_name ) ON DELETE CASCADE ON UPDATE CASCADE,
);

Create table Emails(
primary key(time_sent,sender_user_name),
time_sent timestamp,
sender_email varchar(50),
recipient_email varchar(50),
email_subject varchar(20),
email_body varchar (100),
sender_user_name varchar(30),

FOREIGN KEY (sender_user_name) REFERENCES Staff_Members(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
);


-- Romy ended her work here --