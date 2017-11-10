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
day_off VARCHAR(10) NOT NULL,
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
date DATE NOT NULL,
start_time TIME NOT NULL,
leave_time TIME NOT NULL,
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
comments TEXT NULL,
description TEXT NULL,
status VARCHAR(10) NOT NULL,
FOREIGN KEY (project_name) REFERENCES Projects(project_name) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT CHK_status CHECK(status = 'Open' OR status = 'Assigned' OR status = 'Fixed' or status = 'Closed')
);

CREATE TABLE Projects(
project_name VARCHAR(20) PRIMARY KEY NOT NULL,
manager_user_name VARCHAR(30) NULL,
start_date DATETIME NOT NULL,
end_date DATETIME NOT NULL,
FOREIGN KEY(manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Managers_Assign_Projects_To_Regulars(
PRIMARY KEY(regular_user_name,project_name),
regular_user_name VARCHAR(30) NOT NULL,	
project_name VARCHAR(100) NOT NULL,
manager_user_name VARCHAR(30) NULL,
FOREIGN KEY (manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (project_name) REFERENCES Projects(project_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Managers_Assign_Tasks_To_Regulars(
PRIMARY KEY(task_name,task_deadline,project_name),
manager_user_name VARCHAR(30) NULL,
regular_user_name VARCHAR(30) NULL,
project_name VARCHAR(50) NOT NULL,
task_name VARCHAR(30) NOT NULL,
task_deadline DATETIME NOT NULL,
FOREIGN KEY(manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(task_name,task_deadline,project_name) REFERENCES Tasks(name,deadline,project_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Departments(
PRIMARY KEY (demartment_code, company_domain_name),
company_domain_name VARCHAR(150) NOT NULL,
department_code VARCHAR(30) NOT NULL,
name VARCHAR(70) NOT NULL,
FOREIGN KEY (company_domain_name) REFERENCES Company(domain_name)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Requests(
request_id INT PRIMARY KEY NOT NULL IDENTITY(1,1), 
end_date DATETIME NOT NULL,
hr_response VARCHAR(20) NOT NULL,
hr_user_name VARCHAR(30) NULL,
manager_response VARCHAR(20) NOT NULL,
manager_user_name VARCHAR(30) NULL,
--no_of_leave_days INT AS (TIMESTAMPDIFF(YEAR,end_date,start_date)) ,   
request_date DATETIME NOT NULL,
reason_of_disapproval TEXT NULL,
start_date DATETIME NOT NULL,
FOREIGN KEY (hr_user_name) REFERENCES HR_Employees(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT CHK_hr_respose CHECK(hr_response = 'Accepted' OR hr_response = 'Rejected' OR hr_response = NULL),
CONSTRAINT CHK_manager_response CHECK(manager_response = 'Accepted' OR manager_response = 'Rejected' OR manager_response = NULL)
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
department_code INT NOT NULL, 
job_title VARCHAR(50) NOT NULL,
application_deadline TIMESTAMP NOT NULL,
detailed_description TEXT NOT NULL,
min_years_experience INT NOT NULL,
salary INT NOT NULL,
short_description VARCHAR(100) NOT NULL,
vacancies INT NOT NULL,
working_hours INT NOT NULL,
FOREIGN KEY (department_code, company_domain) REFERENCES Departments ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Managers(
user_name VARCHAR(50) PRIMARY KEY NOT NULL ,
type VARCHAR(50) NOT NULL,
FOREIGN KEY (user_name) REFERENCES Staff_Members
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
CREATE TABLE Managers(
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
manager_type VARCHAR(20),
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Companies(
domain_name VARCHAR(20) PRIMARY KEY NOT NULL, -- company_type ,_name etc are because these are predefined names in sql --
company_name VARCHAR(20),
company_address VARCHAR(20),
field VARCHAR(20),
company_type VARCHAR(20),
vision VARCHAR(50),
email VARCHAR(20),
);

CREATE TABLE Companies_Phones(
PRIMARY KEY(phone,domain_name),
phone INT NOT NULL,
domain_name VARCHAR(20),
FOREIGN KEY (domain_name) REFERENCES Companies(domain_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Applications (
PRIMARY KEY(seeker_username,job_title,department_code,company_domain_name) ,
score INT,
app_status VARCHAR(20),
hr_response VARCHAR(20),
manager_response VARCHAR(20),
hr_username VARCHAR(30),
manager_username VARCHAR(30),
seeker_username VARCHAR(30),
job_title VARCHAR(20),
department_code INT NOT NULL, 
company_domain_name VARCHAR(20),
FOREIGN KEY (seeker_username) REFERENCES Job_Seekers(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (manager_username) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (hr_username) REFERENCES HR_Employees(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (job_title,department_code, company_domain_name) REFERENCES Jobs(job_title,department_code, domain_name ) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Emails(
PRIMARY KEY(time_sent,sender_user_name),
time_sent TIMESTAMP,
sender_email VARCHAR(50),
recipient_email VARCHAR(50),
email_subject VARCHAR(20),
email_body VARCHAR (100),
sender_user_name VARCHAR(30),
FOREIGN KEY (sender_user_name) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Staff_Receives_Email(
PRIMARY KEY(time_sent,sender_user_name,receipent_username),
time_sent TIMESTAMP,
sender_username VARCHAR(30),
receipent_username VARCHAR(30),
FOREIGN KEY(time_sent,sender_user_name) REFERENCES Emails(time_sent,sender_user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(receipent_username) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Questions(
question_title VARCHAR(50) PRIMARY KEY NOT NULL,
answer BIT,
);

CREATE TABLE Questions_in_Jobs(
PRIMARY KEY(question_title ,job_title,department_code,domain_name),
question_title VARCHAR(50)  NOT NULL,
job_title VARCHAR(20),
department_code INT NOT NULL, 
company_domain_name VARCHAR(20),
FOREIGN KEY (question_title) REFERENCES Questions(question_title) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (job_title,department_code, company_domain_name) REFERENCES Jobs(job_title,department_code, domain_name ) ON DELETE CASCADE ON UPDATE CASCADE,
);

-- Romy ended her work here --