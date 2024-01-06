-- Expresiones de tablas comunes (CTE´s)

-- ¿Cuál es el color del que existen más pólizas de auto?

-- Subconsultas
SELECT color
FROM ccolor
WHERE id_ccolor IN (
					SELECT T2.id_ccolor
					FROM (SELECT id_ccolor, COUNT(id_poliza_vehiculo) AS total
						  FROM poliza_vehiculo
						  GROUP BY id_ccolor) AS T2
					WHERE total = (SELECT MAX(total)
								   FROM (SELECT id_ccolor, COUNT(id_poliza_vehiculo) AS total
										 FROM poliza_vehiculo
										 GROUP BY id_ccolor) AS T1));  
										
-- JOIN										
SELECT color
FROM (SELECT id_ccolor, COUNT(id_poliza_vehiculo) AS total
	  FROM poliza_vehiculo
	  GROUP BY id_ccolor) AS T2 JOIN ccolor ON T2.id_ccolor = ccolor.id_ccolor
WHERE total = (SELECT MAX(total)
			   FROM (SELECT id_ccolor, COUNT(id_poliza_vehiculo) AS total
					 FROM poliza_vehiculo
					 GROUP BY id_ccolor) AS T1);	

-- Tablas comunes

-- Con subconsultas
WITH cte_polizasporcolor AS (
	SELECT id_ccolor, COUNT(id_poliza_vehiculo) AS total
	FROM poliza_vehiculo
	GROUP BY id_ccolor)
	
SELECT color
FROM ccolor
WHERE id_ccolor IN (SELECT id_ccolor
					FROM cte_polizasporcolor
					WHERE total = (SELECT MAX(total)
								  FROM cte_polizasporcolor));

-- Con JOIN
WITH cte_polizasporcolor AS (
	SELECT id_ccolor, COUNT(id_poliza_vehiculo) AS total
	FROM poliza_vehiculo
	GROUP BY id_ccolor)
	
SELECT color
FROM cte_polizasporcolor JOIN ccolor ON cte_polizasporcolor.id_ccolor = ccolor.id_ccolor
WHERE total = (SELECT MAX(total)
			  FROM cte_polizasporcolor);


-- Nombre y apellidos de la persona que cuenta con más pólizas de vida

-- Con subconsultas
WITH cte_polizasvidaporpersona AS (
	SELECT id_persona, COUNT(id_poliza_vida) total
	FROM poliza JOIN poliza_vida ON poliza_vida.id_poliza = poliza.id_poliza
	GROUP BY id_persona)

SELECT nombre, app, apm
FROM persona
WHERE id_persona IN (SELECT id_persona
					FROM cte_polizasvidaporpersona 
					WHERE total = (SELECT MAX(total)
								   FROM cte_polizasvidaporpersona));

-- Con JOIN 
WITH cte_polizasvidaporpersona AS (
	SELECT id_persona, COUNT(id_poliza_vida) total
	FROM poliza JOIN poliza_vida ON poliza_vida.id_poliza = poliza.id_poliza
	GROUP BY id_persona)

SELECT nombre, app, apm
FROM cte_polizasvidaporpersona JOIN persona ON cte_polizasvidaporpersona.id_persona = persona.id_persona
WHERE total = (SELECT MAX(total)
			   FROM cte_polizasvidaporpersona);