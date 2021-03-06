/*

 Script: 50_ApplicationPackages.table.sql

 Description: Creates a table to contain SSIS application packages metadata.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - 1.0.0.20211229 - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql
   30_Packages.table.sql
   40_Applications.table.sql

? Copyright 2022 Enterprise Data & Analytics

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

 -- custom.ApplicationPackages table
print 'Custom.ApplicationPackages table'
If Not Exists(Select s.name + '.' + t.name
              From sys.tables t
		      Join sys.schemas s
		        On s.schema_id = t.schema_id
		      Where s.name = 'custom'
		        And t.name = 'ApplicationPackages')
 begin
  print ' - Creating custom.ApplicationPackages table'
  Create Table custom.ApplicationPackages
  (ApplicationPackageID int identity(1,1)
  ,ApplicationID int
  ,PackageID int
  ,ExecutionOrder int
  )
  print ' - Custom.ApplicationPackages table created'
 end
Else
 print ' - Custom.ApplicationPackages table already exists.'
go

print ''
print 'UX_custom_ApplicationPackages_PackageId_Plus'
If Not Exists(Select name
              From sys.key_constraints
			  Where name = 'UX_custom_ApplicationPackages_PackageId_Plus')
 begin
  print ' - Adding UX_custom_ApplicationPackages_PackageId_Plus unique constraint'
  Alter Table custom.ApplicationPackages
   Add Constraint UX_custom_ApplicationPackages_PackageId_Plus Unique(ApplicationID, PackageID, ExecutionOrder)
  print ' - UX_custom_ApplicationPackages_PackageId_Plus unique constraint added'
 end
Else
 print ' - UX_custom_ApplicationPackages_PackageId_Plus unique constraint already exists.'
go
