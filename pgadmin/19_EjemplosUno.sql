-- Ejemplos de consultas 1

-- Nombre y apellidos de las personas que cuentan con polizas de vida y poliza de auto

--12,574 uplas
SELECT nombre, app, apm
FROM poliza JOIN persona ON poliza.id_persona = persona.id_persona
WHERE id_poliza IN (SELECT poliza_vida.id_poliza FROM poliza_vida) 
OR id_poliza  IN (SELECT poliza_vehiculo.id_poliza FROM poliza_vehiculo); 

-- 7,825
SELECT nombre, app, apm
FROM persona  
WHERE id_persona IN (SELECT poliza.id_persona FROM poliza_vehiculo JOIN poliza ON poliza_vehiculo.id_poliza = poliza.id_poliza)
OR id_persona IN (SELECT poliza.id_persona FROM poliza_vida JOIN poliza ON  poliza_vida.id_poliza = poliza.id_poliza);

-- 7,825
SELECT DISTINCT nombre, app, apm
FROM poliza JOIN persona ON poliza.id_persona = persona.id_persona
WHERE id_poliza IN (SELECT poliza_vida.id_poliza FROM poliza_vida) 
OR id_poliza  IN (SELECT poliza_vehiculo.id_poliza FROM poliza_vehiculo); 

-- 7,825
SELECT DISTINCT nombre, app, apm
FROM persona  
WHERE id_persona IN (SELECT poliza.id_persona FROM poliza_vehiculo JOIN poliza ON poliza_vehiculo.id_poliza = poliza.id_poliza)
OR id_persona IN (SELECT poliza.id_persona FROM poliza_vida JOIN poliza ON  poliza_vida.id_poliza = poliza.id_poliza);

-- Para asegurarnos de que son personas únicas hay que aplicar el DISTINCT a un atributo de forma inteligente;es decir, id_persona
-- 7,825
SELECT DISTINCT persona.id_persona, nombre, app, apm
FROM poliza JOIN persona ON poliza.id_persona = persona.id_persona
WHERE id_poliza IN (SELECT poliza_vida.id_poliza FROM poliza_vida) 
OR id_poliza  IN (SELECT poliza_vehiculo.id_poliza FROM poliza_vehiculo); 


-- Total de pólizas por tipo de póliza emitidas después del año 2014

SELECT 'VIDA' AS TIPO, COUNT(id_poliza_vida) AS TOTAL
FROM poliza_vida
WHERE id_poliza IN (SELECT poliza.id_poliza FROM poliza WHERE DATE_PART('YEAR', fecha_emision) > 2014)
UNION ALL
SELECT 'CASA', COUNT(poliza_vivienda)
FROM poliza_vivienda
WHERE id_poliza IN (SELECT poliza.id_poliza FROM poliza WHERE DATE_PART('YEAR', fecha_emision) > 2014)
UNION ALL
SELECT 'GASTOS', COUNT(poliza_ap_gm)
FROM poliza_ap_gm
WHERE id_poliza IN (SELECT poliza.id_poliza FROM poliza WHERE DATE_PART('YEAR', fecha_emision) > 2014)
UNION ALL
SELECT 'AUTO', COUNT(poliza_vehiculo)
FROM poliza_vehiculo
WHERE id_poliza IN (SELECT poliza.id_poliza FROM poliza WHERE DATE_PART('YEAR', fecha_emision) > 2014);


-- Edades de los clientes que tienen más pólizas de vivienda que el promedio de polizas de vivienda por cliente

--id_persona con el total de polizas de vivienda
SELECT id_persona, COUNT(id_poliza_vivienda) AS totalvivienda
FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
GROUP BY id_persona;

-- Promedio de polizaz de vivienda por cliente
SELECT AVG(totalvivienda) 
FROM (SELECT id_persona, COUNT(id_poliza_vivienda) AS totalvivienda
	 FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
	 GROUP BY id_persona) AS T1;


SELECT id_persona
FROM(SELECT id_persona, COUNT(id_poliza_vivienda) AS total
	 FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
	 GROUP BY id_persona) AS T2
WHERE total > (SELECT AVG(totalvivienda) 
			   FROM (SELECT id_persona, COUNT(id_poliza_vivienda) AS totalvivienda
					  FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
					  GROUP BY id_persona) AS T1);


-- Veamos las edades
SELECT AGE(fecha_nac)
FROM persona
WHERE id_persona IN (SELECT id_persona
					FROM(SELECT id_persona, COUNT(id_poliza_vivienda) AS total
						 FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
						 GROUP BY id_persona) AS T2
					WHERE total > (SELECT AVG(totalvivienda) 
								   FROM (SELECT id_persona, COUNT(id_poliza_vivienda) AS totalvivienda
										  FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
										  GROUP BY id_persona) AS T1));

-- Tablas comunes
WITH cte_polizascasaxcliente AS (
	SELECT  id_persona, COUNT(id_poliza_vivienda) AS total
	FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
	GROUP BY id_persona)

SELECT DISTINCT AGE(fecha_nac)
FROM persona
WHERE id_persona IN (SELECT id_persona
					FROM cte_polizascasaxcliente 
					WHERE total > (SELECT AVG(total) FROM cte_polizascasaxcliente));
					

WITH cte_polizascasaxcliente AS (
	SELECT  id_persona, COUNT(id_poliza_vivienda) AS total
	FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
	GROUP BY id_persona)

SELECT DISTINCT AGE(fecha_nac)
FROM cte_polizascasaxcliente JOIN persona ON cte_polizascasaxcliente.id_persona = persona.id_persona
WHERE total > (SELECT AVG(total) FROM cte_polizascasaxcliente);