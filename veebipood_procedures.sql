create database veebipoodKekkonen2
use veebipoodKekkonen2;
--tabeli loomnie
delete categories
create table categories(
categoryID int primary key identity (1,1),
categoryName varchar(25) unique);
update categories set categoryName = 'riided'
where categoryID = 2;
create table brands(
brandID int primary key identity (1,1),
brand_name varchar(25) unique);
--procedure mis lisab insert andmeid tabelisse
drop procedure lisaBrand;
create procedure lisaBrand
@brand_nimi varchar (30)
as
begin
insert into brands (brand_name) values (@brand_nimi);
select * from brands;
end;
--procedure kutse
exec lisaBrand 'Audi';
--procedure mis kutsutab delete tabelist id järgi
create procedure kutsutaBrand
@id int
as
begin
select * from brands;
delete from brands where brandID = @id;
select * from brands;
end;
--kutse
exec kutsutaBrand 1;
exec kutsutaBrand @id=1;
--procedure mis otsib brandinimed 1 tähte järgi
create procedure otsing1tahte
@taht char (1)
as
begin
select * from brands where brand_name like @taht+'%';
end;
--kutse 
exec otsing1tahte 'A';
--procedure mis uuendab update brandinimi id järgi
create procedure uuendaBrand
@id int,
@uus_brandNimi varchar(30)
as
begin
select * from brands;
update brands set brand_name=@uus_brandNimi
where brandID=@id;
select * from brands;
end;
--kutse
exec uuendaBrand 1, 'uusApollo';
