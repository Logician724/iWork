-- Romy Started  fixing here
--DROP PROC RegisterToWebsite;
GO
CREATE PROC RegisterToWebsite   -- Handles 5 in unregistered user
@userName VARCHAR(30)  , --takes entity as input 
@password VARCHAR(30) ,
@personalEmail VARCHAR(70) ,
@birthDate DATETIME ,
@expYear INT ,
@firstName VARCHAR(25) ,
@lastName VARCHAR(25) 
AS
insert into Users
Values(@username,@password,@personalEmail,@birthDate,@expYear,@firstName,@lastName)



-- She eneded here 
EXEC RegisterToWebsite 'Mohamed_Zaki','123455','Zaki@guc.edu.eg','05/05/2012',10,'Mohamed','Zaki' --executes the procedure 