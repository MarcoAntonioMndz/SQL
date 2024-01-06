-- UNION, INERSECT 

SELECT 1 
UNION
SELECT 1;

SELECT 1 
UNION ALL
SELECT 1;

SELECT nombre, app
FROM persona
WHERE id_cgenero = 1
UNION
SELECT nombre, app
FROM persona
WHERE id_cgenero = 2;

SELECT nombre, app
FROM persona
WHERE id_cgenero = 1
UNION ALL
SELECT nombre, app
FROM persona
WHERE id_cgenero = 2;

-- ERROR 

SELECT nombre, app, apm
FROM persona
WHERE id_cgenero = 1
UNION ALL
SELECT nombre, app
FROM persona
WHERE id_cgenero = 2;

-- INTERSECT

SELECT 1
INTERSECT
SELECT 1;

SELECT nombre, app
FROM persona 
WHERE id_cgenero = 1
INTERSECT
SELECT nombre, app
FROM persona 
WHERE id_cgenero = 2;

SELECT nombre, app
FROM persona 
INTERSECT
SELECT nombre, app
FROM persona;

