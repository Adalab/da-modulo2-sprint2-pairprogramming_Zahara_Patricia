USE northwind

/*1. Pedidos por empresa en UK:
	Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos 
    pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/
	-- ID cliente customer_id
	-- nombre empresa company_name
	-- numero de pedidos order_id
	-- pais ship_country NO, es country

SELECT `c`.`company_name` AS `NombreEmpresa`, `c`.`customer_id` AS `Identificador`, COUNT(DISTINCT`o`.`customer_id`) AS `NumeroPedidos`
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`country` = "UK"
    GROUP BY `o`.`customer_id`

    
/*2. Productos pedidos por empresa en UK por año:
	Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie 
	de consultas adicionales. La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa 
	cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido.
	Para ello hará falta hacer 2 joins. */
 
 SELECT `c`. `company_name` AS `NombreEmpresa`, YEAR(`o`. `order_date`) AS `Año`, SUM(`od`. `quantity`) AS `NumObjetos`
	FROM `customers` AS `c`
    INNER JOIN `orders` AS `o`
    INNER JOIN `order_details` AS `od`
    #ON??
    WHERE `c`.`country` = "UK"
    GROUP BY `Año`,`NombreEmpresa`;
 
 
/*3. Mejorad la query anterior:
	Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa 
	cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 
	15% nos sale como 0.15.*/

	# SELECT `c`.`company_name`AS `NombreEmpresa`, YEAR(`o`.`order_date`) AS `Año`, SUM(`od`.`quantity`) AS `NumObjetos`, SUM(`od`.`unit_price`*0.15,`od`.`unit_price`-(`od`.`unit_price`*0.15) * `od`.`quantity`) AS `DineroTotal`
    SELECT `c`.`company_name`AS `NombreEmpresa`, YEAR(`o`.`order_date`) AS `Año`, SUM(`od`.`quantity`) AS `NumObjetos`, SUM(`od`.`unit_price` * `od`.`quantity`- `od`.`discount`) AS `DineroTotal`
		FROM `customers` AS `c`
		INNER JOIN `orders` AS `o`
		INNER JOIN `order_details` AS `od`
		WHERE `c`.`country` = "UK"
		GROUP BY `Año`,`NombreEmpresa`;
 

 /*4. BONUS: Pedidos que han realizado cada compañía y su fecha:
	Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han
	pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.*/
    
    SELECT `company_name`, `o`.`order_id`, `order_date`, `country`
		FROM `customers` AS `c`
		INNER JOIN `orders` AS `o`
		ON `c`.`customer_id` = `o`.`customer_id`;
    
/*5. BONUS: Tipos de producto vendidos:
	Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto,
	y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
	Pista Necesitaréis usar 3 joins.*/
    SELECT `c`.`category_id`, `c`.`category_name`, `p`.`product_name`, `p`.`unit_price`*`p`.`units_on_order` AS `Importe_total`
		FROM `categories` AS `c`
		INNER JOIN `products` AS `p`
		ON `c`.`category_id` = `p`.`category_id`
		HAVING `Importe_total` >0;
      
    
/*6. Qué empresas tenemos en la BBDD Northwind:
	Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.*/
	
    SELECT `c`.`company_name`, `o`.`order_id`, `o`.`order_date`
		FROM `customers` AS `c`
		NATURAL JOIN `orders` AS `o`;


/*7. Pedidos por cliente de UK:
	Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada cliente del propio
	Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía
	cliente junto con el número de pedidos.*/
	
    SELECT `c`.`company_name`, COUNT(`o`.`order_id`) AS total_pedidos, `c`.`country`
		FROM `customers` as `c`
        INNER JOIN `orders` as `o`
        ON `c`.`customer_id` = `o`.`customer_id`
        GROUP BY (`o`.`customer_id`)
        HAVING `c`.`country` = 'UK';
        
 
/*8. Empresas de UK y sus pedidos:
	También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) 
	junto con los ID de todos los pedidos que han realizado y la fecha del pedido.*/
        
	 SELECT `c`.`company_name`, `o`.`order_id`, `o`.`order_date`, `c`.`country`
		FROM `customers` AS `c`
		LEFT JOIN `orders` AS `o`
		ON `c`.`customer_id` = `o`.`customer_id`
        WHERE `c`.`country` = 'UK'
		UNION
		SELECT `c`.`company_name`, `o`.`order_id`, `o`.`order_date`, `c`.`country`
		FROM `orders` AS `o`
		LEFT JOIN `customers` AS `c`
		ON `c`.`customer_id` = `o`.`customer_id`
		WHERE `c`.`country` = 'UK';         
        
 
/*9. Empleadas que sean de la misma ciudad: TIENE ERROR!!!!!!
	Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las 
	empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas.
	Investiga el resultado, ¿sabes decir quién es el director?*/
	 SELECT a.first_name AS `Nombre empleadas`,a.last_name AS `Apellido Empleadas`,a.city AS `Ciudad Empleadas`,a.country AS `País Empleadas`, 
     b.first_name AS `Nombre Supervisora`,b.last_name AS `Apellido Supervisora`
		 FROM employees AS a
		 JOIN employees AS b
		 ON a.employee_id = b.reports_to;
 

/*10.BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no: TIENE ERROR!!!!!!!!
	Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. 
    Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido (si existe).*/
 SELECT o.order_id, o.order_date, c.company_name
 FROM orders AS o
 LEFT JOIN customers AS c
 ON o.customer_id = c.customer_id
 UNION
 SELECT o.order_id, o.order_date, c.company_name
 FROM orders AS o
 RIGHT JOIN customers AS c
 ON o.customer_id = c.customer_id;
 
SELECT c.company_name, o.order_date, o.order_id
 FROM orders AS o
 LEFT JOIN customers AS c
 ON o.customer_id = c.customer_id
 UNION
 SELECT o.order_id, o.order_date, c.company_name
 FROM orders AS o
 RIGHT JOIN customers AS c
 ON o.customer_id = c.customer_id;
 
 
 
 
 
 
  