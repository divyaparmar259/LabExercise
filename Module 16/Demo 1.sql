use AdventureWorks2016;
GO

SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH 
FROM AdventureWorks2016.INFORMATION_SCHEMA.COLUMNS 
WHERE DATA_TYPE = 'varbinary' 
AND CHARACTER_MAXIMUM_LENGTH = -1;
GO

SELECT OBS.name AS TableName, COLS.name AS ColumnName, is_filestream
FROM sys.columns AS COLS
INNER JOIN sys.objects AS OBS
ON COLS.object_id = OBS.object_id 
WHERE COLS.name = 'LargePhoto';
Go

SELECT * FROM AdventureWorks2016.sys.filetables;
