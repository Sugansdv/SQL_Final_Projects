CREATE DATABASE ecommerce_catalog;
USE ecommerce_catalog;

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    category_id INT,
    brand_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(id) ON DELETE SET NULL
);

CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_brand ON products(brand_id);
CREATE INDEX idx_products_price ON products(price);

INSERT INTO categories (name) VALUES
  ('Electronics'),
  ('Apparel'),
  ('Home Appliances');

INSERT INTO brands (name) VALUES
  ('Apple'),
  ('Nike'),
  ('Samsung');

INSERT INTO products (name, description, price, stock, image_url, category_id, brand_id) VALUES
  ('iPhone 14', 'Latest Apple iPhone model', 999.99, 50, 'https://example.com/iphone14.jpg', 1, 1),
  ('Nike Running Shoes', 'Comfortable running shoes', 120.00, 200, 'https://example.com/nikeshoes.jpg', 2, 2),
  ('Samsung Smart TV', '55 inch 4K TV', 799.00, 30, 'https://example.com/samsungtv.jpg', 1, 3);

-- Filter products by category 
SELECT 
  p.name, 
  c.name AS category_name, 
  b.name AS brand_name
FROM products p
JOIN categories c ON p.category_id = c.id
JOIN brands b ON p.brand_id = b.id
WHERE c.name = 'Electronics';

-- Filter products by brand
SELECT 
  p.name, 
  c.name AS category_name, 
  b.name AS brand_name
FROM products p
JOIN categories c ON p.category_id = c.id
JOIN brands b ON p.brand_id = b.id
WHERE b.name = 'Nike';

-- Filter products by price range
SELECT 
  p.name, 
  p.price,   
  c.name AS category_name, 
  b.name AS brand_name
FROM products p
JOIN categories c ON p.category_id = c.id
JOIN brands b ON p.brand_id = b.id
WHERE p.price BETWEEN 50 AND 300;

-- Return products by category and brand 
SELECT 
  p.name, 
  p.description, 
  p.price, 
  c.name AS category_name,
  b.name AS brand_name
FROM products p
JOIN categories c ON p.category_id = c.id
JOIN brands b ON p.brand_id = b.id
WHERE c.name = 'Electronics' AND b.name = 'Samsung';
