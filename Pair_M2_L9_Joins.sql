USE northwind

-- 1. Pedidos por empresa en UK:
-- Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos 
-- ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.
-- Deberéis obtener una tabla similar a esta:

-- ID cliente customer_id
-- nombre empresa company_name
-- numero de pedidos order_id
-- pais ship_country

SELECT `customer_id`, `order_id` , `ship_country`, `company_name`
	FROM `orders` NATURAL JOIN `customers`
	WHERE `ship_country`= "UK"
	COUNT (`company_name`) AS `numero_pedidos`; 
    

