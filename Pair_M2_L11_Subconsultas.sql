use northwind

/*1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.*/

SELECT order_id, customer_id, employee_id, order_date, required_date
	FROM orders AS `od1`
    
    SELECT order_date GROUP employees 




/*3. Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/

SELECT product_id, product_name, category_id
	FROM products
	WHERE category_id IN (SELECT category_id
							FROM categories
							WHERE category_name = "Beverages");


/*4. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales.*/

SELECT country
	FROM customers AS `c` GROUP BY country
    HAVING c.country NOT IN (SELECT s.country
							FROM suppliers AS `s` GROUP BY country);
                            

/*5. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread".
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.*/

SELECT order_id, customer_id
	FROM orders 
    WHERE order_id IN (SELECT order_id
						FROM order_details
						WHERE quantity > 20 AND product_id = 6);

/*6. Extraed los 10 productos más caros.
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.*/














