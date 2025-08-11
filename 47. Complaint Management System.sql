CREATE DATABASE complaint_management;

USE complaint_management;

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    department_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE responses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT NOT NULL,
    responder_id INT NOT NULL,
    message TEXT NOT NULL,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id)
);

INSERT INTO departments (name) VALUES
('Water Supply'),
('Electricity'),
('Sanitation');

INSERT INTO complaints (title, department_id, status) VALUES
('Water leakage in street', 1, 'Open'),
('Frequent power cuts', 2, 'In Progress'),
('Garbage not collected', 3, 'Resolved'),
('Low water pressure', 1, 'Resolved');

INSERT INTO responses (complaint_id, responder_id, message) VALUES
(1, 101, 'Inspection scheduled for tomorrow.'),
(2, 102, 'Technicians sent to investigate.'),
(3, 103, 'Clean-up completed.'),
(4, 101, 'Issue resolved after pipeline maintenance.');

-- Status summary 
SELECT complaints.status,
       COUNT(complaints.id) AS total_complaints
FROM complaints
GROUP BY complaints.status
ORDER BY total_complaints DESC;

-- Department workload
SELECT departments.name AS department_name,
       COUNT(complaints.id) AS open_complaints
FROM departments
LEFT JOIN complaints 
       ON departments.id = complaints.department_id
       AND complaints.status = 'Open'
GROUP BY departments.name
ORDER BY open_complaints DESC;
