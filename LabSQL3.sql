Select ProductID , ProductName, UnitPrice, UnitsInStock, 
        UnitPrice * UnitsInStock AS StockValue 
From Products

Select ProductID AS รหัส, ProductName AS สินค้า,
        UnitsInStock + UnitsOnOrder AS จำนวนคงเหลือทั้งหมด, ReorderLevel AS จุดสั้งซื้อ
From Products
Where (UnitsInStock + UnitsOnOrder) < ReorderLevel

Select ProductID, ProductName,
        UnitPrice, ROUND(Unitprice * 0.07,2) AS VAT7
From Products

Select EmployeeID,
        TitleOfCourtesy + FirstName + ' ' + LastName AS [Employee Name]
From Employees

Select EmployeeID,
        TitleOfCourtesy + FirstName + Space(1) + LastName AS [Employee Name]
From Employees

Select OrderId, ProductID, UnitPrice, Quantity, Discount,
        (UnitPrice * Quantity) AS TotalPrice,
        (UnitPrice * Quantity) - (UnitPrice * Quantity * Discount) AS Netprice,
        (UnitPrice * Quantity * Discount) AS DiscountPrice
From [Order Details]

Select OrderId, ProductID, UnitPrice, Quantity, Discount,
        (UnitPrice * Quantity) AS TotalPrice,
        (UnitPrice * Quantity * (1-Discount)) AS Netprice
From [Order Details]

Select (42.40*35)-(42.40*35*0.85)

Select EmployeeID, FirstName, BirthDate, 
        Datediff(YEAR, BirthDate, '2024-12-31') AS Age,
        HireDate, Datediff(YEAR, HireDate, Getdate()) AS YearInOffice
From Employees

Select Getdate()

Select Count(*) AS จำนวนสินค้า
From Products
Where UnitsInStock < 15

Select Count(*) AS จำนวนสินค้า, Count(ProductID), Count(ProductName), Count(UnitPrice)
From Products
Where UnitsInStock < 15

Select *
From Products
Where UnitsInStock < 15

Select Count(*)
From Customers
Where Country = 'USA'

Select Count(*)
From Employees
Where City = 'London'

Select Count(*)
From Orders
Where year(OrderDate) = 1997

Select Count(*)
From [Order Details]
Where ProductID = 77

Select sum(Quantity)
From [Order Details]
Where ProductID = 1

Select sum(Unitprice * UnitsInStock)
From Products

Select sum(UnitsOnOrder)
From Products
Where CategoryID = 8

Select max(UnitPrice),min(UnitPrice)
from [Order Details]
Where ProductID = 1

Select avg(UnitPrice),min(UnitPrice),max(UnitPrice)
From [Order Details]
Where ProductID = 5

Select Country, Count(*) AS [Num of Country]
From Customers
Group By Country

Select CategoryID, avg(Unitprice),min(UnitPrice),max(UnitPrice)
From Products
Group By CategoryID

Select OrderID, Count(*)
From [Order Details]
Group By OrderID
Having Count(*) > 3

Select ShipCountry, Count(*) AS [Num of Orders]
From Orders
Group By ShipCountry
Having Count(*) >= 100

Select Country, Count(*) AS [Num of Country]
From Customers
Group By Country
Having count(*) > 5

Select OrderID, sum(Unitprice*Quantity*(1-Discount))
From [Order Details]
Group By OrderID
Having sum(Unitprice*Quantity*(1-Discount)) < 100

Select ShipCountry, Count(*)
From Orders
Where year(OrderDate) = 1997
Group By ShipCountry
HAVING Count(*) < 20 
Order By Count(*) DESC

Select top 1 OrderID, sum(Unitprice*Quantity*(1-Discount)) as Total
From [Order Details]
Group By OrderID
Order By Total DESC


Select top 5 OrderID, sum(Unitprice*Quantity*(1-Discount)) as Total
From [Order Details]
Group By OrderID
Order By Total ASC
