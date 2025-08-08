CREATE DATABASE sales_crm;
USE sales_crm;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE leads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    source VARCHAR(100)  -- e.g., 'Website', 'Referral'
);

CREATE TABLE deals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lead_id INT NOT NULL,
    user_id INT NOT NULL,
    stage ENUM('new', 'contacted', 'proposal', 'negotiation', 'won', 'lost') NOT NULL DEFAULT 'new',
    amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lead_id) REFERENCES leads(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob');

INSERT INTO leads (name, source) VALUES
('Company A', 'Website'),
('Company B', 'Referral'),
('Company C', 'Email Campaign');

INSERT INTO deals (lead_id, user_id, stage, amount) VALUES
(1, 1, 'new', 10000),
(1, 1, 'proposal', 12000),
(2, 2, 'contacted', 5000),
(3, 2, 'won', 15000),
(2, 1, 'negotiation', 7000);

-- CTEs or Window functions for deal progression 
WITH RankedDeals AS (
    SELECT
        d.*,
        ROW_NUMBER() OVER (PARTITION BY d.lead_id ORDER BY d.created_at DESC, d.id DESC) AS rn
    FROM deals d
)
SELECT
    rd.lead_id,
    l.name AS lead_name,
    rd.stage,
    rd.amount,
    rd.created_at
FROM RankedDeals rd
JOIN leads l ON rd.lead_id = l.id
WHERE rd.rn = 1
ORDER BY rd.created_at DESC;

-- Filters by status/date 
SELECT
    d.id,
    l.name AS lead_name,
    u.name AS user_name,
    d.stage,
    d.amount,
    d.created_at
FROM deals d
JOIN leads l ON d.lead_id = l.id
JOIN users u ON d.user_id = u.id
WHERE d.stage = 'won'
  AND d.created_at BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY d.created_at DESC;
