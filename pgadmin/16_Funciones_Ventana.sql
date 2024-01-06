-- Funciones de ventana

/*
	Nombre y apelllidos de los clientes, número de póliza, monto pagado por la póliza 
	y total pagado en todas las pólizas (considerando las de todos los clientes)
*/


SELECT id_poliza, SUM(monto)
FROM pago
GROUP BY id_poliza;


SELECT nombre, app, apm, poliza.id_poliza, total
FROM poliza JOIN (SELECT id_poliza, SUM(monto) AS total
				  FROM pago
				  GROUP BY id_poliza) AS T1 ON T1.id_poliza = poliza.id_poliza
			JOIN persona ON poliza.id_persona = persona.id_persona;
			
-- Nos falta el total pagado en todas las pólizas
SELECT nombre, app, apm, poliza.id_poliza, total, (SELECT SUM(monto) FROM pago) AS total_global
FROM poliza JOIN (SELECT id_poliza, SUM(monto) AS total
				  FROM pago
				  GROUP BY id_poliza) AS T1 ON T1.id_poliza = poliza.id_poliza
			JOIN persona ON poliza.id_persona = persona.id_persona;

-- Veamos la consulta con funciones de ventana
/*
	Nombre y apelllidos de los clientes, número de póliza, monto de parcialidad, monto pagado por la póliza 
	y total pagado en todas las pólizas (considerando las de todos los clientes)
*/

SELECT nombre, app, apm, poliza.id_poliza, monto, 
	   SUM(monto) OVER(PARTITION BY pago.id_poliza) total_poliza,
	   SUM(monto) OVER() total_global
FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
JOIN pago ON poliza.id_poliza = pago.id_poliza
ORDER BY id_poliza;

-- Vamos a ver que onda con las fechas de pago

SELECT *
FROM pago;

SELECT nombre, app, apm, poliza.id_poliza, fecha_pago, monto, 
	   SUM(monto) OVER(PARTITION BY pago.id_poliza) total_poliza,
	   SUM(monto) OVER() total_global
FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
JOIN pago ON poliza.id_poliza = pago.id_poliza
ORDER BY id_poliza, fecha_pago ASC;