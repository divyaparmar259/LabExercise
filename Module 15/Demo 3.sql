USE AdventureWorks;
GO

WITH SalesPersonLocation
AS ( SELECT c.BusinessEntityID,
       c.FirstName,
       c.LastName,
       a.SpatialLocation
FROM Person.Person AS c
INNER JOIN Person.BusinessEntityAddress AS ea
ON c.BusinessEntityID = ea.BusinessEntityID 
INNER JOIN Person.Address AS a
ON ea.AddressID = a.AddressID 
WHERE a.SpatialLocation IS NOT NULL
   )
 SELECT TOP(1)
        sp1.FirstName, 
        sp1.LastName,
        sp2.FirstName,
        sp2.LastName,
        sp1.SpatialLocation.STDistance(sp2.SpatialLocation) / 1000
          AS DistanceKms
 FROM SalesPersonLocation AS sp1
 CROSS JOIN SalesPersonLocation AS sp2
 WHERE sp1.BusinessEntityID > sp2.BusinessEntityID 
 ORDER BY DistanceKms;
