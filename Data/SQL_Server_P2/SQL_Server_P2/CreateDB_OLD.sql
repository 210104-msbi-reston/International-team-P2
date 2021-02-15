--CREATE DATABASE Covid19DB
--GO
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
USE Covid19DB
GO
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS [Case], Test, TestResult, Facility, FacilityType, 
Outcome, OutcomeType, Symptom, Patient, City, [State], 
Occupation, Gender, Ethnicity;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
CREATE TABLE Ethnicity(
	EthnicityID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(255)
);

CREATE TABLE Gender(
	GenderID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(255)
);

CREATE TABLE Occupation(
	OccupationID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(255)
);

CREATE TABLE [State](
	StateID INT IDENTITY(1,1) PRIMARY KEY,
	[StateAbbreviation] VARCHAR(2),
	[State] VARCHAR(50)
);

CREATE TABLE City(
	CityID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(50),
	StateID INT,
	FOREIGN KEY (StateID) REFERENCES [State]
);

CREATE TABLE Patient(
    PatientID INT PRIMARY KEY,	
	Age INT,
	EthnicityID INT,
	GenderID INT,
	OccupationID INT,
	--CityID INT,
	StateID INT,
	FOREIGN KEY (EthnicityID) REFERENCES Ethnicity,
	FOREIGN KEY (GenderID) REFERENCES Gender,
	FOREIGN KEY (OccupationID) REFERENCES Occupation,
	--FOREIGN KEY (CityID) REFERENCES City
	FOREIGN KEY (StateID) REFERENCES [State]
);

CREATE TABLE Symptom(
	SymptomID INT IDENTITY(1,1) PRIMARY KEY,
	Severity VARCHAR(255)
);

CREATE TABLE Outcome(
	OutcomeID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(255)	
);

CREATE TABLE FacilityType(
	FacilityTypeID INT IDENTITY(1,1) PRIMARY KEY,
	[NAME] VARCHAR(255)
);

CREATE TABLE Facility(
	FacilityID INT IDENTITY(1,1) PRIMARY KEY,
	FacilityTypeID INT,
	CityID INT,
	FOREIGN KEY (FacilityTypeID) REFERENCES FacilityType,
	FOREIGN KEY (CityID) REFERENCES City
);

CREATE TABLE Test(
	TestID INT PRIMARY KEY,
	[Date] DATE,
	TestResult VARCHAR(50)
);

CREATE TABLE [Case](
    CaseID INT PRIMARY KEY,
	[Date] DATE,
	PatientID INT,
	SymptomID INT,
	OutcomeID INT,
	TestID INT,
	FOREIGN KEY (PatientID) REFERENCES Patient,
	FOREIGN KEY (SymptomID) REFERENCES Symptom,
	FOREIGN KEY (OutcomeID) REFERENCES Outcome,
	FOREIGN KEY (TestID) REFERENCES Test
);

SELECT [Case].PatientID, Patient.Age, Gender.[Name] As Gender, 
Ethnicity.[Name] AS Ethnicity, Occupation.[Name] AS Occupation FROM [Case]
LEFT JOIN Patient
ON Patient.PatientID = [Case].PatientID
LEFT JOIN Gender
ON Gender.GenderID = Patient.GenderID
LEFT JOIN Ethnicity
ON Ethnicity.EthnicityID = Patient.EthnicityID
LEFT JOIN Occupation
ON Occupation.OccupationID = Patient.OccupationID;

SELECT [State].StateAbbreviation AS StateAbbreviation FROM [Case]
LEFT JOIN Patient
ON Patient.PatientID = [Case].PatientID
LEFT JOIN [State]
ON [State].StateID = Patient.StateID;
