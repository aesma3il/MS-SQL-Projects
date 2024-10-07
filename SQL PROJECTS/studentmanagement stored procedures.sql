




--create proc AddStudent
--@firstname varchar(50),
--@lastname varchar(50),
--@email varchar(100),
--@phonenumber int varchar(20),
--@s_address text,
--@date_of_birth date,
--@gender varchar(10),
--@departmentID int
--AS
--BEGIN
--INSERT INTO students (first_name, last_name, email, phone_number, s_address, date_of_birth, gender, department_id) values(@firstname, @lastname, @email, @phonenumber, @s_address, @birth_of_date, @gender, @departmentID );
--END;

--create proc UdateStudent
--@ID int,
--@firstname varchar(50),
--@lastname varchar(50),
--@email varchar(100),
--@phonenumber int varchar(20),
--@s_address text,
--@date_of_birth date,
--@gender varchar(10),
--@departmentID int
--AS
--BEGIN
--UPdate Students set
-- first_name =@firstname,
-- last_name =@lastname,
-- email =@email,
-- phone_number =@phonenumber,
-- s_address =@s_address,
-- date_of_birth =@birth_of_date,
-- gender = @gender,
-- department_id = @departmentID
-- where id = @ID;
--END;

--use dbstudent;

--CREATE PROC GETSTUDENT
--AS
--BEGIN
--SELECT * FROM Students
--END

--CREATE VIEW vwStudent
--AS
--EXEC GETSTUDENT;


--alter table Students
--add gpa float default 0


--create proc evaluationstudent
--as
--begin
--SELECT id,first_name, last_name,gpa,
--	CASE
--		WHEN gpa <50 THEN 'FAIL'
--		WHEN gpa >=50 and gpa <=70 THEN 'good'
--		WHEN gpa >= 80 AND gpa<90 THEN ' very GOOD'
--		WHEN gpa >= 80 AND gpa<80 THEN 'GOOD'
--		ELSE 'ACCEPTABLE'
--END AS GPAEVALUATION
--FROM Students
--end

