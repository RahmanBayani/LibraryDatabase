/* Apply Data Integrity between library2018_RB Tables
Script Date: July 21, 2018
Developed by: Rahman Bayani
*/

/* Add statment that specifies that the script runs in the context of the Master Databse */

-- switch to the Library database

USE library2018_RB3
; -- semi colon is optional 

GO -- include end of batch markers (go statement)

-- Foreign key constraint: 
/* 1- Between Adult and Member */ 
ALTER TABLE member.adult 
	ADD CONSTRAINT fk_adult_member FOREIGN KEY (member_No)
	REFERENCES member.member (member_No)
	; 
	Go 

	
	-- Foreign key constraint: 
/* 2- Between juvenile and Adult */ 
ALTER TABLE member.juvenile
	ADD CONSTRAINT fk_juvenile_adult FOREIGN KEY (Adult_Member_No)
	REFERENCES member.adult (member_No)
	; 
	Go 

-- Foreign key constraint: 
/* 3- Between juvenile and Member */ 
ALTER TABLE member.juvenile
	ADD CONSTRAINT fk_juvenile_member FOREIGN KEY (member_No)
	REFERENCES member.member (member_No)
	; 
	Go 


	-- Foreign key constraint: 
/* 4- Between reservation and member   */ 
ALTER TABLE loan.reservation
ADD CONSTRAINT fk_reservation_member FOREIGN KEY (member_No)
	REFERENCES member.member (member_No)
	; 
	Go 

	-- Foreign key constraint: 
/* 5- Between reservation and item   */ 
ALTER TABLE loan.reservation
ADD CONSTRAINT fk_reservation_item FOREIGN KEY (ISBN)
	REFERENCES Book.item (ISBN)
	; 
	Go 


	-- Foreign key constraint: 
/* 6- Between item and title   */ 
ALTER TABLE Book.item
ADD CONSTRAINT fk_item_Title FOREIGN KEY (Title_No)
	REFERENCES Book.Title (Title_No)
	; 
	Go 


-- Foreign key constraint: 
/* 7- Between copy and item   */ 
ALTER TABLE Book.Copy
ADD CONSTRAINT fk_Copy_item FOREIGN KEY (ISBN)
	REFERENCES Book.item (ISBN)
	; 
	Go 


-- Foreign key constraint: 
/* 8- Between Copy and Title   */ 
ALTER TABLE Book.Copy
ADD CONSTRAINT fk_Copy_Title FOREIGN KEY (Title_No)
	REFERENCES Book.Title (Title_No)
	; 
	Go 

-- Foreign key constraint: 
/* 9- Defining a composite foreign key Between Loan and item   */ 
ALTER TABLE Loan.Loan
  ADD CONSTRAINT FK_loan_copy
  FOREIGN KEY(ISBN, copy_no)
  REFERENCES book.copy(ISBN, copy_no)
	; 
	Go 
	


-- Foreign key constraint: 
/* 10- Between Loan and title   */ 
ALTER TABLE Loan.Loan
ADD CONSTRAINT fk_Loan_title FOREIGN KEY (title_No)
	REFERENCES Book.title (title_No)
	; 
	Go 



-- Foreign key constraint: 
/* 11- Between Loan and member   */ 
ALTER TABLE Loan.Loan
ADD CONSTRAINT fk_Loan_member FOREIGN KEY (member_No)
	REFERENCES member.member (member_No)
	; 
	Go 


-- Foreign key constraint: 
/* 12- Defining a composite foreign key Between Loanhist and copy   */ 
ALTER TABLE Loan.LoanHist
  ADD CONSTRAINT FK_loanHist_copy
  FOREIGN KEY(ISBN, copy_no)
  REFERENCES book.copy(ISBN, copy_no)
	; 
	Go 


-- Foreign key constraint: 
/* 13- Between loanHist and title   */ 
ALTER TABLE Loan.LoanHist
ADD CONSTRAINT fk_LoanHist_title FOREIGN KEY (title_No)
	REFERENCES Book.title (title_No)
	; 
	Go 

	-- Foreign key constraint: 
/* 14- Between loanHist and member */ 
ALTER TABLE Loan.LoanHist
ADD CONSTRAINT fk_LoanHist_member FOREIGN KEY (member_No)
	REFERENCES member.member (member_No)
	; 
	Go 













