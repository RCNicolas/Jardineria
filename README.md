## Consultas multitabla (Composición interna)

<details> 
<summary>Consultas Internas</summary>

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

   ```sql
   SELECT
   c.nombre_cliente AS NombreCliente,
   CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
   FROM cliente c
   JOIN  eempleado ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
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
   SELECT
   c.nombre_cliente AS Nombre_Cliente,
   e.nombre AS Nombre_Representanre,
   o.ciudad AS Ciudad_Oficina_Representante
   FROM cliente c
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
   ```

8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

   ```sql
   SELECT
     CONCAT(e1.nombre, ' ', e1.apellido1) AS NombreEmpleado,
     CONCAT(e2.nombre, ' ', e2.apellido1) AS NombreJefe
   FROM empleado e1
   LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;
   ```

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

   ```sql
   SELECT
     e1.codigo_empleado AS CodigoEmpleado,
     CONCAT(e1.nombre, ' ', e1.apellido1) AS NombreEmpleado,
     CONCAT(e2.nombre, ' ', e2.apellido1) AS NombreJefe,
     CONCAT(e3.nombre, ' ', e3.apellido1) AS NombreJefeDelJefe
   FROM empleado e1
   LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
   LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;
   ```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

    ```sql
    SELECT DISTINCT c.nombre_cliente AS NombreCliente
    FROM cliente c
    INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.fecha_entrega > p.fecha_esperada;
    ```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

   ```sql
      SELECT DISTINCT
         c.nombre_cliente AS NombreCliente,
         g.gama AS GamaProducto
      FROM cliente c
      JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
      JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
      JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
      JOIN gama_producto g ON pr.gama = g.gama
      GROUP BY c.nombre_cliente, g.gama;
   ```

</details>

## Consultas multitabla (Composición externa)

<details> 
<summary>Consultas Externas</summary>

1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
   
   ```sql
   SELECT 
   c.codigo_cliente AS Codigo, 
   c.nombre_cliente AS Cliente 
   FROM cliente c 
   LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
   WHERE p.codigo_cliente IS NULL;
   ```
2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
   
   ```sql
   SELECT 
   c.codigo_cliente AS Codigo, 
   c.nombre_cliente AS Cliente 
   FROM cliente c 
   LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
   WHERE p.codigo_cliente IS NULL;
   ```
3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
   
   ```sql
   SELECT 
   c.codigo_cliente AS Codigo, 
   c.nombre_cliente AS Cliente 
   FROM cliente c 
   LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
   LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente 
   WHERE p.codigo_cliente IS NULL AND pd.codigo_cliente IS NULL;
   ```
4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
   
   ```sql
   SELECT e.codigo_empleado AS Codigo, 
   CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS Empleado 
   FROM empleado e 
   LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
   WHERE e.codigo_oficina IS NULL;
   ```
5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
   
   ```sql
   SELECT 
   e.codigo_empleado AS Codigo, 
   CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS Empleado
   FROM empleado e 
   LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
   WHERE c.codigo_empleado_rep_ventas IS NULL;
   ```
6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
   
   ```sql
   SELECT 
   e.codigo_empleado AS Codigo, 
   CONCAT (e.nombre,' ',e.apellido1,' ',e.apellido2) AS Empleado, 
   o.telefono AS Telefono_Oficina, 
   o.ciudad AS Ciudad, 
   o.pais AS País 
   FROM empleado e 
   LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
   INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina  
   WHERE c.codigo_empleado_rep_ventas IS NULL ;
   ```
7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
   
   ```sql
   SELECT 
   CONCAT(e.nombre, ' ', e.apellido1, ' ', e.apellido2) AS Empleado 
   FROM empleado e 
   LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
   WHERE e.codigo_oficina IS NULL AND c.codigo_empleado_rep_ventas IS NULL;
   ```
8. Devuelve un listado de los productos que nunca han aparecido en un pedido.
   
   ```sql
   SELECT 
   p.codigo_producto AS Codigo,
   p.nombre AS Producto 
   FROM producto p 
   LEFT JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto 
   WHERE d.codigo_producto IS  NULL;
   ```
9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.
   
   ```sql
   SELECT 
   p.codigo_producto AS Codigo,
   p.nombre AS Producto,
   p.descripcion AS Descripción, 
   g.imagen AS Imagen_Gama 
   FROM producto p 
   LEFT JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto 
   INNER JOIN gama_producto g ON p.gama = g.gama 
   WHERE d.codigo_producto IS  NULL;
   ```
10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
    
    ```sql
    select distinct 
    o.codigo_oficina AS Codigo_Oficina, 
    e.nombre AS Nombre
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
    ```
11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
    
    ```sql
    SELECT DISTINCT 
    c.codigo_cliente AS Codigo,
    c.nombre_cliente AS Cliente
    FROM cliente c
    INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    LEFT JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente
    WHERE pg.codigo_cliente IS NULL;
    ```
12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
    
    ```sql
    SELECT 
    e.codigo_empleado AS Codigo_empleado, 
    CONCAT (e.nombre, ' ', e.apellido1, ' ', e.apellido2) AS Empleado
    FROM empleado e
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE c.codigo_empleado_rep_ventas IS NULL;
    ```
</details>

## Consultas simples

<details> 
<summary>Consultas Simples</summary>

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

```sql
SELECT codigo_oficina, ciudad
FROM oficina;
```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

```sql
SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';
```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

```sql
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;
```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

```sql
SELECT puesto, 
CONCAT(nombre,' ',apellido1,' ', apellido2),
email
FROM empleado;
```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

```sql
SELECT  
CONCAT(nombre,' ',apellido1,' ', apellido2) AS Nombre,
puesto
FROM empleado
WHERE puesto != 'Representante Ventas';
```

6. Devuelve un listado con el nombre de todos los clientes españoles.

```sql
SELECT nombre_cliente
FROM cliente
WHERE pais = 'España';
```

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

```sql
SELECT DISTINCT estado
FROM pedido;
```

8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.

Utilizando la función YEAR de MySQL:

```sql
SELECT DISTINCT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;
```

Utilizando la función DATE_FORMAT MySQL:

```sql
SELECT DISTINCT codigo_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';
```

Sin utilizar ninguna de las funciones anteriores:

```sql
SELECT DISTINCT codigo_cliente
FROM pago
WHERE fecha_pago >= '2008-01-01' AND fecha_pago < '2009-01-01';
```

9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

```sql
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;
```

10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

Utilizando la función ADDDATE de MySQL:

```sql
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega < ADDDATE(fecha_esperada, -2);
```

Utilizando la función DATEDIFF de MySQL:

```sql
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
```

No es posible resolver esta consulta utilizando el operador de suma + o resta - directamente en MySQL.

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

```sql
SELECT *
FROM pedido
WHERE estado = 'Rechazado' AND YEAR(fecha_pedido) = 2009;
```

12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

```sql
SELECT *
FROM pedido
WHERE MONTH(fecha_entrega) = 1;
```

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

```sql
SELECT *
FROM pago
WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'Paypal'
ORDER BY total DESC;
```

14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.

```sql
SELECT DISTINCT forma_pago
FROM pago;
```

15. Devuelve un listado con todos los productos que pertenecen a la gama ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.

```sql
SELECT *
FROM producto
WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;
```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.

```sql
SELECT *
FROM cliente
WHERE ciudad = 'Madrid'
AND codigo_empleado_rep_ventas IN (11, 30);
```

</details>

## Subconsultas

<details> 
<summary>Operadores básicos de comparación</summary>

1. Devuelve el nombre del cliente con mayor límite de crédito.

   ```sql
   SELECT 
   nombre_cliente AS Nombre,
   limite_credito AS Limite_Credito
   FROM cliente
   WHERE limite_credito = (
   SELECT MAX(limite_credito )
   FROM cliente 
   );
   ```

2. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```sql
   SELECT 
   nombre AS Nombre,
   precio_venta AS Precio_De_Venta
   FROM producto
   WHERE precio_venta = (
   SELECT MAX(precio_venta)
   FROM producto
   );
   ```

3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla `detalle_pedido`)

   ```sql
   SELECT p.nombre
   FROM producto p
   JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
   GROUP BY p.nombre
   ORDER BY SUM(dp.cantidad) DESC
   LIMIT 1;
   
   ```

4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar `INNER JOIN`).

   ```sql
   SELECT *
   FROM cliente
   WHERE limite_credito > (
      SELECT COALESCE(SUM(total), 0)
      FROM pago
      WHERE pago.codigo_cliente = cliente.codigo_cliente
   );
   ```

5. Devuelve el producto que más unidades tiene en stock.

   ```sql
   SELECT nombre, cantidad_en_stock
   FROM producto
   WHERE cantidad_en_stock = (
      SELECT MAX(cantidad_en_stock)
      FROM producto
   );
   ```

6. Devuelve el producto que menos unidades tiene en stock.

   ```sql
   SELECT *
   FROM producto
   WHERE cantidad_en_stock = (
      SELECT MIN(cantidad_en_stock)
      FROM producto
   );    
   ```

7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de **Alberto Soria**.

   ```sql
   SELECT e.nombre, e.apellido1, e.apellido2, e.email
   FROM empleado e
   WHERE e.codigo_jefe = (
      SELECT codigo_empleado
      FROM empleado
      WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
   );
   ```

</details> 

<details>
<summary>ALL y ANY</summary>

1. Devuelve el nombre del cliente con mayor límite de crédito.
   
   ```sql
   SELECT nombre_cliente
   FROM cliente
   WHERE limite_credito >= ALL (
      SELECT limite_credito
      FROM cliente
   );
   ```

2. Devuelve el nombre del producto que tenga el precio de venta más caro.
   
   ```sql
   SELECT nombre
   FROM producto
   WHERE precio_venta = (
      SELECT MAX(precio_venta)
      FROM producto
   );  
   ```

3. Devuelve el producto que menos unidades tiene en stock.
   
   ```sql
   SELECT nombre as Producto
   FROM producto
   WHERE cantidad_en_stock = (
      SELECT MIN(cantidad_en_stock)
      FROM producto
   );
   ```
</details>

<details>
<summary>IN y NOT IN</summary>

1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
   
   ```sql
   SELECT nombre, apellido1, puesto
   FROM empleado
   WHERE codigo_empleado NOT IN (
      SELECT DISTINCT codigo_empleado_rep_ventas
      FROM cliente
      WHERE codigo_empleado_rep_ventas IS NOT NULL
   );
   ```

2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
   
   ```sql
   SELECT *
   FROM cliente
   WHERE codigo_cliente NOT IN (
      SELECT DISTINCT codigo_cliente
      FROM pago
   );  
   ```

3. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
   
   ```sql
   SELECT *
   FROM cliente
   WHERE codigo_cliente IN (
      SELECT DISTINCT codigo_cliente
      FROM pago
   );
   ```

4. Devuelve un listado de los productos que nunca han aparecido en un pedido.
   
   ```sql
   SELECT *
   FROM producto
   WHERE codigo_producto NOT IN (
      SELECT DISTINCT codigo_producto
      FROM detalle_pedido
   );
   ```

5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
   
   ```sql
   SELECT e.nombre, e.apellido1, e.puesto, o.telefono
   FROM empleado e
   JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
   WHERE e.codigo_empleado NOT IN (
      SELECT DISTINCT codigo_empleado_rep_ventas
      FROM cliente
      WHERE codigo_empleado_rep_ventas IS NOT NULL
   );  
   ```

6. Devuelve las oficinas donde **no trabajan** ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama `Frutales`.
   
   ```sql
   SELECT * 
   FROM oficina
   WHERE codigo_oficina NOT IN (
      SELECT DISTINCT e.codigo_oficina
      FROM empleado e
      JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
      JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
      JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
      JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
      WHERE pr.gama = 'Frutales'
   );
   ```

7. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
   
   ```SQL
   SELECT *
   FROM cliente
   WHERE codigo_cliente IN (
      SELECT DISTINCT p.codigo_cliente
      FROM pedido p
   ) AND codigo_cliente NOT IN (
      SELECT DISTINCT codigo_cliente
      FROM pago
   );
   ```

</details>

<details>
<summary>EXISTS y NOT EXISTS</summary>

1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

```sql
SELECT *
FROM cliente c
WHERE EXISTS (
   SELECT 1
   FROM pago p
   WHERE c.codigo_cliente = p.codigo_cliente
);
```

2. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

```SQL
SELECT *
   FROM cliente c
   WHERE EXISTS (
      SELECT 1
      FROM pago p
      WHERE c.codigo_cliente = p.codigo_cliente
);
```

3. Devuelve un listado de los productos que nunca han aparecido en un pedido.

```SQL
SELECT *
FROM producto pr
WHERE NOT EXISTS (
      SELECT 1
      FROM detalle_pedido dp
      WHERE pr.codigo_producto = dp.codigo_producto
);
```

4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

```SQL
SELECT *
   FROM producto pr
   WHERE EXISTS (
      SELECT 1
      FROM detalle_pedido dp
      WHERE pr.codigo_producto = dp.codigo_producto
);
```
</details>

## Tips en consultas

<details>
<summary>5 Tips SELECT</summary>

1. Uso del CASE en select
   ```sql
   select 
   puesto,
   case 
   when puesto = 'Representante Ventas' then 001 
   when puesto = 'Secretaria' then 002
   else 003 end as CodigoPuesto
   from empleado;
   ```
2. Uso de operaciones ariteticas con select

   ```sql
   select
   precio_venta, precio_proveedor,
   (precio_venta - precio_proveedor) AS Diferencia_entre_precios
   from producto;
   ```
3. Insertar datos en una tabla con select

   ```sql
   select nombre, codigo_jefe, 
   3213581364 as telefono 
   from empleado
   where codigo_jefe = 1;
   ```

4. Tipo de subconsulta usando select y relacionando tablas

   ```sql
   select p.nombre,
	(select count(dp.codigo_pedido)
	from detalle_pedido dp
   where p.codigo_producto = dp.codigo_producto) AS Pedidos_pro_producto
   from producto p;
   ```
5. Consulta sobre consulta
```SQL
    select nombre, Total from
        (select e.nombre, count(e.codigo_empleado) as Total
        from cliente c
        join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
        group by e.nombre) as tabla 
    where tabla.Total > 3;
```

</details>

</details>

<details>
<summary>5 Tips UPDATE</summary>

1. Editar usando un valor ya guardado

   Sumar 10 a la cantidad de stock en los producto

   ```sql   
   UPDATE producto set cantidad_en_stock = cantidad_en_stock + 10;
   ```
2. Uso de operaciones ariteticas con select

   ```sql
   select
   precio_venta, precio_proveedor,
   (precio_venta - precio_proveedor) AS Diferencia_entre_precios
   from producto;
   ```
3. Insertar datos en una tabla con select

   ```sql
   select nombre, codigo_jefe, 
   3213581364 as telefono 
   from empleado
   where codigo_jefe = 1;
   ```

4. Tipo de subconsulta usando select y relacionando tablas

   ```sql
   select p.nombre,
	(select count(dp.codigo_pedido)
	from detalle_pedido dp
   where p.codigo_producto = dp.codigo_producto) AS Pedidos_pro_producto
   from producto p;
   ```
5.

</details>

<details>
<summary> 5 Tips Group By </summary>

1. Utilizacion de group Basica
   ```SQL
      select c.pais, count(*) as Numero_clientes
      from cliente c
      join pago p on p.codigo_cliente = c.codigo_cliente
      group by  c.pais;
   ```

2. Filtrar los paises que empiecen con una letra y utilizacion de HAVING
   ```SQL
      select c.pais, count(*) as Total
      from cliente c
      where substring(c.pais, 1, 1) = 'u' 
      group by c.pais
      having count(*) > 2;
   ``` 

3. Cuenta cuantos paises empiezan por cada letra hay en cada letra 
   ```SQL
      select substring(c.pais, 1, 1) as Primeraletra, count(*) as Total
      from cliente c
      group by c.pais;
   ```

4. une 2 tablas y las agrupa contando el total de cada una

   ```SQL

      select Columna, count(*) as Total 
      from
         (select p.forma_pago as Columna 
         from cliente c
         join pago p on p.codigo_cliente = c.codigo_cliente
         union all
         select c.pais As Columna 
         from cliente c) as mitabla
      group by Columna ;
   ```

5. Concatenar resultados de agrupamiento
   ```SQL
      select
      p.forma_pago, 
      GROUP_CONCAT(c.pais order by c.pais desc SEPARATOR ', ') as pais
      from cliente c
      JOIN pago p on p.codigo_cliente = c.codigo_cliente
      GROUP by p.forma_pago;
   ```
</details>

<details>

<summary>5 Tips Where </summary>

1. Not in, cuando queremos que no muestre los codigos que le ponemos 
   ```SQL
      select codigo_cliente, nombre_cliente
      from cliente
      where codigo_cliente not in (1, 2, 4, 8, 9);
   ```

2. subconsulta
   ```SQL
      select * 
      from oficina o
      where (
         select count(*)
         from empleado e
         where e.codigo_oficina = o.codigo_oficina
      )>4;
   ```

3.  Editar obteniendo el valor por subconsulta
   ```SQL 

      select nombre_cliente 
      from cliente 
      where nombre_cliente REGEXP '[aieo]$';
   ```

4. Regex
   ```SQL

      select * 
      from pago where (
               select pais 
               from cliente 
               where cliente.codigo_cliente  = pago.codigo_cliente ) 
      <> 'France';
   ```

5. In y subconsulta
   ```SQL
      select nombre_cliente 
      from cliente
      where codigo_empleado_rep_ventas IN (
         select codigo_empleado 
         from empleado 
         where apellido1 LIKE 'b%'
      );
   ```

</details>















