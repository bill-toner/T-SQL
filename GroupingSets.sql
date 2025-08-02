/*
  Grouping Sets
   - a set of expressions you group the data by in a grouped query
*/

-- Grouping Sets
Select
  empid
  , custid
  , Sum(qty) 'sumqty'
From dbo.Orders
Group By 
  Grouping Sets
    (
      (empid, custid),
      (empid),
      (custid), 
      ()
    );

-- Cube: provide a set of comma-separated members and get all possible grouping sets (the power set)
Select 
  empid
  , custid
  , Sum(qty) 'sumqty'
From dbo.Orders
Group By Cube(empid, custid);

-- Rollup: assumes a hierarchy among the input members and produces only grouping sets that form leading combinations
Select 
  Year(orderdate) 'orderyear'
  , Month(orderdate) 'ordermonth'
  , Day(orderdate) 'orderday'
  , Sum(qty) 'sumqty'
From dbo.Orders
Group By Rollup(Year(orderdate), Month(orderdate), Day(orderdate));

-- The Grouping and Grouping_ID functions
Select 
  empid
  , custid
  , Sum(qty) 'sumqty'
From dbo.Orders
Group By Cube(empid, custid); -- uses Nulls to separate groups

Select 
  Grouping(empid) 'grpemp' -- using Grouping() to show the association between rows and grouping sets
  , Grouping(custid) 'grpcust'
  , empid
  , custid
  , Sum(qty) 'sumqty'
From dbo.Orders
Group By Cube(empid, custid);  

Select 
  Grouping_ID(empid, custid) 'groupingset' -- using Grouping_ID() once on all grouping sets
  , empid
  , custid
  , Sum(qty) 'sumqty'
From dbo.Orders
Group By Cube(empid, custid);