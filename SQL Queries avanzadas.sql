USE northwind;

/*1*/
SELECT MIN(unit_price) AS lowestPrice, 
	   MAX(unit_price) AS highestPrice,
       product_name
FROM products;

/*2*/
SELECT COUNT(product_id) AS numero_productos, AVG(product_id) AS precio_medio
FROM products;

/*3*/
SELECT MAX(freight), MIN(freight), ship_country
FROM orders
WHERE ship_country = 'UK';

/*4*/
SELECT AVG(unit_price) AS precioMedio
FROM products;

SELECT product_name, unit_price
FROM products
WHERE unit_price > 28.87
ORDER BY unit_price DESC;

/*5*  REVISAR, NO ESTOY USANDO BOOLEANO ¿?*/
SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock <1;

/*6*/
SELECT product_name, product_id
FROM products
WHERE units_in_stock >1
ORDER BY product_id DESC
LIMIT 10;

/*7 REVISAR*/
SELECT employee_id, order_id AS pedido_mas_pesado, freight, COUNT(order_id) AS numero_de_pedidos
FROM orders
GROUP BY employee_id
HAVING MAX(freight);

/*11*/
SELECT city, COUNT(city) AS total_empleadas
FROM employees
GROUP BY city
HAVING total_empleadas >= 4;

/*12*/
SELECT order_id, SUM(unit_price*quantity) AS precio_total,
CASE
		WHEN SUM(unit_price*quantity)> 2000 THEN 'Alto'
		ELSE 'Bajo'
	END AS categoria_pedidos
FROM order_details
GROUP BY order_id;
