CREATE DATABASE course_enrollment_db;

USE course_enrollment_db;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    instructor VARCHAR(100) NOT NULL
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Many-to-many relationships
CREATE TABLE enrollments (
    course_id INT,
    student_id INT,
    enroll_date DATE,
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO courses (title, instructor) VALUES
('Database Systems', 'Dr. A. Devika'),
('Web Development', 'Ms. Vishali'),
('Data Science Basics', 'Mr. Vishwa');

INSERT INTO students (name, email) VALUES
('Dharun', 'dharun@gmail.com'),
('Manoj', 'manoj@gmail.com'),
('Santoz', 'santoz@gmail.com'),
('Sugan', 'sugan@gmail.com');

INSERT INTO enrollments (course_id, student_id, enroll_date) VALUES
(1, 1, '2025-08-01'),
(1, 2, '2025-08-02'),
(2, 2, '2025-08-03'),
(2, 3, '2025-08-04'),
(3, 1, '2025-08-05'),
(3, 4, '2025-08-06');

-- Queries for students per course 
SELECT 
    c.title AS course_title,
    s.name AS student_name,
    s.email
FROM courses c
JOIN enrollments e ON c.id = e.course_id
JOIN students s ON e.student_id = s.id
ORDER BY c.title, s.name;

-- Count enrolled students
SELECT 
    c.title AS course_title,
    COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
ORDER BY total_students DESC;