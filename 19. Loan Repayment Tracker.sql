CREATE DATABASE loan_db;
USE loan_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE loans (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    principal DECIMAL(12,2),
    interest_rate DECIMAL(5,2), -- percentage
    start_date DATE,
    monthly_due_date INT, -- day of month payment is due
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    amount DECIMAL(12,2),
    paid_on DATE,
    FOREIGN KEY (loan_id) REFERENCES loans(id)
);

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun');

INSERT INTO loans (user_id, principal, interest_rate, start_date, monthly_due_date) VALUES
(1, 10000.00, 10.00, '2025-01-01', 10),
(2, 20000.00, 8.00, '2025-02-01', 15);

INSERT INTO payments (loan_id, amount, paid_on) VALUES
(1, 2000.00, '2025-02-10'),
(1, 2000.00, '2025-03-10'),
(2, 5000.00, '2025-03-15');

-- SUM of paid vs total 
SELECT l.id AS loan_id, u.name,
       l.principal + (l.principal * l.interest_rate / 100) AS total_due,
       IFNULL(SUM(p.amount), 0) AS total_paid,
       (l.principal + (l.principal * l.interest_rate / 100)) - IFNULL(SUM(p.amount), 0) AS remaining_balance
FROM loans l
JOIN users u ON l.user_id = u.id
LEFT JOIN payments p ON l.id = p.loan_id
GROUP BY l.id, u.name, l.principal, l.interest_rate;

-- Due date logic 
SELECT u.name, l.id AS loan_id, l.monthly_due_date
FROM loans l
JOIN users u ON l.user_id = u.id
LEFT JOIN payments p
  ON l.id = p.loan_id
  AND MONTH(p.paid_on) = MONTH(CURDATE())
  AND YEAR(p.paid_on) = YEAR(CURDATE())
WHERE p.id IS NULL
  AND DAY(CURDATE()) > l.monthly_due_date;
