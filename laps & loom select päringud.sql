-- select kahe tabeli põhjal
create database select2tabeli;
use select2tabeli;
-- laps/loom tabelit
CREATE TABLE laps(
    lapsID int not null PRIMARY KEY identity(1,1),
    nimi varchar(40) not null,
    pikkus smallint,
    synniaasta int null,
    synnilinn varchar(15)
    )
insert into laps(nimi, pikkus, synniaasta, synnilinn)
values('Kirill', 156, 2006, 'Tallinn'),
('Nikita', 149, 2008, 'Tallinn'),
('Viktor', 179, 2007, 'Narva'),
('Maksim', 173, 2008, 'Tartu'),
('Anton', 170, 2006, 'Tartu');
select * from laps

CREATE TABLE loom(
    loomID int not null PRIMARY KEY identity(1,1),
    nimi varchar(40) not null,
    kaal smallint,
    lapsID int,
    FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
   )
insert into loom(nimi, kaal, lapsID)
values('Petja', 5, 2),
('Sharik', 4, 1),
('Bobik', 4, 3),
('Vasilij', 3, 4);

--Alias nimede kasutamine
select l.nimi, l.kaal from loom as l;
--sisemine ühendamine
select * from laps, loom; --nii ei tohi kirjutada 
--sest 1 tabeli kirjad korrutakse 2 tabeli kirjaga 
select * from laps, loom
where loom.lapsID = laps.lapsID;

select * from laps as lp, loom as l
where l.lapsID = lp.lapsID;
--õige päring 
--kitsendeme päringu 
select  lp.nimi as lapsenimi, l.nimi as loomanimi, l.kaal, lp.synnilinn
from laps as lp, loom as l
where l.lapsID = lp.lapsID;

--inner join ühendamine 
select * from laps inner join loom
on loom.lapsID=laps.lapsID

--left join - näitab kõik lapsed isegi kui puudub loom
select lp.nimi as lapsenimi, l.nimi as loomanimi, l.kaal as kaal
from laps as lp left join loom as l
on l.lapsID=lp.lapsID;
--pilt konspektis

--right join - näitab kõik lapsed isegi kui puudub loom
select lp.nimi as lapsenimi, l.nimi as loomanimi 
from laps as lp right join loom as l
on l.lapsID=lp.lapsID;

--cross join - korrutatud tabelid 
select lp.nimi as lapsenimi, l.nimi as loomanimi
from laps as lp cross join loom as l;

create table varjupaik(
varjupaikID int not null primary key identity(1,1),
koht varchar(35) not null,
firma varchar(35));
drop table varjupaik

alter table loom add varjupaikID int;
alter table loom add constraint fk_varjupaik
foreign key(varjupaikID) references varjupaik(varjupaikID);

insert into varjupaik(koht, firma)
values ('Tallinn', 'PaikMTÜ'),
('Tallinn','LoomaAed Varjupaik');
select * from varjupaik;
update loom set varjupaikID = 1;
select * from loom;

select lp.nimi as lapsenimi, l.nimi as loomanimi, v.koht
from laps as lp, loom as l, varjupaik as v
where l.lapsID= lp.lapsID and l.varjupaikID =v.varjupaikID;

--sama inner joiniga 
select lp.nimi as lapsenimi, l.nimi as loomanimi, v.koht
from (laps as lp inner join loom as l
on l.lapsID=lp.lapsID) inner join varjupaik as v
on l.varjupaikID=v.varjupaikID; 
