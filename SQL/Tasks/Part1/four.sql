Data, kai ėmusiųjų knygas skaitytojų buvo daugiausiai. Greta pateikti ir tuomet ėmusiųjų knygas skaitytojų skaičių.


SELECT paimta ,COUNT(paimta) from stud.egzempliorius GROUP BY paimta ORDER BY COUNT(paimta) DESC LIMIT 1;



SELECT paimta,max(countas) from stud.egzempliorius where countas in (SELECT paimta ,COUNT(paimta) as countas from stud.egzempliorius GROUP BY paimta ORDER BY countas);

WITH lentele(paimta,countas) as (SELECT stud.egzempliorius.paimta ,COUNT(paimta) as countas from stud.egzempliorius GROUP BY paimta),did(maximumas)as(SELECT max(countas) from lentele) SELECT paimta,maximumas from lentele group by max(countas);


SELECT stud.egzempliorius.paimta ,COUNT(paimta) as countas from stud.egzempliorius GROUP BY paimta;



//FINAL
WITH lentele(paimta,countas) AS (SELECT stud.egzempliorius.paimta ,COUNT(paimta) AS countas FROM stud.egzempliorius GROUP BY paimta),did(maximumas) AS (SELECT MAX(countas) from lentele) SELECT lentele.paimta,did.maximumas FROM did,lentele WHERE lentele.countas = did.maximumas;


SELECT stud.egzempliorius.paimta ,COUNT(paimta) as countas from stud.egzempliorius GROUP BY paimta;


//bonus
Datai kiek egzemplioriu skaicius, kiek skirtingu knygu

selecte data,egzemplioriu sk,knygu skaicius,seniausia knyga is tos datos saraso
WITH sarasas(data,egzsk,knygsk) AS(SELECT stud.egzempliorius.paimta,COUNT(stud.egzempliorius.isbn),COUNT (DISTINCT stud.egzempliorius.isbn) FROM stud.egzempliorius GROUP BY stud.egzempliorius.paimta)


SELECT stud.egzempliorius.paimta,COUNT(stud.egzempliorius.isbn),COUNT (DISTINCT stud.egzempliorius.isbn) FROM stud.egzempliorius GROUP BY stud.egzempliorius.paimta;

WITH nefiltruotas(data,isbn,pavadinimas,metai) AS(SELECT stud.egzempliorius.paimta, stud.egzempliorius.isbn, stud.knyga.pavadinimas,stud.knyga.metai  FROM stud.egzempliorius JOIN stud.knyga ON stud.egzempliorius.isbn = stud.knyga.isbn ) SELECT * FROM nefiltruotas;

WITH nefiltruotas(data,isbn,pavadinimas,metai) AS(SELECT stud.egzempliorius.paimta, stud.egzempliorius.isbn, stud.knyga.pavadinimas, stud.knyga.metai  FROM stud.egzempliorius JOIN stud.knyga ON stud.egzempliorius.isbn = stud.knyga.isbn ),WITH minlist(min) AS  SELECT(nefiltruotas.pavadinimas where nefiltruotas.metai = MIN(nefiltruotas.metai)) FROM SELECT stud.egzempliorius.paimta, stud.egzempliorius.isbn, stud.knyga.pavadinimas, stud.knyga.metai  FROM stud.egzempliorius JOIN stud.knyga ON stud.egzempliorius.isbn = stud.knyga.isbn )
 SELECT nefiltruotas.data, COUNT(nefiltruotas.isbn), COUNT (DISTINCT nefiltruotas.isbn),
FROM nefiltruotas GROUP BY data;


WITH nefiltruotas(data,isbn,pavadinimas,metai) AS(SELECT stud.egzempliorius.paimta, stud.egzempliorius.isbn, stud.knyga.pavadinimas, CASE WHEN( THEN MIN(stud.knyga.metai) END AS MINIMUMAS  FROM stud.egzempliorius JOIN stud.knyga ON stud.egzempliorius.isbn = stud.knyga.isbn ) SELECT * FROM nefiltruotas;







kiekvienai knygai isb ,knygos pavadinimas, autoriu sk, egzemplioriu sk, paimtu egzemplioriu sk, anskciausia data is grazinamu knygu

// visa
SELECT egzem.isbn, egzem.paimta, egzem.grazinti FROM stud.egzempliorius as egzem;
//autoriu kiekis
SELECT stud.autorius.isbn, COUNT(*) AS "Autoriu sk" FROM stud.autorius GROUP BY stud.autorius.isbn;

//knygu kiekis
SELECT egzem.isbn,stud.knyga.pavadinimas, COUNT(egzem.isbn) as "Knygu sk",COUNT(egzem.paimta) as "Paima sk"  FROM stud.egzempliorius as egzem JOIN stud.knyga ON egzem.isbn = stud.knyga.isbn GROUP BY egzem.isbn,stud.knyga.pavadinimas;
//anksciausiai grazinama

SELECT egzem.isbn, MIN(egzem.grazinti) as "Anskciausia grazinti" FROM stud.egzempliorius  as egzem GROUP BY egzem.isbn;


//MERGE
WITH autoriai(isbn,autkiekis) AS (SELECT stud.autorius.isbn, COUNT(*) AS "Autoriu sk" FROM stud.autorius GROUP BY stud.autorius.isbn)
SELECT egzem.isbn, MIN(egzem.grazinti) as "Anskciausia grazinti",autoriai.autkiekis as "Autoriu sk" FROM stud.egzempliorius  as egzem JOIN autoriai ON autoriai.isbn = egzem.isbn GROUP BY egzem.isbn,autoriai.autkiekis;



  WITH autoriai(isbn,autkiekis) AS (
    SELECT stud.autorius.isbn, COUNT(*) AS "Autoriu sk" FROM stud.autorius GROUP BY stud.autorius.isbn),
  merged(isbn,anksciausiai,autoriusk) AS (
    SELECT egzem.isbn, MIN(egzem.grazinti) as "Anskciausia grazinti",autoriai.autkiekis as "Autoriu sk" FROM stud.egzempliorius  as egzem JOIN autoriai ON autoriai.isbn = egzem.isbn GROUP BY egzem.isbn,autoriai.autkiekis),
  knygukiekis(isbn,pavadinimas,knygusk,paimta) AS (
    SELECT egzem.isbn,stud.knyga.pavadinimas, COUNT(egzem.isbn) as "Knygu sk",COUNT(egzem.paimta) as "Paima sk"  FROM stud.egzempliorius as egzem JOIN stud.knyga ON egzem.isbn = stud.knyga.isbn GROUP BY egzem.isbn,stud.knyga.pavadinimas
  )
SELECT merged.isbn,knygukiekis.pavadinimas,merged.autoriusk,knygukiekis.knygusk,knygukiekis.paimta,merged.anksciausiai  FROM merged JOIN knygukiekis ON merged.isbn = knygukiekis.isbn;
