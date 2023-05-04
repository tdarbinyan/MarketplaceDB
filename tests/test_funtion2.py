import psycopg2


def test_get_available_products_count():
    conn = psycopg2.connect("dbname=mydatabase user=myuser password=mypassword")
    cur = conn.cursor()

    # Insert sample data
    cur.execute(
        "INSERT INTO product (name, description, price, available_quantity) VALUES (%s, %s, %s, %s)",
        ("Product 1", "Description 1", 10.0, 20),
    )
    cur.execute(
        "INSERT INTO product (name, description, price, available_quantity) VALUES (%s, %s, %s, %s)",
        ("Product 2", "Description 2", 20.0, 30),
    )

    # Test function
    cur.callproc("get_available_products_count")
    result = cur.fetchall()
    assert len(result) == 2
    assert result[0][0] == "Product 1"
    assert result[0][1] == 20
    assert result[1][0] == "Product 2"
    assert result[1][1] == 30

    conn.rollback()
    cur.close()
    conn.close()
