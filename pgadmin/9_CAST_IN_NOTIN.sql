-- CAST, IN, NOT IN,FUNCIONES DE FECHA, CONSTANTES

-- CAST permite convertir el tipo de datos de un valor

SELECT CAST (1 AS TEXT);

SELECT CAST ('23' AS INTEGER);

SELECT CAST ('Marco' AS INTEGER);

SELECT CAST (id_persona AS VARCHAR(8))
FROM persona;

SELECT CAST (id_persona AS INTEGER)
FROM persona;

SELECT CAST('2023-11-27' AS DATE);

-- IN NOT IN

SELECT nombre, app, apm
FROM persona
WHERE id_persona IN (3,5);

SELECT nombre, app, apm
FROM persona
WHERE id_persona NOT IN (3,5);

-- Fuciones de Fecha CURRENT_DAY, CURRENT_TIME, DATE_PART

SELECT CURRENT_DATE;

SELECT CURRENT_TIME;

SELECT DATE_PART('DAY', CAST('2023-11-27' AS DATE));

SELECT DATE_PART('MONTH', CAST('2023-11-27' AS DATE));

SELECT DATE_PART('YEAR', CAST('2023-11-27' AS DATE));

-- Veamos como funciona con una consulta

SELECT fecha_pago
FROM pago;

SELECT DATE_PART('DAY', fecha_pago)
FROM pago;

SELECT DATE_PART('MONTH', fecha_pago)
FROM pago;

SELECT DATE_PART('YEAR', fecha_pago)
FROM pago;

-- Agregar una constante a la consulta

SELECT 'Nombre completo: ', nombre, app, apm, 0
FROM persona;

SELECT 'Nombre completo: ', nombre, app, apm, 0, CURRENT_DATE, CURRENT_TIME
FROM persona;

