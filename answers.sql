CREATE DATABASE BookStore;
USE BookStore;

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL
);
CREATE TABLE order_line (
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    shipping_method_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
);
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    publication_year INT,
    price DECIMAL(10, 2) NOT NULL,
    language_id INT NOT NULL,
    publisher_id INT NOT NULL,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone CHAR(15)
);
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL
);
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'Admin123';
GRANT ALL PRIVILEGES ON BookStore.* TO 'bookstore_admin'@'localhost';

CREATE USER 'bookstore_staff'@'localhost' IDENTIFIED BY 'staff123';
GRANT DELETE ON bookstore.order_line TO 'bookstore_staff'@'localhost';
GRANT DELETE ON bookstore.cust_order TO 'bookstore_staff'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bookstore . * TO 'bookstore_staff'@'localhost';
GRANT SELECT ON bookstore.order_history TO 'bookstore_staff'@'localhost';
GRANT SELECT ON bookstore.order_status TO 'bookstore_staff'@'localhost';
GRANT SELECT ON bookstore.shipping_method TO 'bookstore_staff'@'localhost';
GRANT SELECT ON bookstore.book_author TO 'bookstore_staff'@'localhost';
GRANT SELECT ON bookstore.book TO 'bookstore_staff'@'localhost';

CREATE USER 'bookstore_report'@'localhost' IDENTIFIED BY 'Report123';

GRANT SELECT ON BookStore.* TO 'bookstore_report'@'localhost';

FLUSH PRIVILEGES;



-- Insert sample languages 
INSERT INTO book_language ( language_name) VALUES
( 'English'),
( 'French'),
( 'Spanish'),
( 'German'),
( 'IsiXhosa'),
( 'IsiZulu'),
( 'Setswana');

-- -- Insert sample publishers
INSERT INTO publisher (publisher_name) VALUES
('Penguin Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Macmillan'),
('African Books Collective'),
('Jacana Media');

-- -- Insert sample authors
INSERT INTO author (first_name, last_name) VALUES
('J.K.', 'Rowling'),
('Stephen', 'King'),
('George R.R.', 'Martin'),
('Agatha', 'Christie'),
('Chinua', 'Achebe'),
('Nadine', 'Gordimer'),
('Zakes', 'Mda');

-- Insert sample books 
ALTER TABLE book
ADD COLUMN num_pages INT;
INSERT INTO book (title, isbn, num_pages, publication_date, publisher_id, language_id, price, stock_quantity) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532743', 223, '1997-06-26', 1, 1, 12.99, 50),
('The Shining', '9780307743657', 447, '1977-01-28', 2, 1, 9.99, 30),
('A Game of Thrones', '9780553103540', 694, '1996-08-01', 3, 1, 15.99, 40),
('Murder on the Orient Express', '9780062073495', 256, '1934-01-01', 4, 1, 8.99, 25),
('Things Fall Apart', '9780385474542', 209, '1958-0-1', 5, 1, 10.50, 35),
('July''s People', '9780747500162', 160, '1981-01-01', 6, 1, 11.00, 20),
('Ways of Dying','9780195711202',192, '1995-01-01',6, 1, 13.00, 28),
('Umdlalo weNtsasa', '9780624003294',120, '1979-01-01',6, 5, 9.50, 15),
('Insila kaShaka','9780624003294',120, '1979-01-01',6, 6, 9.50, 15),
('Maru','9780435905202',128,'1971-01-01',5,1,10.00,20);
ALTER TABLE book
ADD COLUMN publication_date DATE;
INSERT INTO book (title, isbn, num_pages, publication_date, publisher_id, language_id, price, stock_quantity) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532743', 223, '1997-06-26', 1, 1, 12.99, 50),
('The Shining', '9780307743657', 447, '1977-01-28', 2, 1, 9.99, 30),
('A Game of Thrones', '9780553103540', 694, '1996-08-01', 3, 1, 15.99, 40),
('Murder on the Orient Express', '9780062073495', 256, '1934-01-01', 4, 1, 8.99, 25),
('Things Fall Apart', '9780385474542', 209, '1958-01-01', 5, 1, 10.50, 35),
('July''s People', '9780747500162', 160, '1981-01-01', 6, 1, 11.00, 20),
('Ways of Dying','9780195711202',192, '1995-01-01',6, 1, 13.00, 28),
('Umdlalo weNtsasa', '9780624003294',120, '1979-01-01',6, 5, 9.50, 15),
('Insila kaShaka','9780624003294',120, '1979-01-01',6, 6, 9.50, 15),
('Maru','9780435905202',128,'1971-01-01',5,1,10.00,20);

ALTER TABLE book
ADD COLUMN stock_quantity INT;


INSERT INTO book_author (book_id, author_id) VALUES
(11, 1), -- Harry Potter and the Philosopher's Stone (J.K. Rowling)
(12, 2), -- The Shining (Stephen King)
(13, 3), -- A Game of Thrones (George R.R. Martin)
(14, 4), -- Murder on the Orient Express (Agatha Christie)
(15, 5), -- Things Fall Apart (Chinua Achebe)
(16, 6), -- July's People (Nadine Gordimer)
(17, 7), -- Ways of Dying(Zakes Mda)
(18, 7), -- Umdlalo weNtsasa(Zakes Mda)
(19, 7), -- Insila kaShaka(Zakes Mda)
(11, 7); -- Maru, I am guessing this is also Zakes Mda.

-- Insert address statuses

ALTER TABLE address_status
ADD COLUMN address_status VARCHAR(50) UNIQUE NOT NULL;

INSERT INTO address_status (address_status, status_name) VALUES
('Current', 'Current'),
('Previous', 'Previous'),
('Billing', 'Billing'),
('Shipping', 'Shipping');


-- Insert countries (including African countries)
INSERT INTO country (country_name) VALUES
('United States'), ('United Kingdom'), ('Canada'), ('Australia'),
('South Africa'), ('Nigeria'), ('Kenya'), ('Ghana');

-- Insert order statuses
INSERT INTO order_status (status_value) VALUES
('Pending'), ('Processing'), ('Shipped'), ('Delivered'), ('Cancelled');

ALTER TABLE order_status
ADD COLUMN status_value VARCHAR(50) UNIQUE NOT NULL;

INSERT INTO order_status (status_value, status_name) VALUES
('Pending', 'Pending'),
('Processing', 'Processing'),
('Shipped', 'Shipped'),
('Delivered', 'Delivered'),
('Cancelled', 'Cancelled');

-- Insert shipping methods
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Shipping', 25.99), ('Express Shipping', 69.99), ('Overnight Shipping', 55.99),
('Local Delivery', 15.99);

-- queries to test data retrieval and analysis
-- filters books where the language is IsiXhosa, IsiZulu, or Setswana.

SELECT 
    b.title,
    b.isbn,
    b.price,
    b.stock_quantity,
    bl.language_name
FROM 
    book b
    JOIN book_language bl ON b.language_id = bl.language_id
WHERE 
    bl.language_name IN ('IsiXhosa', 'IsiZulu', 'Setswana')
ORDER BY 
    bl.language_name, b.title;

-- the total value of books in stock (price * stock_quantity) grouped by publisher.
    SELECT 
    p.publisher_name,
    COUNT(b.book_id) AS book_count,
    SUM(b.stock_quantity) AS total_books_in_stock,
    ROUND(SUM(b.price * b.stock_quantity), 2) AS total_stock_value
FROM 
    book b
    JOIN publisher p ON b.publisher_id = p.publisher_id
GROUP BY 
    p.publisher_name
ORDER BY 
    total_stock_value DESC;

-- lists all shipping methods to verify their data.
    SELECT 
    method_name,
    cost
FROM 
    shipping_method
ORDER BY 
    cost ASC;
