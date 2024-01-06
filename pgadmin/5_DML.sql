-- DML 


/*
SELECT  Nos permie indicar el listado de atributos que se desean obtener de la tabla/relación 
		especificada en FROM
		
FROM	Nos permite especificar la tabla/relación de donde extraeremos los datos

WHERE 	Nos permite indicar las restricciones sobre las tuplas de la tabla/relacion a utilizar
*/


-- Todos los atributos de persona

-- Lista de atributos
-- * Podemos obtener todos los atributos
SELECT *
-- Oregen de los datos 
FROM persona


-- id, nombre, app, apm, correo

SELECT id_persona, nombre, app, apm, correo
FROM persona;

-- id, nombre, app, apm, correo de todas las personas cuyo id > 100

SELECT id_persona, nombre, app, apm, correo
FROM persona
WHERE id_persona > 100;

-- id, nombre, app, apm, correo de todas las personas cuyo id < 100

SELECT id_persona, nombre, app, apm, correo
FROM persona
WHERE id_persona < 100;

-- id, nombre, app, apm, correo de todas las personas cuyo id = 100

SELECT id_persona, nombre, app, apm, correo
FROM persona
WHERE id_persona = 100;

-- id, nombre, app, apm, correo de todas las personas cuyo id = 100 > id  100

SELECT id_persona, nombre, app, apm, correo
FROM persona
WHERE id_persona >= 100;

-- id, nombre, app, apm, correo de todas las personas cuyo id = 100 < id  100

SELECT id_persona, nombre, app, apm, correo
FROM persona
WHERE id_persona <= 100;

-- También podemos recuperara los atributos así:

SELECT persona.id_persona
FROM persona;