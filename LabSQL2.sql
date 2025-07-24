--1. ต้องการรหัสพนักงาน คำนำหน้า ชื่อ นามสกุล ของพนักงานที่อยู่ในประเทศ USA
Select TitleOfCourtesy, FirstName, LastName
From Employees
Where Country= 'USA'

--2. ต้องการข้อมูลสินค้าที่มีรหัสประเภท 1,2,4,8 และมีราคา ช่วง 100$-200$
Select *
From Products
Where CategoryID IN(1,2,4,8) AND UnitPrice Between 100 And 200 

--3. ต้องการประเทศ เมือง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร ของลูกค้าทั้งหมด ที่อยู่ในภาค WA และ WY
Select Country, City, CompanyName, ContactName, Phone
From Customers
Where Region IN ('WA','WY')

--4. ข้อมูลของสินค้ารหัสประเภทที่ 1 ราคาไม่เกิน 20 หรือสินค้ารหัสประเภทที่ 8 ราคาตั้งแต่ 150 ขึ้นไป
Select *
From Products
Where (CategoryID = 1 AND UnitPrice <= 20) 
   OR (CategoryID = 8 AND UnitPrice >= 150)



--5. ชื่อบริษัทลูกค้า ที่อยู่ใน ประเทศ USA ที่ไม่มีหมายเลข FAX  เรียงตามลำดับชื่อบริษัท 
Select CompanyName
From Customers
Where Country = 'USA' AND Fax = NULL
Order By CompanyName ASC

--6. ต้องการข้อมูลลูกค้าที่ชื่อบริษัททมีคำว่า Com
Select * 
From Customers
Where CompanyName Like '%Com%'
