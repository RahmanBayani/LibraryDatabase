/* Create Library tables in library2018_RB Databse
Script Date: July 16, 2018
Developed by: Rahman Bayani
*/

/* Add statment that specifies that the script runs ni the context of the Master Databse */

-- switch to the Library database

USE library2018_RB3
; -- semi colon is optional 

GO -- include end of batch markers (go statement)

/* check for object existance by verifying if the table has an object ID.
if the table exist, it is deleted using the drop clause, if does not exist it will be created.
*/
if OBJECT_ID('Member.adult','U') is not null drop table Member.adult;
go

/*** Table No1 1- Member.Members ****/
CREATE TABLE Member.Member
(

member_No int not null IDENTITY(1,1) NO CHECK, 
LastName nvarchar(40) not null, 
FirstName nvarchar(40) not null,
MiddleInitial nvarchar(20) null,
Photograph varbinary null, 
constraint pk_Member primary key clustered (member_No)
)
; 
GO 

select * 
from Member.Member; 
go 


/*** Table No1 2- Member.Adult ****/
drop TABLE Member.Adult
(
member_No int not null, -- pk , fk
Street nvarchar(40) not null,
City nvarchar(15) not null,
State nvarchar(2) not null,
Zip nvarchar(16) not null,
Phone_no nvarchar(24) null ,
Exp_Date datetime not null,
constraint pk_Adult primary key clustered (member_No asc)
)
; 
GO 
select * 
from  Member.Adult; 
go 

/*** Table No1 3- Member.Juveniles ****/
CREATE TABLE Member.Juvenile
(
member_No int not null, -- pk , fk, 
adult_member_No int not null, -- pk , fk,
birth_date datetime not null, 
constraint pk_Juvenile primary key clustered (member_No asc)
)
; 
Go   


/*** Table No2 4- Loan.OnLoan ****/
CREATE TABLE loan.Loan
(
ISBN nvarchar(13) not null, 
Copy_No int  not null,
title_No int not null, 
member_No int not null, 
Out_Date datetime not null, --  
Due_Date datetime not null, 
constraint PK_loan primary key
		(
			ISBN,
            Copy_No,
		    title_No
		)
)
; 
GO


/*** Table No2 5- Loan.Reservation ****/
CREATE TABLE loan.Reservation
(
ISBN nvarchar(13) not null, --pk, fk
member_No int not null, -- pk, fk
log_Date datetime not null, 
Remarks nvarchar(40) null, 
constraint PK_Reservation primary key
		(
			ISBN,
           member_No
		)
)
; 
GO 

/*** Table No2 6- Loan.LoanHistory ****/
CREATE TABLE loan.LoanHist
(
ISBN nvarchar(13) not null, 
Copy_No int  not null,
Out_Date datetime not null,
Title_No int not null,
member_No int not null, 
Due_Date datetime not null, 
In_Date datetime not null,
fine_assessed money null, 
fine_paid money null, 
fien_waived money null, 
remarks nvarchar(100) null,  
constraint PK_LoanHist primary key
		(
			ISBN,
           Copy_No, 
		   Out_Date
		)
)
; 
GO


/*** Table No3 7- Book.Title ****/
CREATE TABLE Book.title
(
title_No int not null identity(1,1),  -- pk
title nvarchar(40) not null, 
Author nvarchar(40) not null,  
Synopsis nvarchar (225) null, 
constraint pk_title primary key clustered (title_No asc)
)
; 
Go 


/*** Table No3 9- Book.items ****/
CREATE TABLE Book.item 
(
ISBN nvarchar(13) not null, -- pk
Title_No int not null , -- fk
Language nvarchar(10) null, 
Cover nvarchar(5) null,
loanable binary not null, 
constraint pk_Books primary key clustered (ISBN asc)
)
; 
Go


/*** Table No3 10- Book.Copies ****/
CREATE TABLE Book.Copy 
(
ISBN nvarchar(13) not null,
Copy_No int not null,  
Title_No int not null, 
on_loan binary null, 
constraint pk_Copy primary key clustered 
	(	  
	 ISBN,
	 copy_No	
	)
)
; 
Go 

