CREATE DATABASE appointment_scheduler;
USE appointment_scheduler;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    appointment_time DATETIME NOT NULL,
    duration_minutes INT NOT NULL DEFAULT 30,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER trg_prevent_time_clash BEFORE INSERT ON appointments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM appointments
        WHERE service_id = NEW.service_id
          AND appointment_time < DATE_ADD(NEW.appointment_time, INTERVAL NEW.duration_minutes MINUTE)
          AND DATE_ADD(appointment_time, INTERVAL duration_minutes MINUTE) > NEW.appointment_time
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Appointment time clashes with existing appointment for this service.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO users (name) VALUES ('Dharun'), ('Sugan');

INSERT INTO services (name) VALUES ('Haircut'), ('Massage');

INSERT INTO appointments (user_id, service_id, appointment_time, duration_minutes) VALUES
(1, 1, '2025-08-10 10:00:00', 30),
(2, 1, '2025-08-10 10:30:00', 30),
(1, 2, '2025-08-11 14:00:00', 60);

-- Filters by date 
SELECT 
    a.id,
    u.name AS user_name,
    s.name AS service_name,
    a.appointment_time,
    a.duration_minutes
FROM appointments a
JOIN users u ON a.user_id = u.id
JOIN services s ON a.service_id = s.id
WHERE DATE(a.appointment_time) = '2025-08-10'
ORDER BY a.appointment_time;

-- Filters by service 

SELECT 
    a.id,
    u.name AS user_name,
    s.name AS service_name,
    a.appointment_time,
    a.duration_minutes
FROM appointments a
JOIN users u ON a.user_id = u.id
JOIN services s ON a.service_id = s.id
WHERE s.name = 'Haircut'
ORDER BY a.appointment_time;
