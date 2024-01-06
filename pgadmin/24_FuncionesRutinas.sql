-- Funciones que devuelven rutinas

/*
 Función que registre a un nuevo agente, asumir que la persona también es nueva
 para la BD y que nos proporcionará el nombre de la aseguradora.
*/

SELECT *
FROM persona;

-- 1 Masculino | 2 Femenino
SELECT *
FROM cgenero;

-- 27 | "Grupo Nacional Provincial, S.A.B."
SELECT *
FROM aseguradora;


DROP FUNCTION fnc_registrapersonaagente(
pgenero			VARCHAR(16),
pdireccion		INTEGER,
pnombre			VARCHAR(32),
papp			VARCHAR(32),
papm			VARCHAR(32),
prfc			VARCHAR(13),
pfecha			DATE,
pcorreo			VARCHAR(32),
ptelefono		VARCHAR(16),
paseguradora 	VARCHAR(50)
)	 

CREATE FUNCTION fnc_registrapersonaagente(
pgenero			VARCHAR(16),
pdireccion		INTEGER,
pnombre			VARCHAR(32),
papp			VARCHAR(32),
papm			VARCHAR(32),
prfc			VARCHAR(13),
pfecha			DATE,
pcorreo			VARCHAR(32),
ptelefono		NUMERIC,
paseguradora 	VARCHAR(50)
)	
RETURNS INTEGER
AS
$$
DECLARE vidpersona		INTEGER;
DECLARE	vidagente		INTEGER;
DECLARE vidgenero		INTEGER;
DECLARE vidaseguradora	INTEGER;

BEGIN
	vidpersona = ((SELECT MAX(id_persona) FROM persona) + 1);
	
	vidgenero = (SELECT id_cgenero FROM cgenero WHERE genero LIKE pgenero);
	
	INSERT INTO persona (id_persona, id_cgenero, nombre, app, apm, rfc, fecha_nac, correo, telefono)
	VALUES (vidpersona, vidgenero, UPPER(pnombre), UPPER(papp), UPPER(papm), UPPER(prfc), pfecha, pcorreo, ptelefono);
	
	vidagente = ((SELECT MAX(id_agente) FROM agente) + 1);
	
	vidaseguradora = (SELECT id_aseguradora FROM aseguradora WHERE nombre_aseguradora LIKE paseguradora);
	
	INSERT INTO agente (id_agente, id_persona, id_aseguradora, fecha_inicio) 
	VALUES (vidagente, vidpersona, vidaseguradora, CURRENT_DATE);
	
	RETURN 1;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;

-- 391
SELECT *
FROM agente 
ORDER BY id_agente DESC;

-- 22654
SELECT *
FROM persona 
ORDER BY id_persona DESC;

DELETE
FROM persona
WHERE id_persona = 22655;

SELECT *
FROM fnc_registrapersonaagente('Masculino', 0, 'marco', 'mendez', 'moreno', 
							   'memm980219pe2', '1998-02-19', 'marcoa@ciencias.unam.mx', 
							   5555555550, 'Grupo Nacional Provincial, S.A.B.');