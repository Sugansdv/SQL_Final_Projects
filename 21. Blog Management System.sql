CREATE DATABASE blog_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(200),
    content TEXT,
    published_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    comment_text TEXT,
    commented_at DATETIME,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO posts (user_id, title, content, published_date) VALUES
(1, 'First Blog Post', 'Content of the first post.', '2025-08-01'),
(2, 'Travel Tips', 'Some travel tips here.', '2025-08-05');

INSERT INTO comments (post_id, user_id, comment_text, commented_at) VALUES
(1, 2, 'Great post!', '2025-08-02 10:00:00'),
(1, 3, 'Thanks for sharing.', '2025-08-03 12:00:00'),
(2, 1, 'Nice tips!', '2025-08-06 09:30:00');

-- Joins for comments with posts 
SELECT p.title, u.name AS commenter, c.comment_text, c.commented_at
FROM comments c
JOIN posts p ON c.post_id = p.id
JOIN users u ON c.user_id = u.id
ORDER BY c.commented_at;

-- Filter posts by user
SELECT p.title, p.published_date
FROM posts p
JOIN users u ON p.user_id = u.id
WHERE u.name = 'Alice';

-- Filter posts by date 
SELECT title, published_date
FROM posts
WHERE published_date > '2025-08-02';
