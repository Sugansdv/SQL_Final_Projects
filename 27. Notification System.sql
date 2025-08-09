CREATE DATABASE notification_db;
USE notification_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message VARCHAR(255),
    status ENUM('Unread', 'Read') DEFAULT 'Unread',
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun');

INSERT INTO notifications (user_id, message, status, created_at) VALUES
(1, 'Welcome to the app!', 'Unread', '2025-08-01 10:00:00'),
(1, 'Your profile is 80% complete.', 'Read', '2025-08-02 09:15:00'),
(2, 'New message received.', 'Unread', '2025-08-03 14:30:00');

-- Unread count 
SELECT u.name, COUNT(n.id) AS unread_count
FROM users u
LEFT JOIN notifications n ON u.id = n.user_id AND n.status = 'Unread'
GROUP BY u.name;
--  Mark-as-read logic
UPDATE notifications
SET status = 'Read'
WHERE user_id = 1 AND status = 'Unread';
