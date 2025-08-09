CREATE DATABASE voting_db;
USE voting_db;

CREATE TABLE polls (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question VARCHAR(255)
);

CREATE TABLE options (
    id INT PRIMARY KEY AUTO_INCREMENT,
    poll_id INT,
    option_text VARCHAR(255),
    FOREIGN KEY (poll_id) REFERENCES polls(id)
);

CREATE TABLE votes (
    user_id INT,
    option_id INT,
    voted_at DATETIME,
    PRIMARY KEY (user_id, option_id), 
    FOREIGN KEY (option_id) REFERENCES options(id)
);

INSERT INTO polls (question) VALUES
('What is your favorite programming language?');

INSERT INTO options (poll_id, option_text) VALUES
(1, 'Python'),
(1, 'JavaScript'),
(1, 'Java');

INSERT INTO votes (user_id, option_id, voted_at) VALUES
(1, 1, '2025-08-09 10:00:00'),
(2, 2, '2025-08-09 10:05:00'),
(3, 1, '2025-08-09 10:10:00');

-- COUNT votes by option 
SELECT o.option_text, COUNT(v.user_id) AS vote_count
FROM options o
LEFT JOIN votes v ON o.id = v.option_id
WHERE o.poll_id = 1
GROUP BY o.option_text;

-- Prevent duplicate votes per user 
SELECT v.user_id
FROM votes v
JOIN options o ON v.option_id = o.id
WHERE o.poll_id = 1
GROUP BY v.user_id
HAVING COUNT(DISTINCT o.id) > 1;
