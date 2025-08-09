CREATE DATABASE expense_tracker_db;
USE expense_tracker_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE expenses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun');

INSERT INTO categories (name) VALUES
('Food'),
('Transport'),
('Shopping');

INSERT INTO expenses (user_id, category_id, amount, date) VALUES
(1, 1, 250.00, '2025-08-01'),
(1, 2, 100.00, '2025-08-02'),
(1, 1, 300.00, '2025-08-15'),
(2, 3, 500.00, '2025-08-05'),
(2, 1, 200.00, '2025-07-28');


-- Aggregations by category/month 
-- Total expense per category
SELECT c.name AS category, SUM(e.amount) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.id
GROUP BY c.name;

-- Total expense per month
SELECT DATE_FORMAT(e.date, '%Y-%m') AS month, SUM(e.amount) AS total_spent
FROM expenses e
GROUP BY DATE_FORMAT(e.date, '%Y-%m')
ORDER BY month;

-- Filters by amount range 
SELECT u.name AS user_name, c.name AS category, e.amount, e.date
FROM expenses e
JOIN users u ON e.user_id = u.id
JOIN categories c ON e.category_id = c.id
WHERE e.amount BETWEEN 200 AND 400;
