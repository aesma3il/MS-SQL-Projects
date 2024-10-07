create table Tbl_Question(
QuestionID int primary key identity(1,1),
Question varchar(100) not null,
Answer varchar(50) not null
);



create table Tbl_Options(
OptionID int primary key identity(1,1),
QuestionID int ,
OptionText varchar(50),
foreign key(QuestionID) references Tbl_Question(QuestionID)
);




--INSERTING SAMPLE DATA
--INSERT INTO Tbl_Question(Question, Answer) 
--VALUES('who is your father','Abdo');

--DECLARE @Qid INT;
--SET @Qid = SCOPE_IDENTITY();

--INSERT INTO Tbl_Options(QuestionID,OptionText)
--VALUES(@QID,'Abdo'),
--		(@QID,'ali'),
--		(@QID,'Mohammed'),
--		(@QID,'saif');


--INSERT INTO Tbl_Question (Question, Answer)
--VALUES
--    ('What is the capital of France?', 'Paris'),
--    ('What is the largest planet in our solar system?', 'Jupiter'),
--    ('What is the smallest country in the world?', 'Vatican City');


---- Insert data into Tbl_Options
---- For QuestionID 1
--INSERT INTO Tbl_Options (QuestionID, OptionText)
--VALUES
--    (2, 'London'),
--    (2, 'Paris'),
--    (2, 'Madrid'),
--    (2, 'Rome');

---- For QuestionID 2
--INSERT INTO Tbl_Options (QuestionID, OptionText)
--VALUES
--    (3, 'Mars'),
--    (3, 'Jupiter'),
--    (3, 'Saturn'),
--    (3, 'Neptune');

---- For QuestionID 3
--INSERT INTO Tbl_Options (QuestionID, OptionText)
--VALUES
--    (4, 'Monaco'),
--    (4, 'Vatican City'),
--    (4, 'San Marino'),
--    (4, 'Liechtenstein');




--QUERIES

	--GET A QUESTION WITH ITS OPTONS
--SELECT q.Question, o.OptionText
--FROM Tbl_Question q
--JOIN Tbl_Options o ON q.QuestionID = o.QuestionID
--WHERE q.QuestionID = 1;

--GET ALL QUESTIONS
--SELECT * FROM Tbl_Question
		
		

--ANSWERING OPERATION
--BEGIN TRANSACTION;

--declare @id int =1;

--declare @Result varchar(50);

--SELECT @Result = Answer
--from Tbl_Question q
--where q.QuestionID = @id;
--if @Result ='Abdo'
--BEGIN
--UPDATE Tbl_Question 
--SET isAnswer = 1
--where QuestionID = @id
--END
--ELSE
--BEGIN
--UPDATE Tbl_Question 
--SET isAnswer = 0
--where QuestionID = @id
--END

--IF @@ERROR <> 0
--BEGIN
--    -- An error occurred, so roll back the transaction
--    ROLLBACK TRANSACTION;
--END
--ELSE
--BEGIN
--    -- No errors, so commit the transaction
--    COMMIT TRANSACTION;
--END







--STORED PROCEDURES

	--GET ALL QUESTIONS
--CREATE PROC sp_GetQuestionList
--AS
--BEGIN
--	SELECT * FROM Tbl_Question
--END;


--GET ALL QUESTIONS AND ORDER THEM IN DESC
--ALTER PROC sp_GetQuestionList
--AS
--BEGIN
--	SELECT * FROM Tbl_Question
--	ORDER BY QuestionID DESC
--END;

		--DROP PROC sp_GetQuestionList
--DROP PROC sp_GetQuestionList

	--SEARCH FOR A QUESTION BY ID
--CREATE PROC sp_GetQuestionListBYID
--@ID INT
--AS
--BEGIN
--	SELECT * FROM Tbl_Question
--	WHERE QuestionID = @ID
--END;

--EXEC sp_GetQuestionList


--CREATE PROC SP_GETMAX(@MX AS REAL)
--AS
--BEGIN
--SELECT * FROM Tbl_Question AS Q
--WHERE  Q.QuestionID = @MX
--END;


--EXECUTE SP_GETMAX 2




	