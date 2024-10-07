--CREATE PROCEDURE sp_AddBook
--    @BookID VARCHAR(50),
--    @Title VARCHAR(50),
--    @AuthorID INT,
--    @Lang VARCHAR(30),
--	@CategoryId INT,
--	@Description varchar(50)
--AS
--BEGIN
--    INSERT INTO tb_book(BookTitle, Author, Lang, CategoryID, BookDescription)
--    VALUES  (@Title, @AuthorID, @AuthorID, @Lang, @CategoryId, @Description)
--END



--CREATE PROCEDURE SP_ADDCATEGORY
--	@CNAME VARCHAR(30)
--	AS
--	BEGIN
--	INSERT INTO tb_category (CategoryName) VALUES(@CNAME)
--	END

CREATE PROC SPAUTHOR
@FirstName varchar(15),
@LastName varchar(15)
AS 

