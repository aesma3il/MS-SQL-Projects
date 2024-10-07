
--create table tb_city(
--ID int primary key identity(1000,5),
--cName varchar(50)
--);

create table tb_location(
ID int primary key identity(1,1) ,
city_id int,
constraint fk_city foreign key(city_id) references tb_city(ID)
);

create table insurance(
ID int primary key identity(2000,23),
insName varchar(30),
insDescription varchar(200)
);


create table customer(
cus_id int,
cust_name varchar(50),
birth_date date,
driving_license_no varchar(255),
primary key(cus_id)
);


create table category(
cat_id int primary key identity(2000,30),
cat_name varchar(50)
);

create table car(
car_id int,
category_id int,
brand varchar(50),
car_model varchar(255),
production_year int,
mileage int,
color varchar(255),

constraint fk_category foreign key(category_id) references category(cat_id)

);

alter table car
add car_id int primary key;

create table rental(
id int primary key identity(4500,4),
customer_id int,
car_id int ,
pick_up_location_id int,
drop_off_location_id int,
startt_date date,
end_date date,
remarks text,
constraint  fk_pick foreign key(pick_up_location_id) references tb_location(id),
constraint  fk_customer foreign key(customer_id) references customer(cus_id),
constraint  fk_carrs_id foreign key(car_id) references car(car_id),
constraint  fk_rental foreign key(drop_off_location_id) references tb_location(id)

);



create table rental_insurance(
rental_id int ,
insurance_id int , 
constraint  fk_rentfdal foreign key(rental_id) references rental(id),
constraint  fk_insurance foreign key(rental_id) references customer(cus_id),
primary key(rental_id, insurance_id)
);

create table reservation(
id int primary key identity(400,3),
pick_up_location_id int,
drop_off_location_id int,
category_id int,
customer_id int,
constraint  fk_pick_up_loca foreign key(pick_up_location_id) references tb_location(id),
constraint  fk_customer_reservation foreign key(customer_id) references customer(cus_id),
constraint  fk_dropoff foreign key(drop_off_location_id) references tb_location(id),
constraint  fk_category_id foreign key(category_id) references category (cat_id)
);




create table equipment_category(
cat_id int primary key identity(1,1),
cat_name varchar(255) not null
);

create table equipement(
eq_id int primary key identity(20,2),
eq_name varchar(255),
eq_categoryID int,

constraint fk_eq_category foreign key(eq_categoryID) references equipment_category(cat_id)
);


create table car_equipment(
id int primary key identity(2,2),
equipment_id int,
car_id int,
star_date date,
end_date date,
constraint  fk_equipfdment_id foreign key(equipment_id) references equipement(eq_id),
constraint  fk_car_idd foreign key(car_id) references car (car_id)
);


create table reservation_equipment(
reservation_id int not null,
equipment_category_id int not null,

constraint  fk_reservation_id foreign key(reservation_id) references reservation(id),
constraint  fk_eq_cateogry foreign key(equipment_category_id) references equipment_category (cat_id),
primary key(reservation_id , equipment_category_id)
);