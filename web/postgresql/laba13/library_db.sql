-- ==============================================
-- SCHEMA + SEED + ЗАДАНИЯ ДЛЯ ДЕМОНСТРАЦИИ JOIN
-- ==============================================

-- Удаляем старые таблицы, если они существуют (для повторного запуска)
DROP TABLE IF EXISTS issuance CASCADE;
DROP TABLE IF EXISTS library_book CASCADE;
DROP TABLE IF EXISTS reader_library CASCADE;
DROP TABLE IF EXISTS book CASCADE;
DROP TABLE IF EXISTS author CASCADE;
DROP TABLE IF EXISTS library CASCADE;
DROP TABLE IF EXISTS reader CASCADE;

-- =========================
-- DDL
-- =========================

CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    birth_year INT
);

CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INT REFERENCES author(id) ON DELETE SET NULL,
    year_published INT,
    isbn VARCHAR(40) UNIQUE,
    annotation TEXT
);

CREATE TABLE library (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    year_founded INT
);

CREATE TABLE reader (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- MtM: reader <-> library с номером читательского билета
CREATE TABLE reader_library (
    library_id INT NOT NULL REFERENCES library(id) ON DELETE CASCADE,
    reader_id INT NOT NULL REFERENCES reader(id) ON DELETE CASCADE,
    card_number TEXT NOT NULL,
    membership_started DATE DEFAULT CURRENT_DATE,
    membership_ends DATE,
    PRIMARY KEY (library_id, reader_id),
    CONSTRAINT uniq_card_per_library UNIQUE (library_id, card_number)
);

-- MtM: book <-> library с атрибутом quantity
CREATE TABLE library_book (
    library_id INT NOT NULL REFERENCES library(id) ON DELETE CASCADE,
    book_id INT NOT NULL REFERENCES book(id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity >= 0),
    shelf TEXT,
    PRIMARY KEY (library_id, book_id)
);

-- Issuance (выдача)
CREATE TABLE issuance (
    id SERIAL PRIMARY KEY,
    library_id INT NOT NULL REFERENCES library(id) ON DELETE CASCADE,
    card_number TEXT NOT NULL,
    book_id INT NOT NULL REFERENCES book(id) ON DELETE RESTRICT,
    term_days INT NOT NULL CHECK (term_days > 0),
    issued_at DATE NOT NULL DEFAULT CURRENT_DATE,
    returned_at DATE,
    CONSTRAINT fk_reader_card FOREIGN KEY (library_id, card_number)
        REFERENCES reader_library (library_id, card_number)
        ON DELETE RESTRICT
);

CREATE INDEX idx_issuance_card ON issuance(library_id, card_number);
CREATE INDEX idx_issuance_book ON issuance(book_id);

-- =========================
-- SEED DATA
-- =========================

-- 1) Авторы (вставляем явные id для надёжности)
INSERT INTO author (id, name, birth_year) VALUES
(1, 'Фёдор Достоевский', 1821),
(2, 'Лев Толстой', 1828),
(3, 'Маргарет Этвуд', 1939),
(4, 'Джордж Оруэлл', 1903),
(5, 'Харуки Мураками', 1949),
(6, 'Неизвестный автор', NULL),
(7, 'Джон Смит', 1975),
(8, 'Эмили Браун', 1982),
(9, 'Александр Куприн', 1870),
(10, 'Анна Каренина-автор (демо)', 1877),
(11, 'Доп. автор 1', 1960),
(12, 'Доп. автор 2', 1970),
(13, 'Доп. автор 3', 1985);

-- Обновляем последовательность author_id
SELECT setval(pg_get_serial_sequence('author','id'), (SELECT COALESCE(MAX(id),0) FROM author));

-- 2) Книги (явные id)
INSERT INTO book (id, title, author_id, year_published, isbn, annotation) VALUES
(1, 'Преступление и наказание', 1, 1866, '978-5-17-118366-1', 'Роман о моральных дилеммах.'),
(2, 'Война и мир', 2, 1869, '978-5-17-084875-6', 'Эпопея о России эпохи Наполеоновских войн.'),
(3, 'Рассказ служанки', 3, 1985, '978-0-241-12239-1', 'Антиутопия.'),
(4, '1984', 4, 1949, '978-0-452-28423-4', 'Антиутопия про тоталитаризм.'),
(5, 'Норвежский лес', 5, 1987, '978-0-670-80752-0', 'Роман о взрослении.'),
(6, 'Идиот', 1, 1869, '978-5-17-089565-5', 'О человеке с необычной добротой.'),
(7, 'Анна Каренина', 2, 1877, '978-5-699-98973-4', 'Трагедия любви и общества.'),
(8, 'Хор любимых женщин', 5, 2013, '978-0-316-25280-9', 'Сборник рассказов.'),
(9, 'Загадочная книга', 6, 2000, NULL, 'Книга с неясной авторской информацией.'),
(10, 'Путешествие в горы', 11, 2010, '111-1111111111', 'Приключенческая книга.'),
(11, 'Тайные сны', 12, 2018, '222-2222222222', 'Романтическая проза.'),
(12, 'Книга без автора', NULL, 2020, '333-3333333333', 'Преднамеренно без автора.'),
(13, 'Редкая рукопись', NULL, NULL, NULL, 'Редкая рукопись.'),
(14, 'Дополнительная книга A', 7, 2005, '444-4444444444', 'Доп. для демо.'),
(15, 'Дополнительная книга B', 8, 2012, '555-5555555555', 'Доп. для демо.');

SELECT setval(pg_get_serial_sequence('book','id'), (SELECT COALESCE(MAX(id),0) FROM book));

-- 3) Библиотеки
INSERT INTO library (id, name, year_founded) VALUES
(1, 'Центральная городская библиотека', 1952),
(2, 'Библиотека на Тихой улице', 1998),
(3, 'Библиотека на холме', 2005),
(4, 'Старая районная библиотека', NULL),
(5, 'Маленький читалый клуб', 2023);

SELECT setval(pg_get_serial_sequence('library','id'), (SELECT COALESCE(MAX(id),0) FROM library));

-- 4) Читатели
INSERT INTO reader (id, name) VALUES
(1, 'Алексей Иванов'),
(2, 'Мария Смирнова'),
(3, 'Ольга Петрова'),
(4, 'Игорь Кузнецов'),
(5, 'Читатель без библиотеки'),
(6, 'Ветеран чтения'),
(7, 'Постоянный посетитель'),
(8, 'Гость');

SELECT setval(pg_get_serial_sequence('reader','id'), (SELECT COALESCE(MAX(id),0) FROM reader));

-- 5) Связи reader_library (номера читательских билетов)
INSERT INTO reader_library (library_id, reader_id, card_number, membership_started) VALUES
(1, 1, 'C-0001', '2020-02-10'),
(1, 2, 'C-0002', '2021-06-15'),
(2, 3, 'T-1001', '2022-01-05'),
(2, 4, 'T-1002', '2023-09-20'),
(2, 1, 'T-2001', '2024-03-01'),
(1, 5, 'C-0100', '2024-05-10'),
(3, 6, 'H-2001', '2023-01-01'),
(4, 7, 'O-3001', '2024-12-01'),
(5, 4, 'M-5001', '2025-02-20');

-- 6) library_book (книжные фонды)
INSERT INTO library_book (library_id, book_id, quantity, shelf) VALUES
-- библиотека 1
(1, 1, 3, 'A-1'),
(1, 2, 1, 'A-2'),
(1, 4, 2, 'B-1'),
(1, 6, 1, 'A-3'),
(1, 5, 1, 'B-2'),
-- библиотека 2
(2, 3, 4, 'C-1'),
(2, 5, 2, 'C-2'),
(2, 7, 1, 'C-3'),
(2, 8, 2, 'C-4'),
-- библиотека 3
(3, 9, 2, 'D-1'),
(3, 10, 1, 'D-2'),
(3, 15, 1, 'D-3'),
-- библиотека 4
(4, 11, 3, 'E-1'),
-- библиотека 5
(5, 12, 1, 'F-1'),
(5, 13, 2, 'F-2'),
(5, 14, 1, 'F-3');

-- 7) Выдачи (issuance)
INSERT INTO issuance (library_id, card_number, book_id, term_days, issued_at) VALUES
-- библиотека 1
(1, 'C-0001', 1, 21, '2025-11-01'),
(1, 'C-0002', 4, 14, '2025-10-28'),
(1, 'C-0001', 6, 30, '2025-09-15'),
-- библиотека 2
(2, 'T-1001', 3, 14, '2025-11-10'),
(2, 'T-1002', 5, 21, '2025-11-05'),
(2, 'T-2001', 8, 14, '2025-10-20'),
-- библиотека 3
(3, 'H-2001', 9, 14, '2025-11-01'),
(3, 'H-2001', 10, 30, '2025-11-05'),
-- библиотека 4
(4, 'O-3001', 11, 21, '2025-11-10'),
-- библиотека 5
(5, 'M-5001', 12, 7, '2025-11-05'),
(5, 'M-5001', 13, 14, '2025-11-12');

-- 1.1 INNER JOIN
SELECT
    b.title AS название_книги,
    a.name AS автор,
    b.year_published AS год_публикации
FROM book b
INNER JOIN author a ON b.author_id = a.id;

-- 1.2
SELECT
    l.name AS библиотека,
    b.title AS книга,
    lb.quantity AS количество
FROM library_book lb
INNER JOIN library l ON lb.library_id = l.id
INNER JOIN book b ON lb.book_id = b.id
WHERE lb.quantity > 0;

-- 2.1 LEFT JOIN
SELECT
    b.title AS книга,
    l.name AS библиотека,
    COALESCE(lb.quantity, 0) AS количество
FROM book b
LEFT JOIN library_book lb ON b.id = lb.book_id
LEFT JOIN library l ON lb.library_id = l.id
ORDER BY b.title, l.name;

-- 2.2
SELECT
    a.name  AS автор,
    COALESCE(SUM(lb.quantity), 0) AS всего_экземпляров
FROM author a
LEFT JOIN book b ON a.id = b.author_id
LEFT JOIN library_book lb ON b.id = lb.book_id
GROUP BY a.id, a.name
ORDER BY всего_экземпляров DESC;

-- 3.1 RIGHT JOIN
SELECT 
    b.title AS название_книги,
    l.name AS библиотека,
    COALESCE(lb.quantity, 0) AS количество
FROM library_book lb
RIGHT JOIN library l ON lb.library_id = l.id
LEFT JOIN book b ON lb.book_id = b.id
ORDER BY l.name, b.title;

-- 3.2
SELECT 
    l.name AS библиотека,
    COUNT(DISTINCT b.id) AS уникальных_книг
FROM library l
LEFT JOIN library_book lb ON l.id = lb.library_id
LEFT JOIN book b ON lb.book_id = b.id
GROUP BY l.id, l.name
ORDER BY уникальных_книг DESC;

-- 4.1 FULL JOIN
SELECT 
    b.title AS книга,
    l.name AS библиотека,
    COALESCE(lb.quantity, 0) AS количество
FROM book b
FULL JOIN library_book lb ON b.id = lb.book_id
FULL JOIN library l ON lb.library_id = l.id
WHERE b.id IS NOT NULL OR l.id IS NOT NULL
ORDER BY l.name, b.title;

-- 4.2
SELECT 
    a.name AS автор,
    b.title AS книга,
    b.year_published AS год_публикации
FROM author a
FULL JOIN book b ON a.id = b.author_id
ORDER BY a.name, b.title;

-- 5.1 CROSS JOIN
SELECT 
    l.name AS библиотека,
    b.title AS книга,
    0 AS planned_copies
FROM library l
CROSS JOIN book b
LIMIT 50;

-- 5.2
SELECT 
    l.name AS библиотека,
    b.year_published AS год_публикации
FROM library l
CROSS JOIN (
    SELECT DISTINCT year_published 
    FROM book 
    WHERE year_published IS NOT NULL
) b
ORDER BY l.name, b.year_published;

-- 6.1 LATERAL JOIN
SELECT 
    l.name AS библиотека,
    book_info.название_книги,
    book_info.максимальное_количество
FROM library l
LEFT JOIN LATERAL (
    SELECT 
        b.title AS название_книги,
        lb.quantity AS максимальное_количество
    FROM library_book lb
    JOIN book b ON lb.book_id = b.id
    WHERE lb.library_id = l.id
    ORDER BY lb.quantity DESC
    LIMIT 1
) book_info ON TRUE
ORDER BY l.name;

-- 6.2
SELECT 
    a.name AS автор,
    top_libs.библиотека,
    top_libs.общее_количество
FROM author a
LEFT JOIN LATERAL (
    SELECT 
        l.name AS библиотека,
        SUM(lb.quantity) AS общее_количество
    FROM library_book lb
    JOIN book b ON lb.book_id = b.id
    JOIN library l ON lb.library_id = l.id
    WHERE b.author_id = a.id
    GROUP BY l.id, l.name
    ORDER BY общее_количество DESC
    LIMIT 2
) top_libs ON TRUE
WHERE a.name IS NOT NULL
ORDER BY a.name, top_libs.общее_количество DESC;

-- 7.1 SELF JOIN
SELECT 
    a1.name AS автор_1,
    a2.name AS автор_2,
    a1.birth_year AS год_рождения
FROM author a1
JOIN author a2 ON a1.birth_year = a2.birth_year 
    AND a1.id < a2.id
    AND a1.birth_year IS NOT NULL
ORDER BY a1.birth_year, a1.name;

-- 7.2
SELECT 
    b1.title AS книга_1,
    a1.name AS автор_1,
    b2.title AS книга_2,
    a2.name AS автор_2,
    b1.year_published AS год_публикации
FROM book b1
JOIN book b2 ON b1.year_published = b2.year_published 
    AND b1.id < b2.id
    AND b1.year_published IS NOT NULL
LEFT JOIN author a1 ON b1.author_id = a1.id
LEFT JOIN author a2 ON b2.author_id = a2.id
WHERE (b1.author_id IS NULL OR b2.author_id IS NULL OR b1.author_id != b2.author_id)
ORDER BY b1.year_published, b1.title;