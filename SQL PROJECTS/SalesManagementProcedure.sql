


create proc sp_AddCity
@CityName varchar(50)
as
insert into Tbl_City(CityName) Values (@CityName)

create proc sp_UpdateCity
@Code int, @CityName varchar(50)
as
update Tbl_City
set CityName = @CityName
where Code = @Code


create proc sp_DeleteCity
@Code int
AS
Delete from Tbl_City
where Code = @Code


create proc sp_ViewCity
as
select * from Tbl_City


