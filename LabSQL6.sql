-- 1.จงแสดงให้เห็นว่าพนักงานแต่ละคนขายสินค้าประเภท Beverage ได้เป็นจำนวนเท่าใด และเป็นจำนวนกี่ชิ้น เฉพาะครึ่งปีแรกของ 2540(ทศนิยม 4 ตำแหน่ง)
SELECT
    e.FirstName AS 'ชื่อ',
    e.LastName AS 'นามสกุล',
    CAST(SUM(od.Quantity) AS DECIMAL(10, 4)) AS 'จำนวนสินค้าทั้งหมด (ชิ้น)',
    COUNT(od.ProductID) AS 'จำนวนครั้งที่ขาย'
FROM
    Employees AS e
JOIN
    Orders AS o ON e.EmployeeID = o.EmployeeID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
JOIN
    Products AS p ON od.ProductID = p.ProductID
JOIN
    Categories AS c ON p.CategoryID = c.CategoryID
WHERE
    c.CategoryName = 'Beverages' AND o.OrderDate BETWEEN '1997-01-01' AND '1997-06-30'
GROUP BY
    e.EmployeeID, e.FirstName, e.LastName
ORDER BY
    e.LastName, e.FirstName;

-- 2.จงแสดงชื่อบริษัทตัวแทนจำหน่าย  เบอร์โทร เบอร์แฟกซ์ ชื่อผู้ติดต่อ จำนวนชนิดสินค้าประเภท Beverage ที่จำหน่าย โดยแสดงจำนวนสินค้า จากมากไปน้อย 3 อันดับแรก
SELECT TOP 3
    s.CompanyName AS 'ชื่อบริษัท',
    s.Phone AS 'เบอร์โทร',
    s.Fax AS 'เบอร์แฟกซ์',
    s.ContactName AS 'ชื่อผู้ติดต่อ',
    COUNT(p.ProductID) AS 'จำนวนชนิดสินค้าประเภท Beverage'
FROM
    Suppliers AS s
JOIN
    Products AS p ON s.SupplierID = p.SupplierID
JOIN
    Categories AS c ON p.CategoryID = c.CategoryID
WHERE
    c.CategoryName = 'Beverages'
GROUP BY
    s.SupplierID, s.CompanyName, s.Phone, s.Fax, s.ContactName
ORDER BY
    COUNT(p.ProductID) DESC;

-- 3.จงแสดงข้อมูลชื่อลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ ของลูกค้าที่ซื้อของในเดือน สิงหาคม 2539 ยอดรวมของการซื้อโดยแสดงเฉพาะ ลูกค้าที่ไม่มีเบอร์แฟกซ์
SELECT
    c.CompanyName AS 'ชื่อลูกค้า',
    c.ContactName AS 'ชื่อผู้ติดต่อ',
    c.Phone AS 'เบอร์โทรศัพท์',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดรวมการซื้อ'
FROM
    Customers AS c
JOIN
    Orders AS o ON c.CustomerID = o.CustomerID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
WHERE
    o.OrderDate BETWEEN '1996-08-01' AND '1996-08-31'
    AND (c.Fax IS NULL OR c.Fax = '')
GROUP BY
    c.CustomerID, c.CompanyName, c.ContactName, c.Phone
ORDER BY
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) DESC;

-- 4.แสดงรหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ทั้งหมดในปี 2541 ยอดเงินรวมที่ขายได้ทั้งหมดโดยเรียงลำดับตาม จำนวนที่ขายได้เรียงจากน้อยไปมาก พรอ้มทั้งใส่ลำดับที่ ให้กับรายการแต่ละรายการด้วย
SELECT
    ROW_NUMBER() OVER (ORDER BY SUM(od.Quantity) ASC) AS 'ลำดับที่',
    p.ProductID AS 'รหัสสินค้า',
    p.ProductName AS 'ชื่อสินค้า',
    SUM(od.Quantity) AS 'จำนวนที่ขายได้ทั้งหมด',
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS 'ยอดเงินรวม'
FROM
    Products AS p
JOIN
    [Order Details] AS od ON p.ProductID = od.ProductID
JOIN
    Orders AS o ON od.OrderID = o.OrderID
WHERE
    YEAR(o.OrderDate) = 1998 -- ปี 2541 ในปฏิทินไทย
GROUP BY
    p.ProductID, p.ProductName
ORDER BY
    'จำนวนที่ขายได้ทั้งหมด' ASC;

-- 5.จงแสดงข้อมูลของสินค้าที่ขายในเดือนมกราคม 2540 เรียงตามลำดับจากมากไปน้อย 5 อันดับใส่ลำดับด้วย รวมถึงราคาเฉลี่ยที่ขายให้ลูกค้าทั้งหมดด้วย
SELECT TOP 5
    ROW_NUMBER() OVER (ORDER BY SUM(od.Quantity) DESC) AS 'ลำดับ',
    p.ProductName AS 'ชื่อสินค้า',
    SUM(od.Quantity) AS 'จำนวนที่ขายได้',
    AVG(od.UnitPrice) AS 'ราคาเฉลี่ย'
FROM
    Products AS p
JOIN
    [Order Details] AS od ON p.ProductID = od.ProductID
JOIN
    Orders AS o ON od.OrderID = o.OrderID
WHERE
    o.OrderDate BETWEEN '1997-01-01' AND '1997-01-31'
GROUP BY
    p.ProductName
ORDER BY
    'จำนวนที่ขายได้' DESC;

-- 6.จงแสดงชื่อพนักงาน จำนวนใบสั่งซื้อ ยอดเงินรวมทั้งหมด ที่พนักงานแต่ละคนขายได้ ในเดือน ธันวาคม 2539 โดยแสดงเพียง 5 อันดับที่มากที่สุด
SELECT TOP 5
    e.FirstName AS 'ชื่อ',
    e.LastName AS 'นามสกุล',
    COUNT(DISTINCT o.OrderID) AS 'จำนวนใบสั่งซื้อ',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดเงินรวมทั้งหมด'
FROM
    Employees AS e
JOIN
    Orders AS o ON e.EmployeeID = o.EmployeeID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
WHERE
    o.OrderDate BETWEEN '1996-12-01' AND '1996-12-31'
GROUP BY
    e.EmployeeID, e.FirstName, e.LastName
ORDER BY
    'ยอดเงินรวมทั้งหมด' DESC;

-- 7.จงแสดงรหัสสินค้า ชื่อสินค้า ชื่อประเภทสินค้า ที่มียอดขาย สูงสุด 10 อันดับแรก ในเดือน ธันวาคม 2539 โดยแสดงยอดขาย และจำนวนที่ขายด้วย
SELECT TOP 10
    p.ProductID AS 'รหัสสินค้า',
    p.ProductName AS 'ชื่อสินค้า',
    c.CategoryName AS 'ชื่อประเภทสินค้า',
    SUM(od.Quantity) AS 'จำนวนที่ขายได้',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดขาย'
FROM
    Products AS p
JOIN
    Categories AS c ON p.CategoryID = c.CategoryID
JOIN
    [Order Details] AS od ON p.ProductID = od.ProductID
JOIN
    Orders AS o ON od.OrderID = o.OrderID
WHERE
    o.OrderDate BETWEEN '1996-12-01' AND '1996-12-31'
GROUP BY
    p.ProductID, p.ProductName, c.CategoryName
ORDER BY
    'ยอดขาย' DESC;

-- 8.จงแสดงหมายเลขใบสั่งซื้อ ชื่อบริษัทลูกค้า ที่อยู่ เมืองประเทศของลูกค้า ชื่อเต็มพนักงานผู้รับผิดชอบ ยอดรวมในแต่ละใบสั่งซื้อ จำนวนรายการสินค้าในใบสั่งซื้อ และเลือกแสดงเฉพาะที่จำนวนรายการในใบสั่งซื้อมากกว่า 2 รายการ
SELECT
    o.OrderID AS 'หมายเลขใบสั่งซื้อ',
    c.CompanyName AS 'ชื่อบริษัทลูกค้า',
    c.Address AS 'ที่อยู่',
    c.City AS 'เมือง',
    c.Country AS 'ประเทศ',
    e.FirstName + ' ' + e.LastName AS 'ชื่อพนักงานผู้รับผิดชอบ',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดรวมในแต่ละใบสั่งซื้อ',
    COUNT(od.ProductID) AS 'จำนวนรายการสินค้า'
FROM
    Orders AS o
JOIN
    Customers AS c ON o.CustomerID = c.CustomerID
JOIN
    Employees AS e ON o.EmployeeID = e.EmployeeID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY
    o.OrderID, c.CompanyName, c.Address, c.City, c.Country, e.FirstName, e.LastName
HAVING
    COUNT(od.ProductID) > 2;

-- 9.จงแสดง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร เบอร์แฟกซ์ ยอดที่สั่งซื้อทั้งหมดในเดือน ธันวาคม 2539 แสดงผลเฉพาะลูกค้าที่มีเบอร์แฟกซ์
SELECT
    c.CompanyName AS 'ชื่อบริษัทลูกค้า',
    c.ContactName AS 'ชื่อผู้ติดต่อ',
    c.Phone AS 'เบอร์โทร',
    c.Fax AS 'เบอร์แฟกซ์',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดสั่งซื้อทั้งหมด'
FROM
    Customers AS c
JOIN
    Orders AS o ON c.CustomerID = o.CustomerID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
WHERE
    o.OrderDate BETWEEN '1996-12-01' AND '1996-12-31'
    AND (c.Fax IS NOT NULL AND c.Fax != '')
GROUP BY
    c.CustomerID, c.CompanyName, c.ContactName, c.Phone, c.Fax
ORDER BY
    'ยอดสั่งซื้อทั้งหมด' DESC;

-- 10จงแสดงชื่อเต็มพนักงาน จำนวนใบสั่งซื้อที่รับผิดชอบ ยอดขายรวมทั้งหมด เฉพาะในไตรมาสสุดท้ายของปี 2539 เรียงตามลำดับ มากไปน้อยและแสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
    e.FirstName + ' ' + e.LastName AS 'ชื่อเต็มพนักงาน',
    COUNT(DISTINCT o.OrderID) AS 'จำนวนใบสั่งซื้อที่รับผิดชอบ',
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(10, 4)) AS 'ยอดขายรวมทั้งหมด'
FROM
    Employees AS e
JOIN
    Orders AS o ON e.EmployeeID = o.EmployeeID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
WHERE
    o.OrderDate BETWEEN '1996-10-01' AND '1996-12-31'
GROUP BY
    e.EmployeeID, e.FirstName, e.LastName
ORDER BY
    'ยอดขายรวมทั้งหมด' DESC;

-- 11จงแสดงชื่อพนักงาน และแสดงยอดขายรวมทั้งหมด ของสินค้าที่เป็นประเภท Beverage ที่ส่งไปยังประเทศ ญี่ปุ่น
SELECT
    e.FirstName + ' ' + e.LastName AS 'ชื่อพนักงาน',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดขายรวมทั้งหมด'
FROM
    Employees AS e
JOIN
    Orders AS o ON e.EmployeeID = o.EmployeeID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
JOIN
    Products AS p ON od.ProductID = p.ProductID
JOIN
    Categories AS c ON p.CategoryID = c.CategoryID
WHERE
    c.CategoryName = 'Beverages' AND o.ShipCountry = 'Japan'
GROUP BY
    e.EmployeeID, e.FirstName, e.LastName;

-- 12แสดงรหัสบริษัทตัวแทนจำหน่าย ชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร ชื่อสินค้าที่ขาย เฉพาะประเภท Seafood ยอดรวมที่ขายได้แต่ละชนิด แสดงผลเป็นทศนิยม 4 ตำแหน่ง เรียงจาก มากไปน้อย 10 อันดับแรก
SELECT TOP 10
    s.SupplierID AS 'รหัสบริษัทตัวแทนจำหน่าย',
    s.CompanyName AS 'ชื่อบริษัทตัวแทนจำหน่าย',
    s.ContactName AS 'ชื่อผู้ติดต่อ',
    s.Phone AS 'เบอร์โทร',
    p.ProductName AS 'ชื่อสินค้า',
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(10, 4)) AS 'ยอดรวมที่ขายได้แต่ละชนิด'
FROM
    Suppliers AS s
JOIN
    Products AS p ON s.SupplierID = p.SupplierID
JOIN
    Categories AS c ON p.CategoryID = c.CategoryID
JOIN
    [Order Details] AS od ON p.ProductID = od.ProductID
WHERE
    c.CategoryName = 'Seafood'
GROUP BY
    s.SupplierID, s.CompanyName, s.ContactName, s.Phone, p.ProductName
ORDER BY
    'ยอดรวมที่ขายได้แต่ละชนิด' DESC;

-- 13.จงแสดงชื่อเต็มพนักงานทุกคน วันเกิด อายุเป็นปีและเดือน พร้อมด้วยชื่อหัวหน้า
SELECT
    e.FirstName + ' ' + e.LastName AS 'ชื่อเต็มพนักงาน',
    e.BirthDate AS 'วันเกิด',
    DATEDIFF(YEAR, e.BirthDate, GETDATE()) AS 'อายุ (ปี)',
    DATEDIFF(MONTH, e.BirthDate, GETDATE()) % 12 AS 'อายุ (เดือน)',
    m.FirstName + ' ' + m.LastName AS 'ชื่อหัวหน้า'
FROM
    Employees AS e
LEFT JOIN
    Employees AS m ON e.ReportsTo = m.EmployeeID;

-- 14.จงแสดงชื่อบริษัทลูกค้าที่อยู่ในประเทศ USA และแสดงยอดเงินการซื้อสินค้าแต่ละประเภทสินค้า
SELECT
    c.CompanyName AS 'ชื่อบริษัทลูกค้า',
    cat.CategoryName AS 'ประเภทสินค้า',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดเงินการซื้อ'
FROM
    Customers AS c
JOIN
    Orders AS o ON c.CustomerID = o.CustomerID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
JOIN
    Products AS p ON od.ProductID = p.ProductID
JOIN
    Categories AS cat ON p.CategoryID = cat.CategoryID
WHERE
    c.Country = 'USA'
GROUP BY
    c.CompanyName, cat.CategoryName
ORDER BY
    c.CompanyName, cat.CategoryName;

-- 15.แสดงข้อมูลบริษัทผู้จำหน่าย ชื่อบริษัท ชื่อสินค้าที่บริษัทนั้นจำหน่าย จำนวนสินค้าทั้งหมดที่ขายได้และราคาเฉลี่ยของสินค้าที่ขายไปแต่ละรายการ แสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
    s.CompanyName AS 'ชื่อบริษัทผู้จำหน่าย',
    p.ProductName AS 'ชื่อสินค้า',
    SUM(od.Quantity) AS 'จำนวนสินค้าที่ขายได้ทั้งหมด',
    CAST(AVG(od.UnitPrice) AS DECIMAL(10, 4)) AS 'ราคาเฉลี่ย'
FROM
    Suppliers AS s
JOIN
    Products AS p ON s.SupplierID = p.SupplierID
JOIN
    [Order Details] AS od ON p.ProductID = od.ProductID
GROUP BY
    s.CompanyName, p.ProductName;

-- 16.ต้องการชื่อบริษัทผู้ผลิต ชื่อผู้ต่อต่อ เบอร์โทร เบอร์แฟกซ์ เฉพาะผู้ผลิตที่อยู่ประเทศ ญี่ปุ่น พร้อมทั้งชื่อสินค้า และจำนวนที่ขายได้ทั้งหมด หลังจาก 1 มกราคม 2541
SELECT
    s.CompanyName AS 'ชื่อบริษัทผู้ผลิต',
    s.ContactName AS 'ชื่อผู้ติดต่อ',
    s.Phone AS 'เบอร์โทร',
    s.Fax AS 'เบอร์แฟกซ์',
    p.ProductName AS 'ชื่อสินค้า',
    SUM(od.Quantity) AS 'จำนวนที่ขายได้ทั้งหมด'
FROM
    Suppliers AS s
JOIN
    Products AS p ON s.SupplierID = p.SupplierID
JOIN
    [Order Details] AS od ON p.ProductID = od.ProductID
JOIN
    Orders AS o ON od.OrderID = o.OrderID
WHERE
    s.Country = 'Japan' AND o.OrderDate > '1998-01-01'
GROUP BY
    s.CompanyName, s.ContactName, s.Phone, s.Fax, p.ProductName;

-- 17.แสดงชื่อบริษัทขนส่งสินค้า เบอร์โทรศัพท์ จำนวนรายการสั่งซื้อที่ส่งของไปเฉพาะรายการที่ส่งไปให้ลูกค้า ประเทศ USA และ Canada แสดงค่าขนส่งโดยรวมด้วย
SELECT
    s.CompanyName AS 'ชื่อบริษัทขนส่งสินค้า',
    s.Phone AS 'เบอร์โทรศัพท์',
    COUNT(o.OrderID) AS 'จำนวนรายการสั่งซื้อที่ส่งของ',
    SUM(o.Freight) AS 'ค่าขนส่งโดยรวม'
FROM
    Shippers AS s
JOIN
    Orders AS o ON s.ShipperID = o.ShipVia
WHERE
    o.ShipCountry IN ('USA', 'Canada')
GROUP BY
    s.CompanyName, s.Phone;

-- 18.ต้องการข้อมูลรายชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ เบอร์แฟกซ์ ของลูกค้าที่ซื้อสินค้าประเภท Seafood แสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์เท่านั้น
SELECT
    c.CompanyName AS 'ชื่อบริษัทลูกค้า',
    c.ContactName AS 'ชื่อผู้ติดต่อ',
    c.Phone AS 'เบอร์โทรศัพท์',
    c.Fax AS 'เบอร์แฟกซ์'
FROM
    Customers AS c
JOIN
    Orders AS o ON c.CustomerID = o.CustomerID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
JOIN
    Products AS p ON od.ProductID = p.ProductID
JOIN
    Categories AS cat ON p.CategoryID = cat.CategoryID
WHERE
    cat.CategoryName = 'Seafood' AND c.Fax IS NOT NULL AND c.Fax != ''
GROUP BY
    c.CompanyName, c.ContactName, c.Phone, c.Fax;

-- 19. จงแสดงชื่อเต็มของพนักงาน  วันเริ่มงาน (รูปแบบ 105) อายุงานเป็นปี เป็นเดือน ยอดขายรวม เฉพาะสินค้าประเภท Condiment ในปี 2540
SELECT
    e.FirstName + ' ' + e.LastName AS 'ชื่อเต็มของพนักงาน',
    CONVERT(VARCHAR(10), e.HireDate, 105) AS 'วันเริ่มงาน',
    DATEDIFF(YEAR, e.HireDate, GETDATE()) AS 'อายุงาน (ปี)',
    DATEDIFF(MONTH, e.HireDate, GETDATE()) % 12 AS 'อายุงาน (เดือน)',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดขายรวม'
FROM
    Employees AS e
JOIN
    Orders AS o ON e.EmployeeID = o.EmployeeID
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
JOIN
    Products AS p ON od.ProductID = p.ProductID
JOIN
    Categories AS cat ON p.CategoryID = cat.CategoryID
WHERE
    cat.CategoryName = 'Condiments' AND YEAR(o.OrderDate) = 1997
GROUP BY
    e.EmployeeID, e.FirstName, e.LastName, e.HireDate;

-- 20.จงแสดงหมายเลขใบสั่งซื้อ  วันที่สั่งซื้อ(รูปแบบ 105) ยอดขายรวมทั้งหมด ในแต่ละใบสั่งซื้อ โดยแสดงเฉพาะ ใบสั่งซื้อที่มียอดจำหน่ายสูงสุด 10 อันดับแรก
SELECT TOP 10
    o.OrderID AS 'หมายเลขใบสั่งซื้อ',
    CONVERT(VARCHAR(10), o.OrderDate, 105) AS 'วันที่สั่งซื้อ',
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'ยอดขายรวมทั้งหมด'
FROM
    Orders AS o
JOIN
    [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY
    o.OrderID, o.OrderDate
ORDER BY
    'ยอดขายรวมทั้งหมด' DESC;
