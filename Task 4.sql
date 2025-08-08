USE mis602_ass2;
# seen all the tables content 
SELECT * FROM patient LIMIT 10;
SELECT * FROM doctor LIMIT 10;
SELECT * FROM appointment LIMIT 10;
SELECT * FROM medication LIMIT 10;
SELECT * FROM prescription LIMIT 10;
SELECT * FROM speciality LIMIT 10;
show tables;
# counted no of male patients
select count(gender) as male from patient where gender ='male';
#counted total no.of patients
select count(patient_id) as count from patient;
# counted female patients
select count(gender) as female from patient where gender ='female';
# doctor and there speciality
select d.name,s.name from doctor d join speciality s on d.speciality_id=s.speciality_id;
#viewed which patient consults which doctor
SELECT 
    p.name AS patient_name,
    d.name AS doctor_name,
    a.appointment_date
FROM appointment a
JOIN patient p 
    ON a.patient_id = p.patient_id
JOIN doctor d 
    ON a.doctor_id = d.doctor_id
ORDER BY patient_name;
#viewed patient medication
SELECT 
    p.name AS patient_name,
    m.name AS medication_name,
    pr.prescription_id,
    a.appointment_date
FROM prescription pr
JOIN appointment a 
    ON pr.appointment_id = a.appointment_id
JOIN patient p 
    ON a.patient_id = p.patient_id
JOIN medication m 
    ON pr.medication_id = m.medication_id
ORDER BY patient_name, a.appointment_date;
# viewed doctor who specialize in cadiology
select name,doctor_id from doctor where speciality_id=1;
#viewed patients who consult cadiology doctors
SELECT 
    p.name AS patient_name,
    d.name AS doctor_name,
    s.name AS speciality_name
FROM appointment a
JOIN patient p 
    ON a.patient_id = p.patient_id
JOIN doctor d 
    ON a.doctor_id = d.doctor_id
JOIN speciality s 
    ON d.speciality_id = s.speciality_id
WHERE s.name = 'Neurology';
# count of patient for each speciality
SELECT 
    s.name AS speciality_name,
    COUNT(DISTINCT a.patient_id) AS patient_count
FROM appointment a
JOIN doctor d ON a.doctor_id = d.doctor_id
JOIN speciality s ON d.speciality_id = s.speciality_id
GROUP BY s.name
ORDER BY patient_count DESC;
#patient count per speciality
SELECT 
    m.name AS medication_name,
    COUNT(*) AS times_prescribed
FROM prescription pr
JOIN medication m ON pr.medication_id = m.medication_id
GROUP BY m.name
ORDER BY times_prescribed DESC;
select state_code,count(state_code) from patient group by state_code;
select status,count(status) from appointment group by status;
# patients with same medication
SELECT 
    m.name AS medication_name,
    GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS patients
FROM prescription pr
JOIN appointment a ON pr.appointment_id = a.appointment_id
JOIN patient p ON a.patient_id = p.patient_id
JOIN medication m ON pr.medication_id = m.medication_id
GROUP BY m.name;
# patients who have more than 1 appointment
SELECT name
FROM patient
WHERE patient_id IN (
    SELECT patient_id
    FROM appointment
    GROUP BY patient_id
    HAVING COUNT(*) > 1
);
#doctor who prescribed a specific medicine
SELECT name
FROM doctor
WHERE doctor_id IN (
    SELECT doctor_id
    FROM appointment
    WHERE appointment_id IN (
        SELECT appointment_id
        FROM prescription
        WHERE medication_id = (
            SELECT medication_id
            FROM medication
            WHERE name = 'Losartan'
        )
    )
);
#patients who are prescribed a specific medicine
SELECT name
FROM patient
WHERE patient_id IN (
    SELECT patient_id
    FROM appointment
    WHERE appointment_id IN (
        SELECT appointment_id
        FROM prescription
        WHERE medication_id = (
            SELECT medication_id
            FROM medication
            WHERE name = 'aspirin'
        )
    )
);
# categorised patients
select name ,case
when dob between '1950-01-01' and'1999-12-31' then 'old'
when dob between'2000-01-01' and '2005-12-31' then'adult'
end as patient_category
from patient;
# categorised patients on there visits
SELECT 
    p.name,
    COUNT(a.appointment_id) AS total_visits,
    CASE 
        WHEN COUNT(a.appointment_id) > 3 THEN 'Frequent Visitor'
        ELSE 'Occasional Visitor'
    END AS visit_type
FROM patient p
JOIN appointment a ON p.patient_id = a.patient_id
GROUP BY p.name;
# view for patient doctor appointment
CREATE VIEW patient_doctor_view AS
SELECT 
    p.name AS patient_name,
    d.name AS doctor_name,
    a.appointment_date
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN doctor d ON a.doctor_id = d.doctor_id;

SELECT * FROM patient_doctor_view WHERE doctor_name = 'Dr. John Doe';
# patient medication report
CREATE VIEW patient_medication_view AS
SELECT 
    p.name AS patient_name,
    m.name AS medication_name,
    pr.prescription_id,
    a.appointment_date
FROM prescription pr
JOIN appointment a ON pr.appointment_id = a.appointment_id
JOIN patient p ON a.patient_id = p.patient_id
JOIN medication m ON pr.medication_id = m.medication_id;

SELECT * FROM patient_medication_view WHERE patient_name = 'Jane Doe';
#indexes for frequently used
CREATE INDEX idx_patient_name ON patient(name);
CREATE INDEX idx_appointment_date ON appointment(appointment_date);
CREATE INDEX idx_doctor_name ON doctor(name);
SHOW INDEXES FROM doctor;

