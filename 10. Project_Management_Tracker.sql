CREATE DATABASE project_management;
USE project_management;

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    status ENUM('todo', 'in_progress', 'done') NOT NULL DEFAULT 'todo',
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE task_assignments (
    task_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (task_id, user_id),
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO projects (name) VALUES
('Website Redesign'),
('Mobile App Development');

INSERT INTO tasks (project_id, name, status) VALUES
(1, 'Design homepage', 'done'),
(1, 'Develop login feature', 'in_progress'),
(2, 'Set up database', 'todo'),
(2, 'Implement push notifications', 'todo');

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO task_assignments (task_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 3);

SELECT 
    p.name AS project_name,
    t.name AS task_name,
    t.status,
    GROUP_CONCAT(u.name) AS assigned_users
FROM tasks t
JOIN projects p ON t.project_id = p.id
LEFT JOIN task_assignments ta ON t.id = ta.task_id
LEFT JOIN users u ON ta.user_id = u.id
GROUP BY t.id, p.name, t.name, t.status
ORDER BY p.name, t.status;


SELECT 
    p.name AS project_name,
    t.status,
    COUNT(t.id) AS task_count
FROM tasks t
JOIN projects p ON t.project_id = p.id
GROUP BY p.id, t.status
ORDER BY p.name, t.status;

SELECT 
    t.id AS task_id,
    t.name AS task_name,
    p.name AS project_name,
    t.status
FROM task_assignments ta
JOIN tasks t ON ta.task_id = t.id
JOIN projects p ON t.project_id = p.id
WHERE ta.user_id = 2
ORDER BY t.status, t.name;
