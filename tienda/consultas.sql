USE tienda;

DESCRIBE clientes;
DESCRIBE compras;
DESCRIBE productos;
DESCRIBE proveedores;

SHOW tables;

INSERT INTO clientes VALUES ("MEMM980219HDF", "Marco Antonio", "Méndez Moreno", "San Pedro Mártir, Tlalpan, CDMX", "1998-02-19");
INSERT INTO clientes VALUES ("ARPO8795LP24P", "Juanito", "Pérez", "San Andrés, Tlalpan, CDMX", "1990-09-22");
SELECT * FROM clientes;

INSERT INTO proveedores VALUES ("PUKJML89752PL", "Andrea López", "Taxqueña, CDMX");
INSERT INTO productos VALUES (NULL, "Motocicleta 150", 20000, "PUKJML89752PL");

SELECT * FROM productos;