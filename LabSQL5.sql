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
