Create Database proyecto2_201708850

USE proyecto2_201708850

CREATE TABLE Maestro (
    codigo VARCHAR(500),
    transaccion VARCHAR(500),
    nombre VARCHAR(500),
    valor VARCHAR(500),
    tipo VARCHAR(500),
    valor_anterior VARCHAR(500),
    Clave1 VARCHAR(50),
    clave2 VARCHAR(50)
);


CREATE TABLE Municipio (
    Departamento CHAR(2),
    Codigo CHAR(2),
    Nombre VARCHAR(100),
    Tipo CHAR(1),
);

CREATE TABLE Departamento (
    Codigo CHAR(2) PRIMARY KEY,
    Nombre VARCHAR(50) ,
    Tipo CHAR(1) 
);

CREATE TABLE Detalle (
    codigo_detalle INT,
    Codigo_maestro INT,
    operacion BIGINT,
    nombre VARCHAR(50),
    fecha VARCHAR(50),
    tipo VARCHAR(50),
    transaccion BIGINT,
    Clave1 VARCHAR(50),
    clave2 VARCHAR(50)
);



DROP TABLE Detalle;

Select * from Departamento;
Select * from Municipio;
Select * from Maestro;
Select * from Detalle;

select * from Maestro Where upper(nombre)='';
select * from Detalle Where upper(nombre)='NUMERO';
select * from Municipio Where upper(nombre)='RETALHULEU';
select * from Departamento Where upper(nombre)='RETALHULEU';

Select * from Departamento Where nombre like '10'
Select * from Municipio Where nombre like '10'
Select * from Maestro Where nombre like 'NUMERO'
Select * from Detalle Where nombre like 'ERRORES_DE'

select distinct tipo from Maestro 
select distinct tipo from Detalle
select distinct Tipo from Municipio
select distinct Tipo from Departamento

select distinct tipo from Maestro where tipo in ('D','I','1','V');
select distinct tipo from Detalle where tipo in ('D','I','1','V');
select distinct Tipo from Municipio where Tipo in ('D','I','1','V');
select distinct Tipo from Departamento where Tipo in ('D','I','1','V');

SELECT TOP 100 *
FROM Maestro ma
JOIN Detalle de ON ma.codigo = de.Codigo_maestro
WHERE ma.tipo IN ('D', 'I', '1', 'V', 'N');

SELECT * FROM Departamento d, Municipio m WHERE m.codigo in (select codigo_detalle from Detalle)

SELECT COUNT(*) FROM Detalle WHERE 5 < operacion AND tipo in ('D','I','1','U','N')

Select * from Maestro where transaccion = 236515870

Select * from MAESTRO where nombre like 'NUMERO'

Select * from MAESTRO where tipo ='D'

Select * from Detalle where transaccion='204929274'

Select * from DETALLE where nombre like 'ERRORES_DE'

Select * from DETALLE where fecha like '13/06/06'

Select * from DETALLE where tipo ='U'

Select * from DETALLE where operacion = '203087682'

select * from maestro m,detalle d Where m.codigo NOT like '0'

Select * from MUNICIPIO where Nombre like 'RETALHULEU'

Select * from MUNICIPIO where nombre like 'EL ASINTAL'

Select * from MUNICIPIO where tipo ='1'

CREATE TABLE Maestro1 (
    codigo VARCHAR(500),
    transaccion VARCHAR(500),
    nombre VARCHAR(500),
    valor VARCHAR(500),
    tipo VARCHAR(500),
    valor_anterior VARCHAR(500),
    Clave1 VARCHAR(50),
    clave2 VARCHAR(50)
);

CREATE TABLE Municipio1 (
    Departamento CHAR(2),
    Codigo CHAR(2),
    Nombre VARCHAR(100),
    Tipo CHAR(1),
);

CREATE TABLE Departamento1 (
    Codigo CHAR(2) PRIMARY KEY,
    Nombre VARCHAR(50) ,
    Tipo CHAR(1) 
);

CREATE TABLE Detalle1 (
    codigo_detalle INT,
    Codigo_maestro INT,
    operacion BIGINT,
    nombre VARCHAR(50),
    fecha VARCHAR(50),
    tipo VARCHAR(50),
    transaccion BIGINT,
    Clave1 VARCHAR(50),
    clave2 VARCHAR(50)
);

INSERT INTO Maestro1
SELECT * FROM Maestro;

INSERT INTO Detalle1
SELECT * FROM Detalle;

INSERT INTO Municipio1
SELECT * FROM Municipio;

INSERT INTO Departamento1
SELECT * FROM Departamento;

CREATE INDEX IX_Maestro1_Transaccion_Nombre_Tipo
ON Maestro1 (transaccion, nombre, tipo);


--Btree--

CREATE INDEX IX_Maestro1_Transaccion_Nombre_Tipo
ON Maestro1 (transaccion, nombre, tipo);
--Index Organized
CREATE CLUSTERED INDEX IX_Maestro1_Clustered
ON Maestro1 (transaccion, nombre, tipo);
--Bit Map
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_Maestro1_Columnstore
ON Maestro1 (transaccion, nombre, tipo);
-- Join Map
CREATE INDEX IX_Maestro1
ON  Maestro1 (codigo_maestro, descripcion);

--Domain Index

EXEC sp_fulltext_database 'enable';

CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;

CREATE FULLTEXT INDEX ON Maestro1 (nombre) KEY INDEX PK_Maestro1;

-- Cluster Index
CREATE CLUSTERED INDEX IX_Maestro1_Codigo ON Maestro1 (codigo);

-- Partition Tables
CREATE PARTITION FUNCTION pf_Maestro1 (INT)
AS RANGE LEFT FOR VALUES (1000, 2000, 3000);

CREATE PARTITION SCHEME ps_Maestro1
AS PARTITION pf_Maestro1 TO ([PRIMARY], [FileGroup1], [FileGroup2], [FileGroup3]);

CREATE TABLE Maestro1 (
    codigo INT,
    transaccion INT,
    nombre VARCHAR(500),
    valor VARCHAR(500),
    tipo VARCHAR(500),
    valor_anterior VARCHAR(500),
    Clave1 VARCHAR(50),
    clave2 VARCHAR(50)
)
ON ps_Maestro1 (codigo); -- Partitioning column


CREATE INDEX IX_Maestro1_Partitioned
ON Maestro1 (transaccion)
ON ps_Maestro1 (codigo); -- Partitioning column

--