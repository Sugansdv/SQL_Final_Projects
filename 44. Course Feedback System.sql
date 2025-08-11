CREATE DATABASE course_feedback;

USE course_feedback;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comments TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO courses (title) VALUES
('Python for Beginners'),
('Advanced SQL Queries'),
('Web Development with React'),
('Data Science Fundamentals');

INSERT INTO feedback (course_id, user_id, rating, comments) VALUES
(1, 101, 4.5, 'Great course, easy to follow!'),
(1, 102, 4.0, 'Helpful content but could use more examples.'),
(2, 103, 5.0, 'Excellent explanations and exercises.'),
(3, 104, 3.5, 'Good but pacing was too fast.'),
(4, 105, 4.8, 'Very informative and well-structured.');

-- Sentiment tracking 
SELECT feedback.id,
       courses.title,
       feedback.user_id,
       feedback.rating,
       feedback.comments,
       CASE 
           WHEN feedback.rating >= 4 THEN 'Positive'
           ELSE 'Negative'
       END AS sentiment
FROM feedback
JOIN courses 
     ON feedback.course_id = courses.id;

-- AVG rating per course 
SELECT courses.id,
       courses.title,
       ROUND(AVG(feedback.rating), 2) AS avg_rating
FROM courses
JOIN feedback 
     ON courses.id = feedback.course_id
GROUP BY courses.id, courses.title
ORDER BY avg_rating DESC;
