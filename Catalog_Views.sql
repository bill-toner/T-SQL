-- Tables
Select Schema_Name(schema_id) 'Schema'
  , Name 'Table'
From Sys.Tables;

-- Columns
Select 
  Name 'ColumnName'
  , Type_Name(system_type_id) 'ColumnType'
  , Max_Length
  , Is_Nullable
From Sys.Columns
Where Object_ID = Object_ID(N'Sales.Orders');

Select Table_Schema, Table_Name
From Information_Schema.Tables
Where Table_Type = N'Base Table';

Select 
  Column_Name
  , Data_Type
  , Character_Maximum_Length
  , Collation_Name
  , Is_Nullable
From Information_Schema.Columns
Where Table_Schema = N'Sales'
  and Table_Name = N'Orders';

Exec Sys.sp_tables;

Exec Sys.sp_help
  @objname = N'Sales.Orders';