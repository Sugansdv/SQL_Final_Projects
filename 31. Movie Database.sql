CREATE DATABASE movie_database;
USE movie_database;

CREATE TABLE genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year YEAR NOT NULL,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE SET NULL
);

CREATE TABLE ratings (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    score DECIMAL(2,1) NOT NULL CHECK (score BETWEEN 0 AND 10),
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

INSERT INTO genres (name) VALUES
('Action'),
('Comedy'),
('Drama');

INSERT INTO movies (title, release_year, genre_id) VALUES
('Fast & Furious', 2020, 1),
('The Hangover', 2009, 2),
('The Shawshank Redemption', 1994, 3);

INSERT INTO ratings (user_id, movie_id, score) VALUES
(1, 1, 7.5),
(2, 1, 8.0),
(1, 2, 6.0),
(3, 3, 9.5),
(2, 3, 9.0);

-- AVG rating per movie 
SELECT 
    m.title,
    AVG(r.score) AS avg_rating,
    COUNT(r.user_id) AS rating_count
FROM movies m
LEFT JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title
ORDER BY avg_rating DESC;

-- JOINs across genre and ratings 
SELECT 
    m.title,
    g.name AS genre,
    m.release_year,
    AVG(r.score) AS avg_rating
FROM movies m
LEFT JOIN genres g ON m.genre_id = g.id
LEFT JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title, g.name, m.release_year
ORDER BY avg_rating DESC;

