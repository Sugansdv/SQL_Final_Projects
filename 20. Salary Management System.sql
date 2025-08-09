CREATE DATABASE salary_db;
USE salary_db;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE salaries (
    emp_id INT,
    month DATE,
    base DECIMAL(10,2),
    bonus DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

CREATE TABLE deductions (
    emp_id INT,
    month DATE,
    reason VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

INSERT INTO employees (name) VALUES
('Sugan'),
('Dharun');

INSERT INTO salaries (emp_id, month, base, bonus) VALUES
(1, '2025-08-01', 3000.00, 200.00),
(2, '2025-08-01', 2800.00, 0.00);

INSERT INTO deductions (emp_id, month, reason, amount) VALUES
(1, '2025-08-01', 'Late Penalty', 50.00),
(1, '2025-08-01', 'Loan Repayment', 100.00),
(2, '2025-08-01', 'Tax', 200.00);

-- Monthly aggregation 
-- Calculate net salary per employee for a month
SELECT e.name,
       s.month,
       s.base,
       s.bonus,
       IFNULL(SUM(d.amount), 0) AS total_deductions,
       (s.base + s.bonus - IFNULL(SUM(d.amount), 0)) AS net_salary
FROM salaries s
JOIN employees e ON s.emp_id = e.id
LEFT JOIN deductions d ON s.emp_id = d.emp_id AND s.month = d.month
GROUP BY e.name, s.month, s.base, s.bonus;

-- Conditional bonus 
SELECT e.name,
       s.month,
       s.base,
       s.bonus + CASE WHEN s.base > 2900 THEN 100 ELSE 0 END AS adjusted_bonus
FROM salaries s
JOIN employees e ON s.emp_id = e.id;
