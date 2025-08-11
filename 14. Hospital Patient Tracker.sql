CREATE DATABASE hospital_db;
USE hospital_db;

CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE visits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    visit_time DATETIME,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    UNIQUE (doctor_id, visit_time)
);

INSERT INTO patients (name, dob) VALUES
('John Doe', '1990-05-12'),
('Jane Smith', '1985-09-20'),
('Michael Johnson', '2000-01-15');

INSERT INTO doctors (name, specialization) VALUES
('Dr. A Kumar', 'Cardiology'),
('Dr. Priya Singh', 'Dermatology');

INSERT INTO visits (patient_id, doctor_id, visit_time) VALUES
(1, 1, '2025-08-09 10:00:00'),
(2, 1, '2025-08-09 11:00:00'),
(3, 2, '2025-08-10 09:30:00');

-- Query patients by doctor/date 
SELECT p.name AS patient_name, d.name AS doctor_name, v.visit_time
FROM visits v
JOIN patients p ON v.patient_id = p.id
JOIN doctors d ON v.doctor_id = d.id
WHERE v.doctor_id = 1;

-- Constraints on overlapping visits 
SELECT p.name AS patient_name, d.name AS doctor_name, v.visit_time
FROM visits v
JOIN patients p ON v.patient_id = p.id
JOIN doctors d ON v.doctor_id = d.id
WHERE DATE(v.visit_time) = '2025-08-09';
