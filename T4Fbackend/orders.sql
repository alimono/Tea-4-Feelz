-- DROP DATABASE tea_orders;
CREATE DATABASE tea_orders;
USE tea_orders;

CREATE TABLE stock (
	tea_id INT PRIMARY KEY,
    tea_type VARCHAR(50) NOT NULL,
    tea_quantity INT 
);

-- CREATE TABLE customers (
-- 	customer_id INT PRIMARY KEY,
--     customer_name VARCHAR (100) NOT NULL,
--     delivery_address VARCHAR (100) NOT NULL,
--     delivery_postcode VARCHAR (10) NOT NULL
-- );

CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_quantity INT NOT NULL,
    tea_id INT NOT NULL,
    FOREIGN KEY (tea_id) REFERENCES stock(tea_id)
--     customer_id INT NOT NULL,
--     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- CREATE TABLE order_items (
-- 	order_item_id INT PRIMARY KEY AUTO_INCREMENT,
-- 	order_id INT NOT NULL,
--     tea_id INT NOT NULL,
--     quantity INT  NOT NULL,
--     customer_id INT NOT NULL,
--     FOREIGN KEY (order_id) REFERENCES orders(order_id),
--     FOREIGN KEY (tea_id) REFERENCES stock(tea_id)
-- );

-- CREATE TABLE payments (
-- 	payment_id INT PRIMARY KEY,
--     order_id INT NOT NULL,
--     payment_amount DECIMAL(5, 2), -- 5 total digits, 2 decimal places
--     FOREIGN KEY (order_id) REFERENCES orders(order_id)
-- );

INSERT INTO stock
VALUES 
(1, 'Earl Grey', 50),
(2, 'Chamomile', 50),
(3, 'Green Tea', 50),
(4, 'Rooibos', 50),
(5, 'Pepperment', 50),
(6, 'Hibiscus', 50);

-- SELECT * FROM stock;