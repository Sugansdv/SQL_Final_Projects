CREATE DATABASE invoice_db;
USE invoice_db;

CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE invoices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    date DATE,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE invoice_items (
    invoice_id INT,
    description VARCHAR(200),
    quantity INT,
    rate DECIMAL(10,2),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);

INSERT INTO clients (name) VALUES
('ABC Pvt Ltd'),
('XYZ Enterprises');

INSERT INTO invoices (client_id, date) VALUES
(1, '2025-08-01'),
(2, '2025-08-05');

INSERT INTO invoice_items (invoice_id, description, quantity, rate) VALUES
(1, 'Website Design', 1, 15000.00),
(1, 'Hosting (1 year)', 1, 3000.00),
(1, 'Domain Registration', 1, 800.00),
(2, 'Mobile App Development', 1, 25000.00),
(2, 'Maintenance (6 months)', 1, 6000.00);

-- Subtotal/total calculations 
-- JOINs between invoice and items
-- invoice details with subtotal per item
SELECT i.id AS invoice_id, c.name AS client_name, i.date,
       ii.description, ii.quantity, ii.rate,
       (ii.quantity * ii.rate) AS subtotal
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON i.id = ii.invoice_id;

-- total amount per invoice
SELECT i.id AS invoice_id, c.name AS client_name, i.date,
       SUM(ii.quantity * ii.rate) AS total_amount
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON i.id = ii.invoice_id
GROUP BY i.id, c.name, i.date;
