USE 131224_Leshchenko;

-- Создать кастомные функции
-- 1. Функция для расчета площади круга
DELIMITER //

CREATE FUNCTION circle_area(radius DECIMAL(10,3))
RETURNS DECIMAL(10,3)
DETERMINISTIC
BEGIN
    RETURN PI() * radius * radius;
END //

DELIMITER ;

SELECT circle_area(6);

-- 2. Функция для расчета гипотенузы треугольника
DELIMITER //

CREATE FUNCTION hypotenuse(a DOUBLE, b DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN SQRT(POW(a, 2) + POW(b, 2));
END;
//

DELIMITER ;

SELECT hypotenuse(5, 7);

