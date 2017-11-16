--put your creations in here
USE iWork
DROP TABLE Managers_Assign_Tasks_To_Regulars;
DROP TABLE Managers_Assign_Projects_To_Regulars;
DROP TABLE Tasks;
DROP TABLE Projects;
DROP TABLE Jobs_Have_Questions;
DROP TABLE Questions;
DROP TABLE Announcements;
DROP TABLE Regular_Employees_Replace_Regular_Employees;
DROP TABLE HR_Employees_Replace_HR_Employees;
DROP TABLE Managers_Replace_Managers_In_Requests;
DROP TABLE Business_Trip_Requests;
DROP TABLE Leave_Requests;
DROP TABLE Requests;
DROP TABLE Applications;
DROP TABLE HR_Employees;
DROP TABLE Regular_Employees;
DROP TABLE Managers;
DROP TABLE Job_Seekers;
DROP TABLE Attendances;
DROP TABLE Staff_Receives_Email;
DROP TABLE Emails;
DROP TABLE Staff_Members;
DROP TABLE USER_Prev_Jobs;
DROP TABLE Users;
DROP TABLE Jobs;
DROP TABLE Departments;
DROP TABLE Companies_Phones;
DROP TABLE Companies;

CREATE TABLE Companies(
domain_name VARCHAR(150) PRIMARY KEY NOT NULL,
name VARCHAR(50) NOT NULL,
address VARCHAR(300) NOT NULL,
field VARCHAR(80) NOT NULL,
type VARCHAR(50) NOT NULL,
vision TEXT NULL,
email VARCHAR(70) NOT NULL
);
CREATE TABLE Companies_Phones(
PRIMARY KEY(phone,company_domain),
phone varchar(15) NOT NULL,
company_domain VARCHAR(150) NOT NULL,
FOREIGN KEY (company_domain) REFERENCES Companies(domain_name) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Departments(
PRIMARY KEY (department_code, company_domain),
company_domain VARCHAR(150) NOT NULL,
department_code VARCHAR(30) NOT NULL,
name VARCHAR(70) NOT NULL,
FOREIGN KEY (company_domain) REFERENCES Companies(domain_name)  ON DELETE CASCADE ON UPDATE CASCADE
);
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

CREATE TABLE Jobs(
PRIMARY KEY (job_title,department_code,company_domain),
job_title VARCHAR(150) NOT NULL,
company_domain VARCHAR(150) NOT NULL ,
department_code VARCHAR(30) NOT NULL, 
application_deadline DATETIME NOT NULL,
detailed_description TEXT NOT NULL,
min_years_experience INT NOT NULL,
salary INT NOT NULL,
short_description TEXT NOT NULL,
vacancies INT NOT NULL,
working_hours INT NOT NULL,
FOREIGN KEY (department_code, company_domain) REFERENCES Departments(department_code, company_domain) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT CHK_job_title CHECK (dbo.CheckJobTitle(job_title) = '1')
);

CREATE TABLE Staff_Members( 
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
day_off VARCHAR(10) NOT NULL,
no_annual_leaves INT NOT NULL,
salary INT NOT NULL,
company_email AS (dbo.MakeCompanyEmail(user_name,company_domain)),
job_title VARCHAR(150) NOT NULL,
department_code VARCHAR(30) NOT NULL,
company_domain VARCHAR(150) NOT NULL ,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (job_title,department_code,company_domain) REFERENCES Jobs(job_title,department_code,company_domain) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE HR_Employees(
user_name VARCHAR(30) PRIMARY KEY NOT NULL, 
FOREIGN KEY (user_name) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Managers(
user_name VARCHAR(30) PRIMARY KEY NOT NULL ,
type VARCHAR(50) NOT NULL,
FOREIGN KEY (user_name) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Attendances(
PRIMARY KEY (user_name,date),
user_name VARCHAR(30) NOT NULL,
date DATE NOT NULL,
start_time DATETIME NOT NULL,
leave_time DATETIME NOT NULL,
duration AS DATEPART(hour,leave_time)-DATEPART(hour,start_time),
missing_hours AS dbo.GetMissingHours(user_name,start_time,leave_time),
FOREIGN KEY (user_name) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Regular_Employees (
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Projects(
project_name VARCHAR(100) PRIMARY KEY NOT NULL,
manager_user_name VARCHAR(30) NULL,
start_date DATETIME NOT NULL,
end_date DATETIME NOT NULL,
FOREIGN KEY(manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Tasks(
PRIMARY KEY(name,deadline,project_name),
deadline DATETIME NOT NULL,
name VARCHAR(30) NOT NULL,
project_name VARCHAR(100) NOT NULL,
comments TEXT NULL,
description TEXT NULL,
status VARCHAR(10) NOT NULL,
FOREIGN KEY (project_name) REFERENCES Projects(project_name) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT CHK_status CHECK(status = 'Open' OR status = 'Assigned' OR status = 'Fixed' or status = 'Closed')
);

CREATE TABLE Managers_Assign_Projects_To_Regulars(
PRIMARY KEY(regular_user_name,project_name),
regular_user_name VARCHAR(30) NOT NULL,	
project_name VARCHAR(100) NOT NULL,
manager_user_name VARCHAR(30) NULL,
FOREIGN KEY (manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (project_name) REFERENCES Projects(project_name) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Managers_Assign_Tasks_To_Regulars(
PRIMARY KEY(task_name,task_deadline,project_name),
manager_user_name VARCHAR(30) NULL,
regular_user_name VARCHAR(30) NULL,
project_name VARCHAR(100) NOT NULL,
task_name VARCHAR(30) NOT NULL,
task_deadline DATETIME NOT NULL,
FOREIGN KEY(manager_user_name) REFERENCES Managers(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE SET NULL ON UPDATE NO ACTION,
FOREIGN KEY(task_name,task_deadline,project_name) REFERENCES Tasks(name,deadline,project_name) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Requests(
request_id INT IDENTITY(1,1) PRIMARY KEY NOT NULL , 
end_date DATETIME NOT NULL,
hr_response_req VARCHAR(20) NULL,
hr_user_name VARCHAR(30) NULL,
manager_response_req VARCHAR(20)  NULL,
manager_user_name VARCHAR(30) NULL,
--no_of_leave_days INT AS (TIMESTAMPDIFF(YEAR,end_date,start_date)) ,--
request_date DATETIME NOT NULL,
reason_of_disapproval TEXT NULL,
start_date DATETIME NOT NULL,
FOREIGN KEY (hr_user_name) REFERENCES HR_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE NO ACTION,
CONSTRAINT CHK_hr_respose_req CHECK(hr_response_req = 'Accepted' OR hr_response_req = 'Rejected' OR hr_response_req = NULL),
CONSTRAINT CHK_manager_response_req CHECK(manager_response_req = 'Accepted' OR manager_response_req = 'Rejected' OR manager_response_req = NULL)
);

CREATE TABLE Leave_Requests(
request_id INT PRIMARY KEY NOT NULL,
type VARCHAR(50) NOT NULL,
FOREIGN KEY (request_id) REFERENCES Requests(request_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Business_Trip_Requests(
request_id INT PRIMARY KEY NOT NULL,
trip_destination VARCHAR(150) NOT NULL,
trip_purpose TEXT NOT NULL,
FOREIGN KEY (request_id) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE
);






CREATE TABLE Managers_Replace_Managers_In_Requests(
request_id INT PRIMARY KEY NOT NULL,
user_name_replacer VARCHAR(30) NULL,
user_name_request_owner VARCHAR(30) NULL,
FOREIGN KEY(user_name_replacer) REFERENCES Managers(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(user_name_request_owner) REFERENCES Managers(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(request_id) REFERENCES Requests(request_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE HR_Employees_Replace_HR_Employees(
request_id INT PRIMARY KEY NOT NULL,
user_name_replacer VARCHAR(30) NULL,
user_name_request_owner VARCHAR(30) NULL,
FOREIGN KEY(user_name_replacer) REFERENCES HR_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(user_name_request_owner) REFERENCES HR_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(request_id) REFERENCES Requests(request_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Regular_Employees_Replace_Regular_Employees(
request_id INT PRIMARY KEY NOT NULL,
user_name_replacer VARCHAR(30) NULL,
user_name_request_owner VARCHAR(30) NULL,
FOREIGN KEY(user_name_replacer) REFERENCES Regular_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(user_name_request_owner) REFERENCES Regular_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(request_id) REFERENCES Requests(request_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Announcements(
PRIMARY KEY(company_domain,title,date),
date DATETIME NOT NULL,
company_domain VARCHAR(150) NOT NULL,
title VARCHAR(280) NOT NULL,
hr_user_name VARCHAR(30) NULL,
description TEXT NOT NULL,
type VARCHAR(20) NOT NULL,
FOREIGN KEY(hr_user_name) REFERENCES HR_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(company_domain) REFERENCES Companies(domain_name) ON DELETE NO ACTION ON UPDATE NO ACTION
);



CREATE TABLE Applications (
PRIMARY KEY(seeker_username,job_title,department_code,company_domain) ,
score INT NOT NULL DEFAULT 0,
app_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
hr_response_app VARCHAR(20) NULL,
manager_response_app VARCHAR(20) NULL ,
hr_username VARCHAR(30) NULL,
manager_username VARCHAR(30) NULL,
seeker_username VARCHAR(30) NOT NULL,
job_title VARCHAR(150) NOT NULL,
department_code VARCHAR(30) NOT NULL, 
company_domain VARCHAR(150) NOT NULL,
FOREIGN KEY (seeker_username) REFERENCES Job_Seekers(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (manager_username) REFERENCES Managers(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION ,
FOREIGN KEY (hr_username) REFERENCES HR_Employees(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION ,
--debatable
FOREIGN KEY (job_title,department_code, company_domain) REFERENCES Jobs(job_title,department_code, company_domain ) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT CHK_app_status CHECK( app_status = 'Pending' OR app_status = 'Accepted' OR app_status = 'Rejected'),
CONSTRAINT CHK_hr_response_app CHECK( hr_response_app = 'Accepted' OR hr_response_app = 'Rejected' OR hr_response_app = NULL),
CONSTRAINT CHK_manager_response_app CHECK( manager_response_app = 'Accepted' OR manager_response_app = 'Rejected' OR manager_response_app = NULL)
);

CREATE TABLE Emails(
PRIMARY KEY(time_stamp,sender_user_name),
time_stamp DATETIME NOT NULL,
sender_user_name VARCHAR(30) NOT NULL,
sender_email VARCHAR(70) NOT NULL,
recipient_email VARCHAR(70) NOT NULL,
email_subject VARCHAR(140) NULL,
email_body TEXT NULL,
FOREIGN KEY (sender_user_name) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Staff_Receives_Email(
PRIMARY KEY(time_stamp,sender_user_name,recipient_username),
time_stamp DATETIME NOT NULL,
sender_user_name VARCHAR(30) NOT NULL,
recipient_username VARCHAR(30) NOT NULL,
FOREIGN KEY(time_stamp,sender_user_name) REFERENCES Emails(time_stamp,sender_user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(recipient_username) REFERENCES Staff_Members(user_name) ON DELETE NO ACTION ON UPDATE NO ACTION,
);


CREATE TABLE Questions(
question_id INT IDENTITY PRIMARY KEY NOT NULL,
question_title VARCHAR(700) NOT NULL,
answer BIT NULL,
);

CREATE TABLE Jobs_Have_Questions(
PRIMARY KEY(question_id,job_title,department_code,company_domain),
question_id INT NOT NULL,
job_title VARCHAR(150) NOT NULL,
department_code VARCHAR(30)NOT NULL, 
company_domain VARCHAR(150) NOT NULL,
FOREIGN KEY(question_id) REFERENCES Questions(question_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (job_title,department_code, company_domain) REFERENCES Jobs(job_title,department_code, company_domain ) ON DELETE CASCADE ON UPDATE CASCADE
);