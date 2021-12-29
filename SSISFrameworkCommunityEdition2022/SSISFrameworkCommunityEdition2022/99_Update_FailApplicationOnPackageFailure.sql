/*

 Script: 99_Update_FailApplicationOnPackageFailure.sql

 Description: Updates the FailApplicationOnPackageFailure column
               in the custom.ApplicationPackages table.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql
   30_Packages.table.sql
   40_Applications.table.sql
   50_ApplicationPackages.table.sql
   60_ApplicationPackages.FailApplicationOnPackageFailure.col.sql

© Copyright 2022 Enterprise Data & Analytics

*/

Use SSISFrameworkDB
go

Update custom.ApplicationPackages
Set FailApplicationOnPackageFailure = 0

Update custom.ApplicationPackages
Set FailApplicationOnPackageFailure = 1
Where ApplicationPackageID = 3

