USE AdventureWorks;
GO

DECLARE @Shape geometry;
SET @Shape = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SELECT @Shape;
GO

DECLARE @Shape1 geometry;
DECLARE @Shape2 geometry;
SET @Shape1 = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SET @Shape2 = geometry::STGeomFromText('POLYGON ((10 10, 25 5, 35 5, 40 10, 10 10))',0);
SELECT @Shape1 
UNION ALL
SELECT @Shape2;
GO

DECLARE @Shape1 geometry;
DECLARE @Shape2 geometry;
SET @Shape1 = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SET @Shape2 = geometry::STGeomFromText('POLYGON ((10 10, 25 5, 35 5, 40 10, 10 10))',0);
SELECT @Shape1 
UNION 
SELECT @Shape2;
GO

DECLARE @Shape1 geometry;
DECLARE @Shape2 geometry;
SET @Shape1 = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SET @Shape2 = geometry::STGeomFromText('POLYGON ((10 10, 25 5, 35 5, 40 10, 10 10))',0);
SELECT @Shape1.STUnion(@Shape2);
GO

DECLARE @NewYork geography;
DECLARE @LosAngeles geography;
SET @NewYork = geography::STGeomFromText('POINT (-74.007339 40.726966)',4326);
SET @LosAngeles = geography::STGeomFromText('POINT (-118.24585 34.083375)',4326);
SELECT @NewYork.STDistance(@LosAngeles);
GO

DECLARE @Pentagon geography;
SET @Pentagon = geography::STPolyFromText(
  'POLYGON(( -77.0532219483429 38.870863029297695,
             -77.05468297004701 38.87304314667469,
             -77.05788016319276 38.872800914712734,
             -77.05849170684814 38.870219840133124,
             -77.05556273460198 38.8690670969195,
             -77.0532219483429 38.870863029297695),
           ( -77.05582022666931 38.8702866652523,
             -77.0569360256195 38.870734733163644,
             -77.05673214773439 38.87170668418343,
             -77.0554769039154 38.871848684516294,
             -77.05491900444031 38.87097997215688,
             -77.05582022666931 38.8702866652523))',
           4326);
SELECT @Pentagon;
GO

DECLARE @Point geometry;
SET @Point = geometry::STPointFromText('POINT(10 20 15 5)', 0);
SELECT @Point.ToString()
GO

DECLARE @Point geography;
SET @Point = geography::GeomFromGml('
  <Point xmlns="http://www.opengis.net/gml">
      <pos>12 50</pos>
  </Point>',4326);
SELECT @Point;
GO

DECLARE @PanamaCanal geography;
SET @PanamaCanal 
  = geography::STLineFromText('LINESTRING( -79.909 9.339, -79.536 8.942 )',4326);
SELECT @PanamaCanal,@PanamaCanal.AsGml();
GO

DECLARE @ShapeCollection geometry;
SET @ShapeCollection = geometry::STGeomCollFromText(
   'GEOMETRYCOLLECTION( POLYGON((15 15, 10 15, 10 10, 15 15)),
                        POINT(10 10))',0);
SELECT @ShapeCollection;
GO