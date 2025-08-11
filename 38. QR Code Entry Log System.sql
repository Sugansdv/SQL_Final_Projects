CREATE DATABASE qr_code_entry_log;
USE qr_code_entry_log;

CREATE TABLE locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE entry_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    location_id INT NOT NULL,
    entry_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE
);

INSERT INTO locations (name) VALUES
('Main Gate'),
('Conference Hall'),
('Gym');

INSERT INTO users (name) VALUES
('Dharun'),
('Sugan'),
('Vishwa');

INSERT INTO entry_logs (user_id, location_id, entry_time) VALUES
(1, 1, '2025-08-09 08:15:00'),
(2, 2, '2025-08-09 09:05:00'),
(1, 3, '2025-08-09 10:20:00'),
(3, 1, '2025-08-09 11:10:00'),
(2, 3, '2025-08-08 17:00:00');

-- Count entries per location 
SELECT 
    l.name AS location_name,
    COUNT(e.id) AS total_entries
FROM entry_logs e
JOIN locations l ON e.location_id = l.id
GROUP BY l.id, l.name
ORDER BY total_entries DESC;

-- Filter by date
SELECT 
    u.name AS user_name,
    l.name AS location_name,
    e.entry_time
FROM entry_logs e
JOIN users u ON e.user_id = u.id
JOIN locations l ON e.location_id = l.id
WHERE DATE(e.entry_time) = '2025-08-09'
ORDER BY e.entry_time;

-- Filter by time 
SELECT 
    u.name AS user_name,
    l.name AS location_name,
    e.entry_time
FROM entry_logs e
JOIN users u ON e.user_id = u.id
JOIN locations l ON e.location_id = l.id
WHERE TIME(e.entry_time) BETWEEN '08:00:00' AND '12:00:00'
ORDER BY e.entry_time;

