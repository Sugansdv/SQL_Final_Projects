CREATE DATABASE food_delivery_tracker;
USE food_delivery_tracker;

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    user_id INT NOT NULL,
    placed_at DATETIME NOT NULL,
    delivered_at DATETIME,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE delivery_agents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE deliveries (
    order_id INT NOT NULL PRIMARY KEY,
    agent_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(id) ON DELETE CASCADE
);

INSERT INTO restaurants (name) VALUES
('Pizza Palace'),
('Burger Barn');

INSERT INTO users (name) VALUES
('Sugan'),
('Dharun'),
('Vishwa');

INSERT INTO delivery_agents (name) VALUES
('David'),
('Eva');

INSERT INTO orders (restaurant_id, user_id, placed_at, delivered_at) VALUES
(1, 1, '2025-08-09 12:00:00', '2025-08-09 12:30:00'),
(2, 2, '2025-08-09 13:15:00', '2025-08-09 13:50:00'),
(1, 3, '2025-08-09 14:00:00', '2025-08-09 14:25:00');

INSERT INTO deliveries (order_id, agent_id) VALUES
(1, 1),
(2, 2),
(3, 1);

-- Delivery time analysis 
SELECT 
    o.id AS order_id,
    r.name AS restaurant_name,
    u.name AS customer_name,
    TIMESTAMPDIFF(MINUTE, o.placed_at, o.delivered_at) AS delivery_time_minutes
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.id
JOIN users u ON o.user_id = u.id
ORDER BY delivery_time_minutes ASC;

-- Agent workload 
SELECT 
    da.name AS agent_name,
    COUNT(d.order_id) AS total_deliveries
FROM deliveries d
JOIN delivery_agents da ON d.agent_id = da.id
GROUP BY da.id, da.name
ORDER BY total_deliveries DESC;

-- Average delivery time per agent
SELECT 
    da.name AS agent_name,
    AVG(TIMESTAMPDIFF(MINUTE, o.placed_at, o.delivered_at)) AS avg_delivery_time_minutes
FROM deliveries d
JOIN delivery_agents da ON d.agent_id = da.id
JOIN orders o ON d.order_id = o.id
GROUP BY da.id, da.name
ORDER BY avg_delivery_time_minutes ASC;
