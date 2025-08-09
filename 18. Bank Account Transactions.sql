CREATE DATABASE bank_db;
USE bank_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE accounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    balance DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    type ENUM('deposit', 'withdrawal'),
    amount DECIMAL(12,2),
    timestamp DATETIME,
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun');

-- Sample accounts
INSERT INTO accounts (user_id, balance) VALUES
(1, 0),
(2, 0);

-- Sample transactions
INSERT INTO transactions (account_id, type, amount, timestamp) VALUES
(1, 'deposit', 1000.00, '2025-08-01 09:00:00'),
(1, 'withdrawal', 200.00, '2025-08-02 10:00:00'),
(1, 'deposit', 500.00, '2025-08-03 14:00:00'),
(2, 'deposit', 2000.00, '2025-08-01 11:00:00');

-- Transaction logs 
SELECT u.name AS user_name, a.id AS account_id, t.type, t.amount, t.timestamp
FROM transactions t
JOIN accounts a ON t.account_id = a.id
JOIN users u ON a.user_id = u.id
ORDER BY t.timestamp;

-- CTE for balance calculation 
WITH transaction_sums AS (
    SELECT account_id,
           SUM(CASE WHEN type = 'deposit' THEN amount ELSE -amount END) AS total_change
    FROM transactions
    GROUP BY account_id
)
SELECT a.id AS account_id, u.name AS user_name,
       (a.balance + IFNULL(ts.total_change, 0)) AS current_balance
FROM accounts a
JOIN users u ON a.user_id = u.id
LEFT JOIN transaction_sums ts ON a.id = ts.account_id;
