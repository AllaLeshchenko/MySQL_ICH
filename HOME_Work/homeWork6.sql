/* 1. Выведите одним запросом с использованием UNION столбцы id, 
employee_id из таблицы orders и соответствующие им столбцы из таблицы purchase_orders. 
В таблице purchase_orders  created_by соответствует employee_id */
SELECT 
    id, employee_id
FROM
    orders 
UNION 
SELECT 
    id, created_by
FROM
    purchase_orders;


/* 2. Из предыдущего запроса удалите записи там где employee_id не имеет значения. 
Добавьте дополнительный столбец со сведениями из какой таблицы была взята запись */
SELECT 
    id, employee_id, 'orders' AS source
FROM
    orders
WHERE
    employee_id IS NOT NULL 
UNION SELECT 
    id, created_by AS employee_id, 'purchase_orders' AS source
FROM
    purchase_orders
WHERE
    created_by IS NOT NULL;
    
/* 3. Выведите все столбцы таблицы order_details, а также дополнительный столбец payment_method 
из таблицы purchase_orders. Оставьте только заказы для которых известен payment_method */
SELECT 
    o_d.*, p_o.payment_method
FROM
    order_details o_d
        JOIN
    purchase_orders p_o ON o_d.order_id = p_o.id
WHERE
    p_o.payment_method IS NOT NULL;


/* 4. Выведите заказы orders и фамилии клиентов customers для тех заказов, 
по которым были инвойсы таблица invoices */
SELECT 
    o.id AS order_id, o.customer_id, c.last_name
FROM
    orders o
        JOIN
    invoices i ON o.id = i.order_id
        JOIN
    customers c ON o.customer_id = c.id;


/* 5. Подсчитайте количество инвойсов для каждого клиента из предыдущего запроса */
SELECT 
    c.last_name, COUNT(i.id) AS invoice_count
FROM
    orders o
        JOIN
    invoices i ON o.id = i.order_id
        JOIN
    customers c ON o.customer_id = c.id
GROUP BY c.last_name
ORDER BY invoice_count DESC;