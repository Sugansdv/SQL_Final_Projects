CREATE DATABASE recruitment_db;
USE recruitment_db;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    company VARCHAR(100)
);

CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE applications (
    job_id INT,
    candidate_id INT,
    status ENUM('Applied', 'Interview', 'Hired', 'Rejected'),
    applied_at DATE,
    PRIMARY KEY (job_id, candidate_id),
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

INSERT INTO jobs (title, company) VALUES
('Software Engineer', 'TechCorp'),
('Data Analyst', 'DataWorks');

INSERT INTO candidates (name) VALUES
('Dharun'),
('Vishwa'),
('Sugan');

INSERT INTO applications (job_id, candidate_id, status, applied_at) VALUES
(1, 1, 'Applied', '2025-08-01'),
(1, 2, 'Interview', '2025-08-02'),
(2, 3, 'Hired', '2025-08-03');

-- Filter candidates by status 
SELECT c.name, j.title, a.status
FROM applications a
JOIN candidates c ON a.candidate_id = c.id
JOIN jobs j ON a.job_id = j.id
WHERE a.status = 'Interview';

-- Job-wise applicant count 
SELECT j.title, COUNT(a.candidate_id) AS applicant_count
FROM jobs j
LEFT JOIN applications a ON j.id = a.job_id
GROUP BY j.title;
