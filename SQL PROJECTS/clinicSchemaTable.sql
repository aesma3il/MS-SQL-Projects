--CREATE DATABASE db_clinic
use db_clinic
CREATE TABLE tbl_person (
	person_id INT IDENTITY(1,1) PRIMARY KEY,
	first_name NVARCHAR(50) NOT NULL,
	last_name NVARCHAR(50) NULL,
	date_of_birth DATE NOT NULL,
	gender NVARCHAR(1) NOT NULL,
	phone_number NVARCHAR(50) NULL,
	email  NVARCHAR(100),
	person_address  NVARCHAR(100) NOT NULL
);

CREATE TABLE tbl_patient(
	patient_id INT IDENTITY(1,1) PRIMARY KEY,
	person_id INT NOT NULL,
	CONSTRAINT fk_patient_person FOREIGN KEY(person_id) REFERENCES tbl_person(person_id) 
	
);

CREATE TABLE tbl_doctor(
	doctor_id INT IDENTITY(1,1) PRIMARY KEY,
	person_id INT NOT NULL,
	specialist NVARCHAR(100) NOT NULL,
	CONSTRAINT fk_doctor_person FOREIGN KEY(person_id) REFERENCES tbl_person(person_id)
	
	
);

CREATE TABLE tbl_payment(
	payment_id INT IDENTITY(1,1) PRIMARY KEY,
	payment_date DATE,
	payment_method NVARCHAR(100),
	amount_paid  DECIMAL,
	other_note NVARCHAR(200)
);

CREATE TABLE tbl_medical_record(
	medical_record_id INT IDENTITY(1,1) PRIMARY KEY,
	visit_description  NVARCHAR(200),
	diagnosis NVARCHAR(200),
	other_note NVARCHAR(200)
);

CREATE TABLE tbl_appointment(
	appointment_id INT IDENTITY(1,1) PRIMARY KEY,
	patient_id INT NOT NULL,
	doctor_id INT NOT NULL,
	appointment_date_time DATETIME ,
	appointment_status NVARCHAR(100),
	medical_record_id INT NOT NULL,
	payment_id INT NOT NULL,
	CONSTRAINT fk_appointment_patient FOREIGN KEY(patient_id) REFERENCES tbl_patient(patient_id)
	,
	CONSTRAINT fk_appointmendt_doctor FOREIGN KEY(doctor_id) REFERENCES tbl_patient(patient_id)
	,
	CONSTRAINT fk_appointment_medical_record FOREIGN KEY(medical_record_id) REFERENCES tbl_medical_record(medical_record_id)
	,
	CONSTRAINT fk_appointment_payment FOREIGN KEY(payment_id) REFERENCES tbl_payment(payment_id)
	

);


CREATE TABLE tbl_prescription(
	prescription_id INT IDENTITY(1,1) PRIMARY KEY,
	medical_record_id INT NOT NULL,
	medication_name NVARCHAR(100),
	dosage NVARCHAR(50),
	frequentcy NVARCHAR(50),
	date_start DATE,
	date_end DATE,
	special_instructions NVARCHAR(200),
	CONSTRAINT fk_prescription_medical_record FOREIGN KEY(medical_record_id) REFERENCES tbl_medical_record(medical_record_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);