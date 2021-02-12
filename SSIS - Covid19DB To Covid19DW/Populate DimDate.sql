USE Covid19DW
GO
DELETE FROM DimDate

DECLARE @_i INT = 0

WHILE @_i < 1095
BEGIN
	INSERT INTO DimDate (DateKey, FullDate)
	VALUES (@_i, CAST(CAST('2020-01-01' AS DATETIME)+@_i AS DATE))
	SET @_i += 1
END

UPDATE DimDate
SET DateKey = YEAR(FullDate)*10000 + MONTH(FullDate)*100 + DAY(FullDate)
, CalendarYear = YEAR(FullDate)
, CalendarMonth = MONTH(FullDate)
, CalendarDay = DAY(FullDate)
, NameOfMonth = DATENAME(MONTH, FULLDATE)
, NameOfDay = DATENAME(WEEKDAY, FULLDATE)

