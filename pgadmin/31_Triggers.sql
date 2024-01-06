-- Disparadores (Triggers)

CREATE OR REPLACE FUNCTION tr_verificarnulos()
RETURNS TRIGGER
AS
$$
BEGIN
	IF(NEW.nombre IS NULL OR NEW.app IS NULL)
	THEN
		RAISE EXCEPTION 'LOS DATOS (NOMBRE, APP) NO PUEDEN SER NULOS';
	ELSE
		RETURN NEW;
	END IF;	
END;
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER tr_verificarnulos
	/*
		BEFORE 			-> Antes de la acción que lo disparó (primero validar y después ejecutar la acción)
		AFTER			-> Después de la acción que lo disparó (primero ejecutamos la acción y después validamos)
		INSTEAD OF		-> Tomará el control total y se ejecutarán envez de la acción que los disparó
	*/
BEFORE INSERT -- UPDATE DELETE
ON persona -- NOMBRE DE UNA TABLA 
FOR EACH ROW
EXECUTE PROCEDURE tr_verificarnulos();

SELECT *
FROM persona
ORDER BY id_persona DESC;

INSERT INTO persona (id_persona, id_cgenero, id_direccion, nombre, app, apm, rfc, fecha_nac, correo, telefono)
VALUES (22655, 2, 1, NULL, NULL, NULL, 'HACE88071200', '1988-07-12', 'ematla@ciencias.unam.mx', '5555555555');