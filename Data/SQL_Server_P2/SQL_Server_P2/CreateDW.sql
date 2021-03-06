--CREATE DATABASE Covid19DW
--GO
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
USE Covid19DW
GO
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS FactCases, DimPatient, DimGeography, DimDate;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
CREATE TABLE DimDate(
	[DateKey] INT PRIMARY KEY,
	[FullDate] [date] NULL,
	[CalendarYear] [int] NULL,
	[CalendarMonth] [int] NULL,
	[CalendarDay] [int] NULL,
	[NameOfMonth] [varchar](10) NULL,
	[NameOfDay] [varchar](10) NULL
)

CREATE TABLE DimGeography(
	[GeographyKey] INT IDENTITY(1,1) PRIMARY KEY,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[StateAbbreviation] [char](2) NULL
)

CREATE TABLE DimPatient(
	[PatientKey] INT IDENTITY(1,1) PRIMARY KEY,
	[AgeGroup] VARCHAR(10) NULL,
	[Ethnicity] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[Occupation] [varchar](50) NULL
)

CREATE TABLE FactCases(
	[CaseKey] INT PRIMARY KEY,
	[Infection] INT,
	[Recovery] INT,
	[Hospitalization] INT,
	[Death] INT,
	[PatientKey] [int] NULL,
	[DateKey] [int] NULL,
	[GeographyKey] [int] NULL
	FOREIGN KEY (PatientKey) REFERENCES DimPatient,
	FOREIGN KEY (DateKey) REFERENCES dimDate,
	FOREIGN KEY (GeographyKey) REFERENCES DimGeography
)
