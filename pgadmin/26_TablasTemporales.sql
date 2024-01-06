-- Tablas temporales

CREATE TEMP TABLE prueba1 AS SELECT * FROM persona;

SELECT *
FROM prueba1;

DELETE FROM agente WHERE id_persona = 22655;
DELETE FROM persona WHERE id_persona = 22655;

DELETE FROM agente WHERE id_persona = 22656;
DELETE FROM persona WHERE id_persona = 22656;

-- 22654 -> Tuplas originales
SELECT *
FROM persona
ORDER BY id_persona DESC;

-- 22656 Tuplas
SELECT *
FROM prueba1;