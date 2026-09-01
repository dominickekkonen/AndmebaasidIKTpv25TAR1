create database kordamineIKT25;
use kordamineIKT25;
create table opilane(
opilaneID int primary key identity(1, 1),
nimi varchar(50),
isikukood char(11) not null,
ryhmID int);

create table ryhm(
ryhmID int primary key identity(1, 1),
ryhmNimi char(11) unique,
opilasteArv int);

--välisvõti - FK
Alter table opilane add foreign key (ryhmID) references ryhm(ryhmID);

insert into opilane(nimi,isikukood,ryhmID)
values('Eduard','123456789',1);
insert into ryhm(ryhmNimi,opilasteArv)
values('IKT1',15);

--õiguste määramine varem tehtud kasutajale 
grant select to opilaneDom;
grant insert on opilane to opilaneDom;

deny delete to opilaneDom;



