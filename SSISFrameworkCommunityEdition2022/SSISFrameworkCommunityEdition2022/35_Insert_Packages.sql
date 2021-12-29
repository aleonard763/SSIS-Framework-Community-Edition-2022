/*

 Script: 35_Insert_Packages.sql

 Description: Inserts initial test SSIS package metadata into the custom.Packages table.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql
   30_Packages.table.sql

© Copyright 2022 Enterprise Data & Analytics

*/

Use SSISFrameworkDB
go

 -- truncate table custom.Packages

If Not Exists(Select *
              From custom.Packages
			  Where PackageID = 1)
Insert Into custom.Packages
(PackageName, Projectname, FolderName)
Values
  ('Child1.dtsx', 'FrameworkTest1', 'Test')
, ('Child2.dtsx', 'FrameworkTest1', 'Test')
, ('Child3.dtsx', 'FrameworkTest2', 'Test')

Select * From custom.Packages
