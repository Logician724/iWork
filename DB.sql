--put your creations in here
CREATE TABLE Users (
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
password VARCHAR(30) NOT NULL,
personal_email VARCHAR(70) NOT NULL,
birth_date DATETIME NOT NULL,
exp_year INT NOT NULL,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25) NOT NULL,
age  AS (YEAR(CURRENT_TIMESTAMP)-YEAR(birth_date)) NOT NULL
)
CREATE TABLE USER_Prev_Jobs(
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
prev_job VARCHAR(15) PRIMARY KEY NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
)
CREATE TABLE Job_Seekers(
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
)
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
FOREIGN KEY (department_code,company_domain) REFERENCES Departments(department_code,company_domain) ON DELETE CASCADE ON UPDATE CASCADE
)
CREATE TABLE Attendances(
PRIMARY KEY (user_name,date),
user_name VARCHAR(30) NOT NULL,
date DATETIME NOT NULL,
start_time DATETIME NOT NULL,
leave_time DATETIME NOT NULL,
FOREIGN KEY (user_name) REFERENCES Staff_Members(user_name) ON DELETE CASCADE ON UPDATE CASCADE
)
CREATE TABLE Regular_Employees (
user_name VARCHAR(30) PRIMARY KEY NOT NULL,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
)
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
)
CREATE TABLE Projects(
project_name VARCHAR(20) PRIMARY KEY NOT NULL,
start_date DATETIME NOT NULL,
end_date DATETIME NOT NULL,
FOREIGN KEY (Manager_User_Name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE CASCADE
)
CREATE TABLE Managers_Assign_Projects_To_Regulars
(
PRIMARY KEY(manager_user_name,regular_user_name,project_name),
manager_user_name VARCHAR(30)  NOT NULL,
regular_user_name VARCHAR(30)  NOT NULL,
project_name VARCHAR(50)  NOT NULL,
FOREIGN KEY (manager_user_name) REFERENCES Managers(user_name) ON DELETE SET NULL ON UPDATE SET NULL,
FOREIGN KEY (regular_user_name) REFERENCES Regular_Employees(user_name) ON DELETE SET NULL ON UPDATE SET NULL,
FOREIGN KEY (project_name) REFERENCES Projects(project_name) ON DELETE CASCADE ON UPDATE CASCADE
)
CREATE TABLE Managers_Assign_Tasks_To_Regulars(
PRIMARY KEY(manager_user_name,regular_user_name,task_name,task_deadline,project_name),
manager_user_name VARCHAR(30) NOT NULL,
regular_user_name VARCHAR(30) NOT NULL,
project_name VARCHAR(50) NOT NULL,
task_name VARCHAR(30) NOT NULL,
task_deadline DATETIME NOT NULL
)