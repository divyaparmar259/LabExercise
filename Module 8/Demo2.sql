use AdventureWorks2016

IF OBJECT_ID(N'SalesLT.vw_CustomerOrders', N'V') IS NOT NULL
	DROP VIEW SalesLT.vw_CustomerOrders;
GO

CREATE VIEW Sales.vw_CustomerOrders
AS
SELECT C.CustomerID, O.OrderDate, O.SubTotal, O.TotalDue 
FROM Sales.Customer AS C
	INNER JOIN Sales.SalesOrderHeader as O
ON C.CustomerID =O.CustomerID;
GO

SELECT * 
	FROM Sales.vw_CustomerOrders;
GO

SELECT * 
FROM Sales.vw_CustomerOrders
ORDER BY TotalDue Desc;
GO

SELECT OBJECT_DEFINITION(OBJECT_ID(N'SalesLT.vw_CustomerOrders',N'V'));
GO

ALTER VIEW Sales.vw_CustomerOrders
WITH ENCRYPTION
AS
	SELECT C.CustomerID, O.OrderDate, O.SubTotal, O.TotalDue 
FROM Sales.Customer AS C
	INNER JOIN Sales.SalesOrderHeader as O
ON C.CustomerID =O.CustomerID;
GO

SELECT OBJECT_DEFINITION(OBJECT_ID(N'SalesLT.vw_CustomerOrders',N'V'));
GO

DROP VIEW Sales.vw_CustomerOrders;
GO

