import psycopg2


def test_order_user_view():
    # Открываем соединение с базой данных
    conn = psycopg2.connect(
        dbname="your_db_name",
        user="your_username",
        password="your_password",
        host="your_host",
        port="your_port",
    )
    # Создаем курсор
    cur = conn.cursor()
    # Выполняем запрос
    cur.execute("SELECT id, user_id, name, address, status, date FROM order_user")
    # Получаем результаты
    results = cur.fetchall()
    # Закрываем соединение
    conn.close()
    # Проверяем, что запрос вернул не пустой результат
    assert len(results) > 0
    # Проверяем, что все поля в результате имеют значения
    for row in results:
        assert row[0] is not None
        assert row[1] is not None
        assert row[2] is not None
        assert row[3] is not None
        assert row[4] is not None
        assert row[5] is not None

