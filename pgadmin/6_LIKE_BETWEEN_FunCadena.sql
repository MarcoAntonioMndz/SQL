-- LIKE, BETWEEN, FUCIONES DE CADENA

-- Concatenar "cadena1" + "cadena2"  = "cadena1cadena2"

-- ||
-- Las cadenas en Postgrsql ' '

SELECT id_aseguradora, nombre_aseguradora
FROM aseguradora;

-- Quiero concatenar el id con el nombre de la aseguradora

SELECT id_aseguradora || nombre_aseguradora
FROM aseguradora;

-- Idaseguradora - Nombre de la aseguradora

SELECT id_aseguradora || ' - ' || nombre_aseguradora
FROM aseguradora;

-- Nombre completo de las personas: Nombre App Apm

SELECT 'Nombre completo: ' || nombre || ' ' || app || ' ' || apm
FROM persona;

-- LIKE
-- Permite comparar valores en cadenas 

-- LIKE -> -

SELECT id_persona, nombre, app, correo
FROM persona
WHERE nombre LIKE 'Irina'; 

-- NOT LIKE -> -

SELECT id_persona, nombre, app, correo
FROM persona
WHERE nombre NOT LIKE 'Irina'; 

-- Verificar la existencia de un valor o de una cadena al principio del valor de una cadena
-- LIKE 'algo%'

SELECT id_persona, nombre, correo
FROM persona
WHERE nombre LIKE 'E%'

SELECT id_persona, nombre, correo
FROM persona
WHERE nombre LIKE 'Er%'

-- case sensitive Puede identificar entre mayúsculas y minúsculas 

SELECT id_persona, nombre, correo
FROM persona
WHERE nombre LIKE 'ER%'

-- Transformar mayúsculas y minúsculas

SELECT UPPER('marco')

SELECT UPPER(nombre)
FROM persona;

SELECT nombre
FROM persona;

SELECT id_persona, nombre, correo
FROM persona
WHERE UPPER(nombre) LIKE 'ER%';

SELECT id_persona, UPPER(nombre), correo
FROM persona
WHERE UPPER(nombre) LIKE 'ER%';

-- LIKE '%algo';

SELECT *
FROM aseguradora
WHERE nombre_aseguradora LIKE '%a';

SELECT *
FROM aseguradora
WHERE nombre_aseguradora LIKE '%a' OR nombre_aseguradora LIKE '%A';

SELECT *
FROM aseguradora
WHERE UPPER(nombre_aseguradora) LIKE '%A';

SELECT *
FROM aseguradora
WHERE LOWER(nombre_aseguradora) LIKE '%A';

SELECT *
FROM aseguradora
WHERE LOWER(nombre_aseguradora) LIKE '%a';

-- LIKE '%algo%'
-- Todos los datos de las aseguradoras que contienen la letra n en su nombre

SELECT *
FROM aseguradora
WHERE LOWER(nombre_aseguradora) LIKE '%n%';

-- substring

SELECT SUBSTRING('MARCO' FROM 1 FOR 3);

SELECT SUBSTRING(app FROM 2 FOR 2)
FROM persona;

-- BETWEEN incluye los extremos  

SELECT id_persona, nombre, correo
FROM persona
WHERE id_persona BETWEEN 1000 and 5000;
WHERE id_persona >= 1000 and id_persona <= 5000;