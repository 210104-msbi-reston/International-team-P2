USE Covid19DB
GO
DROP TABLE IF EXISTS staging_CasePatient, temp_PatientID

CREATE TABLE staging_CasePatient (
	ID INT PRIMARY KEY IDENTITY,
	[Date] DATE,
	Age	INT,
	Gender	VARCHAR(255),
	Ethnicity VARCHAR(255),
	Occupation VARCHAR(255),
	City VARCHAR(255),
	StateAbbreviation VARCHAR(2),
	Symptom VARCHAR(255),
	Outcome VARCHAR(255),
)

CREATE TABLE temp_PatientID (
	ID INT PRIMARY KEY IDENTITY,
	PatientID INT
)


GO

DROP PROCEDURE IF EXISTS proc_InsertPatientTable

GO

CREATE PROCEDURE proc_InsertPatientTable AS
BEGIN
	INSERT INTO Patient
		OUTPUT inserted.PatientID
			INTO temp_PatientID
	SELECT s.Age, Ethnicity.EthnicityID, Gender.GenderID, Occupation.OccupationID, City.CityID
	FROM staging_CasePatient s, Ethnicity, Gender, Occupation, City, [State]
	WHERE s.Ethnicity = Ethnicity.[Name]
	AND s.Gender = Gender.[Name]
	AND s.Occupation = Occupation.[Name]
	AND s.City = City.[Name]
	AND s.StateAbbreviation = [State].StateAbbreviation
	AND City.StateID = [State].StateID

	INSERT INTO [Case]
	SELECT s.[Date], t.PatientID, SymptomID, OutcomeID
	FROM staging_CasePatient s, temp_PatientID t, Symptom, Outcome
	WHERE s.ID = t.ID
	AND s.Symptom = Symptom.Severity
	AND s.Outcome = Outcome.[Name]

	TRUNCATE TABLE staging_CasePatient
	TRUNCATE TABLE temp_PatientID
END

GO