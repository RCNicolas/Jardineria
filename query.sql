--1
SELECT 
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
--2
SELECT
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;
--3
SELECT
c.nombre_cliente AS NombreCliente,
CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is NULL;

--4
SELECT
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
  o.ciudad AS Ciudad
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

--5
SELECT DISTINCT
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
  o.ciudad AS Ciudad
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE p.codigo_cliente is NULL;

--6
SELECT DISTINCT
  c.nombre_cliente AS NombreCliente, c.ciudad AS Ciudad_Cielnte, o.linea_direccion1 AS Direccion_Oficina
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE c.ciudad = "Fuenlabrada";

--7
SELECT 
c.nombre_cliente AS Nombre_Cliente,
e.nombre AS Nombre_Representanre,
o.ciudad AS Ciudad_Oficina_Representante
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina; 

--8
SELECT
  CONCAT(e1.nombre, ' ', e1.apellido1) AS NombreEmpleado,
  CONCAT(e2.nombre, ' ', e2.apellido1) AS NombreJefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;


--9
SELECT
  e1.codigo_empleado AS CodigoEmpleado,
  CONCAT(e1.nombre, ' ', e1.apellido1) AS NombreEmpleado,
  CONCAT(e2.nombre, ' ', e2.apellido1) AS NombreJefe,
  CONCAT(e3.nombre, ' ', e3.apellido1) AS NombreJefeDelJefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;


--10
SELECT DISTINCT c.nombre_cliente AS NombreCliente
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

--11
SELECT DISTINCT
  c.nombre_cliente AS NombreCliente,
  g.gama AS GamaProducto
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
JOIN gama_producto g ON pr.gama = g.gama
GROUP BY c.nombre_cliente, g.gama;
