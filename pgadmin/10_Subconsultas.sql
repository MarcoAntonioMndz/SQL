-- SUBCONSULTAS
-- Es una consulta cuyo resultado es necesario para que se pueda ejecutar una consulta exterior o principal.

/*
SELECT *
FROM tabla
WHERE atrributo IN - NOT IN /// = < >
	(
	SELECT
	FROM 
	WHERE
	)
*/

-- Nombre y apellidos de aquellas personas que son agentes

SELECT *
FROM persona;

SELECT *
FROM agente;

SELECT DISTINCT id_persona
FROM agente;

SELECT nombre, app, apm
FROM persona
WHERE id_persona IN 
	(
		SELECT DISTINCT id_persona
		FROM agente
	);
	
-- Quiero saber el nombre, app, apm de la persona dueñ@ de la póliza 10,000

SELECT id_persona
FROM poliza
WHERE id_poliza = 10000;

SELECT nombre,app, apm
FROM persona
WHERE id_persona = 
	(
		SELECT id_persona
		FROM poliza
		WHERE id_poliza = 10000
	);
	

-- Obtener el nombre completo de las personas que realizaron algún pago de póliza en al año 2016

SELECT nombre, app, apm
FROM persona;

SELECT id_persona
FROM poliza;

-- id de las polizas que registraron unpago en el año 2016
SELECT DISTINCT id_poliza
FROM pago
WHERE DATE_PART('YEAR', fecha_pago) = 2016;


SELECT DISTINCT id_persona
FROM poliza
WHERE id_poliza IN
	(
		SELECT DISTINCT id_poliza
		FROM pago
		WHERE DATE_PART('YEAR', fecha_pago) = 2016
	);

-- CONSULTA COMPLETA
SELECT nombre, app, apm
FROM persona
WHERE id_persona IN
	(
		SELECT DISTINCT id_persona
		FROM poliza
		WHERE id_poliza IN
			(
				SELECT DISTINCT id_poliza
				FROM pago
				WHERE DATE_PART('YEAR', fecha_pago) = 2016
			)
	);