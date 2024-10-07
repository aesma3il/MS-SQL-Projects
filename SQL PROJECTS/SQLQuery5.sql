create table Tbl_Quantity(
ID int primary key identity(1,1),
StoreID int,
ProductID int,
Quantity int,
 foreign key(StoreID) references Tbl_Store(ID),
 foreign key(ProductID) references Tbl_Product(ID)
);