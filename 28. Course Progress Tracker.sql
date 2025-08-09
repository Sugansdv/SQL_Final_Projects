CREATE DATABASE course_progress_db;
USE course_progress_db;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE lessons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    title VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE progress (
    student_id INT,
    lesson_id INT,
    completed_at DATE,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (lesson_id) REFERENCES lessons(id)
);

INSERT INTO courses (name) VALUES
('Math 101'),
('History Basics');

INSERT INTO lessons (course_id, title) VALUES
(1, 'Algebra Basics'),
(1, 'Geometry Intro'),
(1, 'Fractions'),
(2, 'Ancient Civilizations'),
(2, 'Medieval Times');

INSERT INTO progress (student_id, lesson_id, completed_at) VALUES
(1, 1, '2025-08-01'),
(1, 2, '2025-08-02'),
(2, 4, '2025-08-03');

-- Completion % calculation 
-- JOINs and GROUP BY 
SELECT p.student_id, c.name AS course_name,
       CONCAT(ROUND(COUNT(DISTINCT p.lesson_id) / COUNT(DISTINCT l.id) * 100, 1), '%') AS completion_percentage
FROM courses c
JOIN lessons l ON c.id = l.course_id
LEFT JOIN progress p ON l.id = p.lesson_id
GROUP BY p.student_id, c.id;
