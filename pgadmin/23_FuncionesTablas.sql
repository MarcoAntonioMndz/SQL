-- Funciones que devuelven tablas 

/*
 Función que permitirá obtener el nombre completo y id de los clientes
*/

CREATE FUNCTION fnc_nombrecompletoclientes()
RETURNS TABLE(onombrecompleto TEXT, oid INTEGER)
AS
$$
BEGIN
	RETURN QUERY SELECT nombre || ' ' || app || ' ' || apm AS nombrecompleto, id_poliza AS idclientepoliza
				 FROM persona JOIN poliza ON persona.id_persona = poliza.id_persona;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;

SELECT *
FROM fnc_nombrecompletoclientes();


/*
 Cuando ejecutamos una sentencia en SQL
 1.- Revisión sint+actica
 2.- Revisión semántica
 3.- Los posibles planes de ejecución 
 4.- Elección del plan "óptimo"
 ------------------------------------------------
 5.- Ejecución
 6.- Entrega del resultado
 
 Los primeros 4 pasos sólo se hacen una vez al crear la función.
*/

/*
 Nombre de los clientes que cuentan con pólizas por un año especifico (año como parámetro).
 2010, 2011, 2012
*/

CREATE VIEW  vw_clientes2010 AS
	SELECT nombre 
	FROM persona JOIN poliza ON poliza.id_persona = persona.id_persona
	WHERE EXTRACT(YEAR FROM fecha_emision) = 2010;

SELECT *
FROM vw_clientes2010;


CREATE FUNCTION fnc_recuperapolizasano(pano INTEGER)
RETURNS TABLE(onombre VARCHAR(128))
AS
$$
BEGIN
	RETURN QUERY SELECT nombre
				 FROM persona JOIN poliza ON poliza.id_persona = persona.id_persona
				 WHERE EXTRACT(YEAR FROM fecha_emision) = pano;
END;
$$
LANGUAGE 'plpgsql' VOLATILE; 

SELECT *
FROM fnc_recuperapolizasano(2010);

SELECT *
FROM fnc_recuperapolizasano(2011);

SELECT *
FROM fnc_recuperapolizasano(2012);