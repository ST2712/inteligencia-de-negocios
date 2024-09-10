use NORTHWND;

-- Seleccionar todos los clientes
select * from Customers;
GO

-- Seleccionar todas las ordenes mostrando
-- solamente fecha de la orden, cliente que la solicito,
-- El empleado que la realizo
select OrderDate, CustomerID, EmployeeID from orders;
GO

-- Seleccionar todas las ordenes mostrando
-- solamente fecha de la orden, cliente que la solicito,
-- El empleado que la realizo, pero poniendo nombres
-- personalizados a los campos (Alias de columna)
select OrderDate as FechaOrden, CustomerID as Clave_Cliente, EmployeeID as Clave_Empleado from orders;
GO

-- Seleccionar todos los productos que tengan un precio
-- igual a 18
select ProductID as [NumeroProducto], ProductName as [NombreProducto], UnitPrice as [PrecioUnitario] from Products
where UnitPrice = 18;

-- Operadores Relacionales
-- =, <, >, <=, >=, <> o !=
select * from Products where UnitsInStock >= 20;

select * from Products where UnitsInStock < 20;

-- Seleccionar todas las ordenes que tengan una fecha de orden menor a diciembre de 1996
select OrderID as [Numero Orden], 
OrderDate as [Fecha Orden], 
year(orderDate) as [Año], 
DATEPART(year, orderDate) as 'Año',
DATEPART(quarter, orderDate) as 'Trimestre',
DATEPART(mm, orderDate) as 'Mes',
datename(month, orderDate) as 'Nombre mes',
CustomerID as [Clave Cliente]
 from Orders where OrderDate < '1996-12-01';

 select OrderID as [Numero Orden], 
OrderDate as [Fecha Orden], 
year(orderDate) as [Año], 
DATEPART(year, orderDate) as 'Año',
DATEPART(quarter, orderDate) as 'Trimestre',
DATEPART(mm, orderDate) as 'Mes',
datename(month, orderDate) as 'Nombre mes',
CustomerID as [Clave Cliente]
 from Orders where OrderDate > '1996-12-31';

 -- Seleccionar todas las ordenes de 1997
 select OrderID as [Numero Orden], 
OrderDate as [Fecha Orden], 
year(orderDate) as [Año], 
DATEPART(year, orderDate) as 'Año',
DATEPART(quarter, orderDate) as 'Trimestre',
DATEPART(mm, orderDate) as 'Mes',
datename(month, orderDate) as 'Nombre mes',
CustomerID as [Clave Cliente]
from Orders 
where year(orderDate) = 1997;
GO

 select OrderID as [Numero Orden], 
OrderDate as [Fecha Orden], 
year(orderDate) as [Año], 
DATEPART(year, orderDate) as 'Año',
DATEPART(quarter, orderDate) as 'Trimestre',
DATEPART(mm, orderDate) as 'Mes',
datename(month, orderDate) as 'Nombre mes',
CustomerID as [Clave Cliente]
from Orders 
where datepart(YY, orderDate) = 1997;

-- Operadores logicos
-- and, or, not, between, in

-- Seleccionar nombre del producto, cantidad,
-- precio pero solamente los que tengan un precio entre 20 y 80
select ProductName as [Nombre Producto],
UnitPrice as [Precio],
UnitsInStock as [Cantidad]
from Products where UnitPrice between 20 and 80;

select ProductName as [Nombre Producto],
UnitPrice as [Precio],
UnitsInStock as [Cantidad]
from Products where UnitPrice >= 20 or UnitPrice <= 80 order by UnitPrice desc;

select ProductName as [Nombre Producto],
UnitPrice as [Precio],
UnitsInStock as [Cantidad]
from Products where UnitsInStock = 20 or UnitsInStock = 80 order by UnitPrice desc;

-- Seleccionar todos los clientes que sean de Alemania
-- o Estados unidos
select CompanyName as [Nombre Compañia],
Country as [Pais],
ContactName as [Nombre contacto]
from Customers
where Country like 'Ger%' or Country like 'US%' order by Country asc;

-- Seleccionar las ordenes que se le vendieron a los clientes
-- Frankenversand y Great Lakes Food Market, mostrando el año,
-- mes, y la fecha completa
SELECT DATEPART(yy, OrderDate) AS Año,
DATEPART(mm, OrderDate) AS Mes,
OrderDate AS Fecha, ShipName
FROM Orders where CustomerID = 'FRANK' or CustomerID = 'GREAL';

-- Seleccionar las ordenes que no se le vendieron a los clientes
-- Frankenversand y Great Lakes Food Market, mostrando el año,
-- mes, y la fecha completa
SELECT DATEPART(yy, OrderDate) AS Año,
DATEPART(mm, OrderDate) AS Mes,
OrderDate AS Fecha, ShipName
FROM Orders where not (CustomerID = 'FRANK' 
or CustomerID = 'GREAL') order by ShipName;


-- Seleccionar todos los empleados de Londres y seatle
-- mostrando el nombre completo del empleado, la ciudad y el pais
Select LastName as [Apellido], 
FirstName as [Nombre]
from Employees;

