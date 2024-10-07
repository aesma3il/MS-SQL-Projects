--create database ChatApp;

CREATE TABLE TBL_USER(
	UserID int,
	FirstName Varchar(20) not null,
	LastName Varchar(20),
	Gender varchar(10) not null,
	DateOfBirth DateTime,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	Email varchar(50) not null,
	Pass varchar(30) not null
);


CREATE TABLE friend_requests (
    id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accepted_at TIMESTAMP NULL
);


CREATE TABLE friends (
    id INT PRIMARY KEY,
    user1_id INT,--must be unique
    user2_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE messages (
    id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
	Header Varchar(50),
    Body TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);