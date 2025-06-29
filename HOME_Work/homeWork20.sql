-- 1.Подключитесь к базе данных hr (которая находится на удаленном сервере). 

USE hr;


-- 2.Выведите количество сотрудников в базе

SELECT COUNT(*) AS employee_count FROM employees;



-- 3.Выведите количество департаментов (отделов) в базе

SELECT COUNT(*) AS department_count FROM departments;


-- 4.Подключитесь к базе данных World (которая находится на удаленном сервере).

USE world;


-- 5.Выведите среднее население в городах Индии (таблица City, код Индии - IND)

SELECT AVG(Population) AS avg_population 
FROM city 
WHERE CountryCode = 'IND';


-- 6.Выведите минимальное население в индийском городе и максимальное.

SELECT MIN(Population) AS min_population, MAX(Population) AS max_population
FROM city
WHERE CountryCode = 'IND';


-- 7.Выведите самую большую площадь территории.

SELECT Name, SurfaceArea 
FROM country 
ORDER BY SurfaceArea DESC 
LIMIT 1;


-- 8.Выведите среднюю продолжительность жизни по странам. 

SELECT AVG(LifeExpectancy) AS avg_life_expectacy
FROM country
WHERE LifeExpectancy IS NOT NULL;


-- Найдите самый населенный город (подсказка: использовать подзапросы)

SELECT Name, Population 
FROM city 
WHERE Population = (
    SELECT MAX(Population) 
    FROM city
);











