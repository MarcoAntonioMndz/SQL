-- ORDER BY, LIMIT, TRIM

-- ORDER BY

SELECT id_persona, app, nombre
FROM persona
WHERE id_persona > 5000
ORDER BY id_persona;

-- Ascendente Y Descendente

SELECT id_persona, app, nombre
FROM persona
WHERE id_persona > 5000
ORDER BY id_persona ASC;

SELECT id_persona, app, nombre
FROM persona
WHERE id_persona > 5000
ORDER BY id_persona DESC;

-- LIMIT
-- Limitar o restringir el total de tuplas que deseamos recuperar

SELECT *
FROM persona
LIMIT 5;

-- Notar que LIMIT se ejecuta al final de la consulta

SELECT *
FROM persona
ORDER BY id_persona
LIMIT 5;

SELECT *
FROM persona
WHERE id_cgenero = 2
ORDER BY id_persona
LIMIT 5;

SELECT *
FROM persona
WHERE id_cgenero = 2
ORDER BY id_persona DESC
LIMIT 5;

-- TRIM Función para eliminar espacios a la izquierda  a la derecha de un valor cadena
-- Funciones de cadena de Postgresql

SELECT LTRIM('       Marco');
SELECT LTRIM('Marco       ');


SELECT LTRIM(nombre)
FROM persona;

UPDATE persona SET nombre = LTRIM(nombre);

SELECT nombre
FROM persona;

SELECT RTRIM('       Marco');
SELECT RTRIM('Marco       ');

SELECT RTRIM(nombre)
FROM persona;

UPDATE persona SET nombre = RTRIM(nombre);

SELECT TRIM('       Marco');
SELECT TRIM('Marco       ');
SELECT TRIM('      Marco     ');

-- OJO

SELECT TRIM('      Marco Antonio    ');

UPDATE persona SET nombre = TRIM(nombre);





