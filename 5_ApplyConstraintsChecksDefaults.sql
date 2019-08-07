/* Apply Checks, Defaults, RegularExpressions between library2018_RB Tables
Script Date: July 21, 2018
Developed by: Rahman Bayani
*/

/* Add statment that specifies that the script runs in the context of the Master Databse */

-- switch to the Library database

USE library2018_RB3
; -- semi colon is optional 

GO -- include end of batch markers (go statement)

/* add default value for table Member.Adult , column State */ 
ALTER TABLE Member.Adult
ADD CONSTRAINT col_State_def 
DEFAULT 'WA' FOR [State] ;  
GO  

/* add check constraint for member.adult.zip */
ALTER TABLE Member.Adult
ADD CONSTRAINT CHK_zip CHECK (zip LIKE '[0-9][0-9][0-9][0-9][0-9]' 
				OR Zip LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'  
				OR Zip LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]');


/* add check constraint for member.adult.phone */ 
ALTER TABLE Member.Adult
ADD CONSTRAINT CHK_Phone_no Check (Phone_no not like '%[^0-9]%' ) -- checks that no value is not a digit 
;  
GO  


/* add check constraint for loan.loan */ 
ALTER TABLE loan.loan
ADD CONSTRAINT CHK_Due_Date Check (Due_Date > Out_Date)
;  
GO  
/* add check constraint to check that InDate is greater than outDate */ 
alter table loan.Loanhist
	add constraint chk_In_Date_Out_Date check ([In_Date]>= [Out_Date])
;
go

-- add check constraint to check age must be >18 years old

alter table member.juvenile
	add constraint chk_birth_date check(datediff(year,getdate(),birth_date)< 18)
;
go







