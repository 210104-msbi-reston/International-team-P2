/****** Script for SelectTopNRows command from SSMS  ******/

  Insert Into Gender
  VALUES
  ('Male'),
  ('Female')

  SELECT * FROM FacilityType

  insert into FacilityType VALUES
  ('Pharmacy'),
  ('Testing Center'),
  ('Hospital')

  SELECT * FROM Facility
  DBCC CHECKIDENT ('Facility', RESEED, 1)

  select * from Test where TestResult=1
  select * from [Case]

  select * from Patient

  select * from Occupation
  Insert into Occupation Values
  ('Health Care'),
  ('Transportation'),
  ('Government'),
  ('Sales'),
  ('Other')

  select * from Ethnicity
  select * from Gender

 select * from Ethnicity

 SELECT FLOOR(RAND()*(2-1+1))+1;

declare @rowCount INT = (SELECT COUNT(*) FROM Patient)
DECLARE @counter int =1
declare @patientNum INT
declare @rand INT
while @counter<=@rowCount
begin
     
	 ; with  A (rowNum,patientId)
		as
		(select ROW_NUMBER() over (order by patientID), PatientId from  Patient)
		Select @patientNum = (select patientId from A where rowNum = @counter)
		SELECT @rand=(SELECT FLOOR(RAND()*(2-1+1))+1)
		UPDATE Patient set EthnicityID=@rand WHERE PatientID=@patientNum

	 set @counter =@counter +1 
end

UPDATE Patient set EthnicityID=3 WHERE PatientID=2430

SELECT * FROM Outcome

Insert into Outcome Values
('Dead'),('Hospitalized'),('Recovered')

INSERT INTO [Case]([Date],TestID)
SELECT [Date],TestID FROM Test

delete from [Case] where TestID in (select TestID from Test where TestResult=0)