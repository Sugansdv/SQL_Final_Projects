CREATE DATABASE product_review_system;
USE product_review_system;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id) -- prevent duplicate reviews per user-product
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO products (name) VALUES
('iPhone 14'),
('Nike Running Shoes'),
('Samsung Smart TV');

INSERT INTO reviews (user_id, product_id, rating, review) VALUES
(1, 1, 5, 'Amazing phone, highly recommend!'),
(2, 1, 4, 'Great phone but expensive.'),
(3, 2, 3, 'Comfortable shoes but not very durable.'),
(1, 3, 4, 'Nice TV with good picture quality.');

-- Aggregate ratings using AVG and GROUP BY 
SELECT 
    p.id,
    p.name,
    AVG(r.rating) AS avg_rating,
    COUNT(r.id) AS review_count
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name
ORDER BY avg_rating DESC;

-- Query to get top-rated products 

SELECT 
    p.id,
    p.name,
    AVG(r.rating) AS avg_rating,
    COUNT(r.id) AS review_count
FROM products p
JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name
HAVING AVG(r.rating) >= 4
ORDER BY avg_rating DESC;
