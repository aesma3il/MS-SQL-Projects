create table classroom
(building varchar (15),
room number varchar (7),
capacity numeric (4,0),
primary key (building, room number));


create table department
(deptname varchar (20),
building varchar (15),
budget numeric (12,2) check (budget > 0),
primary key (dept name));


create table course
(course id varchar (7),
title varchar (50),
dept name varchar (20),
credits numeric (2,0) check (credits > 0),
primary key (course id),
foreign key (dept name) references department
on delete set null);


create table instructor
(ID varchar (5),
name varchar (20) not null,
dept name varchar (20),
salary numeric (8,2) check (salary > 29000),
primary key (ID),
foreign key (dept name) references department
on delete set null);


create table section
(course id varchar (8),
sec id varchar (8),
semester varchar (6) check (semester in
(’Fall’, ’Winter’, ’Spring’, ’Summer’)),
year numeric (4,0) check (year > 1701 and year < 2100),
building varchar (15),
room number varchar (7),
time slot id varchar (4),
primary key (course id, sec id, semester, year),
foreign key (course id) references course
on delete cascade,
foreign key (building, room number) references classroom
on delete set null);




create table teaches
(ID varchar (5),
course id varchar (8),
sec id varchar (8),
semester varchar (6),
year numeric (4,0),
primary key (ID, course id, sec id, semester, year),
foreign key (course id, sec id, semester, year) references section
on delete cascade,
foreign key (ID) references instructor
on delete cascade);



create table student
(ID varchar (5),
name varchar (20) not null,
dept name varchar (20),
tot cred numeric (3,0) check (tot cred >= 0),
primary key (ID),
foreign key (dept name) references department
on delete set null);



create table takes
(ID varchar (5),
course id varchar (8),
sec id varchar (8),
semester varchar (6),
year numeric (4,0),
grade varchar (2),
primary key (ID, course id, sec id, semester, year),
foreign key (course id, sec id, semester, year) references section
on delete cascade,
foreign key (ID) references student
on delete cascade);


create table advisor
(s ID varchar (5),
i ID varchar (5),
primary key (s ID),
foreign key (i ID) references instructor (ID)
on delete set null,
foreign key (s ID) references student (ID)
on delete cascade);


create table prereq
(course id varchar(8),
prereq id varchar(8),
primary key (course id, prereq id),
foreign key (course id) references course
on delete cascade,
foreign key (prereq id) references course);


create table timeslot
(time slot id varchar (4),
day varchar (1) check (day in (’M’, ’T’, ’W’, ’R’, ’F’, ’S’, ’U’)),
start time time,
end time time,
primary key (time slot id, day, start time));



create table timeslot
(time slot id varchar (4),
day varchar (1),
start hr numeric (2) check (start hr >= 0 and end hr < 24),
start_min numeric (2) check (start min >= 0 and start_min < 60),
end hr numeric (2) check (end hr >= 0 and end hr < 24),
end min numeric (2) check (end min >= 0 and end min < 60),
primary key (time slot id, day, start hr, start min));