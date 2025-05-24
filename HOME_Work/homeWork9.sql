/* 1.Для каждого заказа order_id выведите минимальный, максимальный и средний unit_cost. */
SELECT 
    purchase_order_id,
    MIN(unit_cost) OVER (PARTITION BY purchase_order_id) AS min_unit_cost,
    MAX(unit_cost) OVER (PARTITION BY purchase_order_id) AS max_unit_cost,
    AVG(unit_cost) OVER (PARTITION BY purchase_order_id) AS avg_unit_cost
FROM
    purchase_order_details;
    
/* 2.Оставьте только уникальные строки из предыдущего запроса */
SELECT DISTINCT 
	quantity, purchase_order_id,
    MIN(unit_cost) OVER (PARTITION BY purchase_order_id),
    MAX(unit_cost) OVER (PARTITION BY purchase_order_id),
    AVG(unit_cost) OVER (PARTITION BY purchase_order_id)
FROM
    purchase_order_details;
    
/*запрос с помощью GROUP BY*/
SELECT 
    purchase_order_id,
    quantity,
    MIN(unit_cost),
    MAX(unit_cost),
    AVG(unit_cost)
FROM
    purchase_order_details
GROUP BY purchase_order_id , quantity
ORDER BY purchase_order_id;

/* 3.Посчитайте стоимость продукта в заказе как quantity*unit_cost.
Выведите суммарную стоимость продуктов с помощью оконной функции.*/
SELECT 
    *,
    quantity * unit_cost AS product_total,
    SUM(quantity * unit_cost) OVER () AS total_cost_all_orders
FROM 
    purchase_order_details;
   
-- Сделайте то же самое с помощью GROUP BY. 
SELECT 
    SUM(quantity * unit_cost) AS total_cost_all_orders
FROM 
    purchase_order_details;
    
/* 4.Посчитайте количество заказов по дате получения и posted_to_inventory. 
Если оно превышает 1 то выведите '>1' в противном случае '=1'.
Выведите purchase_order_id, date_received и вычисленный столбец */
SELECT 
    purchase_order_id,
    date_received,
    CASE 
        WHEN COUNT(*) OVER (PARTITION BY date_received, posted_to_inventory) > 1 THEN '>1'
        ELSE '=1'
    END AS order_count_flag
FROM 
    purchase_order_details;
    