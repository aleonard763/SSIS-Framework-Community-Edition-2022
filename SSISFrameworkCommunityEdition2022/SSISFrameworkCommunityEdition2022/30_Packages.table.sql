/*

 Script: 30_Packages.table.sql

 Description: Creates a table to contain SSIS package metadata.

 Version History:
   1.0.0: 29 Dec 2021 - Andy Leonard - 1.0.0.20211229 - initial release.
   1.0.1: 01 Jan 2022 - Andy Leonard - 1.0.1.20220101 - changed data types for folder name
                                                        , project name, and package name to
									                    match SSISDB.
 Prerequisites:
   05_SSISFrameworkDB.database.sql
   10_Custom.schema.sql

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

 -- custom.Packages table
print 'Custom.Packages table'
If Not Exists(Select s.name + '.' + t.name
              From sys.tables t
		      Join sys.schemas s
		        On s.schema_id = t.schema_id
		      Where s.name = 'custom'
		        And t.name = 'Packages')
 begin
  print ' - Creating custom.Packages table'
  Create Table custom.Packages
  (PackageID int identity(1,1)
  ,PackageName nvarchar(260)
  ,ProjectName nvarchar(128)
  ,FolderName nvarchar(128)
  )
  print ' - Custom.Packages table created'
 end
Else
 print ' - Custom.Packages table already exists.'
go


print 'Check FolderName column length'
If((Select c.max_length
   From [sys].[columns] c
   Join [sys].[tables] t
     On t.[name] = object_name(c.[object_id])
   Join [sys].[schemas] s
     On s.[schema_id] = t.[schema_id]
   Where s.[name] = N'custom'
     And t.[name] = N'Packages'
	 And c.[name] = N'FolderName') <> 128)
 begin

  print ' - Managing UX_custom_Packages_PackageName_Plus foreign key constraint'

  If Exists(Select [name]
            From [sys].[key_constraints]
			Where [name] = 'UX_custom_Packages_PackageName_Plus')
   begin
    print ' - Dropping UX_custom_Packages_PackageName_Plus constraint'

    Alter Table [custom].Packages
     Drop Constraint UX_custom_Packages_PackageName_Plus
    
	print ' - Dropping UX_custom_Packages_PackageName_Plus constraint dropped'
   end

  print ' - UX_custom_Packages_PackageName_Plus foreign key constraint managed'

  print ' - Setting FolderName column length to 128'
  Alter Table [custom].Packages
	Alter Column FolderName nvarchar(128)
  print ' - FolderName column length set to 128'
 end
Else
 begin
  print ' - FolderName column length already set to 128.'
 end

print 'Check ProjectName column length'
If((Select c.max_length
   From [sys].[columns] c
   Join [sys].[tables] t
     On t.[name] = object_name(c.[object_id])
   Join [sys].[schemas] s
     On s.[schema_id] = t.[schema_id]
   Where s.[name] = N'custom'
     And t.[name] = N'Packages'
	 And c.[name] = N'ProjectName') <> 128)
 begin

  print ' - Managing UX_custom_Packages_PackageName_Plus foreign key constraint'

  If Exists(Select [name]
            From [sys].[key_constraints]
			Where [name] = 'UX_custom_Packages_PackageName_Plus')
   begin
    print ' - Dropping UX_custom_Packages_PackageName_Plus constraint'

    Alter Table [custom].Packages
     Drop Constraint UX_custom_Packages_PackageName_Plus
    
	print ' - Dropping UX_custom_Packages_PackageName_Plus constraint dropped'
   end

  print ' - UX_custom_Packages_PackageName_Plus foreign key constraint managed'

  print ' - Setting ProjectName column length to 128'
  Alter Table [custom].Packages
	Alter Column ProjectName nvarchar(128)
  print ' - ProjectName column length set to 128'
 end
Else
 begin
  print ' - ProjectName column length already set to 128.'
 end

print 'Check PackageName column length'
If((Select c.max_length
   From [sys].[columns] c
   Join [sys].[tables] t
     On t.[name] = object_name(c.[object_id])
   Join [sys].[schemas] s
     On s.[schema_id] = t.[schema_id]
   Where s.[name] = N'custom'
     And t.[name] = N'Packages'
	 And c.[name] = N'PackageName') <> 260)
 begin

  print ' - Managing UX_custom_Packages_PackageName_Plus foreign key constraint'

  If Exists(Select [name]
            From [sys].[key_constraints]
			Where [name] = 'UX_custom_Packages_PackageName_Plus')
   begin
    print ' - Dropping UX_custom_Packages_PackageName_Plus constraint'

    Alter Table [custom].Packages
     Drop Constraint UX_custom_Packages_PackageName_Plus
    
	print ' - Dropping UX_custom_Packages_PackageName_Plus constraint dropped'
   end

  print ' - UX_custom_Packages_PackageName_Plus foreign key constraint managed'

  print ' - Setting PackageName column length to 260'
  Alter Table [custom].Packages
	Alter Column PackageName nvarchar(260)
  print ' - PackageName column length set to 260'
 end
Else
 begin
  print ' - PackageName column length already set to 260.'
 end


print ''
print 'UX_custom_Packages_PackageName_Plus'
If Not Exists(Select [name]
              From [sys].[key_constraints]
			  Where [name] = 'UX_custom_Packages_PackageName_Plus')
 begin
  print ' - Adding UX_custom_Packages_PackageName_Plus unique constraint'
  Alter Table [custom].Packages
   Add Constraint UX_custom_Packages_PackageName_Plus Unique(PackageName, ProjectName, FolderName)
  print ' - UX_custom_Packages_PackageName_Plus unique constraint added'
 end
Else
 print ' - UX_custom_Packages_PackageName_Plus unique constraint already exists.'
go
print ''
