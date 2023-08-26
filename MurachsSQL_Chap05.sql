/*
  Murach's SQL Server 2022 Chapter 05
*/

--1
Select VendorID, Sum(PaymentTotal) as 'PaymentSum'
From AP.dbo.Invoices
Group By VendorID;

--2
Select Top 10 v.VendorName, Sum(i.PaymentTotal) as 'PaymentSum'
From AP.dbo.Invoices as i
Join AP.dbo.Vendors as v
  on i.VendorID = v.VendorID
Group By v.VendorName
Order By Sum(i.PaymentTotal) Desc;

--3
Select v.VendorName, 
  Count(i.InvoiceID) as InvoiceCount, 
  Sum(InvoiceTotal) as InvoiceSum
From AP.dbo.Invoices as i
Join AP.dbo.Vendors as v
  on i.VendorID = v.VendorID
Group By v.VendorName
Order By Count(i.InvoiceID) Desc;

--4
Select gl.AccountDescription, 
  Count(li.AccountNo)as LineItemCount, 
  Sum(li.InvoiceLineItemAmount) as LineItemSum
From AP.dbo.InvoiceLineItems as li
Join AP.dbo.GLAccounts as gl
  on li.AccountNo = gl.AccountNo
Group By li.AccountNo, gl.AccountDescription
Having Count(li.AccountNo) > 1
Order By Count(li.AccountNo) Desc;

--5
Select gl.AccountDescription, 
  Count(li.AccountNo)as LineItemCount, 
  Sum(li.InvoiceLineItemAmount) as LineItemSum
From AP.dbo.InvoiceLineItems as li
Join AP.dbo.GLAccounts as gl
  on li.AccountNo = gl.AccountNo
Join AP.dbo.Invoices as i
  on li.InvoiceID = i.InvoiceID
Where i.InvoiceDate Between '2022-10-01' and '2022-12-31'
Group By li.AccountNo, gl.AccountDescription
Having Count(li.AccountNo) > 1
Order By Count(li.AccountNo) Desc;

--6
Select AccountNo, Sum(InvoiceLineItemAmount) as 'SumInvoiceLineItems'
From AP.dbo.InvoiceLineItems
Group By AccountNo With Rollup;

--7
Select v.VendorName, gl.AccountDescription, 
  Count(li.AccountNo) as 'LineItemCount', 
  Sum(li.InvoiceLineItemAmount) as 'LineItemSum'
From AP.dbo.Vendors as v
Join AP.dbo.GLAccounts as gl
  on v.DefaultAccountNo = gl.AccountNo
Join AP.dbo.InvoiceLineItems as li
  on gl.AccountNo = li.AccountNo
Group By v.VendorName, gl.AccountDescription
Order By v.VendorName, gl.AccountDescription;

--8
Select v.VendorName, 
  Count(Distinct li.AccountNo) as 'No Accounts'
From AP.dbo.Vendors as v
Join AP.dbo.Invoices as i
  on v.VendorId = i.VendorID
Join AP.dbo.InvoiceLineItems as li
  on i.InvoiceID = li.InvoiceID
Group By v.VendorName
Having Count(Distinct li.AccountNo) > 1;

--9
Select VendorID, InvoiceDate, InvoiceTotal,
  Sum(InvoiceTotal) Over (Partition By VendorID) as 'VendorTotal',
  Count(InvoiceTotal) Over (Partition By VendorID) as 'VendorCount',
  Avg(InvoiceTotal) Over (Partition By VendorID) as 'VendorAvg'
From AP.dbo.Invoices;

/*
Select Top 1 * From Vendors;
Select Top 1 * From Invoices;
Select Top 1 * From InvoiceLineItems;
Select Top 1 * From GLAccounts;
*/