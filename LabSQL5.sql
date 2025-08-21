SELECT CategoryName, ProductName, Unitprice
FROM Products, Categories
WHERE Products.CategoryID=Categories.CategoryID
