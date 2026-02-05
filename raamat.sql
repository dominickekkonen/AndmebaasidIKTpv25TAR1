create database raamatKekkonen
use raamatKekkonen;
-- tabeli zanr loomine
create table zanr(
zanrID int primary key identity(1,1),
zanrNimetus varchar(50) not null,
kirjeldus text);
select * from zanr;
--table täitlemine
insert into zanr(zanrNimetus,kirjeldus)
values('teadus','see on teaduslik zanr');
--tabel Autor
create table autor(
autorID int primary key identity(1,1),
eesnimi varchar(50) not null,
perenimi varchar(50) not null,
synniaasta int check(synniaasta>1900),
elukoht varchar(30)
);
select * from autor;
--tabeli täitlemine
insert into autor(eesnimi, perenimi, synniaasta)
values('Viktor','Torn',1969);
--tabeli uuendamine
update autor set elukoht='Tallinn';
--kustutamine tabelist
delete from autor where autorID=1;
--tabel Raamat
create table raamat(
raamatID int primary key identity(1,1),
raamatNimetus varchar(100) unique,
lk int,
autorID int,
foreign key(autorID) references autor(autorID),
zanrID int,
foreign key(zanrID) references zanr(zanrID)
);
--drop table raamat
drop table raamat
select * from autor;
select * from zanr;
select * from raamat;
insert into raamat (raamatNimetus, lk, autorID, zanrID)
values('Andrei ja tema sõbrad', 110, 3, 3)
--tabeli trykikoda loomine
create table trykikoda(
trykikodaID int primary key identity(1,1),
trykikodaNimetus varchar(100) unique,
aadress text
);
select * from trykikoda
--tabeli trykitudRaamat loomine
create table trykitudRaamat(
trRaamatID int primary key identity(1,1),
trykikodaID int,
foreign key(trykikodaID) references trykikoda(trykikodaID),
raamatID int,
foreign key(raamatID) references raamat(raamatID),
kogus int,
);
select * from trykitudRaamat
--tabeli täitlemine
insert into trykikoda (trykikodaNimetus, aadress)
values('Printify','Mustamae tee 58')
insert into trykitudRaamat (trykikodaID, raamatID, kogus)
values(1, 2, 5)
