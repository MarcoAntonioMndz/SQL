-- DDL
-- CREANDO NUEVAS TABLAS

CREATE TABLE tabla1 (
id			SERIAL,
atributo1	VARCHAR(32),
atributo2	TEXT,
atributo3	DATE,
atributo4	TIME,
atributo5	NUMERIC(5,2)
);

CREATE TABLE tabla2 (
id			SERIAL,
atributo1	VARCHAR(32),
atributo2	TEXT,
atributo3	DATE,
atributo4	TIME,
atributo5	NUMERIC(5,2),
idt1		INTEGER
);

CREATE TABLE tabla3 (
id			SERIAL,
atributo1	VARCHAR(32),
atributo2	TEXT,
atributo3	DATE,
atributo4	TIME,
atributo5	NUMERIC(5,2),
idt1		INTEGER
);

-- CREANOD LLAVES PRIMARIAS Y FORANEAS 

ALTER TABLE tabla1 ADD CONSTRAINT pk_tabla1_id PRIMARY KEY (id);
ALTER TABLE tabla2 ADD CONSTRAINT pk_tabla2_id PRIMARY KEY (id);
ALTER TABLE tabla3 ADD CONSTRAINT pk_tabla3_id PRIMARY KEY (id);

CREATE TABLE tabla4 (
id1	INTEGER,
id2 INTEGER
);

ALTER TABLE tabla4 ADD CONSTRAINT pk_tabla4_id1id2 PRIMARY KEY (id1, id2);

ALTER TABLE tabla2 ADD CONSTRAINT fk_tabla2_idt1_tabla1_id FOREIGN KEY (idt1) REFERENCES tabla1(id);
ALTER TABLE tabla3 ADD CONSTRAINT fk_tabla3_idt1_tabla1_id FOREIGN KEY (idt1) REFERENCES tabla1(id);

-- CAMBIANDO LA ESTRUCTURA DE LAS TABLAS

ALTER TABLE tabla4 ADD COLUMN atributo0 VARCHAR(16);
ALTER TABLE tabla4 ADD COLUMN atributo1 DATE;

ALTER TABLE tabla4 DROP COLUMN atributo0;

ALTER TABLE tabla4 ADD COLUMN nombre VARCHAR(64);
ALTER TABLE tabla4 ADD COLUMN app VARCHAR(64);
ALTER TABLE tabla4 ADD COLUMN apm VARCHAR(64);

ALTER TABLE tabla4 DROP COLUMN app;

ALTER TABLE tabla4 ADD CONSTRAINT unq_tabla4_atributo0 UNIQUE (atributo0);

CREATE TABLE tabLa5(
	atributo1 SERIAL,
	atributo2 VARCHAR(12)
);

INSERT INTO tabla5 (atributo2) VALUES ('MARCO'); 
INSERT INTO tabla5 (atributo2) VALUES ('MARCO'); 

SELECT *
FROM tabla5;

-- Tenemos un error porque elos valores en la tabla no son unicos, hay que modificar 
-- la tabla. 

ALTER TABLE tabla5 ADD CONSTRAINT unq_tabla5_atributo2 UNIQUE (atributo2);

DELETE FROM tabla5;

INSERT INTO tabla5 (atributo2) VALUES ('MARCO'); 

ALTER TABLE tabla5 ADD CONSTRAINT unq_tabla5_atributo2 UNIQUE (atributo2);

SELECT *
FROM tabla5;

ALTER SEQUENCE tabla5_atributo1_seq RESTART WITH 1;

INSERT INTO tabla5 (atributo2) VALUES ('MARCO'); 

-- Resitricción de dominio

ALTER TABLE tabla2 ADD CONSTRAINT chk_tabla2_atributo5 CHECK (atributo5 > 20);

-- Eliminando restricciones 

ALTER TABLE tabla2 DROP CONSTRAINT fk_tabla2_idt1_tabla1_id;

ALTER TABLE tabla2 DROP COLUMN idt1;

ALTER TABLE tabla3 DROP COLUMN idt1;


ALTER TABLE tabla2 ALTER COLUMN atributo2 TYPE INTEGER USING (atributo2::INTEGER);

ALTER TABLE tabla3 ALTER COLUMN atributo2 TYPE INTEGER USING (atributo2::INTEGER);

ALTER TABLE tabla3 ALTER COLUMN atributo2 SET NOT NULL;
ALTER TABLE tabla3 ALTER COLUMN atributo3 SET NOT NULL;

ALTER TABLE tabla3 ALTER COLUMN atributo3 DROP NOT NULL;

INSERT INTO tabla3 (atributo1, atributo2, atributo3, atributo4) 
VALUES ('MARCO', 3, NULL, NULL);

SELECT *
FROM tabla3;

INSERT INTO tabla3 (atributo1, atributo3, atributo4) 
VALUES ('MENDEZ', NULL, NULL);
