CREATE DATABASE freelance_project_management;
USE freelance_project_management;

CREATE TABLE freelancers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    skill VARCHAR(100) NOT NULL
);

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE proposals (
    freelancer_id INT NOT NULL,
    project_id INT NOT NULL,
    bid_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    PRIMARY KEY (freelancer_id, project_id),
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

INSERT INTO freelancers (name, skill) VALUES
('Alice', 'Web Development'),
('Bob', 'Graphic Design'),
('Charlie', 'Data Analysis');

INSERT INTO projects (client_name, title) VALUES
('Client A', 'E-commerce Website'),
('Client B', 'Logo Design'),
('Client C', 'Sales Data Dashboard');

INSERT INTO proposals (freelancer_id, project_id, bid_amount, status) VALUES
(1, 1, 1500.00, 'pending'),
(1, 3, 1000.00, 'accepted'),
(2, 2, 500.00, 'accepted'),
(3, 3, 1200.00, 'rejected');

-- Bids and accepted proposals 
SELECT 
    f.name AS freelancer_name,
    p.title AS project_title,
    pr.bid_amount,
    pr.status
FROM proposals pr
JOIN freelancers f ON pr.freelancer_id = f.id
JOIN projects p ON pr.project_id = p.id;

-- Find accepted proposals
SELECT 
    f.name AS freelancer_name,
    p.title AS project_title,
    pr.bid_amount
FROM proposals pr
JOIN freelancers f ON pr.freelancer_id = f.id
JOIN projects p ON pr.project_id = p.id
WHERE pr.status = 'accepted';

-- Count projects per freelancer 
SELECT 
    f.name AS freelancer_name,
    COUNT(*) AS total_accepted_projects
FROM proposals pr
JOIN freelancers f ON pr.freelancer_id = f.id
WHERE pr.status = 'accepted'
GROUP BY f.id, f.name;

