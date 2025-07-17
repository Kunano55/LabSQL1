Select * From Employees

Select EmployeeID, FirstName, LastName
from Employees

Select *
From Employees
Where City = 'london'

Select EmployeeID, FirstName, LastName
From Employees
Where City = 'London'

Select City, Country
From Customers

Select Distinct City, Country
From Customers

Select *
From Products
Where UnitPrice > 200

Select *
From Customers
Where City = 'London' Or City = 'Vancouver'

Select *
From Customers
Where Country = 'USA' Or City = 'Vancouver'

Select *
From Products
Where UnitPrice >= 50 And UnitsInStock <20

Select *
From Products
Where UnitsInStock < 20 Or UnitsInStock <= ReorderLevel

Select *
From Products
Where UnitPrice Between 50 And 100

Select *
From Products
Where UnitPrice >= 50 And UnitPrice <= 100

Select *
From Customers
Where Country IN('Brazil', 'Argentina', 'Mexico')

Select *
From Customers
Where Country = 'Brazil' 
Or Country = 'Argentina' 
Or Country = 'Mexico'

Select *
From Employees
Where FirstName Like 'N%'

Select *
From Customers
Where CompanyName Like 'A%'

Select *
From Customers
Where CompanyName Like '%Y'

Select FirstName, LastName
From Employees
Where FirstName Like '%an%'

Select *
From Employees
Where FirstName Like '_____'

SELECT CompanyName
From Customers
WHERE CompanyName Like '_A%'

Select ProductID, ProductName, UnitPrice
From Products
Order By UnitPrice DESC

Select CompanyName, ContactName
From Customers
Order By ContactName ASC

Select top 10 ProductName, UnitPrice, UnitsInStock
From Products
Order By UnitsInStock DESC

Select CategoryID, ProductName, UnitPrice
From Products
Order By CategoryID ASC, UnitPrice DESC

Select CategoryID, ProductName, UnitPrice
From Products
Order By CategoryID ASC, UnitPrice DESC
