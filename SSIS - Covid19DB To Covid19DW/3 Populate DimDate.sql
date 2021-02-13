USE Covid19DW
GO
DELETE FROM DimDate

--Starting Date (The script will add this date, ensure that this date does not already exist)
DECLARE @_StartDateString VARCHAR(10) = '2020-01-01'
--Number of days the script will add
DECLARE @_DaysToAdd INT = 2000
DECLARE @_StartDate DATETIME = CAST(@_StartDateString AS DATETIME)
DECLARE @_i INT = 0


WHILE @_i < @_DaysToAdd
BEGIN
	INSERT INTO DimDate (DateKey, FullDate)
	VALUES (@_i, CAST(@_StartDate + @_i AS DATE))
	SET @_i += 1
END

UPDATE DimDate
SET DateKey = YEAR(FullDate)*10000 + MONTH(FullDate)*100 + DAY(FullDate)
, CalendarYear = YEAR(FullDate)
, CalendarMonth = MONTH(FullDate)
, CalendarDay = DAY(FullDate)
, NameOfMonth = DATENAME(MONTH, FULLDATE)
, NameOfDay = DATENAME(WEEKDAY, FULLDATE)