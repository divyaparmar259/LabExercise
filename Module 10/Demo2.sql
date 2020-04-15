use tempdb

create FUNCTION dbo.EndOfPreviousMonth (@DateToTest date)
RETURNS date
AS BEGIN
  RETURN DATEADD(DAY, 0 - DAY(@DateToTest), @DateToTest);
END;
GO

SELECT dbo.EndOfPreviousMonth(SYSDATETIME());
SELECT dbo.EndOfPreviousMonth('2017-06-01');
SELECT dbo.EndOfPreviousMonth('1999-09-24');
GO

SELECT OBJECTPROPERTY(OBJECT_ID('dbo.EndOfPreviousMonth'),'IsDeterministic');
GO

DROP FUNCTION dbo.EndOfPreviousMonth;
GO

SELECT dbo.EndOfPreviousMonth(SYSDATETIME());
SELECT dbo.EndOfPreviousMonth('2018-03-01');
GO

DROP FUNCTION dbo.EndOfPreviousMonth;
GO
