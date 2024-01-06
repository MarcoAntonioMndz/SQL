-- Subconsultas que regresan tablas

SELECT *
FROM persona;

-- id de la persona y el nombre completo separado por atributos de las personas

SELECT *
FROM (
	 SELECT id_persona, nombre, app, apm
	 FROM persona
	 ) AS T1;

SELECT *
FROM (
	 SELECT id_persona, nombre, app, apm
	 FROM persona
	 ) T1;

SELECT *
FROM (
	 SELECT id_persona, nombre, app, apm
	 FROM persona
	 ) AS T1
WHERE T1.id_persona = 4;	 