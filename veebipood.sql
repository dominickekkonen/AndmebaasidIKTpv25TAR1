create database veebipoodKekkonen
use veebipoodKekkonen;
--tabeli loomnie
create table categories(
categoryID int primary key identity (1,1),
categoryName varchar(25) unique);
--table täitlemine
insert into categories(categoryName)
values ('riidet');
select * from categories
--tabeli loomnie
create table brands(
brandID int primary key identity (1,1),
brandName varchar(25) unique);
--table täitlemine
insert into brands(brandName)
values('New Balance');
select * from brands
--tabeli loomine 
create table products(
productID int primary key identity (1,1),
productName varchar(50) not null,
brandID int,
categoryID int,
foreign key (categoryID) references categories(categoryID),
modelYear int,
listPrice decimal(7,2));
--tabel brands
alter table products add constraint fk_brand 
foreign key (brandID) references brands (brandID);
-- tabel stores loomine 
create table stores(
storeID int primary key identity (1,1),
store_name varchar (30),
phone int,
email text,
street text,
city text,
state_ text,
zip_code varchar (5)
);
select * from stores
-- table stores täitmine 
insert into stores (store_name, phone, email, street, city, state_, zip_code)
values ('clothes',23232424,'clothes@gmail.com','Raadiku 45','Harjumaa','12043')
--table stocks loomine 
create table stocks(
storeID int,
foreign key (storeID) references stores(storeID),
productID int,
foreign key (productID) references products (productID),
quatity int,
);
-- table customers loomine 
create table customers(
customerID int primary key identity (1,1),
first_name varchar (25),
last_name varchar (25),
phone int,
email text,
street text,
city text,
state_ text,
zip_code varchar (5),
);
select * from customers
-- tabeli täitlemine
insert into customers (first_name, last_name, phone, email, street, city, state_, zip_code)
values ('Dominic','Kekkonen',123234,'dominic.kekkonen','Pae 28','Tallinn','Harjumaa','10115')

-- table staffs loomine 
create table staffs(
staffID int primary key identity (1,1),
first_name text,
last_name text,
email text,
phone int,
active text,
storeID int,
foreign key (storeID) references stores(storeID),
managerID int,
foreign key (managerID) references staffs(staffID));
-- table staffs täitmine 
insert into staffs (first_name, last_name, email, phone, active)
values ('Dominic','Kekkonen','dominic.kekkonen',3232323,'jah')
-- tabel orders loomine
create table orders(
orderID int primary key identity (1,1),
customerID int,
foreign key (customerID) references customers(customerID),
order_status text,
order_date date,
required_date date,
shipped_date date,
storeID int,
staffID int,
);
select * from orders
-- tabel orders täitmine
insert into orders(order_status, order_date, required_date, shipped_date)
values ('shipped','2025-10-29','2026-1-28','2026-2-1')
-- tabel order items loomine 
create table order_items (
orderID int,
foreign key (orderID) references orders(orderID),
itemID int primary key identity (1,1),
productID int,
foreign key (productID) references products(productID),
quantity int,
list_price decimal (7,2),
discount int,
);
select * from order_items
-- tabeli order items täitmine
insert into order_items (productID, quantity, list_price, discount)
values (1, 3, 1, 25)
