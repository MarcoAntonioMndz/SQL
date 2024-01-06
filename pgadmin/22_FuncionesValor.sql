-- Funciones que devuelven un valor

SELECT AGE(fecha_nac)
FROM persona;

/*
 Función.
 -----------------------------------------------------
 Una rutina definida y almacenada en esquema de la BD.
 Podrá recibir valores (parámetros) y devuelve un valor.
*/

CREATE FUNCTION fnc_nombre(pvalor1 	INTEGER,
						   pvalor2 	INTEGER)
	RETURNS INTEGER --- VARCHAR TEXT DATE TIME DECIMAL DOUBLE PRECISION  
AS 
$$
BEGIN 
	-- RUTINA
	
	-- Que va a devolver
	RETURN -1;
END;
$$
	LANGUAGE 'plpgsql' VOLATILE;

SELECT *
FROM fnc_nombre();

SELECT *
FROM fnc_nombre(1, 2);




CREATE FUNCTION fnc_nombre(pvalor1 	VARCHAR(8),
						   pvalor2 	VARCHAR(8))
	RETURNS INTEGER --- VARCHAR TEXT DATE TIME DECIMAL DOUBLE PRECISION  
AS 
$$
BEGIN 
	-- RUTINA
	
	-- Que va a devolver
	RETURN -1;
END;
$$
	LANGUAGE 'plpgsql' VOLATILE; 
	

CREATE FUNCTION fnc_nombre(pvalor1 	INTEGER,
						   pvalor2 	VARCHAR(8))
	RETURNS INTEGER --- VARCHAR TEXT DATE TIME DECIMAL DOUBLE PRECISION  
AS 
$$
BEGIN 
	-- RUTINA
	
	-- Que va a devolver
	RETURN -1;
END;
$$
	LANGUAGE 'plpgsql' VOLATILE; 

SELECT *
FROM fnc_nombre(100, 1);

SELECT *
FROM fnc_nombre(100, 'Marco');

SELECT *
FROM fnc_nombre('Marco', 'Mendez');

/*
 POSGRESQL permite la sobrecarga de funciones; es decir, podemos tener tantas funciones 
 como desees que tengan el mismo nombre y el mismo número de parámetros pero que la 
 combinación respecto al orden del tipo de datos de los parámetros sea diferente.
*/

/*
 Total de polizas por tipo de póliza, total de pólizas y porcentaje que reresena cada
 total de tipo respecto al total ded polizas existente.
 Obtener el porcentaje como resultado de una función.
 CREATE FUNCTION porcentaje(totalr, totalg)
*/

SELECT tipo, totalt, totalg, fnc_porcentaje(CAST(totalt AS INTEGER), CAST(totalg AS INTEGER)) AS porcentaje
FROM(SELECT 'GASTOS' AS tipo, COUNT(id_poliza_ap_gm) AS totalt, (SELECT COUNT(id_poliza) FROM poliza) AS totalg
	FROM poliza_ap_gm
	UNION ALL
	SELECT 'VIDA', COUNT(id_poliza_vida), (SELECT COUNT(id_poliza) FROM poliza)
	FROM poliza_vida
	UNION ALL
	SELECT 'AUTO', COUNT(id_poliza_vehiculo), (SELECT COUNT(id_poliza) FROM poliza)
	FROM poliza_vehiculo
	UNION ALL
	SELECT 'CASA', COUNT(id_poliza_vivienda), (SELECT COUNT(id_poliza) FROM poliza)
	FROM poliza_vivienda) AS T1;


CREATE FUNCTION fnc_porcentaje(ptotal1	INTEGER,
							  ptotal2	INTEGER)
	RETURNS DECIMAL				
AS
$$
DECLARE vresultado DECIMAL; 

BEGIN

	vresultado = (CAST(ptotal1 * 100 AS DECIMAL)/ CAST(ptotal2 AS DECIMAL));
	
	RETURN vresultado;
	
END;
$$
	LANGUAGE 'plpgsql' VOLATILE;


SELECT * FROM fnc_porcentaje(25, 100);
SELECT * FROM fnc_porcentaje(25, 30000);