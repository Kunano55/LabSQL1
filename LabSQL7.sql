--Sub Query
Select Title From Employees
Where FirstName = 'Nancy'

Select *
From Employees
Where Title = 'Sales Representative'

Select *
From Employees
Where Title = (Select Title From Employees
Where FirstName = 'Nancy')

SELECT FirstName, LastName
FROM Employees
WHERE BirthDate = (SELECT MIN(BirthDate) FROM Employees)

SELECT ProductName
FROM Products
WHERE Unitprice > (SELECT UnitPrice FROM Products
WHERE ProductName = 'Ikura')

SELECT CompanyName
FROM Customers
WHERE city = (SELECT city FROM Customers
WHERE CompanyName = 'Around the Horn')

SELECT FirstName, LastName
FROM Employees
WHERE HireDate = (SELECT MAX(HireDate) FROM Employees)

SELECT *
FROM Orders
WHERE ShipCountry not in (SELECT DISTINCT Country
FROM Suppliers)

SELECT ROW_NUMBER() OVER(ORDER BY unitorice DESC) as Rownum, productName, UnitPrice
FROM Products
WHERE UnitPrice < 50

SELECT * FROM Shippers

INSERT INTO Shippers
VALUES ('Kerry Express', '02-123-4567')

INSERT INTO Shippers(CompanyName)
VALUES ('Flash Express')

SELECT * FROM Customers

INSERT INTO Customers(CustomerID, CompanyName)
VALUES ('A0001','บริษัทช้างประปา')

SELECT * FROM Employees

INSERt INTO Employees(FirstName, LastName)
VALUES ('Khunanon', 'Sareema')

SELECT * FROM Products

INSERT INTO Products(ProductName, UnitPrice, UnitsInStock)
VALUES ('ปลาแดกปอง', 1.5, 12)

UPDATE Shippers
SET Phone = '02-765-4321'
WHERE ShipperID = 6

UPDATE Products
SET UnitsInStock = UnitsInStock + 100
WHERE ProductID = 1

UPDATE Customers
SET City = 'อุดรธานี', Country = 'Thailand'
WHERE CustomerID = 'A0001'

DELETE FROM Products
WHERE ProductID = 78


DELETE FROM Shippers
WHERE ShipperID = 1