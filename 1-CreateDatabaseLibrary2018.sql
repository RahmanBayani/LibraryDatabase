/* Create Library Database 
Script Date: July 21, 2018
Developed by: Rahman Bayani 
*/


/* Add statment that specifies that the script runs in the context of the Master Databse */

USE master
; -- semi colon is optional 
GO -- include end of batch markers (go statement)

CREATE DATABASE library2018_RB3
ON PRIMARY 
( 
-- file name 
NAME = 'library2018_RB3', 
-- file path 
FILENAME = 'C:\SQL_Library2018_RB3\library2018_RB3.mdf', 
-- file size on disk  
SIZE = 12mb, 
-- file growth every thime the database reaches its designated size on disk
FILEGROWTH = 2mb, 
 -- maximum size on disk 
MAXSIZE = 100mb 
)
 LOG ON 
 ( 
 -- log data file name 
 NAME = library2018_RB_log2,  
 -- file path 
 FILENAME = 'C:\SQL_Library2018_RB3\library2018_RB_log3.ldf', 
 -- file size 
 SIZE = 3mb,  
 -- file growth size 
 FILEGROWTH = 10%,  
 -- maximum size on disk
 MAXSIZE = 25mb 
 )
 ; 
 GO 
