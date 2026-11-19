create database transaktsioonIKT25
use transaktsioonIKT25

CREATE TABLE konto (
    konto_id INT PRIMARY KEY,
    omanik   VARCHAR(50)   NOT NULL,
    saldo    DECIMAL(10,2) NOT NULL CHECK (saldo >= 0)
);

INSERT INTO konto (konto_id, omanik, saldo) VALUES
    (1, 'Mari', 500.00),
    (2, 'Jaan', 200.00),
    (3, 'Liis',  50.00);

-- vaata kehtivat seadet (1 = sees)
SELECT @@autocommit;

-- lülita selle ühenduse jaoks välja (0 ja OFF on samaväärsed)
SET autocommit = 0;

-- lülita tagasi sisse (1 ja ON on samaväärsed)
SET autocommit = 1;

--lisamis transaktsioon
--alustame transaktsiooni
begin TRANSACTION;

UPDATE konto SET saldo = saldo - 100 WHERE konto_id = 1;  -- Mari
UPDATE konto SET saldo = saldo + 100 WHERE konto_id = 2;  -- Jaan

SELECT * FROM konto;

--tagasi võtmine
rollback;
select * from konto

--kustutamis transaktsioon: kogemata kustutamine kõik kontod
-- unustasimine where kirjutama

begin TRANSACTION;

delete from konto;
select count(*) as kontodeArv_enne from konto;

rollback;
select count(*) as kontodeArv_parast from konto;

--uuendamis transaktsioon
begin TRANSACTION;

INSERT INTO konto (konto_id, omanik, saldo) VALUES (5, 'Toomas', 400.00);
SAVe transaction parast_lisamist;

UPDATE konto SET saldo = 0;   -- viga: nullis kõik kontod
select * from konto


ROLLBACK transaction parast_lisamist;   -- UPDATE tühistatud, INSERT alles

COMMIT;

select * from konto

--kehtib seansi lõppuni
SET TRANSACTION ISOLATION LEVEL repeatable READ;
begin TRANSACTION;
SELECT saldo FROM konto WHERE konto_id = 1;
COMMIT;

begin transaction;
update konto set saldo = saldo - 300
where konto_id = 1
--read uncommited
begin transaction;
update konto set saldo = saldo - 300
where konto_id = 1

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
begin TRANSACTION;
SELECT saldo FROM konto WHERE konto_id = 1;
COMMIT;

rollback;
select saldo from konto where konto_id = 1

--veakäsitlus transaktsioonis

BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE konto SET saldo = saldo - 1000 WHERE konto_id = 3;  -- viga
    UPDATE konto SET saldo = saldo + 1000 WHERE konto_id = 1;

    COMMIT TRANSACTION;
    PRINT 'Ülekanne õnnestus';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'Ülekanne tühistati: ' + ERROR_MESSAGE();
END CATCH;
