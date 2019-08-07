/* Create Schemas in Library2018_RB Databse
Script Date: July 21, 2018
Developed by: Rahman Bayani
*/

/* Add statment that specifies that the script runs in the context of the Library2018_RB Databse */

-- switch to the Northwind database

USE library2018_RB3
; -- semi colon is optional 

GO -- include end of batch markers (go statement)

-- create library schemas: Book, Member, and loan Resources
CREATE SCHEMA Book AUTHORIZATION dbo
; 
Go

CREATE SCHEMA Member AUTHORIZATION dbo 
; 
GO 

CREATE SCHEMA Loan AUTHORIZATION dbo 
; 
GO 