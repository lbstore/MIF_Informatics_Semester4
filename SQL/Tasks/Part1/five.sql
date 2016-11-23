Kiekvienai duomenų bazės lentelei - skaitinio tipo stulpelių skaičius.


SELECT Table_Schema, Table_Name,
Column_Name, Data_Type
FROM Information_Schema.Columns;





SELECT Table_Schema, Table_Name, COUNT(*)
FROM Information_Schema.Columns
GROUP BY Table_Schema, Table_Name;

SELECT DISTINCT Table_Name
FROM Information_Schema.Columns
WHERE Table_Schema = 'information_schema'
ORDER BY 1;


SELECT Table_Name
FROM Information_Schema.Tables
WHERE Table_Schema = 'stud'
ORDER BY 1;


SELECT Table_Name
FROM Information_Schema.Tables
WHERE Table_Schema = 'information_schema'
ORDER BY 1;

//Visos lenteles
SELECT Table_Schema, Table_Name
FROM Information_Schema.Tables WHERE Table_Schema = 'stud'
ORDER BY 1, 2;

//Lenteliu skaicius
SELECT count(*) FROM Information_Schema.Tables;

//Visu lenteliu skaitmeniniu stulpeliu skaicius
SELECT Table_Schema, Table_Name,
Column_Name, Data_Type,
	CASE
		WHEN Data_type = 'smallint' THEN 1
		WHEN Data_type = 'integer' THEN 1
		WHEN Data_type = 'bigint' THEN 1
		WHEN Data_type = 'decimal' THEN 1
		WHEN Data_type = 'numeric' THEN 1
		WHEN Data_type = 'real' THEN 1
		WHEN Data_type = 'double precision' THEN 1
		WHEN Data_type = 'serial' THEN 1
		WHEN Data_type = 'bigserial' THEN 1
		ELSE 0
	END AS "indikatorius"
FROM Information_Schema.Columns WHERE Table_Schema = 'stud';


//FINAL

WITH DecimalCol AS (SELECT Table_Schema, Table_Name,
	CASE
		WHEN Data_type = 'smallint' THEN 1
		WHEN Data_type = 'integer' THEN 1
		WHEN Data_type = 'bigint' THEN 1
		WHEN Data_type = 'decimal' THEN 1
		WHEN Data_type = 'numeric' THEN 1
		WHEN Data_type = 'real' THEN 1
		WHEN Data_type = 'double precision' THEN 1
		WHEN Data_type = 'serial' THEN 1
		WHEN Data_type = 'bigserial' THEN 1
		ELSE 0
	END AS "indikatorius"
FROM Information_Schema.Columns)
SELECT Table_Schema as "Schema", Table_Name "Vardas", Sum(indikatorius) as "Viso Skaitinio tipo stulpeliu" FROM DecimalCol GROUP BY Table_Schema,Table_Name ORDER BY Table_Schema DESC;



//BONUS
WITH
NonDecimalCol AS (SELECT Table_Schema, Table_Name,
	CASE
		WHEN Data_type = 'smallint' THEN 0
		WHEN Data_type = 'integer' THEN 0
		WHEN Data_type = 'bigint' THEN 0
		WHEN Data_type = 'decimal' THEN 0
		WHEN Data_type = 'numeric' THEN 0
		WHEN Data_type = 'real' THEN 0
		WHEN Data_type = 'double precision' THEN 0
		WHEN Data_type = 'serial' THEN 0
		WHEN Data_type = 'bigserial' THEN 0
		ELSE 1
	END AS "indikatorius"
FROM Information_Schema.Columns),
NonDecimalColReady(schema,vardas,sk) AS(
	SELECT Table_Schema as "Schema", Table_Name "Vardas", Sum(indikatorius) as "Viso Skaitinio tipo stulpeliu" FROM NonDecimalCol GROUP BY Table_Schema,Table_Name ORDER BY Table_Schema DESC),
DecimalCol AS (SELECT Table_Schema, Table_Name,
	CASE
		WHEN Data_type = 'smallint' THEN 1
		WHEN Data_type = 'integer' THEN 1
		WHEN Data_type = 'bigint' THEN 1
		WHEN Data_type = 'decimal' THEN 1
		WHEN Data_type = 'numeric' THEN 1
		WHEN Data_type = 'real' THEN 1
		WHEN Data_type = 'double precision' THEN 1
		WHEN Data_type = 'serial' THEN 1
		WHEN Data_type = 'bigserial' THEN 1
		ELSE 0
	END AS "indikatorius"
	FROM Information_Schema.Columns),
DecimalColReady(schema,vardas,sk) AS(
	SELECT Table_Schema as "Schema", Table_Name "Vardas", Sum(indikatorius) as "Viso Skaitinio tipo stulpeliu" FROM DecimalCol GROUP BY Table_Schema,Table_Name ORDER BY Table_Schema DESC
)
 SELECT NonDecimalColReady.schema,NonDecimalColReady.vardas FROM NonDecimalColReady JOIN DecimalColReady ON DecimalColReady.sk >= NonDecimalColReady.sk;

//wip
skaitiniu stu
