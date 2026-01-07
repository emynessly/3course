DROP TABLE employees;

CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    department TEXT NOT NULL,
    position TEXT NOT NULL,
    salary NUMERIC(10, 2) NOT NULL CHECK(salary >= 30000 AND salary <= 120000),
    hire_date DATE NOT NULL CHECK(hire_date >= '2000-01-01' AND hire_date <= CURRENT_DATE)
);

INSERT INTO employees (full_name, department, position, salary, hire_date) VALUES
('Иван Петров', 'Sales', 'Senior Sales Manager', 90000, '2018-01-01'),
('Анна Смирнова', 'Global Sales', 'Senior Account Executive', 110000, '2020-06-15'),
('Джон Миллер', 'sales operations', 'Senior Analyst', 85000, '2022-12-31'),
('Мария Иванова', 'Sales', 'Junior Sales Manager', 60000, '2021-03-10'),
('Алекс Браун', 'Sales', 'Senior Consultant', 95000, '2017-12-31'),
('Елена Соколова', 'Marketing', 'Marketing Specialist', 55000, '2019-04-20'),
('Дмитрий Волков', 'Marketing', 'SEO Manager', 70000, '2021-07-01'),
('Ольга Кузнецова', 'Marketing', 'Content Manager', 50000, '2020-02-14'),
('Сергей Иванов', 'Marketing', 'Marketing Intern', 60000, '2022-05-05'),
('Нина Уайт', 'Marketing', 'Brand Manager', 72000, '2018-11-11'),
('Паул Грин', 'Marketing', 'Junior Marketer', 49000, '2019-09-09'),
('Андрей Попов', 'Support', 'Support Trainee', 40000, '2014-05-01'),
('Кейт Уилсон', 'Support', 'Technical Trainee', 42000, '2013-08-20'),
('Роман Орлов', 'Support', 'Support Engineer', 50000, '2014-03-03'),
('Люси Адамс', 'Support', 'Support Trainee', 38000, '2015-01-01'),
('Макс Тейлор', 'Engineering', 'Senior Software Engineer', 120000, '2019-10-10'),
('София Ли', 'Engineering', 'Software Engineer', 110000, '2021-01-15'),
('Игорь Морозов', 'Engineering', 'DevOps Engineer', 115000, '2017-06-06'),
('Наталия Федорова', 'HR', 'HR Manager', 65000, '2018-02-02'),
('Питер Джонсон', 'HR', 'Recruiter', 60000, '2020-12-12'),
('Эмили Кларк', 'Sales Europe', 'Senior Sales Director', 115000, '2019-09-09'),
('Виктор Хьюго', 'Support', 'Customer Support Specialist', 45000, '2016-04-04'),
('Денис Блэк', 'Marketing', 'Senior Marketing Analyst', 68000, '2022-03-03'),
('Лаура Кинг', 'Sales', 'Sales Assistant', 48000, '2021-08-08'),
('Олег Романов', 'Engineering', 'QA Engineer', 90000, '2022-02-22');

SELECT *
FROM employees
WHERE department ILIKE '%sales%'
AND position ILIKE 'Senior%'
AND hire_date BETWEEN '2018-01-01' AND '2022-12-31'
ORDER BY full_name;

UPDATE employees
SET salary = salary *1.1
WHERE department = 'Marketing'
AND salary BETWEEN 50000 AND 70000
AND POSITION NOT ILIKE '%intern%';

DELETE FROM employees
WHERE department = 'Support'
AND hire_date < '2015-01-01'
AND POSITION ILIKE '%trainee%';