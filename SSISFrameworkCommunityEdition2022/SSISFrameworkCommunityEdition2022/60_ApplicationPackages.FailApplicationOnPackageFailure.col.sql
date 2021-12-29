/*

 Script: 60_ApplicationPackages.FailApplicationOnPackageFailure.col.sql

 Description: Adds the FailApplicationOnPackageFailure column
               to the custom.ApplicationPackages table.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql
   30_Packages.table.sql
   40_Applications.table.sql
   50_ApplicationPackages.table.sql

© Copyright 2022 Enterprise Data & Analytics

*/

Use SSISFrameworkDB
go

 -- Add FailApplicationOnPackageFailure to custom.ApplicationPackages table
print 'Custom.ApplicationPackagesFailApplicationOnPackageFailure column'
If Not Exists(Select s.name + '.' + t.name + '.' + c.name
              From sys.columns c
			  Join sys.tables t
			    On t.object_id = c.object_id
		      Join sys.schemas s
		        On s.schema_id = t.schema_id
		      Where s.name = 'custom'
		        And t.name = 'ApplicationPackages'
				And c.name = 'FailApplicationOnPackageFailure')
 begin
  print ' - Adding custom.ApplicationPackages.FailApplicationOnPackageFailure column'
  Alter Table custom.ApplicationPackages
   Add FailApplicationOnPackageFailure bit
  print ' - Custom.ApplicationPackages.FailApplicationOnPackageFailure column created'
 end
Else
 print ' - Custom.ApplicationPackages.FailApplicationOnPackageFailure column already exists.'
go

Update custom.ApplicationPackages
Set FailApplicationOnPackageFailure = 1

Update custom.ApplicationPackages
Set FailApplicationOnPackageFailure = 0
Where ApplicationPackageID = 2
