/* Populating the tables using external excel files library2018_RB Tables
Script Date: July 26, 2018
Developed by: Rahman Bayani
*/

/* Add statment that specifies that the script runs in the context of the Master Databse */

-- switch to the Library database

USE library2018_RB3
; -- semi colon is optional 

GO -- include end of batch markers (go statement)

BULK INSERT member.member  
FROM 'C:\SQL_Library2018_RB3\DataFiles\member_data.TXT'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

alter table member.member
	alter column [Photograph] varchar(max) null;
go

/* inserting data to the member.adult table */ 
BULK INSERT member.adult 
FROM 'C:\SQL_Library2018_RB3\DataFiles\adult_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

alter table member.adult
	alter column [Exp_Date] nvarchar(20) not null;
go

/* inserting data to the member.juvenile table */ 
BULK INSERT member.juvenile 
FROM 'C:\SQL_Library2018_RB3\DataFiles\juvenile_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

/* inserting data to the book.title table */ 
BULK INSERT book.title
FROM 'C:\SQL_Library2018_RB3\DataFiles\title_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

alter table book.title
	alter column [title] nvarchar(60) not null;
go

/* inserting data to the book.item table */ 
BULK INSERT book.item
FROM 'C:\SQL_Library2018_RB3\DataFilesp\item_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

alter table book.item
alter column Cover nvarchar(10) null; 
go 

alter table book.item
alter column loanable varchar(5)  null;
go 

select * 
from book.item; 
go 
/* inserting data to the book.copy table */ 
BULK INSERT book.copy
FROM 'C:\SQL_Library2018_RB3\DataFiles\copy_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

alter table book.copy
	alter column [on_loan] nvarchar(10) not null;
go

select * 
from book.copy; 
go 

/* inserting data to the loan.reservation table */ 
BULK INSERT loan.reservation
FROM 'C:\SQL_Library2018_RB3\DataFiles\reservation_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

/* inserting data to the loan.loan table */ 
BULK INSERT loan.loan
FROM 'C:\SQL_Library2018_RB3\DataFiles\loan_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  


/* inserting data to the loan.loanhist table */ 
BULK INSERT loan.loanHist
FROM 'C:\SQL_Library2018_RB3\DataFiles\loanHist_data.csv'
WITH 
(
	FIRSTROW = 1, 
	DATAFILETYPE = 'char', 
	FIELDTERMINATOR  = 't',
	ROWTERMINATOR = '\n', 
	KEEPNULLS, 
	TABLOCK
);  
GO  

select * 
from loan.loanHist; 
go 


