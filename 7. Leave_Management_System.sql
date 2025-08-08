CREATE DATABASE leave_management;
USE leave_management;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE leave_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE leave_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    leave_type_id INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (emp_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (leave_type_id) REFERENCES leave_types(id) ON DELETE CASCADE,
    CHECK (to_date >= from_date),
    UNIQUE KEY unique_leave_overlap (emp_id, from_date, to_date)
);

-- Constraints on overlapping dates
DELIMITER //
CREATE TRIGGER trg_prevent_overlapping_leave BEFORE INSERT ON leave_requests
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM leave_requests
        WHERE emp_id = NEW.emp_id
          AND status = 'approved'
          AND NEW.from_date <= to_date
          AND NEW.to_date >= from_date
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Overlapping approved leave exists for this employee.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO employees (name) VALUES
('Alice'),
('Bob');

INSERT INTO leave_types (type_name) VALUES
('Sick Leave'),
('Annual Leave');

INSERT INTO leave_requests (emp_id, leave_type_id, from_date, to_date, status) VALUES
(1, 1, '2025-08-01', '2025-08-03', 'approved'),
(1, 2, '2025-08-10', '2025-08-15', 'pending'),
(2, 2, '2025-08-05', '2025-08-07', 'approved');

-- Aggregate leaves by employee 
SELECT 
    e.id AS employee_id,
    e.name AS employee_name,
    lt.type_name,
    SUM(DATEDIFF(lr.to_date, lr.from_date) + 1) AS total_leave_days
FROM leave_requests lr
JOIN employees e ON lr.emp_id = e.id
JOIN leave_types lt ON lr.leave_type_id = lt.id
WHERE lr.status = 'approved'
GROUP BY e.id, lt.id
ORDER BY e.name, lt.type_name;
