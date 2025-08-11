CREATE DATABASE online_forum_system;
USE online_forum_system;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE threads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    thread_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    parent_post_id INT DEFAULT NULL,
    posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (thread_id) REFERENCES threads(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_post_id) REFERENCES posts(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO threads (title, user_id) VALUES
('Welcome to the Forum', 1),
('Favorite Programming Languages', 2);

INSERT INTO posts (thread_id, user_id, content, parent_post_id) VALUES
(1, 1, 'Hello everyone! Welcome to our new forum.', NULL),   
(1, 2, 'Thanks, Alice! Happy to be here.', 1),          
(1, 3, 'Hello all! Excited to join.', 1),                 
(2, 2, 'I love Python and JavaScript.', NULL),       
(2, 3, 'Python is great for data science.', 4),      
(2, 1, 'I prefer C++ for performance.', 4);     

-- Self joins for reply chains 
SELECT
    p.id AS post_id,
    p.content AS post_content,
    u1.name AS post_author,
    p.posted_at AS post_date,
    r.id AS reply_id,
    r.content AS reply_content,
    u2.name AS reply_author,
    r.posted_at AS reply_date
FROM posts p
JOIN users u1 ON p.user_id = u1.id
LEFT JOIN posts r ON r.parent_post_id = p.id
LEFT JOIN users u2 ON r.user_id = u2.id
WHERE p.thread_id = 1
ORDER BY p.posted_at, r.posted_at;

-- Thread view aggregation
SELECT
    t.id AS thread_id,
    t.title,
    u.name AS thread_creator,
    COUNT(p.id) AS total_posts
FROM threads t
JOIN users u ON t.user_id = u.id
LEFT JOIN posts p ON p.thread_id = t.id
GROUP BY t.id, t.title, u.name
ORDER BY total_posts DESC;


