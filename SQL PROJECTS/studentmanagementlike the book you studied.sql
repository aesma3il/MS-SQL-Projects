create table classroom
(
building varchar (15),
room_number varchar (7),
capacity numeric (4,0),
primary key (building, room_number));


create table department
(dept_name varchar (20),
building varchar (15),
budget numeric (12,2) check (budget > 0),
primary key (dept_name));

create table course
(course_id varchar (7),
title varchar (50),
dept_name varchar (20),
credits numeric (2,0) check (credits > 0),
primary key (course_id),
foreign key (dept_name) references department
on delete set null);

create table instructor
(ID varchar (5),
instructor_name varchar (20) not null,
dept_name varchar (20),
salary numeric (8,2) check (salary > 29000),
primary key (ID),
foreign key (dept_name) references department
on delete set null);


create table section
(course_id varchar (8),
sec_id varchar (8),
semester varchar (6) check (semester in
('Fall', 'Winter', 'Spring', 'Summer')),
section_year numeric (4,0) check (section_year > 1701 and section_year < 2100),
building varchar (15),
room_number varchar (7),
time_slot_id varchar (4),
primary key (course_id, sec_id, semester, section_year),
foreign key (course_id) references course
on delete cascade,
foreign key (building, room_number) references classroom
on delete set null);


create table teaches
(ID varchar (5),
course_id varchar (8),
sec_id varchar (8),
semester varchar (6),
teaches_year numeric (4,0),
primary key (ID, course_id, sec_id, semester, teaches_year),
foreign key (course_id, sec_id, semester, teaches_year) references section
on delete cascade,
foreign key (ID) references instructor(ID)
on delete cascade);


create table student
(ID varchar (5),
student_name varchar (20) not null,
dept_name varchar (20),
tot_cred numeric (3,0) check (tot_cred >= 0),
primary key (ID),
foreign key (dept_name) references department
on delete set null);


create table takes
(ID varchar (5),
course_id varchar (8),
sec_id varchar (8),
semester varchar (6),
takes_year numeric (4,0),
grade varchar (2),
primary key (ID, course_id, sec_id, semester, takes_year),
foreign key (course_id, sec_id, semester, takes_year) references section
on delete cascade,
foreign key (ID) references student
on delete cascade);


create table advisor
(s_ID varchar (5),
i_ID varchar (5),
primary key (s_ID),
foreign key (i_ID) references instructor(ID)
on delete set null,
foreign key (s_ID) references student(ID)
on delete cascade);



create table prereq
(course_id varchar(8),
prereq_id varchar(8),
primary key (course_id, prereq_id),
foreign key (course_id) references course
on delete cascade,
foreign key (prereq_id) references course);


create table timeslot
(time_slot_id varchar (4),
t_day varchar (1) check (t_day in ('M', 'T', 'W', 'R', 'F', 'S', 'U')),
start_time time,
end_time time,
primary key (time_slot_id, t_day, start_time));


--additional tables

-- Enrollment table
CREATE TABLE enrollment (
    student_id varchar(5) REFERENCES student(ID),
    course_id varchar(8) REFERENCES course(course_id),
    section_id varchar(8) REFERENCES section(sec_id),
    semester varchar(6),
    enrollment_year numeric(4,0),
    PRIMARY KEY (student_id, course_id, section_id, semester, enrollment_year)
);

-- Assignment table
CREATE TABLE assignment (
    section_id varchar(8) REFERENCES section(sec_id),
    assignment_id int IDENTITY(1,1) PRIMARY KEY,
    title varchar(50),
    as_description varchar(255)
);

-- Submission table
CREATE TABLE submission (
    student_id varchar(5) REFERENCES student(ID),
    assignment_id int REFERENCES assignment(assignment_id),
    submission_date datetime,
    sub_status varchar(20),
    PRIMARY KEY (student_id, assignment_id)
);

-- Grade table
CREATE TABLE grade (
    student_id varchar(5) REFERENCES student(ID),
    section_id varchar(8) REFERENCES section(sec_id),
    assignment_id int REFERENCES assignment(assignment_id),
    grade decimal(3,2),
    feedback varchar(255),
    PRIMARY KEY (student_id, section_id, assignment_id)
);

-- Resource table
CREATE TABLE resource (
    section_id varchar(8) REFERENCES section(sec_id),
    resource_id int IDENTITY(1,1) PRIMARY KEY,
    title varchar(50),
    res_description varchar(255),
    res_url varchar(255)
);

-- Discussion table
CREATE TABLE discussion (
    section_id varchar(8) REFERENCES section(sec_id),
    discussion_id int IDENTITY(1,1) PRIMARY KEY,
    title varchar(50),
    dis_description varchar(255),
    dis_start_date datetime
);

-- Message table
CREATE TABLE message (
    message_id int IDENTITY(1,1) PRIMARY KEY,
    sender_id varchar(5) REFERENCES student(ID),
    recipient_id varchar(5) REFERENCES instructor(ID),
    mes_subject varchar(255),
    body varchar(max),
    mes_timestamp datetime
);
