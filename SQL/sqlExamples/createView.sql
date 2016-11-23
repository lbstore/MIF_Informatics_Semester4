-- Studentai ir ju amziai

CREATE VIEW StudentasAmzius AS
    SELECT A.lsp, A.vardas, A.pavarde,  EXTRACT(YEAR FROM age(A.gimimas)) AS Amzius
    FROM Studentas AS A;


-- Bendrabuciu lenteles sutrumpinimas

CREATE VIEW Bendrabuciai AS
    SELECT A.Nr, A.adresas, A.telefonoNr
    FROM Bendrabutis AS A;


-- Bendarbuciai ir ju administratoriai

CREATE VIEW BendrabutisAdministratorius AS
    SELECT B.Nr, A.vardas, A.pavarde, A.telefonoNr 
      FROM Administratorius as A, 
           Bendrabutis as B 
      WHERE A.ak = B.ak ;