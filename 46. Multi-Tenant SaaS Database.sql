CREATE DATABASE multi_tenant_saas;

USE multi_tenant_saas;

CREATE TABLE tenants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    tenant_id INT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Tenant isolation by foreign key
CREATE TABLE data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tenant_id INT NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

INSERT INTO tenants (name) VALUES
('Tenant A'),
('Tenant B');

INSERT INTO users (name, tenant_id) VALUES
('Dharun', 1),
('Santoz', 1),
('Sugan', 2),
('Vishwa', 2);

INSERT INTO data (tenant_id, content) VALUES
(1, 'Tenant A - Project Plan'),
(1, 'Tenant A - Sales Report'),
(2, 'Tenant B - Marketing Strategy'),
(2, 'Tenant B - Customer List');
 
-- Query partitioning 
-- All users for Tenant A
SELECT users.id, users.name
FROM users
WHERE tenant_id = 1;

SELECT u.name AS user_name, d.content
FROM users u
JOIN data d ON u.tenant_id = d.tenant_id
WHERE u.tenant_id = 1;

