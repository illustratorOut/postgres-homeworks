"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv
from help import host, database, user, password

conn = psycopg2.connect(host=host, database=database, user=user, password=password)


def uploading_data_to_the_database(path: str, name_tabel: str):
    """
        path - Путь к CSV файлу
        name_tabel - Название таблицы в БД (куда будут записаны данные из файла CSV "_")
    """

    with open(path, "r", encoding="UTF-8") as file:
        reader = csv.DictReader(file)
        for row in reader:
            try:
                with conn:
                    with conn.cursor() as cur:
                        request = f"INSERT INTO {name_tabel} VALUES (" + len(reader.fieldnames) * "%s,"
                        ready_request = request[:-1] + ")"

                        data = [row[i] for i in reader.fieldnames]

                        cur.execute(ready_request, data)

            except Exception as e:
                print("Ошибка записи в таблицу БД данных из файла!\n", e)


uploading_data_to_the_database("north_data/orders_data.csv", "orders")
uploading_data_to_the_database("north_data/customers_data.csv", "customers")
uploading_data_to_the_database("north_data/employees_data.csv", "employees")
