-- Представление со списком пользователей без персональных данных
CREATE VIEW users_masked AS 
SELECT 
  id AS masked_id, 
  CONCAT(
    SUBSTR(email, 1, 3), 
    REPEAT(
      '*', 
      LENGTH(email)-3
    )
  ) AS masked_email, 
  '*******' AS masked_password, 
  CONCAT(
    SUBSTR(address, 1, 5), 
    REPEAT(
      '*', 
      LENGTH(address)-5
    )
  ) AS masked_address 
FROM 
  users;

-- order_masked: представление таблицы order с сокрытием поля status:
CREATE VIEW orders_mask AS 
SELECT 
  id, 
  user_id, 
  CONCAT(
    SUBSTR(status, 0, 1), 
    REPEAT(
      '*', 
      LENGTH(status) -1
    )
  ) AS masked_status, 
  date 
FROM 
  orders;
select 
  * 
from 
  orders_mask;

-- order_user: представление соединения таблиц order и user, отображающее
-- информацию о пользователе и его заказах:
CREATE VIEW order_user AS 
SELECT 
  o.id, 
  o.user_id, 
  u.name, 
  u.address, 
  o.status, 
  o.date 
FROM 
  order o 
  JOIN user u ON o.user_id = u.id;


-- order_product_details: представление соединения таблиц order_product, order и
-- product, отображающее информацию о продукте и его заказе:
CREATE VIEW order_product_details AS 
SELECT 
  o.id AS order_id, 
  o.user_id, 
  o.date, 
  p.name, 
  p.description, 
  op.quantity, 
  op.price_per_unit 
FROM 
  orders o 
  JOIN order_product op ON o.id = op.order_id 
  JOIN product p ON p.id = op.product_id;

-- user_orders_count: представление соединения таблиц user и order, отображающее
-- количество заказов для каждого пользователя:
CREATE VIEW user_orders_count AS 
SELECT 
  u.id, 
  u.name, 
  COUNT(*) as orders_count 
FROM 
  users u 
  JOIN orders o ON o.user_id = u.id 
GROUP BY 
  u.id, 
  u.name;


-- Представление со списком пользователей, которые совершили более одного
-- заказа
CREATE VIEW repeat_customers_view AS 
SELECT 
  u.id, 
  u.name, 
  COUNT(o.id) AS orders_count 
FROM 
  users u 
  JOIN orders o ON u.id = o.user_id 
GROUP BY 
  u.id 
HAVING 
  COUNT(o.id) > 1;
