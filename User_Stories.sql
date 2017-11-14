GO

CREATE PROC ViewDepartmentSP
@companyDomain VARCHAR(150),
@departmentCode VARCHAR(30)
AS
SELECT d.*
FROM Departments d
WHERE ((d.company_domain = @companyDomain) AND (d.department_code = @departmentCode))

GO

CREATE PROC UserLoginSP
@userName VARCHAR(30),
@password  VARCHAR(30)
AS
BEGIN
IF
NOT EXISTS (
SELECT u.*
FROM Users u
WHERE (u.user_name = @userName AND u.password = @password)
)

PRINT 'User not found'

ELSE IF
EXISTS ( 
SELECT s.*
FROM Job_Seekers s
WHERE (s.user_name = @userName)
)
PRINT 'Hello Seeker'

ELSE IF
EXISTS (
SELECT m.*
FROM Managers m
WHERE (m.user_name = @userName)
)
PRINT 'Hello Manager'
ELSE IF
EXISTS (
SELECT h.*
FROM HR_Employees h
WHERE (h.user_name = @userName)
)
PRINT  'Hello HR'

ELSE IF
EXISTS (
SELECT r.*
FROM Regular_Employees r
WHERE (r.user_name = @userName)
)
PRINT 'Hello Employee'

END