CREATE TABLE Students (
  id INT NOT NULL IDENTITY(1,1),
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  s_address TEXT NOT NULL,
  date_of_birth DATE NOT NULL,
  gender varchar(10) NOT NULL,
  department_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (department_id) REFERENCES Departments(id)
);

CREATE TABLE Courses (
  id INT NOT NULL IDENTITY(1,1),
  cname VARCHAR(100) NOT NULL,
  cdescription TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Departments (
  id INT NOT NULL IDENTITY(1,1),
  dname VARCHAR(100) NOT NULL,
  ddescription TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Enrollments (
  id INT NOT NULL IDENTITY(1,1),
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  enrollment_date DATE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (student_id) REFERENCES Students(id),
  FOREIGN KEY (course_id) REFERENCES Courses(id)
);
