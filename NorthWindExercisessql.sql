
--1.	--What is the undiscounted subtotal for each Order (identified by OrderID).
--EXERCISE 1
Select O1.OrderID, SUM(UnitPrice) AS SUBTOTAL_PRICE
from Orders O1
Join [Order Details] O2
ON O1.OrderId = O2.OrderID
GROUP BY O1.OrderID

--Or can do by distinct
SELECT DISTINCT (o1.OrderID), SUM(o2.UnitPrice) AS SubTotal_price
FROM Orders o1
JOIN [Order Details] o2
ON o1.OrderID = o2.OrderID
GROUP BY O1.OrderID

--2.	--What products are currently for sale (not discontinued)?
Select *
from Products
where Discontinued=0
--3.	--What is the cost after discount for each order? Discounts should be applied as a percentage off.
Select UnitPrice, OrderId, Discount,
UnitPrice - (Discount*UnitPrice) as FinalPrice
from [Order Details]
WHERE Discount>0
order by OrderID

--1.	---I need a list of sales figures broken down by category name. Include the total $ amount sold over all time and the total number of items sold.
SELECT c.CategoryName,  sum(od.Quantity* od.UnitPrice) as TotalSales, sum(od.Quantity)as ItemsSold
FROM [Order Details] od
JOIN products p 
ON
od.productId = p.productId
right join categories c
ON c.categoryId = p.categoryId
group by c.CategoryName
order by c.CategoryName, TotalSales desc

--1.	--What are our 10 most expensive products?
select Top 10 od.UnitPrice,p.ProductName, p.ProductID
FROM [Order Details] od
JOIN products p 
ON
od.productId = p.productId
group by p.ProductID, p.ProductName, od.UnitPrice
order by od.UnitPrice desc

--1.	--In which quarter in 1997 did we have the most revenue?
SELECT DATEPART(YEAR, a.shippeddate) as yearShipped,
		DATEPART(quarter, a.shippeddate) as quarterShipped,
		sum(b.UnitPrice*b.Quantity) as totalsale
FROM Orders a
join  [Order Details] b
ON a.OrderID= b.OrderID
WHERE Year(a.shippeddate)= 1997
group by 
DATEPART(YEAR, a.shippeddate),
DATEPART(quarter, a.shippeddate)
order by totalsale desc

--2.	--Which products have a price that is higher than average?
With AvgProduct AS
(select AVG(p.UnitPrice)as AvgPrice
from  Products p
 )
 Select  ProductID, ProductName, UnitPrice
 from Products
 where UnitPrice > 28.86
 order by UnitPrice desc

-- 
SELECT Products.ProductName, Products.UnitPrice
FROM Products
WHERE Products.UnitPrice>(SELECT AVG(UnitPrice) From Products)
