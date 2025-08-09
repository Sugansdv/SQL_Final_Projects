CREATE DATABASE donation_db;
USE donation_db;

CREATE TABLE donors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE causes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200)
);

CREATE TABLE donations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT,
    cause_id INT,
    amount DECIMAL(10,2),
    donated_at DATE,
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (cause_id) REFERENCES causes(id)
);

INSERT INTO donors (name) VALUES
('Sugan'),
('Dharun'),
('vishwa');

INSERT INTO causes (title) VALUES
('Clean Water Project'),
('School Renovation'),
('Animal Shelter');

INSERT INTO donations (donor_id, cause_id, amount, donated_at) VALUES
(1, 1, 100.00, '2025-08-01'),
(2, 1, 50.00,  '2025-08-02'),
(3, 2, 200.00, '2025-08-03'),
(1, 3, 150.00, '2025-08-04');

-- SUM of donations per cause 
SELECT c.title AS cause, SUM(d.amount) AS total_donations
FROM causes c
JOIN donations d ON c.id = d.cause_id
GROUP BY c.title
ORDER BY total_donations DESC;

-- Ranking causes by funds 
SELECT c.title AS cause, SUM(d.amount) AS total_donations,
       RANK() OVER (ORDER BY SUM(d.amount) DESC) AS rank_position
FROM causes c
JOIN donations d ON c.id = d.cause_id
GROUP BY c.title;
