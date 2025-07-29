/*
  Window-Partition
  Window-Order
  Window-Frame
*/

Select
  empid
  , ordermonth
  , val
  , Sum(val) Over (Partition by empid 
					Order By ordermonth
					Rows Between Unbounded Preceding and Current Row) 'runval' --Unbounded Preceding = no lower frame limit
From Sales.EmpOrders;

/*
  Ranking Window Functions
*/

Select
  orderid
  , custid
  , val
  , Row_Number() Over(Order by val) 'rownum'
  , Rank() Over(Order by val) 'rank'
  , Dense_Rank() Over(Order by val) 'dense_rank'
  , NTile(10) Over(Order by val) 'NTile'
From Sales.OrderValues
Order by val -- I dated a Val once
;

Select 
  orderid
  , custid
  , val
  , Row_Number() Over(Partition by custid Order by val) 'rownum'
From Sales.OrderValues
Order By custid, val
;

/*
  Offset Window Functions
    Lag, Lead, First_Value, Last_Value
*/

-- Lag and Lead
Select 
  custid
  , orderid
  , val
  , Lag(val) Over(Partition by custid Order by orderid, orderdate) 'LAG_value'
  , Lead(val) Over(Partition by custid Order by orderid, orderdate) 'LEAD_value'
From Sales.OrderValues
Order by custid, orderdate, orderid
;

-- First_Value and Last_Value
Select 
  custid
  , orderid
  , val
  , First_Value(val) Over(Partition by custid
						  Order by orderdate, orderid
						  Rows between Unbounded Preceding and Current Row) 'first_value'
  , Last_Value(val) Over(Partition by custid
						 Order by orderdate, orderid
						 Rows between Current Row and Unbounded Following) 'last_value'
From Sales.OrderValues
Order by custid, orderdate, orderid
;

Select
  orderid
  , custid
  , orderdate
  , shippeddate
  , Last_Value(shippeddate) Ignore Nulls -- alternately use Lag
       Over(Partition by custid Order by orderdate, orderid Rows Unbounded Preceding) 'LastKnownShippedDate'
From Sales.Orders
Where custid in (9, 20, 32, 73)
 and orderdate >= '20220101'
Order By custid, orderdate, orderid
;

/*
  Aggregate Window Functions
*/