USE northwind;

/*1. Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B". 
Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.  NO FUNCIONA!!! */
SELECT city, company_name, contact_name
	FROM customers
	WHERE city LIKE 'A%'
	OR city LIKE 'B%';

/*2. Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades que empiezan por "L".*/
SELECT c.city, c.company_name, c.contact_name, COUNT(o.order_id) AS total_pedidos
	FROM customers AS c 
	INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
    GROUP BY (company_name) 
    HAVING city LIKE 'L%';
    
/*3. Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.*/
SELECT contact_name, contact_title, company_name
FROM customers
WHERE contact_title NOT LIKE '%Sales%';

/*4.Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto. */
SELECT contact_name
FROM customers
WHERE contact_name NOT LIKE '_a%';

/*5. Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores 
que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, 
además de la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en nuestra respuesta. 
La columna Relationship no existe y debe ser creada como columna temporal. Para ello añade el valor que le quieras 
dar al campo y utilizada como alias Relationship.*/
SELECT city, company_name, contact_name, 'Cliente' AS relationship
FROM customers
UNION
SELECT city, company_name, contact_name, 'Proveedor' AS relationship
FROM suppliers;

/*6. Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".*/
SELECT *
FROM `categories`
WHERE `description`LIKE '%sweet%' OR '%Sweet%';

/*7 Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD:
💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? 
Tendremos que combinar dos columnas usando concat para unir dos columnas.*/

SELECT contact_name as Nombre
FROM customers 
UNION ALL
SELECT CONCAT (first_name,' ',last_name) AS Nombre
FROM employees;


