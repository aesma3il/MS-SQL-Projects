create table Tbl_Users(
ID int primary key identity(1,1),
Username varchar(50) NOT NULL,
Pass varchar(50) not null,
FullName Varchar(50)

);
insert into Tbl_Users values('abdullah','abdullah','Abdullah Abdo Mohammed')