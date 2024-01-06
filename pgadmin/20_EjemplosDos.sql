-- Ejemplos de consultas 2

/*
 Correos electrónicos de los clientes en caso de ser nulo, se debe mostrar la cadena '--' (guión-guión).
*/

SELECT DISTINCT CASE WHEN correo IS NULL THEN '--' ELSE correo END 
FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona;

SELECT DISTINCT COALESCE(correo, '--')
FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona;


/*
 Total de pólizas por tipo de póliza, total de pólizas y porcentaje que representa cada total de tipo
 respecto al total de pólizas.
*/

SELECT tipo, totalt, CAST(totalt*100 AS DECIMAL)/CAST(total AS DECIMAL) AS porcentaje, total
FROM (SELECT 'CASA' AS tipo, COUNT(id_poliza_vivienda) AS totalt, (SELECT COUNT(id_poliza) FROM poliza) AS total 
	FROM poliza_vivienda
	UNION ALL
	SELECT 'AUTO', COUNT(id_poliza_vehiculo), (SELECT COUNT(id_poliza) FROM poliza) AS total
	FROM poliza_vehiculo
	UNION ALL
	SELECT 'VIDA', COUNT(id_poliza_vida), (SELECT COUNT(id_poliza) FROM poliza) AS total
	FROM poliza_vida
	UNION ALL
	SELECT 'GASTOS', COUNT(id_poliza_ap_gm), (SELECT COUNT(id_poliza) FROM poliza) AS total
	FROM poliza_ap_gm) AS T1;


/*
 Total de pólizas por cliente, total de pólizas y porcentaje que representa cada total de cliente
 respecto al total de pólizas.
*/

SELECT idcliente, totalc, CAST(totalc*100 AS DECIMAL)/CAST(total AS DECIMAL) AS porcentaje, total
FROM  (SELECT poliza.id_persona AS idcliente, COUNT(id_poliza) AS totalc, (SELECT COUNT(id_poliza) FROM poliza) AS total
	FROM persona JOIN poliza ON poliza.id_persona = persona.id_persona
	GROUP BY poliza.id_persona) AS T1;

SELECT idcliente, totalc, CAST(totalc*100 AS DECIMAL)/CAST(total AS DECIMAL) AS porcentaje, total
FROM (SELECT  DISTINCT poliza.id_persona AS idcliente, COUNT(id_poliza) OVER(PARTITION BY poliza.id_persona) AS totalc, COUNT(id_poliza) OVER() AS total
	  FROM persona JOIN poliza ON poliza.id_persona = persona.id_persona) AS T1;