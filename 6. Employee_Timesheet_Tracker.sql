CREATE DATABASE timesheet_tracker;
USE timesheet_tracker;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept VARCHAR(100) NOT NULL
);

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE timesheets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    project_id INT NOT NULL,
    hours DECIMAL(5,2) NOT NULL,
    work_date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

INSERT INTO employees (name, dept) VALUES
('Sugan', 'Engineering'),
('Dharun', 'Design'),
('Vishwa', 'Engineering');

INSERT INTO projects (name) VALUES
('Project Apollo'),
('Project Zeus');

INSERT INTO timesheets (emp_id, project_id, hours, work_date) VALUES
(1, 1, 8.0, '2025-08-01'),
(1, 2, 4.0, '2025-08-01'),
(2, 1, 7.5, '2025-08-02'),
(3, 1, 6.0, '2025-08-03'),
(1, 1, 5.0, '2025-08-05'),
(2, 2, 8.0, '2025-08-05');

-- JOINs to fetch timesheet per project 

SELECT
    e.name AS employee_name,
    e.dept,
    p.name AS project_name,
    t.hours,
    t.work_date
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
JOIN projects p ON t.project_id = p.id
ORDER BY t.work_date DESC;

-- GROUP BY employee/project 

SELECT
    e.name AS employee_name,
    p.name AS project_name,
    SUM(t.hours) AS total_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
JOIN projects p ON t.project_id = p.id
GROUP BY e.id, p.id
ORDER BY e.name, p.name;

-- Date filters for weekly/monthly hours 
-- Weekly hours for employee with id=1 (assuming week starts Monday)

SELECT
    YEARWEEK(t.work_date, 1) AS year_week,
    SUM(t.hours) AS weekly_hours
FROM timesheets t
WHERE t.emp_id = 1
GROUP BY year_week
ORDER BY year_week DESC;


