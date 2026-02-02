-- kuvab tabeli, * - kõik väljad 
select * from opilane;
-- tabeli kustutamine
drop table opilane;
-- lisame 2. kirjet korraga
insert into opilane(eesnimi, perekonnanimi, synniaeg, kas_opib, aadress)
values ('Dominic','Kekkonen','2009-18-02', 1),
('Dominic','Ivanov','2009-18-02', 0);
select * from opilane
-- ühe kirja kustamine 
delete from opilane where opilaneID=2;
-- kirje uuendamine
update table opilane set aadress='Tallinn'
where opilaneID=2;
select * from opilane;
