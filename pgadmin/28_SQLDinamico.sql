-- SQL Dinámico

/*
 Ejecución de cadenas como sentencias de SQL.
 
 cadena -> es SQL
*/

-- Actualizar el valor de cualquier atributo de tipo cadena de cualquier
-- tupla para cualquier tabla.

UPDATE persona SET nombre		  = 'NUEVO VALOR' WHERE id_persona = 100;
UPDATE agente  SET id_aseguradora = 4 			  WHERE id_agente  = 3;
UPDATE poliza  SET fecha_emision  = '2020-07-01'  WHERE id_poliza  = 100;


-----------------------------
CREATE OR REPLACE FUNCTION fnc_actualizacadena(ptabla		VARCHAR,
											  patributo		VARCHAR,
											  pvalor		VARCHAR,
											  ptupla		INTEGER)
RETURNS INTEGER
AS
$$
BEGIN
	EXECUTE 'UPDATE ' || ptabla || ' SET ' || patributo || ' = '''|| pvalor ||''' WHERE id_' || ptabla || ' = ' || ptupla || ';';
	
	RETURN 1;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;
-----------------------------

SELECT *
FROM persona
WHERE id_persona = 4;

SELECT * FROM fnc_actualizacadena('persona', 'nombre', 'MARCO ANTONIO', 4);
SELECT * FROM fnc_actualizacadena('persona', 'app', 'MENDEZ', 4);
SELECT * FROM fnc_actualizacadena('persona', 'apm', 'MORENO', 4);