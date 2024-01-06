-- Ejemplos de funciones 1

/*
 Recuperar el top n de las personas que cuentan con más pólizas (sin repetición).
*/

----------------------------------------------------
CREATE FUNCTION fnc_recuperaTopsin(ptop	INTEGER)
RETURNS TABLE(oidpersona	INTEGER, 
			  ototal 		INTEGER)
AS 
$$
BEGIN
	RETURN QUERY SELECT  id_persona, total
				 FROM (SELECT poliza.id_persona, CAST(COUNT(id_poliza) AS INTEGER) AS total 
					   FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
					   GROUP BY poliza.id_persona) AS T1
				 ORDER BY total DESC
				 LIMIT ptop;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;
-----------------------------------------------------


SELECT *
FROM fnc_recuperatopsin(1);

SELECT *
FROM fnc_recuperatopsin(1000);

SELECT *
FROM fnc_recuperatopsin(3726);


/*
 Recuperar el top n de las personas que cuentan con más pólizas (con repetición).
*/

----------------------------------------------------
CREATE FUNCTION fnc_recuperaTopRepeticion(ptop	INTEGER)
RETURNS TABLE(oidpersona	INTEGER,
			 otoal			INTEGER,
			 orank			INTEGER)
AS
$$
BEGIN
	RETURN QUERY
		WITH cte_toprepeticion AS (
		SELECT  id_persona, total, CAST(RANK() OVER(ORDER BY total DESC) AS INTEGER) AS ranking
		FROM (SELECT poliza.id_persona, CAST(COUNT(id_poliza) AS INTEGER) AS total 
			  FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
			  GROUP BY poliza.id_persona) AS T1
		ORDER BY total DESC
		)

		SELECT *
		FROM cte_toprepeticion
		WHERE ranking = (SELECT ranking
						FROM cte_toprepeticion
						OFFSET (ptop - 1) ROWS FETCH NEXT 1 ROWS ONLY);
END;
$$
LANGUAGE 'plpgsql' VOLATILE;
----------------------------------------------------

SELECT *
FROM fnc_recuperatoprepeticion(3);


/*
 Paginar resultados, resultados de la pagina "n"... datos de las personas.
*/

----------------------------------------------------
CREATE OR REPLACE FUNCTION fnc_paginaresultados(ptamano	INTEGER,
									   			ppagina	INTEGER)
RETURNS TABLE(oid			INTEGER,
			 onombre		VARCHAR,
			 oapp			VARCHAR,
			 ocorreo		VARCHAR)
AS
$$
BEGIN
	RETURN QUERY
		SELECT id_persona, nombre, app, apm
		FROM persona
		ORDER BY id_persona ASC
		OFFSET ((ppagina - 1) * ptamano) ROWS FETCH NEXT ptamano ROWS ONLY;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;
----------------------------------------------------

SELECT *
FROM fnc_paginaresultados(10, 1);

SELECT *
FROM fnc_paginaresultados(10, 2);