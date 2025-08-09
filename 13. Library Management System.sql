CREATE DATABASE library_management_db;
USE library_management_db;

CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    author VARCHAR(100)
);

CREATE TABLE members (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE borrows (
    id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO books (title, author) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald'),
('1984', 'George Orwell'),
('To Kill a Mockingbird', 'Harper Lee');

INSERT INTO members (name) VALUES
('John Doe'),
('Jane Smith');

INSERT INTO borrows (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2025-08-01', '2025-08-05'),
(1, 2, '2025-08-02', '2025-08-15'),
(2, 3, '2025-07-28', '2025-08-10');

-- Joins and date logic 
SELECT m.name AS member_name, bk.title AS book_title, br.borrow_date, br.return_date
FROM borrows br
JOIN members m ON br.member_id = m.id
JOIN books bk ON br.book_id = bk.id;

-- Fine calculation queries 
SELECT m.name AS member_name, bk.title AS book_title,
       (DATEDIFF(br.return_date, br.borrow_date) - 7) * 10 AS fine_amount
FROM borrows br
JOIN members m ON br.member_id = m.id
JOIN books bk ON br.book_id = bk.id
WHERE DATEDIFF(br.return_date, br.borrow_date) > 7;
