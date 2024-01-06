-- IF - CASE

/*
 Devolver el id de una persona dado su correo electrónico y en caso de que 
 el correo no se encuentre se deberá devolver un valor -1.
*/

CREATE FUNCTION fnc_recuperaIDCorreo(pcorreo	VARCHAR(50))
RETURNS INTEGER
AS
$$
DECLARE vidpersona	INTEGER;
BEGIN
	IF((SELECT id_persona FROM persona WHERE correo LIKE pcorreo) IS NOT NULL)
	THEN
		-- Se cumple la condición de IF
		vidpersona = (SELECT id_persona FROM persona WHERE correo LIKE pcorreo);
		
		RETURN vidpersona;
	ELSE
		-- NO se cumple la condición de IF
		RETURN -1;
	END IF;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;

------------------

SELECT *
FROM fnc_recuperaidcorreo('marco@ciencias.unam.mx');

SELECT *
FROM fnc_recuperaidcorreo('marco@ciencias');



/*
 Devolver el tipo de póliza dado el id de la póliza.
*/

CREATE FUNCTION fnc_recuperaTipoPoliza(pidpoliza	INTEGER)
RETURNS	TEXT
AS
$$
BEGIN
	CASE
		WHEN((SELECT id_poliza_vivienda FROM poliza_vivienda WHERE id_poliza = pidpoliza) IS NOT NULL) THEN
			RETURN 'VIVIENDA';
		WHEN((SELECT id_poliza_vehiculo FROM poliza_vehiculo WHERE id_poliza = pidpoliza) IS NOT NULL) THEN
			RETURN 'VEHICULO';
		WHEN((SELECT id_poliza_vida FROM poliza_vida WHERE id_poliza = pidpoliza) IS NOT NULL) THEN
			RETURN 'VIDA';
		WHEN((SELECT id_poliza_ap_gm FROM poliza_ap_gm WHERE id_poliza = pidpoliza) IS NOT NULL) THEN
			RETURN 'GASTOS';
		ELSE
			RETURN 'ID NO EXISTE';
	END CASE;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;


SELECT *
FROM fnc_recuperaTipoPoliza(2);

SELECT *
FROM fnc_recuperaTipoPoliza(10000);

SELECT *
FROM fnc_recuperaTipoPoliza(1);

SELECT *
FROM fnc_recuperaTipoPoliza(3);

SELECT *
FROM fnc_recuperaTipoPoliza(28888);

SELECT *
FROM fnc_recuperaTipoPoliza(30001);