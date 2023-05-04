# import psycopg2
import unittest


class TestRepeatCustomersView(unittest.TestCase):
    def setUp(self):
        self.conn = psycopg2.connect(
            dbname="your_db_name",
            user="your_username",
            password="your_password",
            host="your_host",
            port="your_port",
        )
        self.cur = self.conn.cursor()

        # Создаем тестовые данные
        self.cur.execute(
            "INSERT INTO users (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Bob')"
        )
        self.cur.execute(
            "INSERT INTO orders (id, user_id) VALUES (1, 1), (2, 1), (3, 2), (4, 3), (5, 3)"
        )

        # Создаем представление repeat_customers_view
        self.cur.execute(
            "CREATE VIEW repeat_customers_view AS SELECT u.id, u.name, COUNT(o.id) AS orders_count \
                FROM users u JOIN orders o ON u.id = o.user_id GROUP BY u.id HAVING COUNT(o.id) > 1;"
        )

    def tearDown(self):
        # Удаляем тестовые данные и представление
        self.cur.execute("DROP VIEW repeat_customers_view")
        self.cur.execute("DELETE FROM orders")
        self.cur.execute("DELETE FROM users")
        self.cur.close()
        self.conn.close()

    def test_repeat_customers_view(self):
        # Выполняем запрос на получение повторных клиентов
        self.cur.execute("SELECT * FROM repeat_customers_view ORDER BY id")

        # Проверяем результат
        result = self.cur.fetchall()
        self.assertEqual(result, [(1, "John", 2)])
