CREATE DATABASE it_support_ticket_system;
USE it_support_ticket_system;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category VARCHAR(50) NOT NULL, -- e.g., Hardware, Software, Network
    issue TEXT NOT NULL,
    status ENUM('open', 'in_progress', 'resolved', 'closed') DEFAULT 'open',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at DATETIME DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE support_staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE assignments (
    ticket_id INT NOT NULL PRIMARY KEY,
    staff_id INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES support_staff(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun'),
('Vishwa');

INSERT INTO support_staff (name) VALUES
('Devika'),
('Santoz');

INSERT INTO tickets (user_id, category, issue, status, created_at, resolved_at) VALUES
(1, 'Hardware', 'Laptop not turning on', 'resolved', '2025-08-05 09:00:00', '2025-08-05 11:00:00'),
(2, 'Software', 'Unable to install app', 'resolved', '2025-08-06 10:15:00', '2025-08-06 13:00:00'),
(3, 'Network', 'WiFi not connecting', 'open', '2025-08-07 14:00:00', NULL);

INSERT INTO assignments (ticket_id, staff_id) VALUES
(1, 1),
(2, 2),
(3, 1);

-- Average resolution time 
SELECT 
    AVG(TIMESTAMPDIFF(MINUTE, created_at, resolved_at)) AS avg_resolution_minutes
FROM tickets
WHERE status = 'resolved';

-- Ticket volume by category 
SELECT 
    category,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;


