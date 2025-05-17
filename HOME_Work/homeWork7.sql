/* 1. Вывести названия продуктов таблица products, включая количество заказанных единиц quantity для
каждого продукта таблица order_details. 
Решить задачу с помощью cte и подзапроса*/
WITH cte_get_sum_quantity_by_product AS 
(SELECT product_id, SUM(quantity) AS sum_quantity_by_product_id
FROM order_details
GROUP BY product_id)
SELECT products.product_name, cte_get_sum_quantity_by_product.sum_quantity_by_product_id
FROM products
LEFT JOIN cte_get_sum_quantity_by_product
ON products.id = cte_get_sum_quantity_by_product.product_id;

-- подзапрос
SELECT 
    p.product_name,
    (
        SELECT SUM(od.quantity)
        FROM order_details od
        WHERE od.product_id = p.id
    ) AS sum_quantity_by_product_id
FROM products p;


/* 2.  Найти все заказы таблица orders, сделанные после даты самого первого заказа клиента Lee таблица customers. */
SELECT 
    *
FROM
    orders
WHERE
    order_date > (SELECT 
            MIN(o.order_date)
        FROM
            orders o
                JOIN
            customers c ON o.customer_id = c.id
        WHERE
            c.last_name = 'Lee');
            
      
/* 3. Найти все продукты таблицы  products c максимальным target_level */
SELECT 
    *
FROM
    products
WHERE
    target_level = (SELECT 
            MAX(target_level)
        FROM
            products); 