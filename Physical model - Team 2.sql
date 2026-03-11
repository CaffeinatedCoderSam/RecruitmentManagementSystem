
CREATE TABLE Person (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    date_of_birth DATE NOT NULL
        CHECK (EXTRACT(YEAR FROM date_of_birth) > 1900 AND EXTRACT(YEAR FROM date_of_birth) <= EXTRACT(YEAR FROM CURRENT_DATE) + 1)
);

CREATE TABLE Applicant (
    applicant_id SERIAL PRIMARY KEY,
    resume TEXT NOT NULL CHECK (resume LIKE 'https://docs.google.com/document/d/%'),
    person_id INTEGER NOT NULL,
    CONSTRAINT fk_person_applicant
        FOREIGN KEY (person_id)
        REFERENCES Person(person_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Notebook (
    notebook_id SERIAL PRIMARY KEY,
    brand VARCHAR(45) NOT NULL CHECK (brand IN ('Dell', 'Lenovo', 'Asus')),
    model VARCHAR(100) NOT NULL,
    serial_number INTEGER NOT NULL
);

CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    mobile_phone BIGINT NOT NULL CHECK (mobile_phone >= 10000000000 AND mobile_phone <= 99999999999),
    id_card BIGINT NOT NULL CHECK (id_card >= 1000000000 AND id_card <= 9999999999),
    role VARCHAR(100) NOT NULL,
    notebook_id INTEGER,
    person_id INTEGER NOT NULL,
    CONSTRAINT fk_notebook_staff
        FOREIGN KEY (notebook_id)
        REFERENCES Notebook(notebook_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_person_staff
        FOREIGN KEY (person_id)
        REFERENCES Person(person_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Application (
    application_id SERIAL PRIMARY KEY,
    accepted BOOLEAN NOT NULL,
    position VARCHAR(100) NOT NULL,
    applicant_id INTEGER NOT NULL,
    CONSTRAINT fk_applicant_application
        FOREIGN KEY (applicant_id)
        REFERENCES Applicant(applicant_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Appointment (
    appointment_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    applicant_id INTEGER NULL,
    application_id INTEGER NOT NULL,
    CONSTRAINT fk_applicant_appointment
        FOREIGN KEY (applicant_id)
        REFERENCES Applicant(applicant_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_application_appointment
        FOREIGN KEY (application_id)
        REFERENCES Application(application_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE StaffAppointments (
    staffAppointment_id SERIAL PRIMARY KEY,
    staff_id INTEGER NULL,
    appointment_id INTEGER NULL,
    CONSTRAINT fk_staff_staffappointment
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_staffappointment
        FOREIGN KEY (appointment_id)
        REFERENCES Appointment(appointment_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Contract (
    contract_id SERIAL PRIMARY KEY,
    salary INTEGER NOT NULL,
    contract_number INTEGER NOT NULL,
    role VARCHAR(100) NOT NULL,
    applicant_id INTEGER NOT NULL,
    CONSTRAINT fk_applicant_contract
        FOREIGN KEY (applicant_id)
        REFERENCES Applicant(applicant_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Feedback (
    feedback_id SERIAL PRIMARY KEY,
    score SMALLINT NOT NULL CHECK (score BETWEEN 1 AND 10), -- Changed TINYINT to SMALLINT
    comments TEXT,
    applicant_id INTEGER NULL,
    staff_id INTEGER NULL,
    appointment_id INTEGER NULL,
    contract_id INTEGER,
    CONSTRAINT fk_applicant_feedback
        FOREIGN KEY (applicant_id)
        REFERENCES Applicant(applicant_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_staff_feedback
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_feedback
        FOREIGN KEY (appointment_id)
        REFERENCES Appointment(appointment_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_contract_feedback
        FOREIGN KEY (contract_id)
        REFERENCES Contract(contract_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


drop table Feedback;
drop table StaffAppointments;
drop table Appointment;
drop table Contract;
drop table Application;
drop table Staff;
drop table Notebook;
drop table Applicant;
drop table Person;


INSERT INTO Person (first_name, last_name, date_of_birth)
VALUES
    ('Alice', 'Johnson', '1990-05-14'),
    ('Bob', 'Smith', '1985-11-22'),
    ('Charlie', 'Brown', '2000-08-19');


insert into Applicant (resume, person_id)
		values 
        ('https://docs.google.com/document/d/1BZy5ornDMmxMnmBqLsWECRUZow8F1TWBSPN9aDKBF2k/edit?tab=t.0#heading=h.ymi089liagec',1);
        
insert into Applicant (resume, person_id)
		values ('https://docs.google.com/document/d/16XzAOz26SzmEaKhjBouaFUlWHKA6rK4wTp5qMUUip7M/edit?tab=t.0#heading=h.x8fm1uorkbaw',2);

insert into Applicant (resume, person_id)
		values ('https://docs.google.com/document/d/1LWGOxGumy-YO1y6H4Y3eCTgV7jInDPDcd0Ztk8nhxuY/edit?tab=t.0#heading=h.x8fm1uorkbaw',3);


INSERT INTO Notebook (brand, model, serial_number)
VALUES
    ('Dell', 'XPS 13', 123456),
    ('Lenovo', 'ThinkPad T14', 234567),
    ('Asus', 'ZenBook 14', 345678);


INSERT INTO Staff (mobile_phone, id_card, role, notebook_id, person_id)
VALUES
    (12345678901, 1234567890, 'Manager', 1, 1),
    (22345678901, 2234567890, 'Engineer', 2, 2),
    (32345678901, 3234567890, 'Technician', 3, 3);

INSERT INTO Application (accepted, position, applicant_id)
VALUES
    (TRUE, 'Software Developer', 1),
    (FALSE, 'Data Analyst', 2),
    (TRUE, 'System Administrator', 3);

INSERT INTO Appointment (date, applicant_id, application_id)
VALUES
    ('2024-12-01', 1, 1),
    ('2024-12-03', 3, 3);

INSERT INTO Contract (salary, contract_number, role, applicant_id)
VALUES
    (80000, 101, 'Software Developer', 1),
    (70000, 103, 'System Administrator', 3);

INSERT INTO Feedback (score, comments, applicant_id, staff_id, appointment_id, contract_id)
VALUES
    (9, 'Excellent performance', 1, 1, 1, 1),
    (8, 'Met expectations', 3, 3, 3, 3);

SELECT App.application_id, P.first_name, P.last_name, 
App.position, App.accepted
FROM Application App
JOIN Applicant A ON App.applicant_id = A.applicant_id
JOIN Person P ON A.person_id = P.person_id;

SELECT 
    A.appointment_id, 
    A.date, 
    P.first_name, 
    P.last_name, 
    App.position
FROM 
    Appointment A
JOIN 
    Application App ON A.application_id = App.application_id
JOIN 
    Applicant Appl ON App.applicant_id = Appl.applicant_id
JOIN 
    Person P ON Appl.person_id = P.person_id;

SELECT C.contract_id, C.contract_number, 
C.salary, C.role, P.first_name, P.last_name
FROM Contract C
JOIN Applicant A ON C.applicant_id = A.applicant_id
JOIN Person P ON A.person_id = P.person_id;