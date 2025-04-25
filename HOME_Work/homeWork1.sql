-- 1. Выберите все строки из таблицы suppliers. Предварительно подключитесь к базе данных northwind.
SELECT 
    *
FROM
    suppliers;

-- 2. Выберите только те строки из таблицы suppliers где company имеет значение Supplier A.
SELECT 
    *
FROM
    suppliers
WHERE
    company = 'Supplier A';
    
-- 3. Выберите все строки из таблицы purchase_orders.
SELECT 
    *
FROM
    purchase_orders;
    
-- 4. Выберите только те строки из таблицы purchase_orders, где supplier_id = 2.
SELECT 
    *
FROM
    purchase_orders
WHERE
    supplier_id = 2;
    
-- 5. Выберите supplier_id и shipping_fee из purchase_orders там где created_by равно 1 и supplier_id равен 5
SELECT 
    supplier_id, shipping_fee
FROM
    purchase_orders
WHERE
    created_by = 1 AND supplier_id = 5;
   
-- 6. Объясните полученный результат.
/* Поиск в пункте 5 не дал никаких результатов, потому что если created_by равно 1,
 то ему соотвествуют только supplier_id равные 1, 2, 2 */
 
-- 7. Выберите last_name и first_name из таблицы employees там, где адрес address имеет значение 123 2nd
-- Avenue или 123 8th Avenue.
SELECT 
    last_name, first_name, city, address
FROM
    employees
WHERE
    address = '123 2nd Avenue'
        OR address = '123 8th Avenue';
        
-- 8. Напишите запрос двумя способами - с применением оператора OR и оператора IN.
SELECT 
    last_name, first_name, city, address
FROM
    employees
WHERE
    address IN ('123 2nd Avenue' , '123 8th Avenue');

-- 9. Выведите все имена сотрудников, которые содержат английскую букву p в середине фамилии.
SELECT 
    first_name, last_name, job_title
FROM
    employees
WHERE
    last_name LIKE '%p%';
    
-- 10. Выберите все строки из таблицы orders там, где нет информации о shipper_id.
SELECT 
    *
FROM
    orders
WHERE
    shipper_id IS NULL;
    
 