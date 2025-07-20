-- 1, orders placed in a specific month
Select 
  orderid
  , orderdate
  , custid
  , empid
From Sales.Orders
Where orderdate Between '2021-06-01' and '2021-06-30'
;

-- 2, orders placed the day before the last day of the month
Select 
  orderid
  , orderdate
  , custid
  , empid
From Sales.Orders
Where orderdate = DateAdd(Day, -1, (EOMonth(orderdate)))
;

--3, employees with a last name containing the letter e more than once
Select empid
  , firstname
  , lastname
From HR.Employees
Where Len(lastname) - Len(Replace(lastname, 'e', '')) >= 2
;

--4, orders with total value > 10k
Select orderid, Sum(unitprice * qty) 'ordertotal'
From Sales.OrderDetails
Group By orderid
Having Sum(unitprice * qty) > 10000
Order By ordertotal Desc
;

--5, case sensitive data quality check
Select * 
From HR.Employees
Where lastname Collate Latin1_General_BIN like '[a-z]%'
;

--7, three countries with highest avg freigt in 2021
Select Top 3 shipcountry, Avg(freight) 'avgfreight'
From Sales.Orders
Where Year(orderdate) = 2021
Group By shipcountry
Order By avgfreight Desc;

--8, row numbers for orders for each customer
Select custid, orderdate, orderid,
  Row_Number() Over (Partition By custid Order By orderdate, orderid) 'rownumber'
From Sales.Orders
;

--9, select gender based on title of courtesy
Select
  empid
  , firstname
  , lastname
  , titleofcourtesy
  , Case
      When titleofcourtesy in ('Ms.', 'Mrs.') Then 'Female'
      When titleofcourtesy = 'Mr.' Then 'Male'
      Else 'Unknown'
    End as 'gender'
From HR.Employees
;

--10, 
Select custid, region
From Sales.Customers
Order By 
  Case When region Is Null Then 1 Else 0 End,  region