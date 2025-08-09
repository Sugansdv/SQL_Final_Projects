CREATE DATABASE wishlist_db;
USE wishlist_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE wishlist (
    user_id INT,
    product_id INT,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO users (name) VALUES
('Sugan'),
('Vishwa'),
('Dharun');

INSERT INTO products (name) VALUES
('Laptop'),
('Smartphone'),
('Headphones');

INSERT INTO wishlist (user_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(2, 3);

-- Query popular wishlist items
-- Popular wishlist items 
SELECT p.name AS product, COUNT(w.user_id) AS wish_count
FROM products p
JOIN wishlist w ON p.id = w.product_id
GROUP BY p.name
ORDER BY wish_count DESC;

-- Wishlist items for a specific user
SELECT p.name AS product
FROM wishlist w
JOIN products p ON w.product_id = p.id
JOIN users u ON w.user_id = u.id
WHERE u.name = 'sugan';
