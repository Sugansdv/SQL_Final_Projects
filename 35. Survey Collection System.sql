CREATE DATABASE survey_collection_system;
USE survey_collection_system;

CREATE TABLE surveys (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT NOT NULL,
    question_text TEXT NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES surveys(id) ON DELETE CASCADE
);

CREATE TABLE responses (
    user_id INT NOT NULL,
    question_id INT NOT NULL,
    answer_text VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id, question_id),
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

INSERT INTO surveys (title) VALUES
('Customer Satisfaction Survey'),
('Product Feedback Survey');

INSERT INTO questions (survey_id, question_text) VALUES
(1, 'How satisfied are you with our service?'),
(1, 'Would you recommend us to others?'),
(2, 'How would you rate the product quality?');

INSERT INTO responses (user_id, question_id, answer_text) VALUES
(1, 1, 'Very Satisfied'),
(1, 2, 'Yes'),
(2, 1, 'Satisfied'),
(2, 2, 'No'),
(3, 1, 'Very Satisfied'),
(3, 2, 'Yes'),
(4, 3, 'Excellent'),
(5, 3, 'Good');

-- COUNT and GROUP BY 
-- Count responses per answer option for a given question
SELECT 
    q.question_text,
    r.answer_text,
    COUNT(*) AS total_responses
FROM responses r
JOIN questions q ON r.question_id = q.id
WHERE q.id = 1
GROUP BY r.answer_text, q.question_text;

-- Survey-wide response summary
SELECT 
    s.title AS survey_title,
    q.question_text,
    r.answer_text,
    COUNT(*) AS total_responses
FROM surveys s
JOIN questions q ON s.id = q.survey_id
JOIN responses r ON q.id = r.question_id
GROUP BY s.title, q.question_text, r.answer_text
ORDER BY s.title, q.question_text;

-- Pivot-style summaries 
SELECT 
    q.question_text,
    SUM(CASE WHEN r.answer_text = 'Yes' THEN 1 ELSE 0 END) AS yes_count,
    SUM(CASE WHEN r.answer_text = 'No' THEN 1 ELSE 0 END) AS no_count
FROM questions q
JOIN responses r ON q.id = r.question_id
WHERE q.id = 2
GROUP BY q.question_text;
