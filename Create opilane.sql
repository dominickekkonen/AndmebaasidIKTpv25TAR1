create database kekkonenSQL;
use kekkonenSQL;

-- tabeli loomine 
create table opliane(
opilaneID int primary key identity(1,1),
eesnimi varchar(25),
perekonnanimi varchar(30) Not null,
synniaeg date, 
aadress text,
kas_opib bit);
select * from opliane;
