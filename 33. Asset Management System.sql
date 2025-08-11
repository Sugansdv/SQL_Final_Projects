CREATE DATABASE asset_management_system;
USE asset_management_system;

CREATE TABLE assets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE assignments (
    asset_id INT NOT NULL,
    user_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    returned_date DATE DEFAULT NULL,
    PRIMARY KEY (asset_id, assigned_date),
    FOREIGN KEY (asset_id) REFERENCES assets(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO assets (name, category) VALUES
('Laptop A', 'Electronics'),
('Laptop B', 'Electronics'),
('Projector 1', 'AV Equipment');

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun'),
('Vishwa');

INSERT INTO assignments (asset_id, user_id, assigned_date, returned_date) VALUES
(1, 1, '2025-07-01', '2025-07-10'),
(2, 2, '2025-07-05', NULL),
(3, 3, '2025-07-07', '2025-07-08'),
(1, 3, '2025-07-15', NULL); 

-- Current vs historical usage tracking 
SELECT 
    a.name AS asset_name,
    u.name AS user_name,
    asn.assigned_date
FROM assignments asn
JOIN assets a ON asn.asset_id = a.id
JOIN users u ON asn.user_id = u.id
WHERE asn.returned_date IS NULL;

SELECT 
    a.name AS asset_name,
    u.name AS user_name,
    asn.assigned_date,
    asn.returned_date
FROM assignments asn
JOIN assets a ON asn.asset_id = a.id
JOIN users u ON asn.user_id = u.id
ORDER BY asn.assigned_date DESC;

-- Asset availability queries 
SELECT 
    a.id,
    a.name,
    a.category
FROM assets a
WHERE a.id NOT IN (
    SELECT asset_id FROM assignments WHERE returned_date IS NULL
);

