USE Covid19DB

--DROP TABLE Ages

CREATE TABLE Ages (
	age INT PRIMARY KEY
)

DECLARE @_i INT = 1
DECLARE @_MaxAge INT = 120
WHILE @_i <= @_MaxAge
BEGIN
	INSERT INTO Ages
	VALUES (@_i)
	SET @_i += 1
END