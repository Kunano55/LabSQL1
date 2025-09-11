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


-- 9.จงแสดง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร เบอร์แฟกซ์ ยอดที่สั่งซื้อทั้งหมดในเดือน ธันวาคม 2539 แสดงผลเฉพาะลูกค้าที่มีเบอร์แฟกซ์
-- 10จงแสดงชื่อเต็มพนักงาน จำนวนใบสั่งซื้อที่รับผิดชอบ ยอดขายรวมทั้งหมด เฉพาะในไตรมาสสุดท้ายของปี 2539 เรียงตามลำดับ มากไปน้อยและแสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
-- 11จงแสดงชื่อพนักงาน และแสดงยอดขายรวมทั้งหมด ของสินค้าที่เป็นประเภท Beverage ที่ส่งไปยังประเทศ ญี่ปุ่น
-- 12แสดงรหัสบริษัทตัวแทนจำหน่าย ชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร ชื่อสินค้าที่ขาย เฉพาะประเภท Seafood ยอดรวมที่ขายได้แต่ละชนิด แสดงผลเป็นทศนิยม 4 ตำแหน่ง เรียงจาก มากไปน้อย 10 อันดับแรก
-- 13.จงแสดงชื่อเต็มพนักงานทุกคน วันเกิด อายุเป็นปีและเดือน พร้อมด้วยชื่อหัวหน้า
-- 14.จงแสดงชื่อบริษัทลูกค้าที่อยู่ในประเทศ USA และแสดงยอดเงินการซื้อสินค้าแต่ละประเภทสินค้า
-- 15.แสดงข้อมูลบริษัทผู้จำหน่าย ชื่อบริษัท ชื่อสินค้าที่บริษัทนั้นจำหน่าย จำนวนสินค้าทั้งหมดที่ขายได้และราคาเฉลี่ยของสินค้าที่ขายไปแต่ละรายการ แสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
-- 16.ต้องการชื่อบริษัทผู้ผลิต ชื่อผู้ต่อต่อ เบอร์โทร เบอร์แฟกซ์ เฉพาะผู้ผลิตที่อยู่ประเทศ ญี่ปุ่น พร้อมทั้งชื่อสินค้า และจำนวนที่ขายได้ทั้งหมด หลังจาก 1 มกราคม 2541
-- 17.แสดงชื่อบริษัทขนส่งสินค้า เบอร์โทรศัพท์ จำนวนรายการสั่งซื้อที่ส่งของไปเฉพาะรายการที่ส่งไปให้ลูกค้า ประเทศ USA และ Canada แสดงค่าขนส่งโดยรวมด้วย
-- 18.ต้องการข้อมูลรายชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ เบอร์แฟกซ์ ของลูกค้าที่ซื้อสินค้าประเภท Seafood แสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์เท่านั้น
-- 19. จงแสดงชื่อเต็มของพนักงาน  วันเริ่มงาน (รูปแบบ 105) อายุงานเป็นปี เป็นเดือน ยอดขายรวม เฉพาะสินค้าประเภท Condiment ในปี 2540
-- 20.จงแสดงหมายเลขใบสั่งซื้อ  วันที่สั่งซื้อ(รูปแบบ 105) ยอดขายรวมทั้งหมด ในแต่ละใบสั่งซื้อ โดยแสดงเฉพาะ ใบสั่งซื้อที่มียอดจำหน่ายสูงสุด 10 อันดับแรก
