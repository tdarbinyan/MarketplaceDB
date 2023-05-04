import psycopg2


def test_users_masked_view():

    # Открываем соединение с базой данных
    conn = psycopg2.connect("marketplace.db")

    # Создаем курсор
    cur = conn.cursor()

    # Выполняем запрос
    cur.execute(
        "SELECT masked_id, masked_email, masked_password, masked_address 	FROM users_masked"
    )

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
        assert row[2] == "*******"
        assert row[3] is not None
