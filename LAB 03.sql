-- Module 3 - Lab Exercise 2 - Implement the Partitioning Strategy


-- Create filegroups
USE HumanResources;
GO
ALTER DATABASE HumanResources ADD FILEGROUP FG0
GO
ALTER DATABASE HumanResources ADD FILE (NAME = F0, FILENAME = 'D:\Labfiles\Lab03\SetupFiles\F0.ndf', SIZE = 3MB, FILEGROWTH = 50%) TO FILEGROUP FG0;
GO
ALTER DATABASE HumanResources ADD FILEGROUP FG1
GO
ALTER DATABASE HumanResources ADD FILE (NAME = F1, FILENAME = 'D:\Labfiles\Lab03\SetupFiles\F1.ndf', SIZE = 3MB, FILEGROWTH = 50%) TO FILEGROUP FG1;
GO
ALTER DATABASE HumanResources ADD FILEGROUP FG2
GO
ALTER DATABASE HumanResources ADD FILE (NAME = F2, FILENAME = 'D:\Labfiles\Lab03\SetupFiles\F2.ndf', SIZE = 3MB, FILEGROWTH = 50%) TO FILEGROUP FG2;
GO
ALTER DATABASE HumanResources ADD FILEGROUP FG3
GO
ALTER DATABASE HumanResources ADD FILE (NAME = F3, FILENAME = 'D:\Labfiles\Lab03\SetupFiles\F3.ndf', SIZE = 3MB, FILEGROWTH = 50%) TO FILEGROUP FG3;
GO


-- Create partition function
CREATE PARTITION FUNCTION pfHumanResourcesDates (datetime) 
AS RANGE RIGHT 
FOR VALUES ('2011-10-01 00:00','2012-01-01 00:00','2012-04-01 00:00');


-- Create partition scheme
CREATE PARTITION SCHEME psHumanResources 
AS PARTITION pfHumanResourcesDates TO (FG0, FG1, FG2, FG3);


-- Create the Timesheet table
CREATE TABLE Payment.Timesheet
(
	PersonID int NOT NULL,
	ShiftID tinyint NOT NULL,
	RegisteredStartTime datetime NOT NULL,
	RegisteredEndTime datetime NOT NULL,
	CONSTRAINT PK_Timesheet_PersonID_ShiftID_ResgisteredStartTime PRIMARY KEY (PersonID ASC, ShiftID ASC, RegisteredStartTime)
) ON psHumanResources(RegisteredStartTime);
GO

-- Query the Timesheet table
USE HumanResources;
GO
SELECT	PersonID, ShiftID, RegisteredStartTime, RegisteredEndTime, $PARTITION.pfHumanResourcesDates(RegisteredStartTime) AS PartitionNumber
FROM	Payment.Timesheet;
GO


-- Create the staging table
CREATE TABLE Timesheet_Staging
(
	PersonID int NOT NULL,
	ShiftID tinyint NOT NULL,
	RegisteredStartTime datetime NOT NULL,
	RegisteredEndTime datetime NOT NULL,
	CONSTRAINT PK_Timesheet_PersonID_ShiftID_RegisteredStartTime PRIMARY KEY (PersonID ASC, ShiftID ASC, RegisteredStartTime)
) ON FG1
GO


-- Add check constraint 
ALTER TABLE Timesheet_Staging
WITH CHECK ADD CONSTRAINT DateBoundaries
CHECK (RegisteredStartTime >= '2011-10-01 00:00' and RegisteredStartTime < '2012-01-01 00:00' AND RegisteredStartTime IS NOT NULL);
GO


-- Switch out the old data
DECLARE @p int = $PARTITION.pfHumanResourcesDates('2011-10-01 00:00');
ALTER TABLE Payment.Timesheet
SWITCH PARTITION @p TO Timesheet_Staging 
GO


-- View archive data in staging table 
SELECT * FROM Timesheet_Staging

-- Merge the first two partitions
ALTER PARTITION FUNCTION pfHumanResourcesDates() MERGE RANGE('2011-10-01 00:00');
GO

-- Make FG1 the next used filegroup  
ALTER PARTITION SCHEME psHumanResources
NEXT USED FG1;
GO


-- Split the empty partition at the end
ALTER PARTITION FUNCTION pfHumanResourcesDates() SPLIT RANGE('2012-07-01 00:00');
GO

DROP TABLE Payment.Timesheet 
GO

-- Drop the current partition scheme
DROP PARTITION SCHEME [psHumanResources]
GO



-- Drop the current partition function
DROP PARTITION FUNCTION [pfHumanResourcesDates]
GO



-- Create the new partition function with wider date ranges
CREATE PARTITION FUNCTION [pfHumanResourcesDates](datetime) 
AS 
RANGE RIGHT FOR VALUES (N'2012-12-31T00:00:00.000', N'2014-12-31T00:00:00.000', N'2016-12-31T00:00:00.000')
GO

-- Re-create the partition scheme
CREATE PARTITION SCHEME [psHumanResources] AS PARTITION [pfHumanResourcesDates] TO ([FG0], [FG2], [FG3], [FG1])
GO

-- Create the Timesheet table
CREATE TABLE Payment.Timesheet
(
	PersonID int NOT NULL,
	ShiftID tinyint NOT NULL,
	RegisteredStartTime datetime NOT NULL,
	RegisteredEndTime datetime NOT NULL,
	CONSTRAINT PK_Timesheet_PersonID_ShiftID_ResgisteredStartTime PRIMARY KEY (PersonID ASC, ShiftID ASC, RegisteredStartTime)
) ON psHumanResources(RegisteredStartTime);
GO

-- View compression estimated savings
EXEC sp_estimate_data_compression_savings 'Payment', 'Timesheet', NULL, NULL, 'ROW';
EXEC sp_estimate_data_compression_savings 'Payment', 'Timesheet', NULL, NULL, 'PAGE';

