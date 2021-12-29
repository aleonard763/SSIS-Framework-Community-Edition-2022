/*

 Script: 45_Insert_Applications.sql

 Description: Inserts initial test SSIS application metadata into the custom.Applications table.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql
   40_Applications.table.sql

© Copyright 2022 Enterprise Data & Analytics

*/

Use SSISFrameworkDB
go


If Not Exists(Select *
              From custom.Applications
			  Where ApplicationID = 1)
Insert Into custom.Applications
(ApplicationName)
Values
  ('Framework Test')

Select * From custom.Applications
