CREATE DATABASE attendance_db;
USE attendance_db;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE attendance (
    student_id INT,
    course_id INT,
    date DATE,
    status ENUM('Present', 'Absent'),
    PRIMARY KEY (student_id, course_id, date),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO students (name) VALUES
('Sugan'),
('Dharun'),
('Vishwa');

INSERT INTO courses (name) VALUES
('Math'),
('Science');

INSERT INTO attendance (student_id, course_id, date, status) VALUES
(1, 1, '2025-08-01', 'Present'),
(1, 1, '2025-08-02', 'Absent'),
(2, 1, '2025-08-01', 'Present'),
(3, 2, '2025-08-01', 'Absent');

-- Query 1: Attendance summary per student per course
SELECT s.name AS student, c.name AS course,
       SUM(status = 'Present') AS days_present,
       SUM(status = 'Absent') AS days_absent
FROM attendance a
JOIN students s ON a.student_id = s.id
JOIN courses c ON a.course_id = c.id
GROUP BY s.name, c.name;

-- Query 2: Students absent on a given date (example: 2025-08-01)
SELECT s.name, c.name AS course
FROM attendance a
JOIN students s ON a.student_id = s.id
JOIN courses c ON a.course_id = c.id
WHERE a.date = '2025-08-01' AND a.status = 'Absent';
