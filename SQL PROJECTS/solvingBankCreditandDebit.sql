CREATE TABLE Customer(
CustomerID INT primary key identity(1,1) ,
FirstName varchar(50) not null,
LastName varchar(50) not null

);

create table AccountType(
AccountTypeID INT primary key identity(1,1),
AccountTypeNumber VARCHAR(20)
);
alter table AccountType
 add AccountTypeName varchar(50) not null

insert into customer(FirstName, LastName) values('Abdullah','Abdo'),('Ghadeer','Mohammed'),('Mohammed','Ameen');


insert into AccountType(AccountTypeName) values( 'Saving'),( 'Checking');


CREATE TABLE Account(
AccountID INT primary key identity(1,1),
AccountTypeID int ,
CustomerID INT,
AccountNumber varchar(50) not null,
AccountName varchar(100) not null,
Balance decimal(10,2) ,

constraint fk_AccountTypeID foreign key (AccountTypeID) references AccountType(AccountTypeID),
constraint fk_customeridID foreign key (CustomerID) references Customer(CustomerID)

);

insert into Account(AccountTypeID, CustomerID,AccountName, AccountNumber) values(2,2,'Ghadeer',002);

select * from Account


alter table Account 
drop column Accoun




create table Transactions(
TransactionID  int primary key identity(1,1),
AccountID int not null,
TransactionType  varchar(8) not null,
Amount decimal(10,2) not null,
Narrative varchar(100) not null,
ValueDate date default getdate(),

constraint fk_accountID_Account foreign key(AccountID) references Account(AccountID)

);


insert into Transactions(AccountID, TransactionType, Amount, Narrative)
values(1,'Credit', 290.11, 'received for service from Ghadeer'),(2,'Debit', 120.11, 'payment for  abdullah abdo mohammed');


select A.AccountID, a.AccountName, Sum(case when t.TransactionType ='Credit' then -t.Amount else t.Amount end) as Balance
From Account A
left join Transactions t on a.AccountID = t.AccountID 
group by A.AccountID, A.AccountName


select * from Transactions







declare @AccountID int = 1;

select t.TransactionID, t.Amount, t.TransactionType, t.TransactionType, t.ValueDate,t.Narrative, a.AccountName, 
Sum(case when t.TransactionType ='Debit' then t.Amount else -t.Amount end) over (partition by  A.AccountID order by t.ValueDate, t.TransactionID)as Balance
From Transactions t
join Account  A on t.AccountID = A.AccountID
where t.AccountID = @AccountID
order by t.ValueDate, t.TransactionID


