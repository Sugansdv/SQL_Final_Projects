CREATE DATABASE restaurant_reservation;

USE restaurant_reservation;

CREATE TABLE tables (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_number INT NOT NULL UNIQUE,
    capacity INT NOT NULL
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE reservations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    table_id INT NOT NULL,
    date DATE NOT NULL,
    time_slot VARCHAR(20) NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (table_id) REFERENCES tables(id)
);

INSERT INTO tables (table_number, capacity) VALUES
(1, 2),
(2, 4),
(3, 4),
(4, 6);

INSERT INTO guests (name) VALUES
('Dharun'),
('Sugan'),
('Santoz'),
('Vishwa');

INSERT INTO reservations (guest_id, table_id, date, time_slot) VALUES
(1, 1, '2025-08-11', '18:00-19:00'),
(2, 2, '2025-08-11', '18:00-19:00'),
(3, 1, '2025-08-11', '19:00-20:00'),
(4, 3, '2025-08-12', '20:00-21:00');

-- Overlap detection 
SELECT r1.id AS reservation1_id, r2.id AS reservation2_id, 
       t.table_number, r1.date, r1.time_slot
FROM reservations r1
JOIN reservations r2 
     ON r1.table_id = r2.table_id 
     AND r1.id < r2.id
     AND r1.date = r2.date
     AND r1.time_slot = r2.time_slot
JOIN tables t ON r1.table_id = t.id;

-- Daily summary 
SELECT reservations.date, 
       COUNT(reservations.id) AS total_reservations
FROM reservations
GROUP BY reservations.date
ORDER BY reservations.date;

