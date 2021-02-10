-- CREATE DATABASE Covid19DB;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
USE Covid19DB
GO
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS [Case], Test, Facility, FacilityType, Result, ResultType, Outcome, 
OutcomeType, Symptom, Patient, [Address], City, [State], Occupation, Gender, Ethnicity;
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
	[Name] VARCHAR(255)
);

CREATE TABLE City(
	CityID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(255),
	StateID INT,
	FOREIGN KEY (StateID) REFERENCES [State]
);

CREATE TABLE [Address](
	AddressID INT IDENTITY(1,1) PRIMARY KEY,
	CityID INT,
	FOREIGN KEY (CityID) REFERENCES City
);

CREATE TABLE Patient(
    PatientID INT IDENTITY(1,1) PRIMARY KEY,	
	Age INT,
	EthnicityID INT,
	GenderID INT,
	OccupationID INT,
	AddressID INT,
	FOREIGN KEY (EthnicityID) REFERENCES Ethnicity,
	FOREIGN KEY (GenderID) REFERENCES Gender,
	FOREIGN KEY (OccupationID) REFERENCES Occupation,
	FOREIGN KEY (AddressID) REFERENCES [Address]
);

CREATE TABLE Symptom(
	SymptomID INT IDENTITY(1,1) PRIMARY KEY,
	Severity VARCHAR(255)
);

CREATE TABLE OutcomeType(
	OutcomeTypeID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(255)
);

CREATE TABLE Outcome(
	OutcomeID INT IDENTITY(1,1) PRIMARY KEY,
	OutcomeTypeID INT,
	FOREIGN KEY (OutcomeTypeID) REFERENCES OutcomeType
);

CREATE TABLE ResultType(
	ResultTypeID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(255)
);

CREATE TABLE Result(
	ResultID INT IDENTITY(1,1) PRIMARY KEY,
	ResultTypeID INT,
	FOREIGN KEY (ResultTypeID) REFERENCES ResultType
);

CREATE TABLE FacilityType(
	FacilityTypeID INT IDENTITY(1,1) PRIMARY KEY,
	[NAME] VARCHAR(255)
);

CREATE TABLE Facility(
	FacilityID INT IDENTITY(1,1) PRIMARY KEY,
	FacilityTypeID INT,
	AddressID INT,
	FOREIGN KEY (FacilityTypeID) REFERENCES FacilityType,
	FOREIGN KEY (AddressID) REFERENCES [Address]
);

CREATE TABLE Test(
	TestID INT IDENTITY(1,1) PRIMARY KEY,
	[Date] DATETIME,
	PatientID INT,
	ResultID INT,
	FOREIGN KEY (PatientID) REFERENCES Patient,
	FOREIGN KEY (ResultID) REFERENCES Result
);

CREATE TABLE [Case](
    CaseID INT IDENTITY(1,1) PRIMARY KEY,	
	[Date] DATETIME,
	PatientID INT,
	SymptomID INT,
	OutcomeID INT,
	TestID INT,
	FOREIGN KEY (PatientID) REFERENCES Patient,
	FOREIGN KEY (SymptomID) REFERENCES Symptom,
	FOREIGN KEY (OutcomeID) REFERENCES Outcome,
	FOREIGN KEY (TestID) REFERENCES Test
);


