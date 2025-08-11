CREATE DATABASE product_return_management;

USE product_return_management;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL
);

CREATE TABLE returns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO orders (user_id, product_id) VALUES
(101, 201),
(102, 202),
(103, 203),
(104, 204);

INSERT INTO returns (order_id, reason, status) VALUES
(1, 'Defective product', 'Pending'),
(2, 'Wrong size', 'Approved'),
(3, 'Changed mind', 'Rejected');

-- JOIN orders with returns 
SELECT orders.id AS order_id,
       orders.user_id,
       orders.product_id,
       returns.id AS return_id,
       returns.reason,
       returns.status
FROM orders
LEFT JOIN returns 
       ON orders.id = returns.order_id;

-- Status reporting 
SELECT returns.status, 
       COUNT(returns.id) AS total_returns
FROM returns
GROUP BY returns.status
ORDER BY total_returns DESC;
