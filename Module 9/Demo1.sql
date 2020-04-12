USE AdventureWorks;
GO

EXEC sp_configure;
GO

EXEC xp_dirtree "C:\Program Files\Microsoft Learning\20762\Allfiles\Demofiles\Mod09",0,1;
GO