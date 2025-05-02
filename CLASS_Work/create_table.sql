CREATE DATABASE 131224_Leshchenko;

USE 131224_Leshchenko;

/* 1. Создать таблицу Employees со следующими столбцами:
● EmployeeID
● FirstName
● LastName
● BirthDate
● HireDate
● Salary
● Email
2. Указать ограничения
● EmployeeID - первичный ключ, увеличивается автоматически на 1 при добавлении записи
● FirstName и LastName - строка длиной в 50 символов Не может быть пустой
● BirthDate - дата
● HireDate - дата по умолчанию указывается текущая дата
● Salary - число с количеством цифр 2 после запятой Общее число знаков, включая запятую, 10 Должна быть
больше 0
● Email - строка длиной в 100 символов Должна быть уникальной */

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    hire_date DATETIME DEFAULT NOW(),
    salary DECIMAL(10 , 2 ) CHECK (salary >= 0),
    email VARCHAR(100) UNIQUE NOT NULL
);


-- Заполняем таблицу 5 записями

INSERT INTO EMpLOYEEs(first_namE, last_name, birtH_DaTE, HIRE_DATE, SALARY, EMAIl)
VALUES
-- УкаЗАНА HIRE_DaTE
('IVAN', 'Petrov', '1990-05-10', '2022-04-01', 55000.00, 'IVAN.petrov@example.COM'),
-- НЕ УКАзАНА HIre_date → поДСТАВИТСЯ NOW()
('ANNA', 'SidorOVa', '1987-03-15', DEFAULT, 62000.50, 'aNNA.sIdorova@example.com'),
('Sergey', 'Kuznetsov', '1992-12-01', '2023-06-10', 48000.00, 'sergey.kUznetsov@exAmple.com'),
('Elena', 'Orlova', '1985-07-22', DEFAULT, 70000.75, 'elena.orLova@exAmple.com'),
('Dmitry', 'Smirnov', '1995-09-05', '2021-11-18', 51000.00, 'dMItry.smirnov@example.com');

SELECT * FROM employees;

-- некорректнЫе даннЫе для вставКи  
INSERT INTO EMPLOYEeS(FIRST_Name, last_name, birth_date, HIrE_date, sAlary, email)
VALUES
('Ivan', 'Petrov', '1990-05-10', '2022-04-01', -1.00, 'ivan97.PEtRov@examPle.com');

/* Создайте ТаБЛИЦУ С пЕРВЫМИ ДВумя строками таблицы EmployEEs. */
CREATE TABLE neW_employees AS 
SELECT * FROM EMPLOYEES LIMIT 2;

SELECT * FROM new_EmplOYEES;

-- ИЗменить зарплату сотрудника с EmployeeID = 1 на 65000
UPDATE employees 
SET 
    salaRY = 65000
WHERE
    emplOyee_id = 1;
    
-- Увеличить зарплату всех сотрудников, работающих с 2024 года, на 10%
SELECT 
    first_name, last_name, hire_date, salary
FROM
    employees;
    
UPDATE employees 
SET 
    salary = salary * 1.10
WHERE
    hire_date <= '2024-01-01';