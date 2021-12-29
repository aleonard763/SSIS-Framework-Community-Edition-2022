/*

 Script: 10_Custom.schema.sql

 Description: Creates a schema which contains SSIS Framework metadata.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql

© Copyright 2022 Enterprise Data & Analytics

*/

Use SSISFrameworkDB
go

-- create custom schema
print 'Custom Schema'
If Not Exists(Select name
              From sys.schemas 
			  Where name = 'custom')
 begin
  print ' - Creating custom schema'
  declare @sql varchar(100) = 'Create Schema custom'
  exec(@sql)
  print ' - Custom schema created'
 end
Else
 print ' - Custom schema already exists.'
print ''
go


