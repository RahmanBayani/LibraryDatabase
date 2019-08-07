/* Coding Queries, Views, Stored Procedures for library2018_RB Tables
Script Date: July 26, 2018
Developed by: Rahman Bayani
*/

/* Add statment that specifies that the script runs in the context of the Master Databse */

-- switch to the Library database

USE library2018_RB3
; -- semi colon is optional 

GO -- include end of batch markers (go statement)

-- 1- Create a mailing list of Library members that includes the members’ 
--    full names and complete address information.

create View Member.MemberMailingListView
as 
select concat(' ', firstname, lastname) as 'Full Name', 
concat(street, ', ',city, ', ' , state, ' ' , zip ) as 'Address'  
from member.member as m
inner join member.Adult as a 
on a.member_No = m.member_No 
; 
go 

select * 
from Member.MemberMailingListView
; 
go 

-- 2- Write and execute a query on the title, item, and copy tables that returns
--    the isbn, copy_no, on_loan, title, translation, and cover, and values for 
--    rows in the copy table with an ISBN of 1 (one), 500 (five hundred), or 1000 
--    (thousand). Order the result by isbn column. 

select i.ISBN, c.Copy_No, t.title, i.Language, i.Cover
from book.title as t 
inner join book.item as i 
on t.title_No = i.Title_No 
inner join book.copy as c 
on c.Title_No = i.Title_No
where i.ISBN in (1, 500, 1000)
order by i.ISBN
; 
go 

select *
from Item.BookInformationView
; 
go 

-- 3- Write and execute a query to retrieve the member’s full name and member_no
--    from the member table and the isbn and log_date values from the reservation
--    table for members 250, 341, 1675. Order the results by member_no. You should 
--    show information for these members, even if they have no books or reserve. 

create View loan.ReservationDateView
as 
select Top 9999999 M.Member_No, concat_ws(' ', FirstName, LastName) as 'Member Full Name',
				   R.ISBN, R.log_Date as 'Request Date for Reservation'  
from Member.Member as M 
     inner join loan.Reservation as R 
	on M.Member_No = R.Member_No 
where M.Member_No in (250, 341, 1675)
order by M.Member_No
; 
go 

select *
from loan.ReservationDateView
; 
go

-- 4- Create a view and save it as adultwideView that queries the member and adult 
--    tables. Lists the name & address for all adults.

create View Member.AdultWideView 
as 
select [Full Name] as 'Full Name', 
	   [Address] as 'Address'
from Member.MemberMailingListView 
; 
go  

select * 
from Member.AdultWideView
; 
go 

-- 5- Create a view and save it as ChildwideView that queries the member, adult, 
--    and juvenile tables. Lists the name & address for the juveniles.

create view member.ChildwideView 
as 
select concat(m.FirstName, ', ' , m.LastName) as 'Full Name', 
concat(street, ', ',city, ', ' , state, ' ' , zip ) as 'Address', 
datepart(year, j.birth_date) as 'juvenile birthdate' 
from Member.Member as m 
inner join member.Adult as a 
on m.member_No = a.member_No
inner join Member.Juvenile as j 
on j.adult_member_No = a.member_No 
; 
go  

select * 
from Member.ChildwideView 
; 
go   

-- 6- Create a view and save it as and CopywideView that queries the copy, title and
--    item tables. Lists complete information about each copy.

create view book.CopywideView 
as 
select distinct t.title, t.Author,i.Language, i.ISBN, i.Cover ,c.Copy_No,  c.on_loan, i.loanable 
from book.title as t 
inner join book.item as i 
on t.title_No = i.Title_No 
inner join book.copy as c 
on c.Title_No = i.Title_No
; 
go 
select * 
from book.CopywideView
; 
go

-- 7- Create a view and save it as LoanableView that queries CopywideView (3-table join).
--    Lists complete information about each copy marked as loanable (loanable = 'Y').

create view book.LoanableView 
as 
select distinct t.title, t.Author,i.Language, i.ISBN, i.Cover ,c.Copy_No,  c.on_loan, i.loanable 
from book.title as t 
inner join book.item as i 
on t.title_No = i.Title_No 
inner join book.copy as c 
on c.Title_No = i.Title_No
where i.loanable = 'Y'
; 
go 

select * 
from book.LoanableView
; 
go

-- 8- Create a view and save it as OnshelfView that queries CopywideView (3-table join).
-- Lists complete information about each copy that is not currently on loan (on_loan ='N').

create view OnshelfView 
as 
select distinct t.title, t.Author,i.Language, i.ISBN, i.Cover ,c.Copy_No,  c.on_loan, i.loanable 
from book.title as t 
inner join book.item as i 
on t.title_No = i.Title_No 
inner join book.copy as c 
on c.Title_No = i.Title_No
where c.on_loan = 'N'
; 
go 

select * 
from OnshelfView 
; 
go
 
-- 9- Create a view and save it as OnloanView that queries the loan, title, and member 
--    tables. Lists the member, title, and loan information of a copy that is currently
--    on loan.
create view OnloanView 
as 
select distinct concat(m.FirstName, ', ' , m.LastName) as 'Full Name', t.title, t.Author, l.ISBN, 
				concat(datepart(month,l.Out_Date), '/', datepart(day,l.Out_Date), '/', datepart(year,l.Out_Date)) as 'Out Date',
				concat(datepart(month,l.Due_Date), '/', datepart(day,l.Due_Date), '/', datepart(year,l.Due_Date)) as 'Due date',
				c.on_loan
from book.title as t 
inner join book.copy as c 
on c.Title_No = t.Title_No
inner join Loan.Loan as l 
on c.ISBN = l.ISBN
inner join Member.Member as m
on l.member_No = m.member_No
where c.on_loan = 'Y'
; 
go 

select * 
from OnloanView; 
go 

-- 10- Create a view and save it as OverdueView that queries OnloanView (3-table join.)
--     Lists the member, title, and loan information of a copy on loan that is overdue 
--      (due_date < current date).
create view OverdueView 
as 
select distinct concat(m.FirstName, ', ' , m.LastName) as 'Full Name', t.title, t.Author, l.ISBN, 
				concat(datepart(month,l.Out_Date), '/', datepart(day,l.Out_Date), '/', datepart(year,l.Out_Date)) as 'Out Date',
				concat(datepart(month,l.Due_Date), '/', datepart(day,l.Due_Date), '/', datepart(year,l.Due_Date)) as 'Due date',
				c.on_loan, 
				datediff(day, l.Due_Date, getdate()) as 'OverDue Days'
from book.title as t 
inner join book.copy as c 
on c.Title_No = t.Title_No
inner join Loan.Loan as l 
on c.ISBN = l.ISBN
inner join Member.Member as m
on l.member_No = m.member_No
where c.on_loan = 'Y' and datediff(day, l.Due_Date, getdate()) > 0
; 
go

select * 
from OverdueView
; 
go 


/* ------------------------------------------------------------------*/
/* 1-	How many loans did the library do last year? */
create function loan.NoOfLoans
(
	@year as int
)
returns int
as 
	begin
			declare @LoanFrequency as int
			Select  @LoanFrequency = count(lh.In_Date) 
			from Loan.LoanHist as lh 
			where year(lh.In_Date) = @year

			return @LoanFrequency
			
	end
;
go

select loan.NoOfLoans(2008)
; 
go 

/* 2-	What percentage of the membership borrowed at least one book? */
/*create function MembersWhoBorrowedBook*/


create function member.MembersWhoBorrowedBook
(
)
returns decimal(4,2)
 as 
 begin
	-- declare variables 
	declare @PercentageOfActiveMembers as decimal(4,2)
	declare @AllMembers as decimal 
	declare @membersWithBooksOnLoan as decimal
	declare @HistoryMembersWithNoBook as decimal
	declare @HistoryMembersWhoCurrentlyLoanedBooks as decimal
	-- compute the percentage of members 
	select @AllMembers = count(m.member_No) -- Total number of members
	from Member.Member as m 

	select distinct @membersWithBooksOnLoan =  count(m.member_No) -- Total number of members who currently borrowed books
			from Member.Member as m
			inner join Loan.Loan as l
			on m.member_No = l.member_No

	select distinct @HistoryMembersWithNoBook =  count(m.member_No) -- Total number of members who borrowed books and return them
			from Member.Member as m
			  inner join loan.LoanHist as lh
			 on m.member_No = lh.member_No

	select  distinct @HistoryMembersWhoCurrentlyLoanedBooks= count(l.member_No)-- common members between loan and loanHistory 
			from loan.loan as l 
			inner join loan.LoanHist as lh
			on l.member_No = lh.member_No 

	select @PercentageOfActiveMembers = (@membersWithBooksOnLoan+@HistoryMembersWithNoBook-@HistoryMembersWhoCurrentlyLoanedBooks)
										/@AllMembers * 100.00
	return @PercentageOfActiveMembers
end
; 
go 

select  member.MembersWhoBorrowedBook()
;
go



/*3-	What was the greatest number of books borrowed by any one individual?  */
  create function loan.WhoBorrowedTheMostBooks
  (
  )
  Returns int 
  as 
	begin
			-- declaring the variables 
			declare @GreatestNomOfBooksBorrowedByOneMember as int 

			-- determine which member borrowed the greatest nomber of books in the LoanHistory table
		  select top 1 @GreatestNomOfBooksBorrowedByOneMember  =
		  count(lh.member_no)
		  from loan.loanhist as lh
		  left outer join loan.loan as l 
		  on l.member_No = lh.member_No
		  group by lh.member_no 
		 order by count(lh.member_no) desc

		 -- return result 
		 return  @GreatestNomOfBooksBorrowedByOneMember
  
	end 
  ; 
  go 

  select loan.WhoBorrowedTheMostBooks(); 
  go 


  /* 4-	What percentage of the books was loaned out at least once last year? */ 
  create function loan.BooksLoaned
  (
  ) 
  returns decimal 
  as 
		begin 
				--declare variables 
				declare @TotalNomsOfBooks as decimal 
				declare @BooksNeverLoaned as decimal
				declare @PercentageLoanedOfBooks as decimal

				-- Total number of books 
				select @TotalNomsOfBooks = count(c.ISBN)
										   from Book.Copy as c

				select @BooksNeverLoaned = count(c.ISBN)
										   from Book.Copy as c
								           left outer join loan.loan as l 
								           on c.ISBN = l.ISBN

				select @BooksNeverLoaned = @BooksNeverLoaned + 
										   count(c.ISBN)
										   from Book.Copy as c
								           left outer join loan.LoanHist as lh
								           on c.ISBN = lh.ISBN

				select @PercentageLoanedOfBooks= (@TotalNomsOfBooks-@BooksNeverLoaned)/@TotalNomsOfBooks*100

		 -- return result 
		 return  @PercentageLoanedOfBooks
		
		end 
; 
go 

select  loan.BooksLoaned()
;
go
 
	


/* 5- What percentage of all loans eventually becomes overdue? */


create function loan.PercentageOverDueLoans
(
)
returns decimal(4,2)
 as 
 begin
-- declare variables 
declare @PercentageOfOverDueLoans as decimal(4,2)
declare @AllLoans as decimal 
declare @OverDueLoansOnLoan as decimal
declare @OverDueLoansCurrentlyLoan as decimal
-- compute the percentage of members 
select @AllLoans = count(ISBN) from Loan.Loan -- Total number of loans in Loan Tabel
   where DATEDIFF(day, Due_Date, GETDATE()) > 0
    select @AllLoans = @AllLoans + count(ISBN) from Loan.LoanHist -- Total number of loans in Loan History
   
select distinct @OverDueLoansCurrentlyLoan =  count(ISBN) from Loan.Loan -- Total number of loans that are overdue in Loan Tabel
   where DATEDIFF(day, Due_Date, GETDATE()) > 0 


select distinct  @OverDueLoansOnLoan =  count(ISBN) from Loan.LoanHist -- Total number of loans that are overdue in Loan History
   where DATEDIFF(day, Due_Date, In_Date) > 0 


select @PercentageOfOverDueLoans = (@OverDueLoansOnLoan+@OverDueLoansCurrentlyLoan) / @AllLoans * 100.00
return @PercentageOfOverDueLoans
end
; 
go 


select  loan.PercentageOverDueLoans()
;
go
 
/* 6-	What is the average length of a loan? */
create function loan.AverageLengthOfLoan
(
)
returns decimal(4,2)
 as 
 begin
-- declare variables 
declare @AverageLengthLoans as decimal(4,2)
declare @SumLengthLoans as decimal
declare @AllLoans as decimal 
-- compute the percentage of members 
select @AllLoans = count(ISBN) from Loan.LoanHist -- Total number of loans in Loan Tabel
   
select @SumLengthLoans =  sum(DATEDIFF(day, Out_Date, In_Date)) from Loan.LoanHist -- Total number of loans that are overdue in Loan History

select @AverageLengthLoans = @SumLengthLoans / @AllLoans

return @AverageLengthLoans
end
; 
go 


select  loan.AverageLengthOfLoan()
;
go

/* 7-	What are the library peak hours for loans? */
create function loan.PeakHourLoans
(
)
returns int
 as 
 begin
-- declare variables 
declare @PeakHourLoans as int
-- compute the percentage of members 
select top 1 @PeakHourLoans = count(datepart(hour, Out_Date)) from Loan.LoanHist 
						 group by datepart(hour, Out_Date)
						 order by count(datepart(hour, Out_Date)) desc

return @PeakHourLoans
end
; 
go 


select  loan.PeakHourLoans()
;
go

