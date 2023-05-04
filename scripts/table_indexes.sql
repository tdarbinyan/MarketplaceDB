-- Для таблицы "user" можно создать индекс по полю "email", так как этот столбец
-- часто используется при поиске пользователей по электронной почте:

CREATE INDEX user_email_idx
    ON users (email);
    
-- Для таблицы "order" можно создать индекс по полю "user_id", так как это поле часто
-- используется при поиске заказов конкретного пользователя:

CREATE INDEX order_user_id_idx 
    ON "order" (user_id);
    
-- Для таблицы "product" можно создать индекс по полю "name", так как это поле
-- часто используется при поиске продуктов по названию:

CREATE INDEX product_name_idx 
    ON product (name);
    
-- Для таблицы "order_product" можно создать два индекса: по полям "order_id" и
-- "product_id", так как эти поля часто используются при поиске продуктов в заказах:

CREATE INDEX order_product_order_id_idx
    ON order_product (order_id);
    
CREATE INDEX order_product_product_id_idx 
    ON order_product (product_id);
