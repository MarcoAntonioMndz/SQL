-- Ejemplos de funciones 2


/*
 Recuperar el nombre, app, apm, correo y id de la póliza de las pólizas dado un "tipo" de póliza.
*/

-------------------------------------------------
CREATE OR REPLACE FUNCTION fnc_recuperaClientePolizaTipo(pstipo		VARCHAR(16))
RETURNS TABLE (onombre		VARCHAR(32),
			  oapp			VARCHAR(32),
			  oapm			VARCHAR(32),
			  ocorreo		VARCHAR(50),
			  oidpoliza		INTEGER)
AS
$$
BEGIN
	-- AUTO, CASA, VIDA, GASTOS
	CASE
		WHEN pstipo LIKE 'AUTO'
		THEN
			RETURN QUERY
				SELECT nombre, app, apm, correo, poliza.id_poliza
				FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
				JOIN poliza_vehiculo ON poliza_vehiculo.id_poliza = poliza.id_poliza
				ORDER BY app, apm, nombre ASC;
				
		WHEN pstipo LIKE 'CASA'
		THEN
			RETURN QUERY
				SELECT nombre, app, apm, correo, poliza.id_poliza
				FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
				JOIN poliza_vivienda ON poliza_vivienda.id_poliza = poliza.id_poliza
				ORDER BY app, apm, nombre ASC;
				
		WHEN pstipo LIKE 'VIDA'
		THEN
			RETURN QUERY
				SELECT nombre, app, apm, correo, poliza.id_poliza
				FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
				JOIN poliza_vida ON poliza_vida.id_poliza = poliza.id_poliza
				ORDER BY app, apm, nombre ASC;
		WHEN pstipo LIKE 'GASTOS'
		THEN
			RETURN QUERY
				SELECT nombre, app, apm, correo, poliza.id_poliza
				FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona
				JOIN poliza_ap_gm ON poliza_ap_gm.id_poliza = poliza.id_poliza
				ORDER BY app, apm, nombre ASC;
	END CASE;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;
-------------------------------------------------

SELECT *
FROM fnc_recuperaclientepolizatipo('CASA');

SELECT *
FROM fnc_recuperaclientepolizatipo('AUTO');

SELECT *
FROM fnc_recuperaclientepolizatipo('VIDA');

SELECT *
FROM fnc_recuperaclientepolizatipo('GASTOS');



/*
 Recuperar el total de pólizas por tipo dado un año especifíco .
*/

-------------------------------------------------
CREATE OR REPLACE FUNCTION fnc_totalPolizasAno(pano		INTEGER)
RETURNS TABLE(otipo		TEXT,
			 ototal		BIGINT)
AS
$$
BEGIN
	RETURN QUERY
		SELECT 'AUTO' AS tipo, COUNT(poliza.id_poliza) AS total
		FROM poliza JOIN poliza_vehiculo ON poliza_vehiculo.id_poliza = poliza.id_poliza
		WHERE EXTRACT(YEAR FROM fecha_emision) = pano
		UNION
		SELECT 'CASA', COUNT(poliza.id_poliza)
		FROM poliza JOIN poliza_vivienda ON poliza_vivienda.id_poliza = poliza.id_poliza
		WHERE EXTRACT(YEAR FROM fecha_emision) = pano
		UNION
		SELECT 'VIDA', COUNT(poliza.id_poliza)
		FROM poliza JOIN poliza_vida ON poliza_vida.id_poliza = poliza.id_poliza
		WHERE EXTRACT(YEAR FROM fecha_emision) = pano
		UNION
		SELECT 'GASTOS', COUNT(poliza.id_poliza)
		FROM poliza JOIN poliza_ap_gm ON poliza_ap_gm.id_poliza = poliza.id_poliza
		WHERE EXTRACT(YEAR FROM fecha_emision) = pano;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;
-------------------------------------------------

SELECT *
FROM fnc_totalpolizasano(2010);

SELECT *
FROM fnc_totalpolizasano(2011);