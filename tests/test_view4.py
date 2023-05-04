import psycopg2
import unittest


class TestOrderProductDetailsView(unittest.TestCase):
    def setUp(self):
        # устанавливаем соединение с БД
        self.conn = psycopg2.connect(
            dbname="your_db_name",
            user="your_username",
            password="your_password",
            host="your_host",
            port="your_port",
        )
        self.cur = self.conn.cursor()

        # создаем таблицы для тестирования
        self.cur.execute(
            "CREATE TABLE product (id SERIAL PRIMARY KEY, name VARCHAR(50), description TEXT)"
        )
        self.cur.execute(
            "CREATE TABLE orders (id SERIAL PRIMARY KEY, user_id INTEGER, date TIMESTAMP)"
        )
        self.cur.execute(
            "CREATE TABLE order_product (id SERIAL PRIMARY KEY, order_id INTEGER REFERENCES orders(id), \   product_id INTEGER REFERENCES product(id), quantity INTEGER, price_per_unit DECIMAL(10,2))"
        )

        # добавляем тестовые данные
        self.cur.execute(
            "INSERT INTO product (name, description) VALUES ('product1', 'description1'), \
                          ('product2', 'description2')"
        )
        self.cur.execute(
            "INSERT INTO orders (user_id, date) VALUES (1, '2023-04-19 10:00:00'), \
                          (2, '2023-04-19 12:00:00')"
        )
        self.cur.execute(
            "INSERT INTO order_product (order_id, product_id, quantity, price_per_unit) \
                          VALUES (1, 1, 2, 10.99), (1, 2, 1, 20.99), (2, 2, 3, 15.99)"
        )

        # создаем представление для тестирования
        self.cur.execute(
            "CREATE VIEW order_product_details AS \
                          SELECT o.id AS order_id, o.user_id, o.date, p.name, p.description, \
                          op.quantity, op.price_per_unit \
                          FROM orders o \
                          JOIN order_product op ON o.id = op.order_id \
                          JOIN product p ON p.id = op.product_id"
        )

        self.conn.commit()

    def tearDown(self):
        # удаляем таблицы и представление после тестов
        self.cur.execute("DROP VIEW IF EXISTS order_product_details")
        self.cur.execute("DROP TABLE IF EXISTS order_product")
        self.cur.execute("DROP TABLE IF EXISTS orders")
        self.cur.execute("DROP TABLE IF EXISTS product")
        self.conn.commit()

        # закрываем соединение с БД
        self.cur.close()
        self.conn.close()
