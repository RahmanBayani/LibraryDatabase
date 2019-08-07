/* Coding triggers for library2018_RB Tables
Script Date: July 26, 2018
Developed by: Rahman Bayani
*/

/* Add statment that specifies that the script runs in the context of the Master Databse */

-- switch to the Library database

USE library2018_RB3
; -- semi colon is optional 

GO -- include end of batch markers (go statement)

/* 1- create a trigger to make sure no member can loan more than 4 item at a time */


create trigger limitFourItemPerMember 
on [Loan].[Loan]
for insert as
  if (@@ROWCOUNT) > 4
  begin
    raiserror ('Cannot insert more than four books', 16, 1)
    rollback transaction 
    return
  end
go


/* create a trigger to automatically transfer a juvenile membership to adult, 
when a juvenile member turns 18 years old */ 