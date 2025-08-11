CREATE DATABASE fitness_tracker;
USE fitness_tracker;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE workouts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE workout_logs (
    user_id INT NOT NULL,
    workout_id INT NOT NULL,
    duration INT NOT NULL, 
    log_date DATE NOT NULL,
    PRIMARY KEY (user_id, workout_id, log_date),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Sugan'),
('Vishwa');

INSERT INTO workouts (name, type) VALUES
('Running', 'Cardio'),
('Push-Ups', 'Strength'),
('Yoga', 'Flexibility');

INSERT INTO workout_logs (user_id, workout_id, duration, log_date) VALUES
(1, 1, 30, '2025-08-05'),
(1, 2, 15, '2025-08-06'),
(1, 3, 40, '2025-08-08'),
(2, 1, 20, '2025-08-05'),
(2, 2, 25, '2025-08-07');

-- Weekly summary per user 
-- JOINs for workout type 
-- Weekly summary per user
SELECT 
    u.name AS user_name,
    YEARWEEK(wl.log_date, 1) AS week_number,
    SUM(wl.duration) AS total_minutes
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
GROUP BY u.id, YEARWEEK(wl.log_date, 1)
ORDER BY week_number, user_name;

-- JOIN to get workout type per log
SELECT 
    u.name AS user_name,
    w.name AS workout_name,
    w.type AS workout_type,
    wl.duration,
    wl.log_date
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
JOIN workouts w ON wl.workout_id = w.id
ORDER BY wl.log_date DESC;

-- Total minutes by workout type per user
SELECT 
    u.name AS user_name,
    w.type AS workout_type,
    SUM(wl.duration) AS total_minutes
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
JOIN workouts w ON wl.workout_id = w.id
GROUP BY u.id, w.type;


