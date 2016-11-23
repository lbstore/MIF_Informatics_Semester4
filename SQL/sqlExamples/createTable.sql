CREATE TABLE juva9765.Klientas (   
    AK            CHAR(11)    NOT NULL, 
    Vardas        VARCHAR(20) NOT NULL,
    Pavarde       VARCHAR(20) NOT NULL,
    Tel_Nr        CHAR(12)    NOT NULL,
    PRIMARY KEY (AK)
);

CREATE TABLE juva9765.Komanda (    
    Komandos_Nr   SERIAL      NOT NULL CHECK (Komandos_Nr > 0),
    Pavadinimas   VARCHAR(20) NOT NULL, 
    Biudzetas     INT         NOT NULL,
    Kliento_AK    VARCHAR(20) NOT NULL,
    PRIMARY KEY (Komandos_Nr),
    FOREIGN KEY (Kliento_AK) REFERENCES juva9765.Klientas     ON DELETE CASCADE
);

CREATE TABLE juva9765.Darbuotojas (   
    AK            CHAR(11)    NOT NULL, 
    Vardas        VARCHAR(20) NOT NULL,
    Pavarde       VARCHAR(20) NOT NULL,
    Atlyginimas   INT         NOT NULL CONSTRAINT MinimalusAtlyginimas CHECK (Atlyginimas >= 1000),
    PRIMARY KEY (AK)
);

CREATE TABLE juva9765.Komandu_sudetys (    
    Komandos_Nr   SMALLINT    NOT NULL,
    Darbuotojo_AK CHAR(11)    NOT NULL, 
    PRIMARY KEY (Komandos_Nr,Darbuotojo_AK),
    FOREIGN KEY (Komandos_Nr) REFERENCES juva9765.Komanda       ON DELETE CASCADE,
    FOREIGN KEY (Darbuotojo_AK) REFERENCES juva9765.Darbuotojas ON DELETE CASCADE
);

CREATE TABLE juva9765.Objektas (   
    Adresas       VARCHAR(20) NOT NULL, 
    Pavadinimas   VARCHAR(20) NOT NULL,
    Plotas        SMALLINT    NOT NULL CONSTRAINT MinimalusPlotas CHECK (Plotas > 2),
    Savininko_AK  CHAR(11)    NOT NULL,
    PRIMARY KEY (Adresas),
    FOREIGN KEY (Savininko_AK) REFERENCES juva9765.Klientas     ON DELETE CASCADE
);

