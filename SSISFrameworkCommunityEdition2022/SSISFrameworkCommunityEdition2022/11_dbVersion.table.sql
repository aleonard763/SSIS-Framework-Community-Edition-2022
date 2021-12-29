/*

 Script: dbVersion.table.sql

 Description: Creates a table which contains SSIS Framework Version metadata.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - initial release.

 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql

© Copyright 2022 Enterprise Data & Analytics

*/


print ''
print Convert(varchar, GetDate(), 101) + ' '
 + Convert(varchar, GetDate(), 108)
 + ' Starting Script dbVersion.table.sql'

use SSISFrameworkDB
go


 -- Create custom.dbVersion table...

If Not Exists(Select s.name + '.' + t.name
              From sys.tables t
              Inner Join sys.schemas s on s.Schema_Id = t.Schema_Id
              Where t.name = 'dbVersion'
                And s.name = 'custom')
 begin
  print ' - Creating custom.dbVersion table...'
  Create Table custom.dbVersion
  (dbVersionID int identity(1,1)
    Constraint PK_dbVersion Primary Key Clustered
  ,dbVersionDateTime datetime Not NULL
    Constraint DF_dbVersion_dbVersioNDateTime
	 Default(GetDate())
  ,dbVersionNumber varchar(20) Not NULL
  ,dbVersionNotes varchar(4000) NULL
  )
  print ' - custom.dbVersion table created.'
 end
else
 begin
  print ' - custom.dbVersion table exists.'
 end

print ''

print Convert(varchar, GetDate(), 101) + ' '
 + Convert(varchar, GetDate(), 108)
 + ' Script dbVersion.Table.sql completed.'

go

