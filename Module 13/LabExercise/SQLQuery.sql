USE AdventureWorks2014;
GO

-- Test IsRegexMatch
SELECT * 
	FROM Production.Product
	WHERE [dbo].[IsRegexMatch] (Name, N'\b[Ww]heel\b') = 1; 

-- Test_StringAggregate
SELECT Name
	FROM (VALUES (N'Alpha'),
				(N'Bravo'),
				(N'Charlie')) AS X (Name);


SELECT dbo.StringAggregate(Name) AS 'AggregatedName'
	FROM (VALUES (N'Alpha'),
				(N'Bravo'),
				(N'Charlie')) AS X (Name);