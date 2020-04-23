USE AdventureWorks;
GO

SELECT ProductID, Name, ListPrice 
FROM Production.Product 
FOR XML AUTO;
GO

SELECT ProductID, Name, ListPrice 
FROM Production.Product
FOR XML RAW, ELEMENTS;
GO

SELECT ProductID, Name, Color
FROM Production.Product
FOR XML AUTO, ELEMENTS XSINIL;
GO

SELECT ProductID, Name, Color
FROM Production.Product AS Product
FOR XML AUTO, ELEMENTS XSINIL;
GO

SELECT ProductID, Name, ListPrice
FROM Production.Product AS Product
FOR XML AUTO, XMLSCHEMA;
GO

SELECT ProductID, 
       Name, ListPrice, ProductModelID,
       (SELECT Description.ProductDescriptionID,
               Description.Description  
        FROM Production.ProductDescription AS Description
        WHERE Description.ProductDescriptionID = Product.ProductModelID
        FOR XML AUTO, ELEMENTS, TYPE) As Description
FROM Production.Product AS Product
WHERE ProductModelID IS NOT NULL 
	AND ProductModelID IN 
	(SELECT Description.ProductDescriptionID 
	FROM Production.ProductDescription AS Description);
GO

SELECT ProductID AS "@ProductID",
       Name AS "*",
       Size AS "Description/@Size",
       Color AS "Description/text()"
FROM Production.Product AS Product
FOR XML PATH ;
GO

SELECT ProductID, Name, ListPrice
FROM Production.Product AS Product
FOR XML AUTO, ROOT('AvailableItems');
GO

SELECT ProductID, Name, ListPrice
FROM Production.Product AS Product
FOR XML RAW('AvailableItem');
GO
