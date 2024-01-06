-- GROUP BY, FUNCIONES DE AGREGACIÓN, RENOMBRE DE ATRIBUTOS

/* 
Funciones de agregación MIN, MAX, COUNT, SUM, AVG
*/

SELECT id_cgenero, nombre, COUNT(nombre)
FROM persona
GROUP BY id_cgenero, nombre;

-- De qué género hay más personas

SELECT id_cgenero, COUNT(id_persona)
FROM persona
GROUP BY id_cgenero;

SELECT MAX(total) 
FROM
	(SELECT id_cgenero, COUNT(id_persona) AS total
	FROM persona
	GROUP BY id_cgenero) AS T1;

-- Aquí la consulta completa

SELECT id_cgenero
FROM (SELECT id_cgenero, COUNT(id_persona) AS total
	  FROM persona
	  GROUP BY id_cgenero) AS T2
WHERE T2.total = (SELECT MAX(total) 
				  FROM (SELECT id_cgenero, COUNT(id_persona) AS total
						FROM persona
						GROUP BY id_cgenero) AS T1);
	
SELECT genero 
FROM cgenero 
WHERE id_cgenero = (SELECT id_cgenero
					FROM (SELECT id_cgenero, COUNT(id_persona) AS total
	  					  FROM persona
	  					  GROUP BY id_cgenero) AS T2
					WHERE T2.total = (SELECT MAX(total) 
				 					  FROM (SELECT id_cgenero, COUNT(id_persona) AS total
									  FROM persona
									  GROUP BY id_cgenero) AS T1)
					);
					
-- ¿CUál es el nombre más frecuente para los hombres?

SELECT id_cgenero, nombre, COUNT(id_persona)
FROM persona
GROUP BY id_cgenero, nombre;

SELECT id_cgenero
FROM cgenero
WHERE genero LIKE 'Masculino';

SELECT id_cgenero, nombre, COUNT(id_persona) AS total
FROM persona
WHERE id_cgenero = (SELECT id_cgenero
					FROM cgenero
					WHERE genero LIKE 'Masculino'
					)
GROUP BY id_cgenero, nombre;


SELECT MAX(total)
FROM (SELECT id_cgenero, nombre, COUNT(id_persona) AS total
	  FROM persona
	  WHERE id_cgenero = (SELECT id_cgenero
			      		  FROM cgenero
						  WHERE genero LIKE 'Masculino'
						 )
	  GROUP BY id_cgenero, nombre) AS T1;

-- Consulta completa:

SELECT id_cgenero, nombre, total
FROM (SELECT id_cgenero, nombre, COUNT(id_persona) AS total
	  FROM persona
	  WHERE id_cgenero = (SELECT id_cgenero
			      		  FROM cgenero
						  WHERE genero LIKE 'Masculino'
						 )
	  GROUP BY id_cgenero, nombre) AS T2
WHERE T2.total = (SELECT MAX(total)
	   FROM (SELECT id_cgenero, nombre, COUNT(id_persona) AS total
	  		 FROM persona
	  		 WHERE id_cgenero = (SELECT id_cgenero
			      		  		 FROM cgenero
						 		 WHERE genero LIKE 'Masculino'
						 		)
	 		 GROUP BY id_cgenero, nombre) AS T1);

-- Las demás funciones

SELECT MIN(id_persona)
FROM persona;

SELECT MAX(id_persona)
FROM persona;

SELECT AVG(id_persona)
FROM persona;

-- COUNT y SUM

SELECT COUNT(id_persona)
FROM persona;

SELECT COUNT(correo)
FROM persona;

SELECT COUNT(id_persona)
FROM persona
WHERE correo IS NULL;

SELECT SUM(id_persona)
FROM persona;