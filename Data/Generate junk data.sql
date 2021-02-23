use Covid19DB
go


-----------------------------------------------create patients------------------------------------------------
declare @_GenerateN INT = 100000  -----------number of patients to generate MARKER

declare @_MaxAge INT = 100
declare @_Age int
declare @_Ethnicity int
declare @_Gender int
declare @_Occupation int
declare @_city int

declare @_i int = 0

while @_i < @_GenerateN
begin

set @_Age = round(rand()*@_MaxAge,0)
select top 1 @_Ethnicity = EthnicityID from Ethnicity order by newid()
select top 1 @_Gender = GenderID from Gender order by newid()
select top 1 @_Occupation = OccupationID from Occupation order by newid()
select top 1 @_city = CityID from City order by newid()


--------------------------------------------store a list of newly created patients------------------------
insert into Patient
	output inserted.PatientID 
		into temp_PatientID
values(@_Age, @_Ethnicity, @_Gender, @_Occupation, @_city)

set @_i += 1
end

go

------------------------mark patients as infected in Case table------------------------------------------------------
declare @_StartDate datetime = cast('2020-01-20' as datetime)
declare @_EndDate datetime = getdate()
declare @_MaxDateDiff int = datediff(day, @_startdate, @_enddate)
declare @_RandDateDiff int -- = rand()*@_MaxDateDiff
declare @_Date date
declare @_PatientID int
declare @_SymptomID int

declare @_OutcomeID int
select @_OutcomeID = OutcomeID from Outcome where [Name] = 'Infected' -----OUTCOME MARKER for Infections

declare @_NInfections int
select @_NInfections = count(*) from [temp_PatientID]

declare @_i int = 0

while @_i < @_NInfections
begin
	set @_RandDateDiff = round(rand()*@_MaxDateDiff, 0)
	set @_Date = cast(@_StartDate + @_RandDateDiff as date)

	select @_PatientID = PatientID from temp_PatientID
	where ID = @_i+1

	select top 1 @_SymptomID = SymptomID from Symptom order by newid()

	

	insert into [Case]
	values(@_Date, @_PatientID, @_SymptomID, @_OutcomeID)
	
	set @_i += 1
end


go

--------------------------------mark newly infected patients as hospitalized------------------

declare @_Date date
declare @_PatientID int
declare @_SymptomID int
declare @_OutcomeID int

declare @_StartDate date
declare @_MaxDateDiff int = 14
declare @_MaxDate date = getdate()

declare @_HRate float = 0.05 ------ RATE MARKER

declare @_Hospitalizations int
select @_Hospitalizations = round(count(*)*@_HRate, 0) from temp_PatientID
--select @_Hospitalizations

if object_id('dbo.temp_h') is null
	create table temp_h (
		id int primary key identity,
		PatientID int
	)

insert into temp_h
select top (@_Hospitalizations) PatientID from temp_PatientID order by newid()

select @_SymptomID = SymptomID from Symptom where [Severity] = 'Severe' ------------Severity MARKER

select @_OutcomeID = OutcomeID from Outcome where [Name] = 'Hospitalized' ------------Hospitalized MARKER

declare @_i int = 0
while @_i < @_Hospitalizations
begin
	print 'yes'
	select @_PatientID = PatientID from temp_h where id = @_i + 1

	select  @_StartDate = [Date] from [case] where PatientID = @_PatientID

	set @_Date = cast(cast(@_StartDate as datetime) + round(@_MaxDateDiff * RAND(), 0) as date)

	if @_Date > @_MaxDate
		set @_Date = @_MaxDate

	insert into [Case]
	values(@_Date, @_PatientID, @_SymptomID, @_OutcomeID)
	
	set @_i += 1

end

truncate table temp_h

go

---------------------------------------------create death events---------------------------------------


declare @_Date date
declare @_PatientID int
declare @_SymptomID int
declare @_OutcomeID int

declare @_StartDate date
declare @_MaxDateDiff int = 14
declare @_MaxDate date = getdate()

declare @_Rate float = 0.02 ------ RATE MARKER

declare @_Events int
select @_Events = round(count(*)*@_Rate, 0) from temp_PatientID
--select @_Hospitalizations

if object_id('dbo.temp_h') is null
	create table temp_h (
		id int primary key identity,
		PatientID int
	)

insert into temp_h
select top (@_Events) PatientID from temp_PatientID order by newid()

select @_SymptomID = SymptomID from Symptom where [Severity] = 'Severe' ------------Severity MARKER

select @_OutcomeID = OutcomeID from Outcome where [Name] = 'Died' ------------Death  MARKER

declare @_i int = 0
while @_i < @_Events
begin

	select @_PatientID = PatientID from temp_h where id = @_i + 1

	select  @_StartDate = max([Date]) from [case] where PatientID = @_PatientID

	set @_Date = cast(cast(@_StartDate as datetime) + round(@_MaxDateDiff * RAND(), 0) as date)

	if @_Date > @_MaxDate
		set @_Date = @_MaxDate

	insert into [Case]
	values(@_Date, @_PatientID, @_SymptomID, @_OutcomeID)
	
	set @_i += 1

end

delete from temp_PatientID
where PatientID in (select PatientID from temp_h)


truncate table temp_h

go


-------------------------------------Create recovery events -------------------------------

declare @_Date date
declare @_PatientID int
declare @_SymptomID int
declare @_OutcomeID int

declare @_StartDate date
declare @_MaxDateDiff int = 14
declare @_MaxDate date = getdate()

declare @_Rate float = 0.7 ------ RATE MARKER

declare @_Events int
select @_Events = round(count(*)*@_Rate, 0) from temp_PatientID


if object_id('dbo.temp_h') is null
	create table temp_h (
		id int primary key identity,
		PatientID int
	)

insert into temp_h
select top (@_Events) PatientID from temp_PatientID order by newid()

select @_SymptomID = SymptomID from Symptom where [Severity] = 'None' ------------Severity MARKER

select @_OutcomeID = OutcomeID from Outcome where [Name] = 'Recovered' ------------Recovered  MARKER

declare @_i int = 0
while @_i < @_Events
begin

	select @_PatientID = PatientID from temp_h where id = @_i + 1

	select  @_StartDate = max([Date]) from [case] where PatientID = @_PatientID

	set @_Date = cast(cast(@_StartDate as datetime) + round(@_MaxDateDiff * RAND(), 0) as date)

	if @_Date > @_MaxDate
		set @_Date = @_MaxDate

	insert into [Case]
	values(@_Date, @_PatientID, @_SymptomID, @_OutcomeID)
	
	set @_i += 1

end

delete from temp_PatientID
where PatientID in (select PatientID from temp_h)


truncate table temp_h
truncate table temp_PatientID
go