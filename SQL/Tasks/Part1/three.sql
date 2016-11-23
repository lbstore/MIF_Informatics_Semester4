Kiekvienam skaitytojui (vardas, pavardė) knygų, kurias jis yra paėmęs, autorių skaičius.

// KNYGU SKAICIUS
SELECT stud.skaitytojas.Vardas,stud.skaitytojas.Pavarde, COUNT(CASE WHEN stud.egzempliorius.skaitytojas =  stud.skaitytojas.nr THEN 1 END) AS "Knygu kiekis" FROM Stud.Skaitytojas INNER JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.Egzempliorius.skaitytojas GROUP BY Stud.skaitytojas.vardas,stud.skaitytojas.pavarde;

//FINAL Praeita karta
//AUTORIU SKAICIUS
SELECT skaitytojas.vardas,skaitytojas.pavarde, COUNT(CASE WHEN (stud.autorius.isbn = egzempliorius.isbn AND egzempliorius.skaitytojas = skaitytojas.nr)  THEN 1 END ) AS "Knygu Autoriu Kiekis" FROM stud.autorius,stud.egzempliorius,stud.skaitytojas GROUP BY skaitytojas.vardas,skaitytojas.pavarde;


//Lentele su autoriu kiekiu kiekvienai knygai
SELECT stud.egzempliorius.isbn,COUNT(*) FROM stud.skaitytojas INNER JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas GROUP BY stud.egzempliorius.isbn;




SELECT stud.skaitytojas.vardas, stud.skaitytojas.pavarde, COUNT(*) FROM stud.skaitytojas INNER JOIN( SELECT stud.egzempliorius.isbn,COUNT(*) FROM stud.skaitytojas INNER JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas GROUP BY stud.egzempliorius.isbn) ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas;


//MERGE skaitytojas + egzempliorius
SELECT s.*, e.* FROM stud.skaitytojas as s inner join stud.egzempliorius as e on e.skaitytojas = s.nr ORDER BY s.nr ASC;

SELECT a.*,e.* FROM stud.autorius AS a INNER JOIN stud.egzempliorius AS e ON a.isbn = e.isbn;

SELECT s.*, e.* FROM stud.skaitytojas as s inner join stud.egzempliorius as e on e.skaitytojas = s.nr ORDER BY s.nr ASC;

// PILNA LENTELE
SELECT stud.skaitytojas.*,stud.egzempliorius.*,stud.autorius.* FROM stud.skaitytojas JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas JOIN stud.autorius ON stud.egzempliorius.isbn = stud.autorius.isbn ORDER BY stud.skaitytojas.nr;

// PILNA LENTELE 2 (Tik tai, ko reikia)
SELECT stud.skaitytojas.vardas,stud.skaitytojas.pavarde,stud.skaitytojas.nr AS numeris,stud.egzempliorius.skaitytojas,stud.egzempliorius.nr,stud.egzempliorius.isbn,stud.autorius.isbn FROM stud.skaitytojas INNER JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas INNER JOIN stud.autorius ON stud.egzempliorius.isbn = stud.autorius.isbn;


//FINAL Su Inner Join

// INLINE
SELECT s.vardas,s.pavarde,COUNT(CASE WHEN fullTable.numeris = s.nr THEN 1 END) AS "Knygu Autoriu Kiekis" FROM stud.skaitytojas AS s,(SELECT stud.skaitytojas.vardas,stud.skaitytojas.pavarde,stud.skaitytojas.nr AS numeris,stud.egzempliorius.skaitytojas,stud.egzempliorius.nr,stud.egzempliorius.isbn,stud.autorius.isbn FROM stud.skaitytojas INNER JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas INNER JOIN stud.autorius ON stud.egzempliorius.isbn = stud.autorius.isbn) fullTable GROUP BY s.vardas,s.pavarde;

SELECT stud.skaitytojas.vardas,stud.skaitytojas.pavarde, COUNT(stud.autorius.vardas || stud.autorius.pavarde) FROM stud.skaitytojas LEFT JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas LEFT JOIN stud.autorius ON stud.egzempliorius.isbn = stud.autorius.isbn GROUP BY skaitytojas.vardas,skaitytojas.pavarde;


// WITH KEYWORD
WITH fulltable AS (SELECT stud.skaitytojas.vardas,stud.skaitytojas.pavarde,stud.skaitytojas.nr AS numeris,stud.egzempliorius.skaitytojas,stud.egzempliorius.nr,stud.egzempliorius.isbn,stud.autorius.isbn FROM stud.skaitytojas INNER JOIN stud.egzempliorius ON stud.skaitytojas.nr = stud.egzempliorius.skaitytojas INNER JOIN stud.autorius ON stud.egzempliorius.isbn = stud.autorius.isbn) SELECT s.vardas,s.pavarde,COUNT(CASE WHEN fullTable.numeris = s.nr THEN 1 END) AS "Knygu Autoriu Kiekis" FROM stud.skaitytojas as s,fulltable GROUP BY s.vardas,s.pavarde;


//bonus
