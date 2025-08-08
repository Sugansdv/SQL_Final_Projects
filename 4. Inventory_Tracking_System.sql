CREATE DATABASE inventory_system;
USE inventory_system;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE inventory_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    action ENUM('restock', 'sale') NOT NULL,
    qty INT NOT NULL,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE
);

INSERT INTO products (name, stock) VALUES
('iPhone 14', 100),
('Nike Running Shoes', 150),
('Samsung Smart TV', 75);

INSERT INTO suppliers (name) VALUES
('Apple Inc.'),
('Nike Inc.'),
('Samsung Electronics');

INSERT INTO inventory_logs (product_id, supplier_id, action, qty) VALUES
(1, 1, 'restock', 50),
(2, 2, 'restock', 100),
(3, 3, 'restock', 40);

-- Triggers to auto-update stock 

DELIMITER //
CREATE TRIGGER trg_update_stock AFTER INSERT ON inventory_logs
FOR EACH ROW
BEGIN
    IF NEW.action = 'restock' THEN
        UPDATE products SET stock = stock + NEW.qty WHERE id = NEW.product_id;
    ELSEIF NEW.action = 'sale' THEN
        UPDATE products SET stock = stock - NEW.qty WHERE id = NEW.product_id;
    END IF;
END;
//
DELIMITER ;

-- Query to get stock status with reorder logic

SELECT 
    p.id,
    p.name,
    p.stock,
    CASE
        WHEN p.stock = 0 THEN 'Out of Stock'
        WHEN p.stock < 20 THEN 'Reorder Soon'
        ELSE 'Stock Sufficient'
    END AS stock_status
FROM products p;

