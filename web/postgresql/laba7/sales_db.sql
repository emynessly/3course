CREATE SCHEMA IF NOT EXISTS sales_db;

CREATE TABLE IF NOT EXISTS sales_db.sales (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    number_sold INTEGER NOT NULL CHECK (number_sold > 0),
    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount > 0),
    min_price NUMERIC(10, 2) NOT NULL CHECK (min_price > 0),
    CHECK (total_amount > number_sold * min_price)
);

INSERT INTO sales_db.sales (name, number_sold, total_amount, min_price)
VALUES
    ('Стул', 5, 22000.00, 4000.00),
    ('Стол', 2, 26000.00, 12000.00),
    ('Шкаф', 1, 18000.00, 16000.00),
    ('Тумба', 3, 10000.00, 3000.00);

SELECT * FROM sales_db.sales