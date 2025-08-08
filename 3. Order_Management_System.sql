CREATE DATABASE order_management;
USE order_management;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,  -- price at order time
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO users (name, email) VALUES
('Sugan', 'sugan@gmail.com'),
('Dharun', 'dharun@gmail.com');

INSERT INTO products (name, description, price, stock, image_url) VALUES
('iPhone 14', 'Latest Apple iPhone model', 999.99, 50, 'https://example.com/iphone14.jpg'),
('Nike Running Shoes', 'Comfortable running shoes', 120.00, 200, 'https://example.com/nikeshoes.jpg'),
('Samsung Smart TV', '55 inch 4K TV', 799.00, 30, 'https://example.com/samsungtv.jpg');

INSERT INTO orders (user_id, status) VALUES
(1, 'pending'),
(1, 'shipped'),
(2, 'delivered');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 999.99),    -- Order 1: 2 iPhones
(1, 2, 1, 120.00),    -- Order 1: 1 Nike shoes
(2, 3, 1, 799.00),    -- Order 2: 1 Samsung TV
(3, 2, 3, 110.00);    -- Order 3: 3 Nike shoes 
 
-- Transactions 
START TRANSACTION;

INSERT INTO orders (user_id, status) VALUES (1, 'pending');
SET @order_id = LAST_INSERT_ID();

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(@order_id, 1, 2, 999.99),
(@order_id, 2, 1, 120.00);

COMMIT;

-- JOINs and GROUP BY 
SELECT 
  o.id AS order_id,
  o.status,
  o.created_at,
  COUNT(oi.id) AS total_items,
  SUM(oi.quantity * oi.price) AS total_value
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.user_id = 1
GROUP BY o.id, o.status, o.created_at
ORDER BY o.created_at DESC;

-- Query to get order history by user 
SELECT 
  o.id AS order_id,
  o.status,
  o.created_at,
  COUNT(oi.id) AS total_items,
  SUM(oi.quantity * oi.price) AS total_order_value
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.user_id = 1
GROUP BY o.id, o.status, o.created_at
ORDER BY o.created_at DESC;



