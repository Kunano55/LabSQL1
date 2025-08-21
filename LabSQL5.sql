SELECT CategoryName, ProductName, Unitprice
FROM Products, Categories
WHERE Products.CategoryID=Categories.CategoryID

SELECT CategoryName, ProductName, Unitprice
FROM Products as P, Categories as C
WHERE P.CategoryID=C.CategoryID

SELECT CategoryName, ProductName, Unitprice
FROM Products JOIN Categories
ON Products.CategoryID=Categories.CategoryID

SELECT CategoryName, ProductName, Unitprice
FROM Products as P JOIN Categories as C
ON P.CategoryID=C.CategoryID


SELECT CategoryName, ProductName, Unitprice
FROM Products as P, Categories as C
WHERE P.CategoryID=C.CategoryID
AND CategoryName='seafood'

SELECT CategoryName, ProductName, Unitprice
FROM Products as P JOIN Categories as C
ON P.CategoryID=C.CategoryID
AND CategoryName='seafood'

SELECT CompanyName, OrderID
FROM Orders JOIN Shippers
ON Shippers.ShipperID=Orders.ShipVia

SELECT CompanyName, OrderID
FROM Orders JOIN Shippers
ON Shippers.ShipperID=Orders.ShipVia
WHERE OrderID=10275

SELECT * FROM Orders WHERE OrderID=10275
SELECT * FROM [Order Details] WHERE OrderID=10275

SELECT ProductName, CompanyName, Country
FROM Products p JOIN Suppliers s
ON p.SupplierID=s.SupplierID
WHERE Country in ('USA', 'UK')

SELECT e.EmployeeID, FirstName, o.OrderID
FROM Employees e JOIN Orders o
on e.EmployeeID=o.EmployeeID
ORDER BY EmployeeID

SELECT O.OrderID เลขใบสั่งซื้อ, C.CompanyName ลูกค้า, E.FirstName พนักงาน, O.ShipAddress ส่งไปที่
FROM Orders O 
JOIN Customers C ON O.CustomerID=C.CustomerID
JOIN Employees E ON O.EmployeeID=E.EmployeeID

SELECT E.EmployeeID, FirstName, count(*) as [จำนวน order]
, sum(freight) as [Sum of Freight]
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
where year(orderdate) = 1998

SELECT S.CompanyName, count(*) as [จำนวน order]
FROM Shippers S JOIN Orders O
ON S.ShipperID=O.ShipVia
GROUP BY S.CompanyName
ORDER BY 2 DESC

SELECT p.ProductID, p.ProductName, Quantity
FROM Products p JOIN [Order Details] od
ON p.ProductID=od.ProductID
GROUP BY p.ProductID, p.ProductName

SELECT DISTINCT p.ProductID, p.ProductName
FROM Employees e join Orders o on e.EmployeeID = o.EmployeeID 
                 join [Order Details] od on o.OrderID = od.OrderID
                 Join Products p on od.ProductID = p.ProductID
WHERE e.FirstName = 'Nancy'
Order BY p.ProductID
