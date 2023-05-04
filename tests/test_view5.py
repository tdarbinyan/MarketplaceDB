import psycopg2
import unittest


def test_user_orders_count(Postgresql):
    # Устанавливаем соединение с базой данных
    conn = psycopg2.connect(
        dbname="your_db_name",
        user="your_username",
        password="your_password",
        host="your_host",
        port="your_port",
    )

    # Создаем курсор для выполнения запросов
    cur = conn.cursor()

    # Создаем тестовые данные
    cur.execute("INSERT INTO users (id, name) VALUES (1, 'John'), (2, 'Jane')")
    cur.execute("INSERT INTO orders (id, user_id) VALUES (1, 1), (2, 1), (3, 2)")

    # Создаем представление user_orders_count
    cur.execute(
        "CREATE VIEW user_orders_count AS SELECT u.id, u.name, COUNT(*) as orders_count \
                FROM users u JOIN orders o ON o.user_id = u.id GROUP BY u.id, u.name;"
    )

    # Выполняем запрос на получение количества заказов для каждого пользователя
    cur.execute("SELECT * FROM user_orders_count ORDER BY id")

    # Проверяем результат
    result = cur.fetchall()
    assert result == [(1, "John", 2), (2, "Jane", 1)]

    # Закрываем соединение и курсор
    cur.close()
    conn.close()
