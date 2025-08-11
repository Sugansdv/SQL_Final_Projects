CREATE DATABASE ecommerce_shop;
USE ecommerce_shop;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    category_id INT,
    brand_id INT
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE carts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE cart_items (
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO products (name, description, price, stock, image_url, category_id, brand_id) VALUES
('iPhone 14', 'Latest Apple iPhone model', 999.99, 50, 'https://example.com/iphone14.jpg', NULL, NULL),
('Nike Running Shoes', 'Comfortable running shoes', 120.00, 200, 'https://example.com/nikeshoes.jpg', NULL, NULL),
('Samsung Smart TV', '55 inch 4K TV', 799.00, 30, 'https://example.com/samsungtv.jpg', NULL, NULL);

INSERT INTO users (name, email) VALUES
('Sugan', 'sugan@gmail.com'),
('Dharun', 'dharun@gmail.com');

INSERT INTO carts (user_id) VALUES
(1),
(2);

INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(1, 1, 2), 
(1, 3, 1); 

-- JOINS to retrieve product details in the cart 
SELECT 
  ci.cart_id,
  p.id AS product_id,
  p.name,
  p.price,
  ci.quantity,
  (p.price * ci.quantity) AS total_price
FROM cart_items ci
JOIN carts c ON ci.cart_id = c.id
JOIN products p ON ci.product_id = p.id
WHERE c.user_id = 1;

-- SUM to calculate total cart value
SELECT 
  SUM(p.price * ci.quantity) AS total_cart_value
FROM cart_items ci
JOIN carts c ON ci.cart_id = c.id
JOIN products p ON ci.product_id = p.id
WHERE c.user_id = 1;

--  INSERT for cart operations 
INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES (1, 2, 1)
ON DUPLICATE KEY UPDATE quantity = quantity + 1;

--  UPDATE for cart operations 
UPDATE cart_items
SET quantity = 3
WHERE cart_id = 1 AND product_id = 1;

-- --  DELETE for cart operations 
DELETE FROM cart_items
WHERE cart_id = 1 AND product_id = 3;
