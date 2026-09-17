CREATE TABLE klient (
  klientID int identity(1, 1),
  klientNimi varchar(30)not null,
  PRIMARY KEY (klientID)
);
CREATE TABLE aadress (
  aadressID int identity(1, 1),
  aadress varchar(30),
  klientID int,
  PRIMARY KEY (aadressID),
  FOREIGN KEY (klientID)
      REFERENCES klient(klientID)
);
CREATE TABLE pakkija (
  pakkijaID int identity(1, 1),
  pakkijaNimi varchar,
  pakkijaPerenimi varchar,
  PRIMARY KEY (pakkijaID)
);

CREATE TABLE kehtivus (
  kehtivID int identity(1, 1),
  kehtivusaeg int,
  PRIMARY KEY (kehtivID)
);

CREATE TABLE kommityyp (
  kommityypID int identity(1, 1),
  kommityyp varchar,
  PRIMARY KEY (kommityypID)
);

CREATE TABLE komm (
  kommID int identity(1, 1),
  kommNimetus varchar,
  kommityypID int,
  hind int,
  kehtivID int,
  PRIMARY KEY (kommID),
  FOREIGN KEY (kommityypID)
      REFERENCES kommityyp(kommityypID),
  FOREIGN KEY (kehtivID)
      REFERENCES kehtivus(kehtivID)
);

CREATE TABLE tellimused (
  tellimusID int identity(1, 1),
  aadressID int,
  tellimuseKuupäev date,
  kommID int,
  kogus int,
  pakkijaID int,
  PRIMARY KEY (tellimusID),
  FOREIGN KEY (aadressID)
      REFERENCES aadress(aadressID),
  FOREIGN KEY (kommID)
      REFERENCES komm(kommID),
  FOREIGN KEY (pakkijaID)
      REFERENCES pakkija(pakkijaID)
);
insert into klient(klientID,klientNimi)
values(1,'Rimi');
insert into klient(klientID,klientNimi)
values(2,'Maxima');
insert into klient(klientID,klientNimi)
values(3,'Selver');
insert into klient(klientID,klientNimi)
values(4,'Prisma');

select * from klient

insert into aadress(aadressID,aadress)
values(1,'Mustakivi 1');
insert into aadress(aadressID,aadress)
values(2,'Kivimurru 32
');
insert into aadress(aadressID,aadress)
values(3,'Toome 3');
insert into aadress(aadressID,aadress)
values(4,'Prisli 45');
insert into aadress(aadressID,aadress)
values(5,'Mustakivi 5');
insert into aadress(aadressID,aadress)
values(6,'Mustakivi 16');

select * from aadress

insert into kommityyp(kommityypID,kommityyp)
values(1,'Sokolaad');
insert into kommityyp(kommityypID,kommityyp)
values(1,'karamell');
