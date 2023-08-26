/*
  Murach's SQL Server 2022 Chapter 04
*/

--1
Select * 
From AP.dbo.Vendors as v
Join AP.dbo.Invoices as i
  on v.VendorID = i.VendorID;

--2
Select v.VendorName, i.InvoiceNumber, i.InvoiceDate,
  i.InvoiceTotal - (i.PaymentTotal + i.CreditTotal) as 'Balance Due'
From AP.dbo.Vendors as v
Join AP.dbo.Invoices as i
  on v.VendorID = i.VendorID
Where i.InvoiceTotal - (i.PaymentTotal + i.CreditTotal) > 0
Order By v.VendorName;

--3
Select v.VendorName, v.DefaultAccountNo, gl.AccountDescription
From AP.dbo.Vendors as v
Join AP.dbo.GLAccounts as gl 
  on v.DefaultAccountNo = gl.AccountNo
Order By AccountDescription, VendorName;

--4
Select v.VendorName, i.InvoiceNumber, i.InvoiceDate,
  i.InvoiceTotal - (i.PaymentTotal + i.CreditTotal) as 'Balance Due'
From AP.dbo.Vendors as v
Join AP.dbo.Invoices as i
  on v.VendorID = i.VendorID 
  and i.InvoiceTotal - (i.PaymentTotal + i.CreditTotal) > 0
Order By v.VendorName;

--5
Select v.VendorName as 'Vendor', 
  i.InvoiceDate as 'Date',
  i.InvoiceNumber as 'Number',
  li.InvoiceSequence as '#',
  li.InvoiceLineItemAmount as 'LineItem'
From AP.dbo.Vendors as v
Join AP.dbo.Invoices as i
  on v.VendorID = i.VendorID
Join AP.dbo.InvoiceLineItems as li
  on v.DefaultAccountNo = li.AccountNo
Order By 1, 2, 3, 4;

--6
Select Distinct v1.VendorID, v1.VendorName, 
  v1.VendorContactFName + ' ' + v1.VendorContactLName as 'Name'
From AP.dbo.Vendors as v1
Join AP.dbo.Vendors as v2
  -- we want the same as another vendor so the ID cannot match
  on (v1.VendorID <> v2.VendorID)
  and (v1.VendorContactFName = v2.VendorContactFName)
Order By 3;

--7
Select gl.AccountNo, gl.AccountDescription
From AP.dbo.GLAccounts as gl
Left Join AP.dbo.InvoiceLineItems as li
  on gl.AccountNo = li.AccountNo
Where li.InvoiceID Is Null
Order By AccountNo;

--8
Select VendorName, 'CA' as 'VendorState'
From AP.dbo.Vendors
Where VendorState = 'CA'
Union
Select VendorName, 'Outside CA'
From AP.dbo.Vendors
Where VendorState <> 'CA'
Order By VendorName;


/*
Select Top 1 * From Vendors;
Select Top 1 * From Invoices;
Select Top 1 * From GLAccounts;
Select Top 1 * From InvoiceLineItems;
*/