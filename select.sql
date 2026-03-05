create table auto (
	auto_id INT primary key,
	auto_number CHAR(6) not null,
	mark VARCHAR(50) not null,
	mudel VARCHAR(50),
	varv VARCHAR(50),
	v_aasta int
);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (1, 'UA2957', 'Oldsmobile', 'Bravada', 'Red', 2001);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (2, 'WN2925', 'Dodge', 'Ram Van 3500', 'Maroon', 1997);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (3, 'BA9357', 'Lexus', 'LS', 'Aquamarine', 2004);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (4, 'LA9613', 'Mercedes-Benz', 'R-Class', 'Purple', 2006);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (5, 'LH2341', 'BMW', '5 Series', 'Goldenrod', 1999);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (6, 'KL9925', 'Ford', 'Thunderbird', 'Violet', 1985);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (7, 'TG8972', 'Lotus', 'Esprit', 'Violet', 1992);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (8, 'SA5364', 'Ford', 'E-Series', 'Orange', 2004);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (9, 'AF7015', 'Maybach', '57', 'Violet', 2007);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (10, 'AV3279', 'Volkswagen', 'Corrado', 'Pink', 1993);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (11, 'AA7154', 'Mazda', 'Mazda3', 'Khaki', 2005);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (12, 'ET6876', 'Ford', 'Escape', 'Green', 2013);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (13, 'AZ2233', 'Ford', 'Ranger', 'Green', 1985);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (14, 'KE9571', 'Chevrolet', 'Astro', 'Orange', 2005);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (15, 'AI7280', 'Ford', 'Ranger', 'Indigo', 1997);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (16, 'AV9376', 'GMC', 'Yukon', 'Purple', 1992);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (17, 'KE1190', 'Dodge', 'Ram 1500 Club', 'Goldenrod', 1996);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (18, 'AI1800', 'Mitsubishi', 'Pajero', 'Fuscia', 1990);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (19, 'AV1794', 'Ford', 'F250', 'Green', 1984);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (20, 'AC9727', 'GMC', 'Sonoma', 'Maroon', 1996);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (21, 'SQ4857', 'Lamborghini', 'Murciélago', 'Puce', 2010);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (22, 'NH9722', 'GMC', 'Yukon', 'Orange', 2002);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (23, 'SQ6860', 'Mercedes-Benz', 'E-Class', 'Crimson', 2002);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (24, 'AM6125', 'Studebaker', 'Avanti', 'Pink', 1964);
insert into auto (auto_id, auto_number, mark, mudel, varv, v_aasta) values (25, 'BA1907', 'Mazda', 'MPV', 'Red', 1998);
select * from auto;
--andmete sorteerimine
--kasvavas jarjekorras
select * from auto 
order by v_aasta;
--kahanevas jarjekorras
select * from auto
order by v_aasta desc;
--kuvab ainult kaks veergu
select mark, mudel from auto
--kordavate vaartuste valistamine distinct
select distinct mark from auto;
--võrdlemine
--1. suurem kui >, väiksem kui <, võrdub =
--leia kõik autod, kus on v_aasta 2000 peale
select mark, mudel, v_aasta 
from auto
where v_aasta>=2000;
--leia kõik autod mis on v_aasta vahemikus 2000-2005
select mark, mudel, v_aasta 
from auto
where v_aasta between 2000 and 2005;
--2. võrdlemine tekst või sümbooliga 
select mark, mudel, v_aasta 
from auto 
where mark like 'Ford';
--IN lause kuvab vastavus loetelus
select mark, mudel, v_aasta 
from auto 
where mark in ('Ford', 'BMW', 'Jeep');
--vastavus mustrile
--algab M tähega
select mark, mudel, v_aasta 
from auto 
where mark like 'M%';
--lõpeb d tähega
select mark, mudel, v_aasta 
from auto 
where mark like '%d';
--sisaldab d tähega
select mark, mudel, v_aasta 
from auto 
where mark like '%d%';
--kuvada esimest 5 mudeli
select top 5 mudel, varv 
from auto
where varv like 'red'
order by varv;
--agregaat funktsioonid: SUM, MIN, MAX, AVG, COUNT
select count(*)as autodeArv from auto;
select max(v_aasta) as suuremAasta from auto;
--keerulisem variant
select mark, AVG(v_aasta) as keskmineAasta 
from auto
group by mark;
