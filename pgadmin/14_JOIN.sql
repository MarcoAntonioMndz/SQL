-- JOIN 

-- NATURAL JOIN

SELECT *
FROM persona;

SELECT *
FROM agente;

SELECT *
FROM persona NATURAL JOIN agente
WHERE id_persona > 10200;

-- INNER JOIN 

SELECT *
FROM persona INNER JOIN agente ON agente.id_persona = persona.id_persona;

SELECT *
FROM persona INNER JOIN agente a ON a.id_persona = persona.id_persona;

SELECT *
FROM persona p INNER JOIN agente a ON a.id_persona = p.id_persona;

-- JOIN = INNER JOIN
SELECT *
FROM persona p JOIN agente a ON a.id_persona = p.id_persona;

-- LEFT JOIN

SELECT *
FROM persona LEFT JOIN agente ON agente.id_persona = persona.id_persona;

-- Las personas que no son agentes

SELECT *
FROM persona LEFT JOIN agente ON agente.id_persona = persona.id_persona
WHERE id_agente IS NULL;

SELECT DISTINCT(agente.id_persona)
FROM persona LEFT JOIN agente ON agente.id_persona = persona.id_persona
WHERE id_agente IS NOT NULL;


SELECT *
FROM persona
WHERE id_persona IN (SELECT agente.id_persona 
					 FROM agente);

SELECT *
FROM persona
WHERE id_persona NOT IN (SELECT agente.id_persona 
					 FROM agente);

-- RIGHT JOIN

SELECT *
FROM persona RIGHT JOIN agente ON agente.id_persona = persona.id_persona;

SELECT *
FROM agente RIGHT JOIN persona ON agente.id_persona = persona.id_persona;

-- CROSS JOIN

SELECT *
FROM persona CROSS JOIN agente;

-- FULL OUTER JOIN

SELECT *
FROM persona FULL OUTER JOIN agente ON agente.id_persona = persona.id_persona;


SELECT *
FROM persona p FULL OUTER JOIN agente a ON a.id_persona = p.id_persona;


-- El nombre de la persona que mas polizas tiene

SELECT MAX(total)
FROM (SELECT id_persona, COUNT(id_poliza) total
	  FROM poliza
	  GROUP BY id_persona) T1;


SELECT id_persona
FROM (SELECT id_persona, COUNT(id_poliza) total
	  FROM poliza
	  GROUP BY id_persona) T2
WHERE total = (SELECT MAX(total)
			   FROM (SELECT id_persona, COUNT(id_poliza) total
	  		  		 FROM poliza
	  		   		 GROUP BY id_persona) T1);

-- Consulta completa realizada con subconsultas
SELECT nombre
FROM persona
WHERE id_persona IN (SELECT id_persona
					 FROM (SELECT id_persona, COUNT(id_poliza) total
	 					   FROM poliza
	  					   GROUP BY id_persona) T2
					 WHERE total = (SELECT MAX(total)
			   					    FROM (SELECT id_persona, COUNT(id_poliza) total
	  		  		 	   				  FROM poliza
	  		   		 	   				  GROUP BY id_persona) T1));


SELECT nombre
FROM persona
WHERE id_persona IN (SELECT id_persona
					 FROM (SELECT id_persona, COUNT(id_poliza) total
	 					   FROM poliza
	  					   GROUP BY id_persona) T2
					 WHERE total = (SELECT MAX(total)
			   					    FROM (SELECT id_persona, COUNT(id_poliza) total
	  		  		 	   				  FROM poliza
	  		   		 	   				  GROUP BY id_persona) T1));

-- Consulta con JOIN 
SELECT persona.id_persona, nombre
FROM (SELECT id_persona, COUNT(id_poliza) total
	 FROM poliza
	 GROUP BY id_persona) T2 JOIN persona ON T2.id_persona = persona.id_persona
WHERE total = (SELECT MAX(total)
			   FROM (SELECT id_persona, COUNT(id_poliza) total
	  		  		 FROM poliza
	  		   		 GROUP BY id_persona) T1);