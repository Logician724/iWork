--put your creations in here
CREATE TABLE Users (
user_name VARCHAR(15) PRIMARY KEY,
password VARCHAR(30),
personal_email VARCHAR(50),
birth_date DATETIME,
exp_year INT,
first_name VARCHAR(25),
last_name VARCHAR(25),
age  AS (YEAR(CURRENT_TIMESTAMP)-YEAR(birth_date))
)
create table Job_Seekers(
user_name VARCHAR(50) PRIMARY KEY,
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE SET NULL ON UPDATE CASCADE
)
create table Staff_Members( 
user_name VARCHAR(50) PRIMARY KEY,
day_off VARCHAR(50),
no_annual_leaves INT,
salary INT,
company_email VARCHAR(50),
department_code INT,
company_domain VARCHAR(50),
FOREIGN KEY (user_name) REFERENCES Users(user_name) ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (department_code,company_domain) REFERENCES Departments (department_code,company_domain) ON DELETE SET NULL ON UPDATE CASCADE
)
