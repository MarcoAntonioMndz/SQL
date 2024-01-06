-- Vistas

CREATE VIEW vw_datospersonas AS
	SELECT nombre, app, apm, correo
	FROM persona;
	
/*
 Tabla virtual se llamará vw_datospersonas estará definida por:
 	SELECT nombre, app, apm, correo
	FROM persona;
--------------------------------------------------------------------
 Almacenaremos en la BD la consulta:
 	SELECT nombre, app, apm, correo
	FROM persona;
 y la llamaremos vw_datos persona
*/
	
CREATE VIEW vw_datospersonas AS
	SELECT nombre, app, apm, correo
	FROM persona;


SELECT *
FROM vw_datospersonas;


SELECT *
FROM (SELECT nombre, app, apm, correo
	 FROM persona) AS vw_datospersonas;

CREATE VIEW vw_datosclientes AS
	SELECT nombre, app, apm, correo, id_poliza, fecha_inicio, fecha_fin
	FROM persona JOIN poliza ON poliza.id_persona = persona.id_persona;

SELECT *
FROM vw_datosclientes;


CREATE VIEW datospersona AS
	SELECT nombre AS nom, app AS PATERNO, apm AS materno, correo AS mail, rfc AS id
	FROM persona;

SELECT *
FROM datospersona;


CREATE VIEW datospolizacliente  AS
	SELECT id_poliza AS id, nombre AS nom, app AS paterno, apm AS materno, fecha_inicio AS fi, fecha_fin AS ff
	FROM persona JOIN poliza ON poliza.id_persona = persona.id_persona;


SELECT *
FROM datospolizacliente;	