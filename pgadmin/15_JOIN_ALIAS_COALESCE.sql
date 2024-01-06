-- JOIN ALIAS COALESCE  

-- Nombre, apellidos, telefono y total de pólizas de cada tipo para cada persona

/*
Esto estoy esperando:

MARCO, MENDEZ, MORENO, 5555555, 5, 0, 3, 2
*/

-- Total de polizas de gastos médicos por cliente/persona
SELECT id_persona, COUNT(id_poliza_ap_gm) AS gastos
FROM poliza_ap_gm JOIN poliza ON poliza_ap_gm.id_poliza = poliza.id_poliza
GROUP BY id_persona;

-- Total de polizas de vehiculo por cliente/persona
SELECT id_persona, COUNT(id_poliza_vehiculo) AS vehiculo
FROM poliza_vehiculo JOIN poliza ON poliza_vehiculo.id_poliza = poliza.id_poliza
GROUP BY id_persona;

-- Total de polizas de vivienda por cliente/persona
SELECT id_persona, COUNT(id_poliza_vivienda) AS vivienda
FROM poliza_vivienda JOIN poliza ON poliza_vivienda.id_poliza = poliza.id_poliza
GROUP BY id_persona;

-- Total de polizas de vida por cliente/persona
SELECT id_persona, COUNT(id_poliza_vida) AS vida
FROM poliza_vida JOIN poliza ON poliza.id_poliza = poliza_vida.id_poliza
GROUP BY id_persona;


-- Hay que empezar a relacionar las tablas
SELECT nombre, app, apm, telefono, T1.id_persona, T1.gastos
FROM persona LEFT JOIN 
					(SELECT id_persona, COUNT(id_poliza_ap_gm) AS gastos
					FROM poliza_ap_gm JOIN poliza ON poliza_ap_gm.id_poliza = poliza.id_poliza
					GROUP BY id_persona) AS T1 ON persona.id_persona = T1.id_persona;	
					
-- Quiero ceros
SELECT nombre, app, apm, telefono, 
	   CASE WHEN T1.gastos IS NULL THEN 0 ELSE T1.gastos END AS total_gastos, 
	   CASE WHEN T2.vehiculo IS NULL THEN 0 ELSE T2.vehiculo END AS total_vehiculo,
	   COALESCE(vivienda, 0) AS total_vivienda,
	   COALESCE(vida, 0) AS total_vida
FROM persona LEFT JOIN 
					(SELECT id_persona, COUNT(id_poliza_ap_gm) AS gastos
					FROM poliza_ap_gm JOIN poliza ON poliza_ap_gm.id_poliza = poliza.id_poliza
					GROUP BY id_persona) AS T1 ON persona.id_persona = T1.id_persona
			 LEFT JOIN		
					(SELECT id_persona, COUNT(id_poliza_vehiculo) AS vehiculo
					FROM poliza_vehiculo JOIN poliza ON poliza_vehiculo.id_poliza = poliza.id_poliza
					GROUP BY id_persona)  AS T2 ON T2.id_persona = persona.id_persona
			 LEFT JOIN
			 		(SELECT id_persona, COUNT(id_poliza_vivienda) AS vivienda
					FROM poliza_vivienda JOIN poliza ON poliza_vivienda.id_poliza = poliza.id_poliza
					GROUP BY id_persona) AS T3 ON T3.id_persona = persona.id_persona
			 LEFT JOIN
			 		(SELECT id_persona, COUNT(id_poliza_vida) AS vida
					FROM poliza_vida JOIN poliza ON poliza.id_poliza = poliza_vida.id_poliza
					GROUP BY id_persona) AS T4 ON T4.id_persona = persona.id_persona;