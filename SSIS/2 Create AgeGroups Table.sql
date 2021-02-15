USE Covid19DB

DROP TABLE IF EXISTS AgeGroups

CREATE TABLE AgeGroups (
	AgeGroup VARCHAR(10) PRIMARY KEY
)

INSERT INTO AgeGroups
VALUES ('0-4')
	,('5-17')
	,('18-29')
	,('30-39')
	,('40-49')
	,('50-65')
	,('65-74')
	,('75-84')
	,('85+')
