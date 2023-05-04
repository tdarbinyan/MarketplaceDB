import psycopg2


def test_get_sales_statistics():
    conn = psycopg2.connect(
        host="localhost",
        database="mydatabase",
        user="myusername",
        password="mypassword",
    )
    cur = conn.cursor()
    cur.callproc("get_sales_statistics", ("2022-01-01 00:00:00", "2022-01-31 23:59:59"))
    result = cur.fetchall()
    assert len(result) == 2
    assert result[0][0] == "Product A"
    assert result[0][1] == 10
    assert result[0][2] == 500.0
    assert result[1][0] == "Product B"
    assert result[1][1] == 5
    assert result[1][2] == 750.0
    conn.close()
