CREATE TABLE analisis_ecommerce (
ID_Orden INT PRIMARY KEY IDENTITY(1,1),
ID_Cliente INT,
Cliente VARCHAR(20),
Producto VARCHAR(30),
Costo_Envio FLOAT,
Dias_Retraso FLOAT,
Estado_Envio VARCHAR(20),
Fecha_Despacho VARCHAR(15),
Monto_Total FLOAT
)

ALTER TABLE dbo.analisis_ecommerce
ALTER COLUMN Costo_Envio VARCHAR(40)

ALTER TABLE dbo.analisis_ecommerce
ALTER COLUMN Dias_Retraso VARCHAR(40)

ALTER TABLE dbo.analisis_ecommerce
ALTER COLUMN Monto_Total VARCHAR(40)

CREATE TABLE dbo.Cliente (
ID_Cliente INT,
Nombre VARCHAR(20),
Apellido VARCHAR(20),
)

CREATE TABLE dbo.Producto (
ID_Producto INT,
Producto VARCHAR(100)
)

CREATE TABLE dbo.Precio (
ID_Precio INT,
Monto_Total FLOAT,
Costo_Envio FLOAT
)

CREATE TABLE dbo.Estado_envio (
ID_Estado INT,
Estado_Envio VARCHAR(12),
Dias_Retraso INT,
Fecha_Despacho VARCHAR(10)
)

INSERT INTO dbo.Cliente (ID_Cliente, Nombre, Apellido)
SELECT ID_Cliente, Cliente, Cliente
FROM dbo.analisis_ecommerce

INSERT INTO dbo.Producto (ID_Producto, Producto)
SELECT ID_Cliente, Producto
FROM dbo.analisis_ecommerce

INSERT INTO dbo.Precio (ID_Precio, Monto_Total, Costo_Envio)
SELECT ID_Cliente, Monto_Total, Costo_Envio
FROM dbo.analisis_ecommerce

INSERT INTO dbo.Estado_envio (ID_Estado, Estado_Envio, Dias_Retraso, Fecha_Despacho)
SELECT ID_Cliente, Estado_Envio, Dias_Retraso, Fecha_Despacho
FROM dbo.analisis_ecommerce

UPDATE dbo.Cliente
SET Nombre = LEFT(Nombre, CHARINDEX(' ', Nombre) -1)

UPDATE dbo.Cliente
SET Apellido = SUBSTRING(Apellido, CHARINDEX(' ', Apellido) +1, LEN(Apellido))

ALTER TABLE dbo.Producto 
ADD ID_Producto INT IDENTITY(1,1) NOT NULL;

ALTER TABLE dbo.Producto 
ADD CONSTRAINT PK_producto PRIMARY KEY (ID_Producto);

ALTER TABLE dbo.Precio
ADD ID_Precio INT IDENTITY(1,1) NOT NULL;

ALTER TABLE dbo.Precio
ADD CONSTRAINT PK_precio PRIMARY KEY (ID_Precio);

ALTER TABLE  dbo.Cliente
ADD ID_Producto INT;

ALTER TABLE dbo.Cliente
ADD CONSTRAINT FK_producto
FOREIGN KEY (ID_Producto) REFERENCES dbo.Producto(ID_Producto)

ALTER TABLE  dbo.Cliente
ADD ID_Precio INT;

ALTER TABLE dbo.Cliente
ADD CONSTRAINT FK_precio
FOREIGN KEY (ID_Precio) REFERENCES dbo.Precio(ID_Precio)

ALTER TABLE  dbo.Cliente
ADD ID_Estado INT;

ALTER TABLE dbo.Cliente
ADD CONSTRAINT FK_estado
FOREIGN KEY (ID_Estado) REFERENCES dbo.Estado_envio(ID_Estado)

WITH NumerosOrdenados AS (
SELECT ID_Estado,
ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) AS Fila
FROM dbo.Cliente
)

UPDATE NumerosOrdenados
SET ID_Estado = Fila

WITH NumerosOrdenados AS (
SELECT ID_Precio,
ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) AS Fila
FROM dbo.Cliente
)

UPDATE NumerosOrdenados
SET ID_Precio = Fila

WITH NumerosOrdenados AS (
SELECT ID_Producto,
ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) AS Fila
FROM dbo.Cliente
)

UPDATE NumerosOrdenados
SET ID_Producto = Fila

WITH Numerosindex AS (
SELECT ID_Cliente, ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) AS Fila
FROM dbo.analisis_ecommerce
)

UPDATE Numerosindex
SET ID_CLiente = Fila
FROM analisis_ecommerce

WITH Numerosindex AS (
SELECT ID_Cliente, ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) AS Fila
FROM dbo.Precio
)

UPDATE Numerosindex
SET ID_CLiente = Fila

WITH Numerosindex AS (
SELECT ID_Cliente, ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) AS Fila
FROM dbo.Estado_envio
)

UPDATE Numerosindex
SET ID_CLiente = Fila

WITH Numerosindex AS (
SELECT ID_Cliente, ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) AS Fila
FROM dbo.Producto
)

UPDATE Numerosindex
SET ID_CLiente = Fila

ALTER TABLE dbo.Cliente
ADD CONSTRAINT PK_cliente PRIMARY KEY (ID_Cliente);

ALTER TABLE dbo.Estado_envio
ADD CONSTRAINT FK_id_cliente
FOREIGN KEY (ID_Cliente) REFERENCES dbo.Cliente(ID_Cliente)

ALTER TABLE dbo.Precio
ADD CONSTRAINT FK_id_cliente_precio
FOREIGN KEY (ID_Cliente) REFERENCES dbo.Cliente(ID_Cliente)

ALTER TABLE dbo.Producto
ADD CONSTRAINT FK_id_cliente_producto
FOREIGN KEY (ID_Cliente) REFERENCES dbo.Cliente(ID_Cliente)

'''¿Cuál es el costo promedio real de envío por pedido tras eliminar los errores y valores atípicos?'''
SELECT AVG(Monto_Total) as Costo_Promedio_de_Envio
FROM dbo.Precio

'''
Costo_Promedio_de_Envio
5287,0375
'''

'''¿Qué porcentaje de los envíos terminan realmente Retrasados o Cancelados en comparación con los exitosos?'''
SELECT 
SUM(CASE WHEN e.Estado_Envio = 'Cancelado' THEN 1 ELSE 0 END) AS Cantidad_Cancelados,
CAST(SUM(CASE WHEN e.Estado_Envio = 'Cancelado' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS Porcentajes_Cancelados,
SUM(CASE WHEN e.Estado_Envio = 'Retrasado' THEN 1 ELSE 0 END) AS Cantidad_Retrasados,
CAST(SUM(CASE WHEN e.Estado_Envio = 'Retrasado' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS Porcentajes_Retrasados
FROM dbo.Estado_envio as e

'''
Cantidad_Cancelados	Porcentajes_Cancelados	Cantidad_Retrasados	Porcentajes_Retrasados
        21	          40,3846153846154	            19	           36,5384615384615
'''

'''¿Cuál es el producto que genera mayores ingresos brutos para la compañía?'''
SELECT Producto, SUM(pr.Monto_Total) AS Ingresos_Brutos
FROM dbo.Producto p
JOIN dbo.Precio pr ON p.ID_Cliente = pr.ID_Cliente
GROUP BY p.Producto
ORDER BY Ingresos_Brutos DESC

'''
Producto	      Ingresos_Brutos
Monitor 24 pulg	     81463,49
Smartphone x	     80601,97
Laptop gamer	     58220,5
Teclado mecanico	 54639,99
'''