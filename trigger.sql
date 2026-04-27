Create database trigerKekkonen;
USE trigerKekkonen;
--lisame linnad table
Create table linnad(
linnID int PRIMARY KEY IDENTITY (1,1),
linnanimi varchar(50) unique,
rahvaarv int);
select * from linnad
--lisame logi table
Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
aeg DATETIME,
toiming  varchar(100),
andmed TEXT
)
--lisame maakond table
Create table maakonnad(
maakondID int PRIMARY KEY IDENTITY (1,1),
maakondnimi varchar(25) unique);
--foreign key tabelis linnad
alter table linnad add maakondID int;
select * from linnad;
alter table linnad add constraint fk_maakond
foreign key (maakondID) references maakonnad(maakondID);
--täidame tabelid
--maakonnad
insert into maakonnad
values('Harjumaa'), ('Pärnumaa'), ('Virumaa');
select * from maakonnad;
insert into linnad (linnanimi, rahvaarv, maakondID)
values('Tallinn', 600000, 1),
('Rakvere',75000, 3);

select * from linnad, maakonnad
where linnad.maakondID=maakonnad.maakondID;
--sama päring inner joiniga 
select * from linnad inner join maakonnad
on linnad.maakondID=maakonnad.maakondID
--triger mis jälgib kaks seostatud tabelid
CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(aeg, toiming, andmed)
SELECT
GETDATE(),
CONCAT(inserted.linnanimi,', ',inserted.rahvaarv,', ', maakonnad.maakondnimi),
SYSTEM_USER
FROM inserted inner join maakonnad
on inserted.maakondID=maakonnad.maakondID;
--kontroll
insert into linnad(linnanimi,rahvaarv,maakondID)
values('Pärnu', 100000, 2);

select * from logi
select * from linnad
--triger mis jälgib kaks seostatud tabelid
CREATE TRIGGER linnaKustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(aeg, toiming, andmed)
SELECT
SUSER_NAME(),
GETDATE(),
CONCAT('linn: ', deleted.linnanimi, ', elanike arv: ', deleted.rahvaarv)  --andmed
FROM deleted inner join maakonnad m
on deleted.maakondID=m.maakondID;
--kontroll
Delete from linnad where linnID=2;
select * from logi;
--triger mis jälgib kaks seostatud tabelid
CREATE TRIGGER linnaUuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(aeg, toiming, andmed)
SELECT
GETDATE(),
CONCAT('vana linna andmed: ', deleted.linnanimi, ', elanike arv: ', deleted.rahvaarv, ', ', m1.maakondnimi,
'uue linna andmed: ', inserted.linnanimi, ', elanike arv: ', deleted.rahvaarv, ', ', m2.maakondnimi),
SYSTEM_USER
FROM deleted
inner join inserted on deleted.linnID=inserted.linnID
inner join maakonnad m1 on deleted.maakondID=m1.maakondID
inner join maakonnad m2 on deleted.maakondID=m2.maakondID;

--kontroll
select * from linnad
select * from maakonnad
update linnad set maakondID=3 where linnID=5;
select * from logi;
update linnad set maakondID=1, linnanimi='uus Paide' where linnID=5;
