CREATE DATABASE payment_subscription_tracker;

USE payment_subscription_tracker;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL
);

CREATE TABLE subscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    plan_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    renewal_cycle INT NOT NULL COMMENT 'Cycle in days',
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun'),
('Vishwa');

INSERT INTO subscriptions (user_id, plan_name, start_date, renewal_cycle) VALUES
(1, 'Premium Plan', '2025-07-15', 30), 
(2, 'Basic Plan', '2025-06-10', 60),   
(3, 'Gold Plan', '2025-07-25', 90);    

-- Auto-renewal date logic 
SELECT u.name,
       s.plan_name,
       s.start_date,
       DATE_ADD(s.start_date, INTERVAL s.renewal_cycle DAY) AS next_renewal
FROM subscriptions s
JOIN users u ON s.user_id = u.id;

-- Expired subscription check 
SELECT u.name,
       s.plan_name,
       s.start_date,
       DATE_ADD(s.start_date, INTERVAL s.renewal_cycle DAY) AS renewal_date
FROM subscriptions s
JOIN users u ON s.user_id = u.id
WHERE DATE_ADD(s.start_date, INTERVAL s.renewal_cycle DAY) < CURDATE();
