import sqlite3
import matplotlib.pyplot as plt

# Подключение к базе данных
conn = sqlite3.connect("marketplace.db")
c = conn.cursor()

# Извлечение данных из таблицы заказов
c.execute("SELECT status, COUNT(*) FROM orders GROUP BY status")
data = c.fetchall()

# Создание графика
labels = [row[0] for row in data]
values = [row[1] for row in data]
plt.pie(values, labels=labels, autopct="%1.1f%%")
plt.title("Orders Status")
plt.show()

# Закрытие соединения с базой данных
conn.close()

