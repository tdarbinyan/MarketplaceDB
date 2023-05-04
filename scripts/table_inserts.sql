INSERT INTO user (id, name, email, password, address)
VALUES
(1, 'John Doe', 'john.doe@example.com', 'hash123', '123 Main St'),
(2, 'Jane Smith', 'jane.smith@example.com', 'hash456', '456 Oak St'),
(3, 'Bob Johnson', 'bob.johnson@example.com', 'hash789', '789 Maple Ave'),
(4, 'Alice Brown', 'alice.brown@example.com', 'hashABC', '321 Elm St'),
(5, 'Tom Wilson', 'tom.wilson@example.com', 'hashDEF', '654 Pine Rd'),
(6, 'Sara Lee', 'sara.lee@example.com', 'hashGHI', '987 Cedar St'),
(7, 'David Kim', 'david.kim@example.com', 'hashJKL', '234 Birch Ave'),
(8, 'Emily Liu', 'emily.liu@example.com', 'hashMNO', '567 Oakwood Ln'),
(9, 'Mike Chen', 'mike.chen@example.com', 'hashPQR', '890 Pine Ct'),
(10, 'Linda Wang', 'linda.wang@example.com', 'hashSTU', '123 Maple Rd');

INSERT INTO order (id, user_id, status, date)
VALUES
(1, 1, 'completed', '2023-03-01 10:30:00'),
(2, 2, 'shipped', '2023-03-02 14:15:00'),
(3, 3, 'processing', '2023-03-03 08:45:00'),
(4, 4, 'completed', '2023-03-04 11:20:00'),
(5, 5, 'cancelled', '2023-03-05 13:00:00'),
(6, 6, 'processing', '2023-03-06 09:30:00'),
(7, 7, 'shipped', '2023-03-07 16:45:00'),
(8, 8, 'completed', '2023-03-08 10:00:00'),
(9, 9, 'processing', '2023-03-09 11:30:00'),
(10, 10, 'cancelled', '2023-03-10 14:00:00');

INSERT INTO product (id, name, description, price, available_quantity)
VALUES
(1, 'T-shirt', 'A plain white T-shirt', 15.99, 50),
(2, 'Jeans', 'Slim fit blue jeans', 49.99, 25),
(3, 'Hoodie', 'Black hoodie with a front pocket', 29.99, 35),
(4, 'Sneakers', 'White canvas sneakers with rubber sole', 39.99, 20),
(5, 'Jacket', 'Lightweight waterproof jacket', 79.99, 10),
(6, 'Backpack', 'Gray backpack with multiple compartments', 45.99, 15),
(7, 'Sunglasses', 'Classic aviator sunglasses', 19.99, 30),
(8, 'Watch', 'Silver analog watch with black leather strap', 99.99, 5),
(9, 'Headphones', 'Wireless over-ear headphones', 129.99, 8),
(10, 'Smartphone', '5.5 inch smartphone with 64GB storage', 349.99, 3);


INSERT INTO order_product (order_id, product_id, quantity, price_per_unit)
VALUES
(1, 2, 2, 49.99),
(1, 4, 1, 39.99),
(1, 6, 1, 45.99),
(2, 1, 3, 15.99),
(2, 3, 2, 29.99),
(2, 7, 1, 19.99),
(3, 5, 1, 79.99),
(3, 9, 1, 129.99),
(3, 10, 1, 349.99),
(4, 2, 1, 49.99);
