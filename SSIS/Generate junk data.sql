--This is a script that will generate junk data for the Test, Patient, and Case tables
Use Covid19DB
DELETE FROM [Case]
DELETE FROM Test
DELETE FROM Patient
DBCC CHECKIDENT ('dbo.Case', RESEED, 0);
DBCC CHECKIDENT ('dbo.Test', RESEED, 0);
DBCC CHECKIDENT ('dbo.Patient', RESEED, 0);

--number of tests to generate (313000000 as of Friday)
DECLARE @_nTests INT = 100000000
--rate per 1000 for positives (87 as of Friday, 27.2 million cases per 313 million tests)
DECLARE @_PositiveRate INT = 87
--earliest date testing can begin
DECLARE @_StartDate DATETIME = CAST('2020-03-20' AS DATETIME)
--latest date testing can happen on
DECLARE @_EndDate DATETIME = CAST('2021-02-01' AS DATETIME)
DECLARE @_MaxDayOffset INT = DATEDIFF(DAY, @_StartDate,@_EndDate)

DECLARE @_TestDate DATETIME
DECLARE @_TestResult BIT

DECLARE @_i INT = 0
WHILE @_i < @_nTests
BEGIN
	SET @_TestDate = @_StartDate + ROUND(RAND()*@_MaxDayOffset, 0)

	IF ( (RAND()*999) < @_PositiveRate )
		SET @_TestResult = 1
	ELSE
		SET @_TestResult = 0

	INSERT INTO Test
	VALUES (@_TestDate, @_TestResult)

	SET @_i += 1
END

GO


------------------------------------------------------------------
--While it is possible for a patient to become infected, recover, and then get reinfected, for the purpose of this script, a patient will only be able to get infected once


--set how many patients to generate
DECLARE @_nPatients INT
SELECT @_nPatients = COUNT(*) FROM [Test] WHERE TestResult > 0

DECLARE @_Age INT
DECLARE @_EthnicityKey INT
DECLARE @_GenderKey INT
DECLARE @_OccupationKey INT
DECLARE @_CityKey INT
DECLARE @_MaxCityKey INT
DECLARE @_MaxEthnicityKey INT
DECLARE @_MaxOccupationKey INT
DECLARE @_MaxGenderKey INT
DECLARE @_MaxAge INT = 120

SELECT @_MaxCityKey = COUNT(*) FROM [City]
SELECT @_MaxEthnicityKey = COUNT(*) FROM [Ethnicity]
SELECT @_MaxOccupationKey = COUNT(*) FROM [Occupation]
SELECT @_MaxGenderKey = COUNT(*) FROM [Gender]


DECLARE @_i INT = 0

WHILE @_i < @_nPatients
BEGIN
	SET @_Age = 1+ROUND(RAND()*(@_MaxAge-1),0)
	SET @_EthnicityKey = 1+ROUND(RAND()*(@_MaxEthnicityKey-1),0)
	SET @_GenderKey = 1+ROUND(RAND()*(@_MaxGenderKey-1),0)
	SET @_OccupationKey = 1+ROUND(RAND()*(@_MaxOccupationKey-1),0)
	SET @_CityKey = 1+ROUND(RAND()*(@_MaxCityKey-1),0)

	INSERT INTO Patient
	VALUES (@_Age, @_EthnicityKey, @_GenderKey, @_OccupationKey, @_CityKey)
	SET @_i += 1
END

GO

----------------------------------------------------------------------------------------------------
----------This batch will create infected events----------------------------------------------------


DECLARE @_nCases INT
DECLARE @_SymptomID INT
DECLARE @_OutcomeID INT = 1
DECLARE @_TestID INT
DECLARE @_Date DateTime
DECLARE @_MaxSymptomID INT = 3

IF OBJECT_ID('dbo.temp_PositiveTests') IS NULL
CREATE TABLE temp_PositiveTests (
	[ID] INT PRIMARY KEY IDENTITY,
	TestID INT,
	[Date] DATETIME
)
ELSE
TRUNCATE TABLE temp_PositiveTests

INSERT INTO temp_PositiveTests
SELECT TestID, [Date] FROM [Test] WHERE [TestResult] > 0


DECLARE @_i INT = 1
SELECT @_nCases = COUNT(*) FROM temp_PositiveTests

WHILE @_i <= @_nCases
BEGIN
	SET @_SymptomID = 1 + ROUND(RAND()*(@_MaxSymptomID-1), 0)
	SELECT @_TestID = TestID, @_Date = [Date] FROM temp_PositiveTests WHERE ID = @_i

	INSERT INTO [Case]
	VALUES (@_Date, @_i, @_SymptomID, @_OutcomeID, @_TestID)

	SET @_i += 1
END

GO

---------------------------------------------------------------------------------
---------------Create Hospitalized Events-------------------------------------------

IF OBJECT_ID('dbo.temp_Case') IS NULL
CREATE TABLE temp_Case (
	[ID] INT PRIMARY KEY IDENTITY,
	[CaseID] INT,
	[Date] DATETIME,
	PatientID INT,
	SymptomID INT,
	OutcomeID INT,
	TestID INT
)
ELSE
TRUNCATE TABLE temp_Case




INSERT INTO temp_Case
SELECT * FROM [Case] WHERE OutcomeID = 1

-- assume 8% hospitalization rate
DECLARE @_HospitalizedPerThousand INT = 80

DECLARE @_Date DATETIME
DECLARE @_PatientID INT
DECLARE @_SymptomID INT = 4 -- this is a hospitalization event so the symptoms can only be severe
DECLARE @_OutcomeID INT = 3 -- this is the key corresponding to hospitalizations
DECLARE @_TestID INT

DECLARE @_DateDiff INT
DECLARE @_MaxDateDiff INT


DECLARE @_i INT = 1
DECLARE @_nCases INT
SELECT @_nCases = COUNT(*) FROM temp_Case

WHILE @_i <= @_nCases
BEGIN
	IF ( (1+RAND()*999) <= @_HospitalizedPerThousand )
	BEGIN
		--Generate random amount of days between infection and hospitalization
		SET @_DateDiff = ROUND(RAND()*14,0)
		
		--Get the previous infection's date plus the offset from above, patient id and test id
		SELECT @_Date = [Date]+@_DateDiff
		, @_PatientID = [PatientID]
		, @_TestID = [TestID]
		FROM temp_Case WHERE ID = @_i
		
		INSERT INTO [Case]
		VALUES (@_Date, @_PatientID, @_SymptomID, @_OutcomeID, @_TestID)

	END
	SET @_i += 1
END

GO

------------------------------------------------------------------------------
-------------------------Create Death Events-------------------------------

--empty the temp case table
IF OBJECT_ID('dbo.temp_Case') IS NULL
CREATE TABLE temp_Case (
	[ID] INT PRIMARY KEY IDENTITY,
	[CaseID] INT,
	[Date] DATETIME,
	PatientID INT,
	SymptomID INT,
	OutcomeID INT,
	TestID INT
)
ELSE
TRUNCATE TABLE temp_Case

--Only hospitalized or infected cases can lead to death
--This will insert all hospitalized cases to the temp table
INSERT INTO temp_Case
SELECT * FROM [Case] WHERE OutcomeID = 3

--This will insert all infected cases to temp table without double counting those that went from infection to hospitalization
INSERT INTO temp_Case
SELECT * FROM [Case] WHERE OutcomeID = 1 AND TestID NOT IN (SELECT TestID FROM [Case] WHERE OutcomeID = 3)

-- assume 1.7% death rate
DECLARE @_DeathsPerThousand INT = 17

DECLARE @_Date DATETIME -- For storing the previous case's date
DECLARE @_PatientID INT -- For storing the patient's ID
DECLARE @_SymptomID INT = 4 -- this is a death event so the symptoms can only be severe
DECLARE @_OutcomeID INT = 4 -- this is the key corresponding to hospitalizations
DECLARE @_TestID INT -- For storing the TestID

DECLARE @_DateDiff INT -- For storing a randomly generated date offset (this is how many days after infection or hospitalization the next event will occur)
DECLARE @_MaxDateDiff INT = 14 -- This is the max number of days before the next event occurs


DECLARE @_i INT = 1
DECLARE @_nCases INT
SELECT @_nCases = COUNT(*) FROM temp_Case

WHILE @_i <= @_nCases
BEGIN
	IF ( (1+RAND()*999) <= @_DeathsPerThousand )
	BEGIN
		--Generate random amount of days between infection/hospitalization and death
		SET @_DateDiff = ROUND(RAND()*@_MaxDateDiff, 0)
		
		--Get the previous infection's date plus the offset from above, patient id and test id
		SELECT @_Date = [Date]+@_DateDiff
		, @_PatientID = [PatientID]
		, @_TestID = [TestID]
		FROM temp_Case WHERE ID = @_i
		
		INSERT INTO [Case]
		VALUES (@_Date, @_PatientID, @_SymptomID, @_OutcomeID, @_TestID)

	END
	SET @_i += 1
END



GO


------------------------------------------------------------------------------
-------------------------Create Recovery Events-------------------------------

--empty the temp case table
IF OBJECT_ID('dbo.temp_Case') IS NULL
CREATE TABLE temp_Case (
	[ID] INT PRIMARY KEY IDENTITY,
	[CaseID] INT,
	[Date] DATETIME,
	PatientID INT,
	SymptomID INT,
	OutcomeID INT,
	TestID INT
)
ELSE
TRUNCATE TABLE temp_Case

--Only hospitalized or infected cases can lead to recovery BUT since death cases were added above, patients that died must be excluded
--This will insert all hospitalized cases to the temp table, does not include hospitalized cases that lead to death
INSERT INTO temp_Case
SELECT * FROM [Case] 
WHERE OutcomeID = 3
AND TestID NOT IN (SELECT TestID FROM [Case] WHERE OutcomeID = 4)

--This will insert all infected cases to temp table without double counting those that went from infection to hospitalization and will exclude patients that died
INSERT INTO temp_Case
SELECT * FROM [Case] 
WHERE OutcomeID = 1 
AND TestID NOT IN (SELECT TestID FROM [Case] WHERE OutcomeID = 3)
AND TestID NOT IN (SELECT TestID FROM [Case] WHERE OutcomeID = 4)

-- assume 60% recovery rate
DECLARE @_RecoveriesPerThousand INT = 600

DECLARE @_Date DATETIME -- For storing the previous case's date
DECLARE @_PatientID INT -- For storing the patient's ID
DECLARE @_SymptomID INT = 1 -- this is a recovery event so the symptoms can only be none
DECLARE @_OutcomeID INT = 2 -- this is the key corresponding to recovery
DECLARE @_TestID INT -- For storing the TestID

DECLARE @_DateDiff INT -- For storing a randomly generated date offset (this is how many days after infection or hospitalization the next event will occur)
DECLARE @_MaxDateDiff INT = 14 -- This is the max number of days before the next event occurs


DECLARE @_i INT = 1
DECLARE @_nCases INT
SELECT @_nCases = COUNT(*) FROM temp_Case

WHILE @_i <= @_nCases
BEGIN
	IF ( (1+RAND()*999) <= @_RecoveriesPerThousand )
	BEGIN
		--Generate random amount of days between infection/hospitalization and death
		SET @_DateDiff = ROUND(RAND()*@_MaxDateDiff, 0)
		
		--Get the previous infection's date plus the offset from above, patient id and test id
		SELECT @_Date = [Date]+@_DateDiff
		, @_PatientID = [PatientID]
		, @_TestID = [TestID]
		FROM temp_Case WHERE ID = @_i
		
		INSERT INTO [Case]
		VALUES (@_Date, @_PatientID, @_SymptomID, @_OutcomeID, @_TestID)

	END
	SET @_i += 1
END



GO