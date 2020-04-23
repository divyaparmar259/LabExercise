USE tempdb;
GO

SELECT * FROM sys.spatial_reference_systems;
GO

SELECT * FROM sys.spatial_reference_systems
WHERE spatial_reference_id = 4326;
GO

SELECT DISTINCT unit_of_measure, unit_conversion_factor 
FROM sys.spatial_reference_systems;
GO



