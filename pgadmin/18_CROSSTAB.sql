-- CROSSTAB 

-- Total de pólizas por año y tipo de póliza

SELECT 'GASTOS' tipo, EXTRACT(YEAR FROM fecha_emision) ano, COUNT(id_poliza_ap_gm) total
FROM poliza JOIN poliza_ap_gm ON poliza.id_poliza = poliza_ap_gm.id_poliza
GROUP BY EXTRACT(YEAR FROM fecha_emision)
UNION ALL
SELECT 'VEHICULO', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vehiculo) total
FROM poliza JOIN poliza_vehiculo ON poliza.id_poliza = poliza_vehiculo.id_poliza
GROUP BY EXTRACT(YEAR FROM fecha_emision)
UNION ALL
SELECT 'VIVIENDA', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vivienda) total
FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
GROUP BY EXTRACT(YEAR FROM fecha_emision)
UNION ALL
SELECT 'VIDA', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vida) total
FROM poliza JOIN poliza_vida ON poliza.id_poliza = poliza_vida.id_poliza
GROUP BY EXTRACT(YEAR FROM fecha_emision)
ORDER BY ano, tipo;

/*
	Me gustaría ver algo así:
	
			| 2000 | 2001 | 2002 | 2003 |
GASTOS		|	
VEHICULO	|
VIDA		|
VIVIENDA	|
*/

-- CROSSTAB

CREATE EXTENSION tablefunc;

-- CROSSTAB cuando recibe 1 parámetro
-- Tabla/resultado de una consulta estará ordenada por el primer y segundo atributo y
-- las posición de los atributos indicará el pivote (que cada vez que camie de valor se generará una nueva tupla),
-- la columna (cada vez que cambie de valor se generará una nueva columna) 
-- y el valor (valor que se ubicará en el renglón, columna). 

SELECT *
FROM CROSSTAB(
	'SELECT ''GASTOS'' tipo, EXTRACT(YEAR FROM fecha_emision) ano, COUNT(id_poliza_ap_gm) total
	FROM poliza JOIN poliza_ap_gm ON poliza.id_poliza = poliza_ap_gm.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	UNION ALL
	SELECT ''VEHICULO'', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vehiculo) total
	FROM poliza JOIN poliza_vehiculo ON poliza.id_poliza = poliza_vehiculo.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	UNION ALL
	SELECT ''VIVIENDA'', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vivienda) total
	FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	UNION ALL
	SELECT ''VIDA'', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vida) total
	FROM poliza JOIN poliza_vida ON poliza.id_poliza = poliza_vida.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	ORDER BY tipo, ano') AS resultado(otipo TEXT, o2000 BIGINT, o2001 BIGINT, o2002 BIGINT, o2003 BIGINT, o2004 BIGINT,
									 o2005 BIGINT, o2006 BIGINT, o2007 BIGINT, o2008 BIGINT, o2009 BIGINT, o2010 BIGINT,
									 o2011 BIGINT, o2012 BIGINT, o2013 BIGINT, o2014 BIGINT, o2015 BIGINT, o2016 BIGINT,
									 o2017 BIGINT);



SELECT DISTINCT EXTRACT(YEAR FROM fecha_emision) ano
FROM poliza
ORDER BY ano; 

SELECT *
FROM CROSSTAB(
	'SELECT ''GASTOS'' tipo, EXTRACT(YEAR FROM fecha_emision) ano, COUNT(id_poliza_ap_gm) total
	FROM poliza JOIN poliza_ap_gm ON poliza.id_poliza = poliza_ap_gm.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	UNION ALL
	SELECT ''VEHICULO'', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vehiculo) total
	FROM poliza JOIN poliza_vehiculo ON poliza.id_poliza = poliza_vehiculo.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	UNION ALL
	SELECT ''VIVIENDA'', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vivienda) total
	FROM poliza JOIN poliza_vivienda ON poliza.id_poliza = poliza_vivienda.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	UNION ALL
	SELECT ''VIDA'', EXTRACT(YEAR FROM fecha_emision), COUNT(id_poliza_vida) total
	FROM poliza JOIN poliza_vida ON poliza.id_poliza = poliza_vida.id_poliza
	GROUP BY EXTRACT(YEAR FROM fecha_emision)
	ORDER BY tipo, ano', 'SELECT DISTINCT EXTRACT(YEAR FROM fecha_emision) ano
	FROM poliza
	ORDER BY ano') AS resultado(otipo TEXT, o2000 BIGINT, o2001 BIGINT, o2002 BIGINT, o2003 BIGINT, o2004 BIGINT,
									 o2005 BIGINT, o2006 BIGINT, o2007 BIGINT, o2008 BIGINT, o2009 BIGINT, o2010 BIGINT,
									 o2011 BIGINT, o2012 BIGINT, o2013 BIGINT, o2014 BIGINT, o2015 BIGINT, o2016 BIGINT,
									 o2017 BIGINT);