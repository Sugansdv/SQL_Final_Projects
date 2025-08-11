CREATE DATABASE inventory_expiry_tracker;

USE inventory_expiry_tracker;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL
);

CREATE TABLE batches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    expiry_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO products (name) VALUES
('Milk'),
('Bread'),
('Cheese'),
('Yogurt');

INSERT INTO batches (product_id, quantity, expiry_date) VALUES
(1, 50, '2025-08-05'), 
(1, 30, '2025-08-20'), 
(2, 100, '2025-08-15'), 
(3, 20, '2025-07-30'), 
(4, 40, '2025-08-25'); 

-- Expired stock alerts 
SELECT products.name AS product_name,
       batches.quantity,
       batches.expiry_date
FROM batches
JOIN products 
     ON batches.product_id = products.id
WHERE batches.expiry_date < CURDATE()
ORDER BY batches.expiry_date;

-- Remaining stock query 
SELECT products.name AS product_name,
       SUM(batches.quantity) AS total_quantity
FROM batches
JOIN products 
     ON batches.product_id = products.id
WHERE batches.expiry_date >= CURDATE()
GROUP BY products.name
ORDER BY total_quantity DESC;

