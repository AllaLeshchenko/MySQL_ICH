-- 1. Выведите Ваш возраст на текущий день в секундах
SELECT 
    TIMESTAMPDIFF(SECOND,
        '1986-04-09',
        NOW()) AS age_in_seconds;

-- 2. Выведите какая дата будет через 51 день
SELECT DATE_ADD(CURDATE(), INTERVAL 51 DAY) AS date_plus_51_days;

-- 3. Отформатируйте предыдущей запрос - выведите день недели для этой даты Используйте документацию My SQL
SELECT DAYNAME(DATE_ADD(CURDATE(), INTERVAL 51 DAY)) AS weekday_of_date_plus_51;


/* 4.  Подключитесь к базе данных northwind. Выведите столбец с исходной датой создания транзакции transaction_created_date из таблицы inventory_transactions, 
а также столбец полученный прибавлением 3 часов к этой дате */
SELECT 
    transaction_created_date,
    DATE_ADD(transaction_created_date,
        INTERVAL 3 HOUR) AS transaction_plus_3h
FROM
    inventory_transactions;


/* 5. Выведите столбец с текстом  'Клиент с id <customer_id> сделал заказ <order_date>' из таблицы orders

Запрос написать двумя способами - с использованием неявных преобразований, а также с указанием изменения типа данных для столбца customer_id

Внимание В MySQL функция CAST не принимает VARCHAR в качестве параметра для длины. Вместо этого, нужно использовать CHAR для указания длины.
*/
-- Неявное преобразование типов
SELECT 
    CONCAT('Клиент с id ', customer_id, ' сделал заказ ', order_date) AS order_info
FROM orders;

-- С указанием изменения типа данных (явное преобразование)
SELECT 
    CONCAT('Клиент с id ', CAST(customer_id AS CHAR(10)), ' сделал заказ ', order_date) AS order_info
FROM orders;