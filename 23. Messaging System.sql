CREATE DATABASE messaging_db;
USE messaging_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE conversations (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT,
    sender_id INT,
    message_text TEXT,
    sent_at DATETIME,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    FOREIGN KEY (sender_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO conversations VALUES
(1),
(2);

INSERT INTO messages (conversation_id, sender_id, message_text, sent_at) VALUES
(1, 1, 'Hey Bob!', '2025-08-09 10:00:00'),
(1, 2, 'Hi Alice!', '2025-08-09 10:01:00'),
(2, 3, 'Hello world!', '2025-08-09 10:05:00');

-- Recent message retrieval 
SELECT m.conversation_id, m.message_text, m.sent_at, u.name AS sender
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.sent_at = (
    SELECT MAX(sent_at)
    FROM messages
    WHERE conversation_id = m.conversation_id
);

-- Threading messages by conversation
SELECT m.sent_at, u.name AS sender, m.message_text
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.conversation_id = 1
ORDER BY m.sent_at;
