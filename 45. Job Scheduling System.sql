CREATE DATABASE job_scheduling;

USE job_scheduling;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    frequency VARCHAR(50) NOT NULL 
);

CREATE TABLE job_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    run_time DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL, 
    FOREIGN KEY (job_id) REFERENCES jobs(id)
);

INSERT INTO jobs (name, frequency) VALUES
('Data Backup', 'Daily'),
('Email Notifications', 'Hourly'),
('Log Cleanup', 'Weekly');

INSERT INTO job_logs (job_id, run_time, status) VALUES
(1, '2025-08-10 02:00:00', 'Success'),
(1, '2025-08-11 02:00:00', 'Success'),
(2, '2025-08-11 09:00:00', 'Failed'),
(2, '2025-08-11 10:00:00', 'Success'),
(3, '2025-08-05 01:00:00', 'Success');

-- Last run, next run
SELECT jobs.id,
       jobs.name,
       MAX(job_logs.run_time) AS last_run
FROM jobs
JOIN job_logs 
     ON jobs.id = job_logs.job_id
GROUP BY jobs.id, jobs.name;
 
-- Status count by job 
SELECT jobs.id,
       jobs.name,
       job_logs.status,
       COUNT(job_logs.id) AS status_count
FROM jobs
JOIN job_logs 
     ON jobs.id = job_logs.job_id
GROUP BY jobs.id, jobs.name, job_logs.status
ORDER BY jobs.name, status_count DESC;
