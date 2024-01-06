-- OFFSET, FETCH


-- OFFSET
-- Descartará las rimeras n tuplas y devolverá todas las tuplas siguientes de la consulta resultado

SELECT *
FROM persona
OFFSET 5 ROWS;

SELECT *
FROM persona
ORDER BY id_persona ASC
OFFSET 5 ROWS;

-- FETCH NEXT
-- Indicar el número de tuplas a recupar después de un descarte

SELECT *
FROM persona
ORDER BY id_persona ASC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT *
FROM persona
ORDER BY id_persona ASC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT *
FROM persona
ORDER BY id_persona ASC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;