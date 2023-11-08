Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
   
   ```sql
   SELECT 
   c.nombre_cliente AS NombreCliente,
   CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
   FROM cliente c
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
   
   
   ```

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
   
   ```sql
   SELECT distinct
   c.nombre_cliente AS NombreCliente,
   CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
   FROM cliente c
   JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
   
   ```
   
   

3. Muestra eI nombre de los clientes que no hayan realizado pagos junto con eI nombre de sus representantes de ventas
   
   ```sql
   SELECT
   c.nombre_cliente AS NombreCliente,
   CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
   FROM cliente c
   LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   WHERE p.codigo_cliente is NULL;
   ```

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
   
   ```sql
   SELECT
     c.nombre_cliente AS NombreCliente,
     CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
     o.ciudad AS Ciudad
   FROM cliente c
   LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
   ```



5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
   
   ```sql
   SELECT DISTINCT
     c.nombre_cliente AS NombreCliente,
     CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
     o.ciudad AS Ciudad
   FROM cliente c
   LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE p.codigo_cliente is NULL
   ```

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
   
   ```sql
   SELECT DISTINCT
     c.nombre_cliente AS NombreCliente, c.ciudad AS Ciudad_Cielnte, o.linea_direccion1 AS Direccion_Oficina
   FROM cliente c
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE c.ciudad = "Fuenlabrada";
   ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

```sql

```

8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

```sql

```

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

```sql

```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

```sql

```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

```sql

```

