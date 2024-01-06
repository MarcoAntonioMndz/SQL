-- Procedimientos almacenados

SELECT *
FROM pago
ORDER BY id_monto DESC;

--------------------------------
CREATE PROCEDURE sp_actualizaMonto(pid		INTEGER, -- ID de la transacción id_monto
								  pvalor	NUMERIC) -- Monto del pago
AS
$$
BEGIN
	/*
	 INSERT
	 
	 UPDATE
	 
	 DELETE
	*/
	UPDATE pago SET monto = pvalor WHERE id_monto = pid;
	
	COMMIT; 
END;
$$
LANGUAGE 'plpgsql';
--------------------------------


SELECT *
FROM pago
ORDER BY id_monto DESC;

CALL sp_actualizamonto(318104, 1838.40);


--------------------------------
CREATE OR REPLACE PROCEDURE transferencia(pidcuenta1		INTEGER,
							   			  pidcuenta2		INTEGER,
							   			  pmonto			NUMERIC)
AS
$$
BEGIN
	UPDATE cuenta SET saldo = saldo - pmonto WHERE id_cuenta = pidcuenta1;
	
	UPDATE cuenta SET saldo = saldo + pmonto WHERE id_cuenta = pidcuenta2;
	
	COMMIT;
END;
$$
LANGUAGE 'plpgsql';
--------------------------------

CREATE TABLE cuenta(
id_cuenta		INTEGER,
saldo			NUMERIC);

INSERT INTO cuenta(id_cuenta, saldo) VALUES (1, 100.00);
INSERT INTO cuenta(id_cuenta, saldo) VALUES (2, 80.00);

SELECT *
FROM cuenta;

CALL transferencia(1, 2, 40);

DROP PROCEDURE transferencia;