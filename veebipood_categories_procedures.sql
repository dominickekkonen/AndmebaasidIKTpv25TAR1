create database iseseisevKekkonen
use iseseisevKekkonen;
--tabeli loomnie
create table categories(
categoryID int primary key identity (1,1),
categoryName varchar(25) unique);
select * from categories
--täitlemine
insert into categories(categoryName)
values('autod')
--tabeli uuendamine
update categories set categoryName = 'riided'
where categoryID = 1;
--tabeli lisamine
create procedure lisaCat
@category_name varchar (30)
as
begin
insert into categories(categoryName) values (@category_name);
select * from categories;
end;
--kutse
exec lisaCat 'autod';
--tabeli kutsutamine
create procedure kutsutaCat
@id int
as
begin
select * from categories;
delete from categories where categoryID = @id;
select * from categories;
end;
--kutse
exec kutsutaCat 1;
--iseseisvalt: tabel Categories - loo protseduurid, millega saab lisada, uuendada, kutsutada
