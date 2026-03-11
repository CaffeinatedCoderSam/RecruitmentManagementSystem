
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