/*
  Pivoting Data
    three logical phases: grouping on rows, spreading on columns, aggregation
*/

Select * From dbo.Orders;

Select 
  empid
  , custid
  , Sum(qty) 'sumqty'
From dbo.Orders
Group By empid, custid;

-- Pivoting with a grouped query

Select 
  empid
  , Sum(Case When custid = 'A' Then qty End) 'A'
  , Sum(Case When custid = 'B' Then qty End) 'B'
  , Sum(Case When custid = 'C' Then qty End) 'C'
  , Sum(Case When custid = 'D' Then qty End) 'D'
From dbo.Orders
Group by empid;

-- With Pivot (always work with a table expression)

Select 
  empid, A, B, C, D
From (Select empid, custid, qty
      From dbo.Orders) D
Pivot(Sum(qty) For custid in (A, B, C, D)) P;

Select 
  custid, [1], [2], [3]
From (Select custid, empid, qty
      From dbo.Orders) D
Pivot(Sum(qty) For empid in ([1], [2], [3])) P;

/*
  Unpivoting Data
*/

Select * From dbo.EmpCustOrders;

-- Unpivoting with Apply: producing copies, extracting values, eliminating irrelevant rows
Select 
  empid
  , custid
  , qty
From dbo.EmpCustOrders
  Cross Apply (Values ('A', A), ('B', B), ('C', C), ('D', D)) as C(custid, qty)
Where qty Is Not Null;

-- Unpivoting with Unpivot: produces two result colums from any number of source columns
Select 
  empid
  , custid
  , qty
From dbo.EmpCustOrders
  Unpivot(qty For custid in (A, B, C, D)) as U;