CREATE DATABASE hotel_booking_db;
USE hotel_booking_db;

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    number VARCHAR(10),
    type VARCHAR(50)
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT,
    guest_id INT,
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (room_id) REFERENCES rooms(id),
    FOREIGN KEY (guest_id) REFERENCES guests(id)
);

INSERT INTO rooms (number, type) VALUES
('101', 'Single'),
('102', 'Double'),
('201', 'Suite');

INSERT INTO guests (name) VALUES
('Dharun'),
('Vishwa');

-- Sample bookings
INSERT INTO bookings (room_id, guest_id, from_date, to_date) VALUES
(1, 1, '2025-08-01', '2025-08-05'),
(2, 2, '2025-08-03', '2025-08-06');


-- Overlap logic 
-- Room availability query
-- Check room availability for a date range
SELECT r.id, r.number, r.type
FROM rooms r
WHERE r.id NOT IN (
    SELECT b.room_id
    FROM bookings b
    WHERE '2025-08-04' < b.to_date AND '2025-08-07' > b.from_date
);

-- List all current bookings with guest names
SELECT r.number AS room_number, r.type, g.name AS guest_name, b.from_date, b.to_date
FROM bookings b
JOIN rooms r ON b.room_id = r.id
JOIN guests g ON b.guest_id = g.id
ORDER BY b.from_date;
