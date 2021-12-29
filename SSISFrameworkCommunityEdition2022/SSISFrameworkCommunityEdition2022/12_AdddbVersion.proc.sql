/*

 Script: AddDbVersion.proc.sql

 Description: Creates a stored procedure to add
  database Version metadata for the SSIS Framework

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql
   11_dbVersion.table.sql

© Copyright 2022 Enterprise Data & Analytics

*/

Use SSISFrameworkDB
go

print 'Custom.AddDbVersion Stored Procedure'
If Exists(Select s.name + '.' + p.name
          From sys.procedures p
		  Join sys.schemas s
		    On s.schema_id = p.schema_id
		  Where s.name = 'custom'
		    And p.name = 'AddDbVersion')
 begin
  print ' - Dropping custom.AddDbVersion stored procedure'
  Drop procedure custom.AddDbVersion
  print ' - Custom.AddDbVersion stored procedure dropped'
 end
print ''
print ' - Creating custom.AddDbVersion stored procedure'
go

/*

     Stored Procedure: custom.AddDbVersion
     Author: Andy Leonard
     Date: 20 Oct 2014
     Description: This script adds version metadata regarding an instance of an 
	              SSIS Framework.

(c) Copyright 2022 Enterprise Data & Analytics

*/
Create Procedure custom.AddDbVersion
  @dbVersionNumber varchar(20)
 ,@dbVersionNotes varchar(4000)
As

 begin

  Set NoCount ON

    Insert Into custom.dbVersion
    (dbVersionNumber
	,dbVersionNotes)
    Values
    (@dbVersionNumber
	,@dbVersionNotes)

 end
 go

 print ' - Custom.AddDbVersion stored procedure created'
