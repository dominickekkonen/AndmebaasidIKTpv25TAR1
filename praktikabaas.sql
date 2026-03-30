create database praktikabaas
use praktikabaas
--1. tabel – firma
CREATE TABLE firma(
    firmaID INT NOT NULL PRIMARY KEY identity(1,1),
    firmanimi VARCHAR(20),
    aadress VARCHAR(20),
    telefon VARCHAR(20)
);
select * from firma;
INSERT INTO firma (firmanimi, aadress, telefon)
VALUES 
('DigiLahendused OÜ', 'Sõpruse pst 15', '5551234'),
('Nordic Ehitus AS', 'Pärnu mnt 102', '5556789'),
('Tallinna Logistika', 'Betooni 4', '5550011'),
('Roheline Energia', 'Narva mnt 7', '5552233'),
('Kiire TeenindusTLN', 'Tartu mnt 50', '5554455');

--2. tabel – praktikajuhendaja
create table praktikajuhendaja(
	praktikajuhendajaID int not null 
primary key identity(1,1),
	eesnimi varchar(20),
	perekonnanimi varchar(20),
	synniaeg date,
	telefon varchar(20)
);
select * from praktikajuhendaja;
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
VALUES 
('Juhan', 'Juust', '1980-05-12', '56123456'),
('Mari', 'Maasikas', '1985-09-20', '56987654'),
('Kati', 'Kask', '1992-11-05', '55112233'),
('Andres', 'Ankur', '1978-03-15', '50445566'),
('Tiina', 'Tamm', '1988-10-22', '53889900');

--3. tabel – praktikabaas
CREATE TABLE praktikabaas(
    praktikabaasID INT NOT NULL 
    PRIMARY KEY identity(1,1),
    firmaID INT,
    praktikatingimused VARCHAR(20),
    arvutiprogramm VARCHAR(20),
    juhendajaID INT,
    FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
    FOREIGN KEY (juhendajaID) 
    REFERENCES praktikajuhendaja(praktikajuhendajaID)
);
select * from praktikabaas;
INSERT INTO praktikabaas (firmaID, praktikatingimused, arvutiprogramm, juhendajaID)
VALUES 
(6, 'Valitöö', 'VS Code', 1),
(7, 'Välitööd', 'AutoCAD', 4),
(8, 'Ladu/Logistika', 'MS Excel', 2),
(9, 'Kaugtöö', 'Python/Slack', 5),
(10, 'Klienditeenindus', 'SAP', 3);

--SELECT päringute ülesanded
--1. Leia kõik firmad, mille nimes sisaldub täht „a“
SELECT * FROM firma WHERE firmanimi LIKE '%a%';

--2. Kuva andmed kahest tabelist, arvestades nende seost ja sorteeri firmade nimede järgi
SELECT *
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
ORDER BY firmanimi;

--3. Leia, mitu korda iga firma on praktikabaas
SELECT firmanimi, COUNT(praktikabaasID) AS kogus
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
GROUP BY firmanimi;

--4. Leia kõik juhendajad, kes on sündinud sügisel (september, oktoober, november)
FROM praktikajuhendaja
WHERE MONTH(synniaeg) = 9 
OR MONTH(synniaeg) = 10 
OR MONTH(synniaeg) = 11;

--5. Edasised ülesanded (koosta ise SQL päringud)
--1 - Kuva iga juhendaja kohta praktikakohtade arv
SELECT eesnimi, perekonnanimi, COUNT(praktikabaasID) AS kohtade_arv
FROM praktikajuhendaja
LEFT JOIN praktikabaas ON praktikajuhendaja.praktikajuhendajaID = praktikabaas.juhendajaID
GROUP BY eesnimi, perekonnanimi;

--2 - Lisa tabelisse praktikajuhendaja uus veerg palk
ALTER TABLE praktikajuhendaja ADD palk DECIMAL(10,2);

--3 - Täida palk väärtustega
   UPDATE praktikajuhendaja SET palk = 1200.00 
   WHERE praktikajuhendajaID = 1;
   UPDATE praktikajuhendaja SET palk = 1450.50 
   WHERE praktikajuhendajaID = 2;
   UPDATE praktikajuhendaja SET palk = 1100.00 
   WHERE praktikajuhendajaID = 3;
   UPDATE praktikajuhendaja SET palk = 1600.00 
   WHERE praktikajuhendajaID = 4;
   UPDATE praktikajuhendaja SET palk = 1320.00 
   WHERE praktikajuhendajaID = 5;

--4. Leia keskmine palk ja kogupalk
SELECT AVG(palk) AS keskmine_palk, SUM(palk) AS kogupalk 
FROM praktikajuhendaja; 

--5. Üks enda SQL päring (Custom Query)
SELECT firma.firmanimi, praktikabaas.arvutiprogramm
FROM firma

--VIEW loomine
--1 – VIEW
CREATE VIEW v_firma_praktikakohad AS
SELECT firmanimi, COUNT(praktikabaasID) AS kogus
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
GROUP BY firmanimi;
--kutse 
SELECT * FROM v_firma_praktikakohad;
 
--2 – VIEW
CREATE VIEW v_sygis_juhendajad AS
SELECT *
FROM praktikajuhendaja
WHERE MONTH(synniaeg) IN (9, 10, 11);
--kutse
SELECT * FROM v_sygis_juhendajad; 

--7. Protseduurid
--1. Lisa uus firma
DELETE FROM firma
WHERE firmaID = 14
CREATE PROCEDURE lisaUusFirma
    @Nimi varchar(40),
    @Aadress varchar(40),
	@telefon varchar(15)
AS
BEGIN
    INSERT INTO Firma (firmanimi, aadress, telefon)
    VALUES (@Nimi, @Aadress, @telefon);
END;
--kutse
exec lisaUusFirma 'TehnilineTöö', 'Sõpruse pst 145', '+37264545782';
select * from firma;
--Muuda tabeli struktuuri
CREATE PROCEDURE LisaEmail
AS
BEGIN
    ALTER TABLE Firma
    ADD Email varchar(100);
END;
--kutse
EXEC LisaEmail;
SELECT * FROM Firma;
--Arvutab keskmine palk
CREATE PROCEDURE KeskminePalkKalk
AS
BEGIN
    SELECT AVG(palk) AS KeskminePalk
    FROM praktikajuhendaja;
END;
--kutse
exec KeskminePalkKalk;
--8. Varem kirjutatud funktsiooni kasutamine.
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(GETDATE())) or (MONTH(@DOB)
		= month (getdate()) and day(@DOB) > DAY(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @years, @tempdate)

		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = dateadd(MONTH, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + 
		' Months ' + cast(@days as nvarchar(2)) + ' Days old'
	return @Age
end
--kutse
DECLARE @DOB DATETIME = '2009-02-18'
SELECT dbo.fnComputeAge(@DOB) AS Age

