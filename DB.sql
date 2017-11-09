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
user_name VARCHAR(30) PRIMARY KEY,
prev_job VARCHAR(15) PRIMARY KEY,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE CASCADE ON UPDATE CASCADE
)
CREATE TABLE Job_Seekers(
user_name VARCHAR(30) PRIMARY KEY,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE SET NULL ON UPDATE CASCADE
)
CREATE TABLE Staff_Members( 
user_name VARCHAR(30) PRIMARY KEY,
day_off VARCHAR(15),
no_annual_leaves INT,
salary INT,
company_email VARCHAR(70),
department_code INT,
company_domain VARCHAR(50),
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (department_code,company_domain) REFERENCES Departments (department_code,company_domain) ON DELETE SET NULL ON UPDATE CASCADE
)
CREATE TABLE Attendances(
user_name VARCHAR(30) ,
date DATETIME,
start_time DATETIME ,
leave_time DATETIME,
PRIMARY KEY (user_name,date)
)