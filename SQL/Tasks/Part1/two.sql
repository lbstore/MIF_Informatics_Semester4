Konkrečioje leidykloje išleistų knygų visų autorių vardai ir jų pavardės.


SELECT a.vardas, a.pavarde FROM Stud.Autorius as a, Stud.Knyga as k WHERE k.leidykla  = 'Baltoji' AND k.isbn = a.isbn;




SELECT a.vardas || ',' || a.pavarde as "Autorius" FROM Stud.Autorius as a, Stud.Knyga as k WHERE (k.leidykla  = 'Baltoji' AND k.isbn = a.isbn);


SELECT leidykla , COUNT(*) FROM Stud.Knyga GROUP BY leidykla;
