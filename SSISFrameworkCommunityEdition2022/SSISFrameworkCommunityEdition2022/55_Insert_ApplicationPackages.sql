/*

 Script: 55_Insert_ApplicationPackages.sql

 Description: Inserts initial test SSIS application package metadata
               into the custom.ApplicationPackages table.

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

If Not Exists(Select *
              From custom.ApplicationPackages
			  Where ApplicationPackageID = 1)
Insert Into custom.ApplicationPackages
(ApplicationID, PackageID, ExecutionOrder)
Values
  (1, 1, 10)
, (1, 3, 20)
, (1, 2, 30)

Select * From custom.ApplicationPackages
