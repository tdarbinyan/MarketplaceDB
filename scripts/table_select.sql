SELECT 
  * 
FROM 
  USER;


SELECT 
  * 
FROM 
  product 
WHERE 
  price > 50;
  
 
SELECT 
  USER.NAME, 
  ORDER.status, 
  ORDER.date 
FROM 
  USER 
  JOIN ORDER ON USER.id = ORDER.user_id;
  
  
SELECT 
  product.NAME, 
  Sum(order_product.quantity) AS total_quantity 
FROM 
  product 
  JOIN order_product ON product.id = order_product.product_id 
GROUP BY 
  product.NAME;
  
  
-- Выберем всех пользователей, у которых было более одного заказа:
SELECT   
  USER.id,
  USER.NAME, 
  Count(order.id) AS order_count 
FROM 
  USER 
  LEFT JOIN order ON USER.id = order.user_id 
GROUP BY 
  USER.id, 
  USER.NAME 
HAVING 
  Count(order.id) > 1;
  
  
 
-- Выберем все заказы, отсортированные по дате:
SELECT
  *
FROM 
  order 
ORDER BY 
  date;
  
  
  
-- Выберем все заказы, отсортированные по дате и разбитые на разделы по идентификатору
-- пользователя:
SELECT
  id,
  user_id, 
  date, 
Row_number() OVER(
  partition BY user_id 
  ORDER BY 
    date
) AS row_num 
FROM 
  order;
  
  
 
-- Выберем все заказы, отсортированные по дате и вычислим для каждого заказа разницу в днях
-- между этим заказом и предыдущим заказом пользователя:
SELECT
  id,
  user_id, 
  date, 
Date_part(
  'day', 
  date - Lag(date) OVER(
    partition BY user_id 
    ORDER BY 
      date
  )
) AS days_since_last_order 
FROM 
  order;
  
  
  
-- Выберем все заказы, отсортированные по дате и разбитые на разделы по идентификатору
-- пользователя, и вычислим суммарную стоимость заказов для каждого пользователя:
SELECT    
  user_id,
  Sum(price_per_unit * quantity) OVER(
  partition BY user_id 
  ORDER BY 
    date
) AS total_spent 
FROM 
  order_product 
  LEFT JOIN order ON order_product.order_id = order.id;
  
  
-- Вычисляем общее количество товаров, проданных каждым пользователем:
SELECT  
  USER.NAME,
  Sum(order_product.quantity) AS total_quantity 
FROM 
  USER 
  JOIN order ON USER.id = order.user_id 
  JOIN order_product ON order.id = order_product.order_id 
GROUP BY 
  USER.NAME;
  
  
-- Находим максимальную цену товара:
SELECT 
  Max(price) AS max_price
FROM 
  product;
  
  
-- Находим рейтинг пользователей по общей стоимости их заказов:
SELECT  
  USER.NAME,
Sum(
  order_product.price_per_unit * order_product.quantity
) AS total_price, 
Rank() OVER (
  ORDER BY 
    Sum(
      order_product.price_per_unit * order_product.quantity
    ) DESC
) AS rank 
FROM 
  USER 
  JOIN order ON USER.id = order.user_id 
  JOIN order_product ON order.id = order_product.order_id 
GROUP BY 
  USER.NAME;
  
  
-- Находим позицию товара в отсортированном списке по цене:
SELECT  
  id,
  NAME, 
  price, 
Row_number() OVER (
  ORDER BY 
    price
) AS position 
FROM 
  product;
  
  
-- Находим среднюю цену товара, при условии, что каждый пользователь делал не менее двух
-- заказов:
SELECT 
  Avg(price) OVER () AS avg_price
FROM 
  (
    SELECT 
      price, 
      user_id, 
      Count(DISTINCT order.id) AS order_count 
    FROM 
      product 
      JOIN order_product ON product.id = order_product.product_id 
      JOIN order ON order_product.order_id = order.id 
    GROUP BY 
      price, 
      user_id 
    HAVING 
      Count(DISTINCT order.id) >= 2
  ) subquery;
  
  
-- Находим пользователей, которые заказывали более 5 единиц товара
SELECT  
  USER.NAME,
Sum(order_product.quantity) AS total_quantity 
FROM 
  USER 
  JOIN order ON USER.id = order.user_id 
  JOIN order_product ON order.id = order_product.order_id 
GROUP BY 
  USER.NAME 
HAVING 
  Sum(order_product.quantity) > 5;
  
  
-- Выбрать все товары и отсортировать их по убыванию цены
SELECT   
  *
FROM 
  product 
ORDER BY 
  price DESC;
  
  
-- Выбрать идентификатор пользователя, дату заказа, статус заказа и количество заказов
-- для каждого пользователя
SELECT 
  user_id,
  date, 
  status, 
Count(*) OVER (partition BY user_id) AS num_orders 
FROM 
  order;
  
  
-- Выбрать идентификатор пользователя, дату заказа, статус заказа и количество заказов
-- для каждого пользователя, отсортированных по дате в порядке возрастания
SELECT  
  user_id,
  date, 
  status, 
Count(*) OVER (
  partition BY user_id 
  ORDER BY 
    date ASC
) AS num_orders 
FROM 
  order;
  
  
-- Выбрать идентификатор пользователя, дату заказа, статус заказа и количество заказов
-- для каждого пользователя, отсортированных по дате в порядке возрастания
SELECT  
  user_id,
  date, 
  status, 
Count(*) OVER (
  partition BY user_id 
  ORDER BY 
    date ASC
) AS num_orders 
FROM 
  order;
  
  
-- Средняя цена каждого пользователя в таблице order_product
SELECT
  Avg(price) OVER (partition BY user_id) AS avg_price_per_user
FROM 
  order_product 
  JOIN product ON order_product.product_id = product.id;
