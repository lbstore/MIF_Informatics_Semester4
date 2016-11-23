-- Dalykine taisykle, uztikrinanti, kad studentas 
-- nebutu apgyvendintas pilname kambaryje

CREATE FUNCTION vietuMax() RETURNS "trigger" AS $$
DECLARE max   SMALLINT;
DECLARE yra   SMALLINT;
    BEGIN

        /* Gauname kambario, i kuri norima apgyvendinti nauja studenta, gyventoju skaiciu */
        SELECT COUNT(*) INTO yra FROM Studentas 
              WHERE kambarioNr = NEW.kambarioNr 
              AND bendrabucioNr = NEW.bendrabucioNr;

        /* Gauname kambario maksimalia gyventoju talpa */
        SELECT vietos INTO max FROM Kambarys
              WHERE nr = NEW.kambarioNr
              AND bendrabutis = NEW.bendrabucioNr;
        
        IF yra >= max
            THEN RAISE EXCEPTION 'Kambaryje laisvu gyvenamu vietu nebera!';
        END IF;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER pilnumui
    BEFORE INSERT OR UPDATE ON Studentas
    FOR EACH ROW EXECUTE PROCEDURE vietuMax();





-- Dalykine taisykle, uztikrinanti, kad administratorius
-- priziuretu ne daugiau nei 2 bendrabucius
CREATE FUNCTION adminMax() RETURNS "trigger" AS $$

DECLARE max CONSTANT SMALLINT := 2;
DECLARE yra          SMALLINT;

    BEGIN

        /* Suskaiciuojame, kiek administratorius jau administruoja bendrabuciu */
        SELECT COUNT(*) INTO yra 
                             FROM Bendrabutis
                             WHERE ak = NEW.ak;

        IF yra >= max
            THEN RAISE EXCEPTION 'Administratorius negali administruoti daugiau nei % bendrabuciu!', max;
        END IF;
        RETURN NEW;

    END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER administratoriui
    BEFORE UPDATE ON Bendrabutis
    FOR EACH ROW EXECUTE PROCEDURE adminMax();