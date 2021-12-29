/*

   IMPORTANT: These steps are necessary to execute this script.

   0. Make sure the SSIS Catalog exists.

      DEPLOY THE FRAMEWORK SSIS PROJECTS to the SSIS Catalog.

   1. Replace the script path variable value 
       "E:\github\SSISFrameworkCommunityEdition2022\SSISFrameworkCommunityEdition2022\SSISFrameworkCommunityEdition2022\"
       with your path to the SSISFrameworkDB database scripts.
      Example: "E:\github\SSISFrameworkCommunityEdition2022\SSISFrameworkCommunityEdition2022\SSISFrameworkCommunityEdition2022\"

   2. Turn on SQLCmd Mode (Query, SQLCmd Mode). 
      The background color of the ":r" lines below will change color (the default is gray).

   3. Update @dbVersionNumber and @dbVersionNotes parameters at the top of the script.

   4. Update @dbVersionNumber parameter at the bottom of the script.

*/

/*

 (c) 2022 Enterprise Data & Analytics

 NOTE: Turn on SQLCmd mode by clicking Query->SQLCMD Mode.
 
       An error similar to: Incorrect syntax near ':' 
       indicates you need to turn on SQLCmd mode.

 Script: 00_MasterBuild.sql

 Description: Adds objects to the SSISFrameworkDB database to support the Enterprise Data & Analytics SSIS Framework Community Edition 2022

 Version History:
   1.0: (00_MasterBuild) 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   N/A

*/
 
 -- configure environment...
Set NoCount ON
Set NoExec OFF /* in case NoExec was set to ON */

:setvar ScriptPath "E:\github\SSISFrameworkCommunityEdition2022\SSISFrameworkCommunityEdition2022\SSISFrameworkCommunityEdition2022\"
:setvar dbVersionNumber "1.0.0.20211229"
:setvar dbVersionNotes "SSIS Framework Community Edition 2022 - initial release."

declare @ErrMsg varchar(4000)

:on error exit

If Not Exists(Select d.[name]
              From [sys].[databases] d
			  Where d.[name] = N'SSISDB')
 begin
  Set @ErrMsg = 'SSISDB database is NOT accessible on SQL Server instance ' + @@servername
  RaisError(@ErrMsg, 16, 1)
  Set NoExec ON
 end
Else
 begin
  print 'SSISDB database is accessible on SQL Server instance ' + @@servername
 end
print ''

 -- Start Deployment Log...
print '-----------------------------------------------'
print '------------ Deployment Log Header ------------'
print '-----------------------------------------------'
print '          -- Deployment Log --'
print '              Started: ' + Convert(varchar, sysdatetimeoffset())
print '               Server: ' + @@servername
print '          Executed By: ' + original_Login()
print '     Script Directory: $(ScriptPath)'
print ''
print '       Version Number: $(dbVersionNumber)'
print '        Version Notes: $(dbVersionNotes)'
print '-----------------------------------------------'
print ''

 --== 00_MasterBuild scripts ==--
 -- Execute 04_Framework_Parent.overrides...
print 'SQLCmd: Calling  $(ScriptPath)04_Framework_Parent.overrides.sql'
:r $(ScriptPath)04_Framework_Parent.overrides.sql

 -- Execute 05_SSISFrameworkDB.database...
print 'SQLCmd: Calling  $(ScriptPath)05_SSISFrameworkDB.database.sql'
:r $(ScriptPath)05_SSISFrameworkDB.database.sql

 -- Execute 10_Custom.schema...
print 'SQLCmd: Calling  $(ScriptPath)10_Custom.schema.sql'
:r $(ScriptPath)10_Custom.schema.sql

 -- Execute 11_dbVersion.table...
print 'SQLCmd: Calling  $(ScriptPath)11_dbVersion.table.sql'
:r $(ScriptPath)11_dbVersion.table.sql

 -- Execute 12_AdddbVersion.proc...
print 'SQLCmd: Calling  $(ScriptPath)12_AdddbVersion.proc.sql'
:r $(ScriptPath)12_AdddbVersion.proc.sql

 -- Add dbVersion --
begin try
 print 'Updating dbVersion'
 declare @dbVersionSql varchar(255) = '
 exec SSISFrameworkDB.custom.AddDbVersion
      @dbVersionNumber = $(dbVersionNumber)
    , @dbVersionNotes = $(dbVersionNotes)'
 exec(@dbVersionSql)
 print ''
end try
begin catch
  print 'Error executing SSISFrameworkDB.custom.AddDbVersion (expected error for initial deployment)'
end catch

 -- Execute 20_execute_catalog_package.proc...
print 'SQLCmd: Calling  $(ScriptPath)20_execute_catalog_package.proc.sql'
:r $(ScriptPath)20_execute_catalog_package.proc.sql

 -- Execute 21_custom.execute_catalog_parent_package.proc...
print 'SQLCmd: Calling  $(ScriptPath)21_custom.execute_catalog_parent_package.proc.sql'
:r $(ScriptPath)21_custom.execute_catalog_parent_package.proc.sql

 -- Execute 30_Packages.table...
print 'SQLCmd: Calling  $(ScriptPath)30_Packages.table.sql'
:r $(ScriptPath)30_Packages.table.sql

 -- Execute 35_Insert_Packages...
print 'SQLCmd: Calling  $(ScriptPath)35_Insert_Packages.sql'
:r $(ScriptPath)35_Insert_Packages.sql

 -- Execute 40_Applications.table....
print 'SQLCmd: Calling  $(ScriptPath)40_Applications.table.sql'
:r $(ScriptPath)40_Applications.table.sql

 -- Execute 45_Insert_Application....
print 'SQLCmd: Calling  $(ScriptPath)45_Insert_Application.sql'
:r $(ScriptPath)45_Insert_Application.sql

 -- Execute 50_ApplicationPackages.table....
print 'SQLCmd: Calling  $(ScriptPath)50_ApplicationPackages.table.sql'
:r $(ScriptPath)50_ApplicationPackages.table.sql

 -- Execute 55_Insert_ApplicationPackages....
print 'SQLCmd: Calling  $(ScriptPath)55_Insert_ApplicationPackages.sql'
:r $(ScriptPath)55_Insert_ApplicationPackages.sql

 -- Execute 60_ApplicationPackages.FailApplicationOnPackageFailure.col....
print 'SQLCmd: Calling  $(ScriptPath)60_ApplicationPackages.FailApplicationOnPackageFailure.col.sql'
:r $(ScriptPath)60_ApplicationPackages.FailApplicationOnPackageFailure.col.sql

 -- Execute 99_Update_FailApplicationOnPackageFailure....
print 'SQLCmd: Calling  $(ScriptPath)99_Update_FailApplicationOnPackageFailure.sql'
:r $(ScriptPath)99_Update_FailApplicationOnPackageFailure.sql

--If Not Exists(Select *
--              From SSISFrameworkDB.custom.dbVersion)
--begin try
-- print 'Updating dbVersion'
--declare @dbVersionNumber varchar(20) = '1.0.0.20211229'
-- exec SSISFrameworkDB.custom.AddDbVersion
--      @dbVersionNumber = @dbVersionNumber
--    , @dbVersionNotes = 'Initial deployment'
-- print ''
--end try
--begin catch
--  print 'Initial deployment error adding a row to SSISFrameworkDB.custom.DbVersion table'
--end catch

 /* Set NoExec OFF */
Set NoExec OFF

 /* Move off SSISFrameworkDB */
Use master
go

print '-----------------------------------------------'
print '------------ Deployment Log Footer ------------'
print '-----------------------------------------------'
print '          @@error: ' + Convert(varchar, @@error)
print '          Completed: ' + Convert(varchar, sysdatetimeoffset())
print '-----------------------------------------------'

/*


*/
