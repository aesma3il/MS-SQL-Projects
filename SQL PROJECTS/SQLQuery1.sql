-----------------------------start categories-----------------------------------------------
create table productdb.dbo.categories(
id_cat int identity(1,1) not null primary key,
description varchar(25)
);
--insert into categories values(1,'diary');
--insert into categories values(2,'food items');
--insert into categories values(3,'diary');

--select * from categories
--order by description;

--delete from categories 
--where id_cat=1;

--update categories
--set id_cat=30
--where id_cat=2;
----------------------------end categories------------------------------------------------

------------------------------------products--------------------------------------------------
create table productdb.dbo.products(
id_product varchar(30) not null primary key ,
label_product varchar(30),
qte_in_stock int,
price varchar(50),
image_product image,
id_cat int,

constraint fk_idcategory foreign key(id_cat)
references productdb.dbo.categories (id_cat)
 on delete cascade 
on update cascade
);

insert into products values('1','milk',20,2423,null,1);
insert into products values('2','apple',200,2600,null,1);
insert into products values('3','banana',30,120,null,1);
insert into products values('4','fish',70,1900,null,1);


select * from products 
where label_product like '%a%';

select * from products 
where label_product like 'a%';

select * from products 
where label_product like '%a';

select * from products 
where price between 100 and 10000;
--------------------------------end product------------------------------------------------------
create table productdb.dbo.customers(
id_customer int identity(1,1) not null primary key,
first_name varchar(25),
last_name varchar(25),
tel varchar(15),
email varchar(25),
image_customer nvarchar(max)
);

select * from customers
where first_name in('abdullah abdo','atef mohammed');

----------------------------------------------------------------------------
create table productdb.dbo.orders(
id_order int identity(1,1) not null primary key,
date_order datetime,
customer_id int,

constraint FK_customer foreign key(customer_id)
references productdb.dbo.customers(id_customer) 
on delete cascade 
on update cascade

);

select orders.id_order,orders.date_order
from orders
inner join customers on orders.customer_id=customers.id_customer;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
create table productdb.dbo.order_details(
id_product varchar(30),
id_order int,
qte int,
constraint FK_order_details foreign key(id_product) references productdb.dbo.products(id_product) 
on delete cascade 
on update cascade,

constraint FK_order_detail foreign key(id_order) references productdb.dbo.orders(id_order) 
on delete cascade 
on update cascade
);

----------------------------------------------------------------------------

