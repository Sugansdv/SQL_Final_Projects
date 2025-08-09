CREATE DATABASE health_records_db;
USE health_records_db;

CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE prescriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE medications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE prescription_details (
    prescription_id INT,
    medication_id INT,
    dosage VARCHAR(50),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
    FOREIGN KEY (medication_id) REFERENCES medications(id)
);

INSERT INTO patients (name, dob) VALUES
('John Doe', '1990-05-12'),
('Jane Smith', '1985-09-20');

INSERT INTO medications (name) VALUES
('Paracetamol'),
('Amoxicillin'),
('Ibuprofen');

INSERT INTO prescriptions (patient_id, date) VALUES
(1, '2025-08-05'),
(1, '2025-08-09'),
(2, '2025-08-09');

INSERT INTO prescription_details (prescription_id, medication_id, dosage) VALUES
(1, 1, '500mg twice a day'),
(1, 2, '250mg three times a day'),
(2, 3, '400mg once a day'),
(3, 1, '500mg twice a day');

-- Joins 
-- Filter by patient
SELECT p.name AS patient_name, pr.date, m.name AS medication, pd.dosage
FROM prescriptions pr
JOIN patients p ON pr.patient_id = p.id
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
WHERE pr.patient_id = 1;

-- Filter by date 
SELECT p.name AS patient_name, pr.date, m.name AS medication, pd.dosage
FROM prescriptions pr
JOIN patients p ON pr.patient_id = p.id
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
WHERE pr.date = '2025-08-09';
