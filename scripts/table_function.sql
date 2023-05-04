-- Функция для получения статистики о продажах за определенный период
-- времени:
CREATE 
OR REPLACE FUNCTION get_sales_statistics(
  start_date timestamp, end_date timestamp
) RETURNS TABLE (
  product_name varchar(100), 
  total_sales bigint, 
  total_revenue numeric(10, 2)
) AS $$ BEGIN RETURN QUERY 
SELECT 
  p.name AS product_name, 
  SUM(op.quantity) AS total_sales, 
  SUM(op.quantity * op.price_per_unit) AS total_revenue 
FROM 
  orders o 
  JOIN order_product op ON o.id = op.order_id 
  JOIN product p ON op.product_id = p.id 
WHERE 
  o.date >= $1 
  AND o.date <= $2 
GROUP BY 
  p.name;
END;
$$ LANGUAGE plpgsql;



-- Функция для получения количества доступных продуктов.
CREATE 
OR REPLACE FUNCTION get_available_products_count_() RETURNS TABLE (
  product_name varchar(100), 
  available_qty integer
) AS $$ BEGIN RETURN QUERY 
SELECT 
  name AS product_name, 
  available_quantity AS available_qty 
FROM 
  product;
END;
$$ LANGUAGE plpgsql;
