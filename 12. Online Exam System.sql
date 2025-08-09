CREATE DATABASE online_exam_db;
USE online_exam_db;

CREATE TABLE exams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    date DATE
);

CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT,
    text VARCHAR(200),
    correct_option CHAR(1),
    FOREIGN KEY (exam_id) REFERENCES exams(id)
);

CREATE TABLE student_answers (
    student_id INT,
    question_id INT,
    selected_option CHAR(1),
    PRIMARY KEY (student_id, question_id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO exams (course_id, date) VALUES
(101, '2025-08-10'),
(102, '2025-08-11');

INSERT INTO questions (exam_id, text, correct_option) VALUES
(1, 'What is SQL?', 'B'),
(1, 'Which keyword filters records?', 'A'),
(2, 'HTML is used for?', 'C');

INSERT INTO student_answers (student_id, question_id, selected_option) VALUES
(1, 1, 'B'),
(1, 2, 'A'),
(1, 3, 'B'),
(2, 1, 'C'),
(2, 2, 'A'),
(2, 3, 'C');

-- Join exam with answers 
SELECT e.id AS exam_id, q.text, sa.student_id, sa.selected_option, q.correct_option
FROM exams e
JOIN questions q ON e.id = q.exam_id
JOIN student_answers sa ON q.id = sa.question_id;

-- Calculate scores with correct answers 
SELECT sa.student_id, q.exam_id,
       SUM(sa.selected_option = q.correct_option) AS correct_answers,
       COUNT(*) AS total_questions
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
GROUP BY sa.student_id, q.exam_id;
