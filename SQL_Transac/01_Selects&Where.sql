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


select
concat(FirstName, ' ', LastName) as [fullname],
country as [pais], city as [ciudad]
from Employees
where city in('seattle', 'london');
GO

select
(FirstName +  ' ' + LastName) as [fullname],
country as [pais], city as [ciudad]
from Employees
where city in('seattle', 'london');
GO

select
concat(FirstName, ' ', LastName) as [fullname],
country as [pais],
city as [ciudad]
from Employees
where city  = 'seatle' or city='london';
GO

-- Tipos de joins (inner, left, right, full)
-- Seleccionar todos los productos con su categoria
-- Mostrando el nombre del producto y el nombre de la categoria

--Alias de tabla
select pr.ProductID as [Numero producto],
pr.ProductName as [Nombre del producto],
ca.CategoryID as [Numero de categoria],
ca.CategoryName as [Nombre de la categoria]
from Products as pr
inner join Categories as ca
on pr.CategoryID = ca.CategoryID;
GO

-- Seleccionar todos los productos mostrando:
-- Nombre del producto y nombre del proveedor (supplier)
Select pr.ProductName as [Nombre producto],
sp.CompanyName as [Nombre proveedor]
from Products as pr
inner join Suppliers as sp
on pr.SupplierID = sp.SupplierID;

-- Seleccionar los nombres de los productos que han sido ordenados y sus subtotales
Select pr.ProductName as [Nombre producto],
(od.Quantity*od.UnitPrice) as [Subtotal]
from Products as pr
inner join [Order Details] as od
on pr.ProductID = od.ProductID;

-- Seleccionar los nombres de los productos vendidos
-- El nombre de su categoria, el precio que se vendio
-- La cantidad vendida y su subtotal

SELECT 
    pr.ProductName AS [Nombre producto],
    ca.CategoryName AS [Nombre categoría],
    od.UnitPrice AS [Precio producto],
    od.Quantity AS [Cantidad vendida],
    (od.Quantity * od.UnitPrice) AS [Subtotal]
FROM Products AS pr
INNER JOIN [Order Details] AS od 
    ON pr.ProductID = od.ProductID
INNER JOIN Categories AS ca
    ON pr.CategoryID = ca.CategoryID;
GO

-- Seleccionar los nombres de los productos vendidos
-- El nombre de su categoria, el nombre completo del empleado que lo realizo
-- la fecha de venta, el precio de venta, cantidad y subtotal, para las categorias
-- Beverages, Condiments y seafood
-- La cantidad vendida y su subtotal
select p.ProductName as [Nombre producto],
c.CategoryName as [Nombre categoria],
o.OrderDate as [Fecha de orden],
(e.FirstName+ ' ' + e.LastName) as [Nombre vendedor],
(od.Quantity*od.UnitPrice) as [Subtotal],
od.Quantity as [Cantidad],
od.UnitPrice as [Precio unitario]
 from Orders as o
 inner join Employees as e
 on o.EmployeeID = e.EmployeeID
 inner join [Order Details] as od
 on o.OrderID = od.OrderID
 inner join Products as p
 on od.ProductID = p.ProductID
 inner join Categories as c
 on c.CategoryID = p.CategoryID
 where c.CategoryName in('Beverages','Condiments','Seafood');
 GO

 --Crear base de datos
 Create database stagenorthwind;
 go

 use stagenorthwind;

 if not exists (select 1 from sys.tables where name = 'ProductsStage')

 Begin
	Create table ProductsStage(
	productoId INT not null identity(1,1),
	NombreProducto nVarchar(40) not null,
	PrecioUnitario MONEY not null,
	stock smallint not null,
	CategoriaId int not null,
	constraint pk_ProductsStage
	primary key(productoId)
	)
END;
select * from ProductsStage;

-- Crear una tabla a partir de una consulta
select top 0 CategoryID as [CategoriaID],
CategoryName as [NombreCategoria]
into stagenorthwind.dbo.categoriesStage
from NORTHWND.dbo.Categories;

alter table categoriesStage
alter column [CategoriaId] int not null;
go

alter table categoriesStage
add constraint pk_categoriesStage
primary key(CategoriaID);
go

select * from categoriesStage;
go
