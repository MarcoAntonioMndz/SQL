-- Indices

CREATE INDEX indx_nombre ON tabla (atributo);

CREATE INDEX indx_persona_app ON persona(app);


SELECT *
FROM persona
WHERE apm LIKE 'E%';

SELECT *
FROM poliza;

SELECT *
FROM agente;

CREATE INDEX indx_persona_apm ON persona(apm);

-- Indices compuestos 

CREATE INDEX indx_persona_app_apm ON persona(app, apm);


SELECT *
FROM persona 
WHERE app LIKE '%M%' AND apm LIKE '%C%'