CREATE TABLE TBLUSER(
ID INT PRIMARY KEY IDENTITY(1,1),
USERNAME VARCHAR(MAX) NOT NULL,
PASS VARCHAR(MAX) NOT NULL
);

INSERT INTO TBLUSER (USERNAME, PASS)
VALUES
    ('user1', 'pass1'),
    ('user2', 'pass2'),
    ('user3', 'pass3'),
    ('user4', 'pass4'),
    ('user5', 'pass5'),
    ('user6', 'pass6'),
    ('user7', 'pass7'),
    ('user8', 'pass8'),
    ('user9', 'pass9'),
    ('user10', 'pass10');