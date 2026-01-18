DROP TABLE IF EXISTS hr_import_lines;
CREATE TABLE hr_import_lines (
  id serial PRIMARY KEY,
  source_file text NOT NULL,      -- имя файла-источника
  line_no int NOT NULL,           -- номер строки в файле
  raw_line text NOT NULL,         -- исходная необработанная строка
  imported_at timestamp with time zone default now(),
  note text                       -- служебная метка (для ревью)
);

INSERT INTO hr_import_lines (source_file, line_no, raw_line, note) VALUES
-- Контактные строки с email в угловых скобках и без
('candidates_2025_10.csv', 1, 'Ivan Ivanov <ivan.ivanov@example.com>, +7 (912) 345-67-89, \"python,sql\"', 'contact record'),
('candidates_2025_10.csv', 2, 'Мария Смирнова, maria.smirnova@company.co, 8-912-3456789, \"python,django\"', 'contact record'),
('candidates_2025_10.csv', 3, 'Petrov <not-an-email@@example..com>, 09123456789, \"rust, systems\"', 'broken email'),

-- Записи о оборудовании / внутренние ID (артикулы, SKU, asset IDs)
('assets_import.csv', 10, 'ASSET: AB-123-XY; location: HQ; qty: 2', 'asset record'),
('assets_import.csv', 11, 'asset: zx9999; note: legacy-id', 'asset record'),

-- Теги/скиллы в одной колонке, через запятую, с разными пробелами
('skills_teams.csv', 1, 'tags: sql, postgres, regex,  performance', 'tags field'),
('skills_teams.csv', 2, 'tags: fastapi,python', 'tags field'),
('skills_teams.csv', 3, 'tags: sql,, ,postgres', 'possible empty tags'),

-- «Грязные» CSV-поля: кавычки и запятые внутри полей (адреса, зарплаты с разделителем тысяч)
('payroll_dirty.csv', 5, '\"Ivanov, Ivan\", Москва, \"30,000\"', 'csv row with commas'),
('payroll_dirty.csv', 6, '\"Sidorova, Anna\", "St.Petersburg, Nevsky", "1,200,000"', 'csv row with many commas'),

-- Логи обработки и сообщения об ошибках разного регистра
('import_log.txt', 201, 'INFO: Started import of candidates_2025_10.csv', 'log'),
('import_log.txt', 202, 'Warning: missing email for line 3', 'log'),
('import_log.txt', 203, 'error: failed to parse csv_row at line 6', 'log'),
('import_log.txt', 204, 'Error: phone number invalid', 'log'),

-- Ловушки/нестандартные случаи (реалистичные, чтобы выявить наивные решения)
('candidates_2025_10.csv', 20, 'Contact: bad@-domain.com, +7 912 ABC-67-89, \"node, js\"', 'trap-invalid-email-and-phone'),
('assets_import.csv', 12, 'SKU: 12-AB-!!; qty: one', 'trap-bad-sku');

SELECT id, source_file, line_no, raw_line
FROM hr_import_lines
WHERE raw_line ~ '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';

SELECT id, source_file, line_no, raw_line
FROM hr_import_lines
WHERE raw_line !~ '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';

SELECT id, source_file, line_no, raw_line
FROM hr_import_lines
WHERE source_file = 'import_log.txt' AND raw_line ~* 'error';

SELECT id, source_file, line_no, raw_line
FROM hr_import_lines
WHERE source_file = 'import_log.txt' AND raw_line !~* 'error';

SELECT
    id,
    source_file,
    line_no,
    (regexp_match(raw_line, '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'))[1] AS email
FROM hr_import_lines
WHERE raw_line ~ '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';

SELECT
    id,
    source_file,
    line_no,
    unnest(regexp_matches(raw_line, '[a-zA-Z0-9]{2,}-[a-zA-Z0-9]+(-[a-zA-Z0-9]+)?', 'g')) AS asset_code
FROM hr_import_lines
WHERE raw_line ~ '[a-zA-Z0-9]{2,}-[a-zA-Z0-9]+(-[a-zA-Z0-9]+)?';

SELECT 
    id,
    source_file,
    line_no,
    raw_line,
    regexp_replace(raw_line, '[^\d]', '', 'g') AS normalized_phone
FROM hr_import_lines
WHERE raw_line ~ '[+\d\s()-]{7,}';

SELECT 
    id,
    source_file,
    line_no,
    raw_line,
    regexp_split_to_array(
        regexp_replace(
            regexp_replace(raw_line, 'tags:\s*', '', 'i'),
            '\s*,\s*',
            ','
        ),
        ','
    ) AS tags_array
FROM hr_import_lines
WHERE raw_line ~* 'tags:';

SELECT 
    id,
    source_file,
    line_no,
    field_num,
    regexp_replace(
        regexp_replace(field, '\\"', '', 'g'), 
        '\|\|COMMA\|\|', 
        ',', 
        'g'
    ) AS csv_field
FROM (
    SELECT 
        id,
        source_file,
        line_no,
        raw_line,
        regexp_replace(raw_line, '\\"([^"]*)\\"', 
            regexp_replace('\1', ',', '||COMMA||', 'g'), 
            'g'
        ) AS processed_line
    FROM hr_import_lines
    WHERE source_file = 'payroll_dirty.csv'
) AS prep,
    LATERAL regexp_split_to_table(processed_line, ',')
    WITH ORDINALITY AS t(field, field_num);

SELECT 
    id,
    source_file,
    line_no,
    regexp_replace(raw_line, 'error', 'ERROR', 'gi') AS replaced_log
FROM hr_import_lines
WHERE source_file = 'import_log.txt';