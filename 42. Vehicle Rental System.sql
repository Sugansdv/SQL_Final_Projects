CREATE DATABASE vehicle_rental;

USE vehicle_rental;

CREATE TABLE vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50) NOT NULL,
    plate_number VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE rentals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    customer_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO vehicles (type, plate_number) VALUES
('Car', 'TN01AB1234'),
('Bike', 'TN02BC5678'),
('Truck', 'TN03CD9101'),
('SUV', 'TN04EF2345');

INSERT INTO customers (name) VALUES
('Dharun'),
('Sugan'),
('Santoz'),
('Vishwa');

INSERT INTO rentals (vehicle_id, customer_id, start_date, end_date) VALUES
(1, 1, '2025-08-01', '2025-08-05'),
(2, 2, '2025-08-03', '2025-08-04'),
(3, 3, '2025-08-05', '2025-08-10'),
(1, 4, '2025-08-07', '2025-08-12');

-- Duration-based charge calculation
SELECT rentals.id,
       customers.name AS customer_name,
       vehicles.type,
       vehicles.plate_number,
       rentals.start_date,
       rentals.end_date,
       DATEDIFF(rentals.end_date, rentals.start_date) + 1 AS rental_days,
       (DATEDIFF(rentals.end_date, rentals.start_date) + 1) * 100 AS total_charge
FROM rentals
JOIN customers ON rentals.customer_id = customers.id
JOIN vehicles ON rentals.vehicle_id = vehicles.id;
 
-- Vehicle availability 
SELECT vehicles.id, vehicles.type, vehicles.plate_number
FROM vehicles
WHERE vehicles.id NOT IN (
    SELECT vehicle_id
    FROM rentals
    WHERE NOT (
        end_date < '2025-08-03' OR start_date > '2025-08-05'
    )
);
