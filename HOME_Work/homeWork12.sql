/* 1. Вывести id департамента , в котором работает сотрудник, в зависимости от Id сотрудника */
SELECT name, department_id
FROM employees
WHERE id = 3;


/* 2. Создайте хранимую процедуру get_employee_age, которая принимает id сотрудника (IN-параметр) и возвращает его возраст через OUT-параметр. */
DELIMITER $$

CREATE PROCEDURE get_employee_age(
    IN emp_id INT,
    OUT emp_age INT
)
BEGIN
    SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE())
    INTO emp_age
    FROM employees
    WHERE id = emp_id;
END $$

DELIMITER ;


-- Где TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) — считает полное количество лет между датой рождения и сегодняшним днем.


/* 3. Создайте хранимую процедуру increase_salary, которая принимает зарплату сотрудника (INOUT-параметр) и уменьшает ее на 10%. */
DELIMITER $$

CREATE PROCEDURE increase_salary(INOUT salary DECIMAL(10,2))
BEGIN
    SET salary = salary * 0.90;
END $$

DELIMITER ;

SET @s = 5000;
CALL increase_salary(@s);
SELECT @s;  