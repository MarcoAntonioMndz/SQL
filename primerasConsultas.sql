CREATE DATABASE dept_emp;
USE dept_emp;

CREATE TABLE dept(
deptno NUMERIC(2) PRIMARY KEY,
dname VARCHAR(12) UNIQUE,
loc VARCHAR(11) NOT NULL);

DESCRIBE dept;

INSERT INTO dept(deptno, dname,loc) VALUES(10,'ACCOUNTING','NEW_YORK');
INSERT INTO dept(deptno, dname,loc) VALUES(20,'RESEARCH','DALLAS');
INSERT INTO dept(deptno, dname,loc) VALUES(30,'SALES','CHICAGO');
INSERT INTO dept(dname,deptno,loc) VALUES('OPERATIONS',40,'BOSTON');

/*SENTENCIA SELECT
SELECT * |columna1, columna2,...
FROM nombre-tabla
[WHERE condición]
[GROUP BY columna1,columna2 ...]
[HAVING condición-selección-grupos]
[ORDEN BY columna1 [DESC], columna2 [DESC], ...]
*/

SELECT * FROM dept;

SELECT loc, dname FROM dept;

SELECT * FROM dept WHERE deptno < 30;

CREATE TABLE emp(
empno NUMERIC(4) PRIMARY KEY,
ename VARCHAR(11) NOT NULL,
job VARCHAR(13) NOT NULL,
mgr NUMERIC(4),
hiredate DATE NOT NULL,
sal NUMERIC(7,2) NOT NULL,
comm NUMERIC(7,2),
deptno NUMERIC(2),
-- Restricción en emp_deptno_dept_deptno_fk llave foranea de la tabla dept
CONSTRAINT emp_deptno_detp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept (deptno),
-- Restrcción en emp_mgr_fk llave forania de la tabla emp 
CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp (empno));

DESCRIBE emp;

INSERT INTO emp VALUES(7839, 'KING', 'PRESIDENT', NULL, '2011-11-17', 5000, NULL, 10);
INSERT INTO emp VALUES(7698, 'BLAKE','MANAGER',7839,'2011-05-01',2850,NULL,30);
INSERT INTO emp VALUES(7782,'CLARK','MANAGER',7839,'2011-06-09',2450,NULL,10);
INSERT INTO emp VALUES(7566,'JONES','MANAGER', 7839, '2011-04-02',2975,NULL,20);
INSERT INTO emp VALUES(7654,'MARTIN','SALESMAN',7698, '2011-09-28',1250,1400,30);
INSERT INTO emp VALUES(7499,'ALLEN', 'SALESMAN',7698, '2011-02-20',1600,300, 30);
INSERT INTO emp VALUES(7844,'TURNER','SALESMAN',7698, '2011-09-08',1500,0, 30);
INSERT INTO emp VALUES(7900,'JAMES', 'CLERK',7698, '2011-12-03',950,NULL,30);
INSERT INTO emp VALUES(7521,'WARD','SALESMAN',7698, '2011-02-22',1250,500, 30);
INSERT INTO emp VALUES(7902,'FORD','ANALYST', 7566, '2011-12-03',3000,NULL,20);
INSERT INTO emp VALUES(7369,'SMITH', 'CLERK',7902, '2010-12-17',800,NULL, 20);
INSERT INTO emp VALUES(7788,'SCOTT', 'ANALYST', 7566, '2012-12-09',3000,NULL,20);
INSERT INTO emp VALUES(7876,'ADAMS', 'CLERK', 7788, '2012-01-12',1100,NULL,20);
INSERT INTO emp VALUES(7934,'MILLER','CLERK',7782, '2012-01-23',1300,NULL,10);

SELECT * FROM emp;
SELECT ename, hiredate, sal FROM emp;

CREATE TABLE salgrade(
    grade NUMERIC(1) PRIMARY KEY,
    losal NUMERIC(6,2) NOT NULL,
    hisal NUMERIC(6,2) NOT NULL
    );
    
DESCRIBE salgrade;

INSERT INTO salgrade VALUES(1,700,1200);
INSERT INTO salgrade VALUES(2,1201,1400);
INSERT INTO salgrade VALUES(3,1401,2000);
INSERT INTO salgrade VALUES(4,2001,3000);
INSERT INTO salgrade VALUES(5,3001,9999);

SELECT * FROM salgrade;
SELECT * FROM salgrade WHERE losal > 1400 AND hisal < 4000;

SELECT ename, sal, sal+300 FROM emp;
SELECT ename, sal, 12*sal+100 FROM emp;
SELECT ename, sal, 100+sal*12 FROM emp;
SELECT ename, sal, 12*(sal+100) FROM emp;
SELECT ename, sal, 1.20*sal FROM emp;
SELECT ename, job, sal, comm FROM emp;
SELECT ename, sal, 12*(sal+100) FROM emp WHERE ename='KING';
SELECT ename, 12*sal+comm FROM emp WHERE ename='KING';
SELECT ename AS nombre, sal salario FROM emp;
SELECT ename AS nombre, 12*sal AS "Salario Anual" FROM emp;
SELECT CONCAT(ename,' ',job) AS empleado FROM emp;
SELECT CONCAT(ename,' is a ',job) AS "Detalles de Empleo" FROM emp;
SELECT DISTINCT deptno FROM emp;
SELECT DISTINCT deptno, job FROM emp;
SELECT ename,job,deptno FROM emp WHERE job = 'CLERK';
SELECT ename, sal, comm FROM emp WHERE sal <= comm;
SELECT ename, sal FROM emp WHERE sal BETWEEN 1000 AND 1500;
select empno, ename,sal, mgr from emp where mgr IN(7902,7566,7788);
SELECT empno,ename,mgr,deptno FROM emp WHERE ename IN('FORD','ALLEN');
SELECT ename FROM emp WHERE ename LIKE 'S%';
SELECT ename, hiredate FROM emp WHERE hiredate LIKE '2011%';
SELECT ename FROM emp WHERE ename LIKE '_A%';