CREATE DATABASE event_management_system;

USE event_management_system;

CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    max_capacity INT NOT NULL
);

CREATE TABLE attendees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    registered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id)
);

INSERT INTO events (title, max_capacity) VALUES
('Tech Conference 2025', 3),
('Music Fest', 5),
('Startup Meetup', 2);

INSERT INTO attendees (event_id, user_id) VALUES
(1, 101),
(1, 102),
(1, 103), 
(2, 104),
(2, 105),
(3, 106);

-- Event-wise participant count 
SELECT e.title,
       COUNT(a.id) AS participant_count
FROM events e
LEFT JOIN attendees a ON e.id = a.event_id
GROUP BY e.id, e.title;

-- Capacity alerts
SELECT e.title,
       COUNT(a.id) AS current_count,
       e.max_capacity,
       CASE 
           WHEN COUNT(a.id) >= e.max_capacity THEN 'Full'
           ELSE 'Available'
       END AS status
FROM events e
LEFT JOIN attendees a ON e.id = a.event_id
GROUP BY e.id, e.title, e.max_capacity;
