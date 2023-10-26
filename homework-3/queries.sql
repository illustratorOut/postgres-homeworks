-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

SELECT c.company_name, CONCAT(first_name, ' ',last_name) AS emploee
FROM customers c
INNER JOIN orders o USING(customer_id)
INNER JOIN employees e ON o.employee_id = e.employee_id
AND c.city = 'London'
AND e.city = 'London'
AND o.ship_via = 2
-- 2 = United Package

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone
FROM products p
INNER JOIN suppliers s USING(supplier_id)
WHERE p.category_id IN (2, 4)
AND p.discontinued = 0
AND p.units_in_stock < 25
ORDER BY units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа

SELECT company_name FROM customers c
WHERE NOT EXISTS(SELECT * FROM orders o WHERE c.customer_id = o.customer_id)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.

SELECT DISTINCT product_name
FROM products p
WHERE EXISTS(SELECT * FROM order_details o
			 WHERE o.product_id = p.product_id
			 AND o.quantity = 10)