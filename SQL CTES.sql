USE northwind;

/*1 Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.*/
WITH id_nombre_cliente AS (
SELECT customer_id, company_name
FROM customers)

SELECT *
FROM id_nombre_cliente;

/*2 Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".*/
WITH id_nombre_cliente AS (
SELECT customer_id, company_name
FROM customers
WHERE country = 'Germany')

SELECT *
FROM id_nombre_cliente;

/*3 En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha y la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name). */

WITH datos_cliente AS (
SELECT customer_id, company_name
FROM customers)

SELECT o.order_id, o.customer_id, o.order_date, d.company_name
FROM orders AS o
JOIN datos_cliente AS d
ON d.customer_id = o.customer_id;

/*4 Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.*/
WITH datos_cliente AS (
SELECT customer_id, company_name
FROM customers)

SELECT o.customer_id, d.company_name, COUNT(o.order_id) AS numero_facturas
FROM orders AS o
JOIN datos_cliente AS d
ON d.customer_id = o.customer_id
GROUP BY o.customer_id;

/*5 Cuál la cantidad media pedida de todos los productos ProductID. Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/
 
 SELECT  p.product_name, AVG(od.quantity) AS media
 FROM products AS p
 JOIN order_details AS od
 ON p.product_id = od.product_id
 GROUP BY p.product_name;
 





