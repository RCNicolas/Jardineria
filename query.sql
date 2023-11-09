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


---1
SELECT
  c.codigo_cliente AS CODIGO,
  c.nombre_cliente AS CLIENTE
FROM cliente c
  LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

---2
SELECT
  c.codigo_cliente AS CODIGO,
  c.nombre_cliente AS CLIENTE
FROM cliente c
  LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

---3
SELECT
  c.codigo_cliente AS CODIGO,
  c.nombre_cliente AS CLIENTE
FROM cliente c
  LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
  LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE p.codigo_cliente IS NULL AND pd.codigo_cliente IS NULL;

---4
SELECT
  e.codigo_empleado AS CODIGO,
  CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS EMPLEADO
FROM empleado e
  LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_oficina IS NULL;

---5
SELECT
  e.codigo_empleado AS CODIGO,
  CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS EMPLEADO
FROM empleado e
  LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;

---6
SELECT
  e.codigo_empleado AS CODIGO,
  CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS EMPLEADO,
  o.telefono AS TELEFONO_OFICINA, o.ciudad AS CIUDAD, o.pais AS PAÍS
FROM empleado e
  LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
  INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_empleado_rep_ventas IS NULL;

---7
SELECT
  CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS EMPLEADO
FROM empleado e
  LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE e.codigo_oficina IS NULL AND c.codigo_empleado_rep_ventas IS NULL;

---8
SELECT
  p.codigo_producto AS CÓDIGO,
  p.nombre AS PRODUCTO
FROM producto p
  LEFT JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto
WHERE d.codigo_producto IS  NULL;

---9
SELECT
  p.codigo_producto AS CÓDIGO,
  p.nombre AS PRODUCTO,
  p.descripcion AS DESCRIPCIÓN,
  g.imagen AS IMG_GAMA
FROM producto p
  LEFT JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto
  INNER JOIN gama_producto g ON p.gama = g.gama
WHERE d.codigo_producto IS  NULL;

---10
select distinct o.codigo_oficina, e.nombre
from oficina o
  left join empleado e on o.codigo_oficina = e.codigo_oficina
  left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
  left join pedido p on c.codigo_cliente = p.codigo_cliente
  left join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido
  left join producto pr ON dp.codigo_producto = pr.codigo_producto
where pr.gama = 'Frutales' and c.codigo_empleado_rep_ventas is not null
  and e.codigo_empleado is not null
  and c.codigo_cliente is not null
  and p.codigo_pedido is not null
  and dp.codigo_pedido is not null
  and pr.codigo_producto is not null
  and o.codigo_oficina is not null;

---11
SELECT DISTINCT c.nombre_cliente
FROM cliente c
  INNER JOIN pedido pd on c.codigo_cliente = pd.codigo_cliente
  LEFT JOIN pago pg on c.codigo_cliente = pg.codigo_cliente
WHERE pg.codigo_cliente is NULL;

---12
SELECT e.codigo_empleado AS CÓDIGO_EMPLEADO ,
  CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS EMPLEADO
FROM empleado e
  LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;
