-- Триггер для таблицы "order" при изменении статуса заказа
-- Этот триггер позволяет автоматически отправлять уведомления пользователям,
-- когда их заказ изменяет статус. Например, при изменении статуса заказа на
-- "отправлен", пользователю может быть отправлено уведомление о том, что его заказ
-- был отправлен.
CREATE FUNCTION order_status_change() RETURNS TRIGGER AS $$ BEGIN IF NEW.status != OLD.status THEN INSERT INTO notification (user_id, message) 
VALUES 
  (
    NEW.user_id, 
    CONCAT(
      'Your order with ID ', NEW.id, ' has been updated to status "', 
      NEW.status, '".'
    )
  );
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER orders_status_change_trigger 
AFTER 
UPDATE 
  ON orders FOR EACH ROW EXECUTE FUNCTION order_status_change();
  
  
-- Триггер для таблицы "order_product" при изменении количества продуктов в заказе
-- Этот триггер позволяет автоматически обновлять количество доступных продуктов
-- на складе, когда оно изменяется в связанной таблице "order_product".
CREATE 
OR REPLACE FUNCTION update_product_quantity() RETURNS TRIGGER AS $$ BEGIN 
UPDATE 
  product 
SET 
  available_quantity = available_quantity - NEW.quantity 
WHERE 
  id = NEW.product_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_product_quantity 
AFTER 
  INSERT ON order_product FOR EACH ROW EXECUTE FUNCTION update_product_quantity();
