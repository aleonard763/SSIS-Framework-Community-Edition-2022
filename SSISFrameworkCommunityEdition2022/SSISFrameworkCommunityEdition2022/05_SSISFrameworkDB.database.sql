/*

 Script: 01_SSISFrameworkDB.database.sql

 Description: Creates a database which contains SSIS Framework Version metadata.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   Custom.schema.sql

(c) Copyright 2022 Enterprise Data & Analytics

*/


print ''
print Convert(varchar, GetDate(), 101) + ' '
 + Convert(varchar, GetDate(), 108)
 + ' Starting Script 01_SSISFrameworkDB.database.sql'

use [master]
go


 -- Create custom.dbVersion table...

If Not Exists(Select [name]
              From [sys].[databases] 
              Where [name] = 'SSISFrameworkDB')
 begin
  print ' - Creating SSISFrameworkDB database...'
  Create Database SSISFrameworkDB;
  print ' - SSISFrameworkDB database created.'
 end
else
 begin
  print ' - SSISFrameworkDB database exists.'
 end

print ''

print Convert(varchar, GetDate(), 101) + ' '
 + Convert(varchar, GetDate(), 108)
 + ' Script 01_SSISFrameworkDB.database.sql completed.'

go

